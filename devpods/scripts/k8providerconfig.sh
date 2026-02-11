#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KUBECONFIG_PATH="$SCRIPT_DIR/devpod-kubeconfig.yaml"

echo "🔥 Deleting all existing workspaces..."
for workspace in $(devpod list --output json 2>/dev/null | jq -r '.[].id' 2>/dev/null); do
    echo "   Deleting workspace: $workspace"
    devpod delete "$workspace" 2>/dev/null || true
done
echo ""

echo "⏳ Waiting for workspace deletions to complete..."
sleep 5
echo ""

# Clean up any ghost pods left behind
echo "🧹 Cleaning up ghost pods..."
export KUBECONFIG="$KUBECONFIG_PATH"
GHOST_PODS=$(kubectl get pods -n devpod --no-headers 2>/dev/null | grep -E "ContainerStatusUnknown|Unknown|Evicted" | awk '{print $1}')
if [ -n "$GHOST_PODS" ]; then
    for pod in $GHOST_PODS; do
        echo "   Force-deleting ghost pod: $pod"
        kubectl delete pod "$pod" -n devpod --force --grace-period=0 2>/dev/null || true
    done
else
    echo "   ✅ No ghost pods found."
fi
echo ""

echo "🔥 NUKING existing Kubernetes provider..."
devpod provider delete kubernetes 2>/dev/null || true
echo ""

echo "⏳ Waiting for provider deletion to complete..."
sleep 3
echo ""

echo "📦 Configuring Kubernetes provider..."
devpod provider add kubernetes 2>/dev/null || devpod provider use kubernetes --reconfigure
echo ""

echo "🎯 Setting as default provider..."
devpod provider use kubernetes
echo ""

echo "⚙️  Configuring provider options..."
echo "   Cluster: 2 nodes × 4 vCPUs × 32GB RAM (Spot)"
echo "   Target: 3 always-on pods, no evictions"

# Core config
devpod provider set-options -o KUBERNETES_CONFIG="$KUBECONFIG_PATH" kubernetes
devpod provider set-options -o KUBERNETES_CONTEXT=jmp_agentics-devpods-1 kubernetes
devpod provider set-options -o KUBERNETES_NAMESPACE=devpod kubernetes

# =============================================================================
# RESOURCE LIMITS - tuned to PREVENT EVICTIONS
# =============================================================================
# Cluster total: 8 vCPUs, 64GB RAM across 2 nodes
# 3 pods target: each gets generous allocation with headroom
#
# KEY FIX: ephemeral-storage limits are set explicitly.
# Without these, Kubernetes evicts pods when setup.sh installs
# blow past the default ephemeral threshold (~6Gi).
# Your LLMOps setup uses ~9-10Gi ephemeral, so we allow 20Gi.
# =============================================================================
devpod provider set-options -o DISK_SIZE=25Gi kubernetes
devpod provider set-options -o RESOURCES='{"requests":{"memory":"8Gi","cpu":"0.8","ephemeral-storage":"15Gi"},"limits":{"memory":"12Gi","cpu":"2","ephemeral-storage":"20Gi"}}' kubernetes

# Pod configuration
# NO inactivity timeout - pods stay alive forever
devpod provider set-options -o CREATE_NAMESPACE=true kubernetes
devpod provider set-options -o POD_TIMEOUT=30m kubernetes

# Storage
devpod provider set-options -o STORAGE_CLASS=ssd kubernetes
devpod provider set-options -o PVC_ACCESS_MODE=ReadWriteOnce kubernetes

# Security
devpod provider set-options -o STRICT_SECURITY=false kubernetes

echo ""
echo "✅ Provider configured — anti-eviction mode!"
echo ""
echo "📊 Resource Allocation:"
echo "   Per Pod Request:      8Gi RAM, 0.8 CPU, 15Gi ephemeral"
echo "   Per Pod Limit:        12Gi RAM, 2 CPU, 20Gi ephemeral"
echo "   PVC Disk Per Pod:     25Gi"
echo "   Inactivity Timeout:   NONE (always-on)"
echo "   Pod Startup Timeout:  30 minutes"
echo "   Max Capacity:         ~3 pods (comfortable), 4 pods (tight)"
echo ""
echo "📋 Current configuration:"
devpod provider options kubernetes
echo ""
echo "🚀 Ready to create workspaces:"
echo "   devpod up <repo> --provider kubernetes --id <name>"
echo ""
echo "💡 Tip: Monitor resource usage with:"
echo "   kubectl --kubeconfig=$KUBECONFIG_PATH top nodes"
echo "   kubectl --kubeconfig=$KUBECONFIG_PATH top pods -n devpod"
