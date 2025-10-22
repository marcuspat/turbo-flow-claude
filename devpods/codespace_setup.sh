#!/bin/bash
set -e

echo "🚀 Running Turbo-Flow Claude Complete Setup"

# Get the devpods directory (where this script is)
DEVPODS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Set workspace to parent of devpods directory
WORKSPACE_FOLDER="$(dirname "$DEVPODS_DIR")"
AGENTS_DIR="$WORKSPACE_FOLDER/agents"

echo "DevPods directory: $DEVPODS_DIR"
echo "Workspace directory: $WORKSPACE_FOLDER"

# Export environment variables that the setup scripts expect
export WORKSPACE_FOLDER
export DEVPOD_WORKSPACE_FOLDER="$WORKSPACE_FOLDER"
export AGENTS_DIR
export DEVPOD_DIR="$DEVPODS_DIR"

# Change to workspace directory (crucial!)
cd "$WORKSPACE_FOLDER"

echo "Changed to workspace directory: $(pwd)"
echo "Running setup scripts..."

# Run scripts with full paths but from workspace directory
yes | bash "$DEVPODS_DIR/setup.sh" || true
yes | bash "$DEVPODS_DIR/post-setup.sh" || true  
yes | bash "$DEVPODS_DIR/tmux-workspace.sh" || true

echo "✅ Setup complete in workspace: $WORKSPACE_FOLDER"

tmux attach-session -t workspace
