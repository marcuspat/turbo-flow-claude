#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KUBECONFIG_PATH="$SCRIPT_DIR/devpod-kubeconfig.yaml"

if [ ! -f "$KUBECONFIG_PATH" ]; then
    echo "❌ FATAL: devpod-kubeconfig.yaml not found at $KUBECONFIG_PATH"
    exit 1
fi
export KUBECONFIG="$KUBECONFIG_PATH"

echo ""
echo "============================================================"
echo "  DevPod Kubernetes Provider — Clean Build"
echo "============================================================"
echo ""

# =============================================================================
# PHASE 1: NUKE EVERYTHING
# =============================================================================
echo "🔥 PHASE 1: Cleaning up everything..."
echo ""

# 1a. Delete all devpod workspaces
echo "   Deleting all DevPod workspaces..."
for workspace in $(devpod list --output json 2>/dev/null | jq -r '.[].id' 2>/dev/null); do
    echo "   ├── Deleting workspace: $workspace"
    devpod delete "$workspace" 2>/dev/null || true
done
echo "   └── Done."
echo ""

# 1b. Wait for devpod to finish cleanup
echo "   ⏳ Waiting for devpod deletions..."
sleep 5

# 1c. Force-delete ALL pods in devpod namespace (ghosts, stuck, everything)
echo "   Cleaning up ALL pods in devpod namespace..."
REMAINING_PODS=$(kubectl get pods -n devpod --no-headers 2>/dev/null | awk '{print $1}')
if [ -n "$REMAINING_PODS" ]; then
    for pod in $REMAINING_PODS; do
        echo "   ├── Force-deleting pod: $pod"
        kubectl delete pod "$pod" -n devpod --force --grace-period=0 2>/dev/null || true
    done
    echo "   └── Done."
else
    echo "   └── No pods to clean up."
fi
echo ""

# 1d. Delete ALL PVCs in devpod namespace — THIS IS THE KEY FIX
# Old PVCs from previous workspaces block new ones from binding
echo "   Cleaning up ALL PVCs in devpod namespace..."
REMAINING_PVCS=$(kubectl get pvc -n devpod --no-headers 2>/dev/null | awk '{print $1}')
if [ -n "$REMAINING_PVCS" ]; then
    for pvc in $REMAINING_PVCS; do
        echo "   ├── Deleting PVC: $pvc"
        kubectl delete pvc "$pvc" -n devpod --force --grace-period=0 2>/dev/null || true
    done
    echo "   └── Done."
else
    echo "   └── No PVCs to clean up."
fi
echo ""

# 1e. Wait for PVCs to fully release
echo "   ⏳ Waiting for volume cleanup..."
sleep 5

# 1f. Verify clean state
echo "   Verifying clean state..."
LEFTOVER_PODS=$(kubectl get pods -n devpod --no-headers 2>/dev/null | wc -l | tr -d ' ')
LEFTOVER_PVCS=$(kubectl get pvc -n devpod --no-headers 2>/dev/null | wc -l | tr -d ' ')
if [ "$LEFTOVER_PODS" -gt 0 ] || [ "$LEFTOVER_PVCS" -gt 0 ]; then
    echo "   ⚠️  WARNING: $LEFTOVER_PODS pods and $LEFTOVER_PVCS PVCs still remain."
    echo "   Attempting harder cleanup..."
    kubectl delete pods --all -n devpod --force --grace-period=0 2>/dev/null || true
    kubectl delete pvc --all -n devpod --force --grace-period=0 2>/dev/null || true
    sleep 5
fi
echo "   ✅ Namespace is clean."
echo ""

# =============================================================================
# PHASE 2: VERIFY STORAGE
# =============================================================================
echo "🔍 PHASE 2: Verifying cluster storage..."
echo ""

# Check storage class exists
echo "   Storage classes available:"
kubectl get storageclass 2>/dev/null | while IFS= read -r line; do
    echo "   │  $line"
done
echo ""

# Verify 'ssd' exists
USE_DEFAULT_SC=false
if kubectl get storageclass ssd > /dev/null 2>&1; then
    echo "   ✅ Storage class 'ssd' exists."
    PROVISIONER=$(kubectl get storageclass ssd -o jsonpath='{.provisioner}' 2>/dev/null)
    RECLAIM=$(kubectl get storageclass ssd -o jsonpath='{.reclaimPolicy}' 2>/dev/null)
    BINDING=$(kubectl get storageclass ssd -o jsonpath='{.volumeBindingMode}' 2>/dev/null)
    echo "      Provisioner:  $PROVISIONER"
    echo "      Reclaim:      $RECLAIM"
    echo "      Binding Mode: $BINDING"
else
    echo "   ❌ Storage class 'ssd' NOT FOUND!"
    echo "   Falling back to default storage class..."
    USE_DEFAULT_SC=true
fi
echo ""

# =============================================================================
# PHASE 3: CONFIGURE PROVIDER
# =============================================================================
echo "📦 PHASE 3: Configuring Kubernetes provider..."
echo ""

# Delete and re-add provider
echo "   Removing old provider..."
devpod provider delete kubernetes 2>/dev/null || true
sleep 3

echo "   Adding fresh provider..."
devpod provider add kubernetes 2>/dev/null || devpod provider use kubernetes --reconfigure

echo "   Setting as default..."
devpod provider use kubernetes
echo ""

echo "   ⚙️  Setting provider options..."
echo ""

# Core config
devpod provider set-options -o KUBERNETES_CONFIG="$KUBECONFIG_PATH" kubernetes
devpod provider set-options -o KUBERNETES_CONTEXT=jmp_agentics-devpods-1 kubernetes
devpod provider set-options -o KUBERNETES_NAMESPACE=devpod kubernetes

# =============================================================================
# RESOURCE LIMITS
# =============================================================================
# Cluster total: 8 vCPUs, 64GB RAM across 2 nodes (Spot)
# Target: 3 always-on pods
#
# DISK_SIZE: 15Gi (proven to work — 25Gi caused PVC binding failures)
#
# RESOURCES:
#   - Memory: 8Gi request / 12Gi limit (plenty of headroom)
#   - CPU: 0.8 request / 2 limit
#   - Ephemeral storage: NO request (avoids scheduling failures),
#     20Gi LIMIT only (prevents eviction without blocking scheduling)
# =============================================================================
devpod provider set-options -o DISK_SIZE=15Gi kubernetes
devpod provider set-options -o RESOURCES='{"requests":{"memory":"8Gi","cpu":"0.8"},"limits":{"memory":"12Gi","cpu":"2","ephemeral-storage":"20Gi"}}' kubernetes

# Pod configuration — no inactivity timeout, pods stay alive
devpod provider set-options -o CREATE_NAMESPACE=true kubernetes
devpod provider set-options -o POD_TIMEOUT=30m kubernetes

# Storage
if [ "$USE_DEFAULT_SC" != "true" ]; then
    devpod provider set-options -o STORAGE_CLASS=ssd kubernetes
fi
devpod provider set-options -o PVC_ACCESS_MODE=ReadWriteOnce kubernetes

# Security
devpod provider set-options -o STRICT_SECURITY=false kubernetes

echo ""
echo "   ✅ Provider configured!"
echo ""

echo "============================================================"
echo "  ✅ PROVIDER READY — launch your devpods:"
echo ""
echo "  devpod up <repo> --provider kubernetes --id <name>"
echo "============================================================"
echo ""
