#!/bin/bash
set -x

# Get the directory where this script is located
readonly DEVPOD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Claude Dev Post-Setup ==="
echo "WORKSPACE_FOLDER: $WORKSPACE_FOLDER"
echo "DEVPOD_WORKSPACE_FOLDER: $DEVPOD_WORKSPACE_FOLDER"
echo "AGENTS_DIR: $AGENTS_DIR"
echo "DEVPOD_DIR: $DEVPOD_DIR"

# Verify installations from setup.sh
echo "Verifying installations..."

# Check Claude Code
if command -v claude >/dev/null 2>&1; then
    echo "✅ Claude Code available"
else
    echo "⚠️ Claude Code not found"
fi

# Check Claude Monitor
if command -v claude-monitor >/dev/null 2>&1; then
    echo "✅ Claude Monitor available"
else
    echo "⚠️ Claude Monitor not found"
fi

# Check agents directory
if [ -d "$AGENTS_DIR" ] && [ "$(ls -A $AGENTS_DIR 2>/dev/null)" ]; then
    agent_count=$(ls -1 $AGENTS_DIR/*.md 2>/dev/null | wc -l)
    echo "✅ Found $agent_count agents in $AGENTS_DIR"
else
    echo "⚠️ Agents directory empty or missing"
fi

# Check claude.md configuration
if [ -f "$WORKSPACE_FOLDER/claude.md" ]; then
    echo "✅ Claude configuration file exists"
else
    echo "⚠️ Claude configuration file missing"
fi

echo "Post-setup verification completed!"

# Fix permissions after ALL setup (in case anything ran as root)
echo "=== Fixing VS Code Server Permissions ==="
sudo chown -R vscode:vscode /home/vscode/.vscode-server 2>/dev/null || true
sudo chown -R vscode:vscode /workspaces/.cache/vscode-server 2>/dev/null || true
echo "✅ Permissions fixed"
