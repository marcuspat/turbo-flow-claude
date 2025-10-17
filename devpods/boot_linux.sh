#!/bin/bash
#
# Linux installer for 'turbo-flow-claude' (Full Execution)
# Installs dependencies, copies devpods, patches for Linux,
# and runs all setup scripts in sequence.

# Exit immediately if a command exits, or if an unset variable is used.
set -euo pipefail

echo "🚀 Starting Linux setup for turbo-flow-claude..."

# 1. Detect Package Manager and Install Dependencies
echo "Installing core dependencies (git, curl, tmux, htop, python, direnv, build-tools)..."
if command -v apt-get &> /dev/null; then
    echo "Detected Debian/Ubuntu-based system. Using apt-get."
    sudo apt-get update
    sudo apt-get install -y git curl tmux htop python3 python3-pip direnv build-essential
elif command -v dnf &> /dev/null; then
    echo "Detected Fedora-based system. Using dnf."
    sudo dnf install -y git curl tmux htop python3 python3-pip direnv @development-tools
elif command -v yum &> /dev/null; then
    echo "Detected RHEL/CentOS-based system. Using yum."
    sudo yum install -y git curl tmux htop python3 python3-pip direnv
    sudo yum groupinstall -y "Development Tools"
else
    echo "Error: Could not find apt-get, dnf, or yum."
    echo "Please install dependencies manually: git, curl, tmux, htop, python3, python3-pip, direnv, build-essential"
    exit 1
fi

# 2. Install NVM (Node Version Manager)
echo "Installing nvm (Node Version Manager)..."
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load nvm for the current session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# 3. Install Node.js LTS
echo "Installing latest LTS version of Node.js..."
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

echo "Node.js $(node -v) and npm $(npm -v) installed."

# 4. Clone Repo, Copy Devpods, and Clean Up
REPO_URL="https://github.com/marcuspat/turbo-flow-claude.git"
CLONE_DIR="turbo-flow-claude"
TARGET_DEVPODS_DIR="devpods"

if [ -d "$CLONE_DIR" ]; then
    echo "Removing old clone directory '$CLONE_DIR'..."
    rm -rf "$CLONE_DIR"
fi

echo "Cloning repository..."
git clone --depth 1 "$REPO_URL" "$CLONE_DIR"

if [ ! -d "$CLONE_DIR/devpods" ]; then
    echo "ERROR: 'devpods' directory not found in cloned repo."
    rm -rf "$CLONE_DIR" # Clean up failed clone
    exit 1
fi

if [ -d "$TARGET_DEVPODS_DIR" ]; then
    echo "WARNING: '$TARGET_DEVPODS_DIR' directory already exists. Overwriting..."
    rm -rf "$TARGET_DEVPODS_DIR"
fi

echo "Copying 'devpods' directory to current directory..."
cp -r "$CLONE_DIR/devpods" "$TARGET_DEVPODS_DIR"

echo "Removing clone directory '$CLONE_DIR'..."
rm -rf "$CLONE_DIR"

# 5. Make scripts executable and apply patches
echo "Making scripts executable..."
chmod +x "$TARGET_DEVPODS_DIR/setup.sh"
chmod +x "$TARGET_DEVPODS_DIR/post-setup.sh"
chmod +x "$TARGET_DEVPODS_DIR/tmux-workspace.sh"

echo "Patching setup.sh for compatibility..."

# Note: Linux 'sed' does not need the '' after -i
# Note: We do NOT need the 'sed -i.bak' patch, as the
#       original syntax in setup.sh is valid for Linux.

# --- PATCH 1: Fix 'claude mcp add' idempotency (allow to fail) ---
sed -i "s/claude mcp add playwright .*/& || true/g" "$TARGET_DEVPODS_DIR/setup.sh"
sed -i "s/claude mcp add chrome-devtools .*/& || true/g" "$TARGET_DEVPODS_DIR/setup.sh"
sed -i "s/claude mcp add chrome-mcp .*/& || true/g" "$TARGET_DEVPODS_DIR/setup.sh"

# --- PATCH 2: Fix alias file for zsh (if used) ---
SHELL_PROFILE="$HOME/.bashrc"
if [ "$SHELL" = "/bin/zsh" ]; then
    SHELL_PROFILE="$HOME/.zshrc"
    echo "Detected zsh. Aliases will be added to $SHELL_PROFILE"
fi
sed -i "s|~/.bashrc|$SHELL_PROFILE|g" "$TARGET_DEVPODS_DIR/setup.sh"

# --- PATCH 3: Fix npx prompt stall and typos ---
sed -i "s/npx playwright --versi/npx -y playwright --version/g" "$TARGET_DEVPODS_DIR/setup.sh"
sed -i "s/npx playwright --versionon/npx -y playwright --version/g" "$TARGET_DEVPODS_DIR/setup.sh"
sed -i "s/npx playwright --version/npx -y playwright --version/g" "$TARGET_DEVPODS_DIR/setup.sh"

# --- PATCH 4: Bypass failing direnv curl install ---
sed -i "s@curl -sfL https://direnv.net/install.sh | bash@# & (Patched out, using apt/dnf install)@g" "$TARGET_DEVPODS_DIR/setup.sh"

echo "Patches applied."


# 6. --- EXECUTION SEQUENCE ---
echo ""
echo "============================================"
echo "✅ Dependencies installed. Running setup scripts..."
echo "============================================"
echo ""

# Set environment variables required by your scripts
export WORKSPACE_FOLDER="$(pwd)"
export DEVPOD_WORKSPACE_FOLDER="$(pwd)"
export AGENTS_DIR="$(pwd)/agents" # As defined in your setup.sh
export DEVPOD_DIR="$(pwd)/devpods"

echo "Running ./devpods/setup.sh..."
bash "$TARGET_DEVPODS_DIR/setup.sh"

echo ""
echo "Running ./devpods/post-setup.sh..."
bash "$TARGET_DEVPODS_DIR/post-setup.sh"

echo ""
echo "Running ./devpods/tmux-workspace.sh..."
# This script will take over the terminal and attach to tmux
bash "$TARGET_DEVPODS_DIR/tmux-workspace.sh"

echo "✅ Full setup complete."
