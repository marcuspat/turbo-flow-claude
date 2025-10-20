#!/bin/bash
#
# macOS installer for 'turbo-flow-claude' (Full Execution)
# Installs dependencies, copies devpods, patches for macOS + zsh,
# and runs all setup scripts in sequence.
# INCLUDES: Comprehensive npm cache clearing to prevent ENOTEMPTY errors

# Exit immediately if a command exits, or if an unset variable is used.
set -euo pipefail

echo "🚀 Starting macOS setup for turbo-flow-claude..."

# 1. Install Homebrew (if not installed)
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for this session
    # For Apple Silicon
    if [ -d "/opt/homebrew/bin" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    # For Intel Macs
    elif [ -d "/usr/local/bin" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "Homebrew is already installed. Updating..."
    brew update
fi

# 2. Install Core Dependencies
echo "Installing core dependencies (git, curl, tmux, htop, python, direnv)..."
brew install git curl tmux htop python direnv

# 3. Clean npm Cache BEFORE Node.js Installation
echo "🧹 Cleaning npm cache to prevent ENOTEMPTY errors..."
echo "Killing any running node/npm processes..."
killall node npm > /dev/null 2>&1 || true
sleep 1

echo "Removing npm cache directories..."
rm -rf ~/.npm || true
rm -rf ~/.npm/_npx || true
rm -rf ~/Library/npm-cache || true

echo "Running npm cache clean --force..."
if command -v npm &> /dev/null; then
    npm cache clean --force || true
    npm cache verify || true
fi

echo "✅ npm cache cleaned successfully."

# 4. Install NVM (Node Version Manager)
echo "Installing nvm (Node Version Manager)..."
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load nvm for the current session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# 5. Install Node.js LTS
echo "Installing latest LTS version of Node.js..."
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

echo "Node.js $(node -v) and npm $(npm -v) installed."

# 6. Final npm Cleanup After Installation
echo "🧹 Performing final npm cache cleanup after Node.js installation..."
npm cache clean --force
npm cache verify
rm -rf ~/.npm/_npx || true

echo "✅ npm is clean and ready."

# 7. Clone Repo, Copy Devpods, and Clean Up
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

# 8. Make scripts executable and apply patches
echo "Making scripts executable..."
chmod +x "$TARGET_DEVPODS_DIR/setup.sh"
chmod +x "$TARGET_DEVPODS_DIR/post-setup.sh"
chmod +x "$TARGET_DEVPODS_DIR/tmux-workspace.sh"

echo "Patching setup.sh for macOS compatibility..."

# --- PATCH 1: Fix 'sed' syntax for macOS ---
sed -i '' "s/sed -i.bak '\$ d' .mcp.json/sed -i '.bak' '\$ d' .mcp.json/g" "$TARGET_DEVPODS_DIR/setup.sh"
sed -i '' "s/sed -i '\$ d' .mcp.json/sed -i '' '\$ d' .mcp.json/g" "$TARGET_DEVPODS_DIR/setup.sh"

# --- PATCH 2: Fix 'claude mcp add' idempotency (allow to fail) ---
sed -i '' "s/claude mcp add playwright .*/& || true/g" "$TARGET_DEVPODS_DIR/setup.sh"
sed -i '' "s/claude mcp add chrome-devtools .*/& || true/g" "$TARGET_DEVPODS_DIR/setup.sh"
sed -i '' "s/claude mcp add chrome-mcp .*/& || true/g" "$TARGET_DEVPODS_DIR/setup.sh"

# --- PATCH 3: Fix alias file for zsh ---
SHELL_PROFILE="$HOME/.bashrc"
if [ "$SHELL" = "/bin/zsh" ]; then
    SHELL_PROFILE="$HOME/.zshrc"
    echo "Detected zsh. Aliases will be added to $SHELL_PROFILE"
fi
sed -i '' "s|~/.bashrc|$SHELL_PROFILE|g" "$TARGET_DEVPODS_DIR/setup.sh"

# --- PATCH 4: Fix npx prompt stall and typos ---
sed -i '' "s/npx playwright --versi/npx -y playwright --version/g" "$TARGET_DEVPODS_DIR/setup.sh"
sed -i '' "s/npx playwright --versionon/npx -y playwright --version/g" "$TARGET_DEVPODS_DIR/setup.sh"
sed -i '' "s/npx playwright --version/npx -y playwright --version/g" "$TARGET_DEVPODS_DIR/setup.sh"

# --- PATCH 5: Add --yes flag to all npx commands to prevent stalls ---
sed -i '' "s/^npx /npx --yes /g" "$TARGET_DEVPODS_DIR/setup.sh"

# --- PATCH 6: Bypass failing direnv curl install ---
# Use @ as the delimiter since the string contains a |
sed -i '' "s@curl -sfL https://direnv.net/install.sh | bash@# & (Patched out, using brew install)@g" "$TARGET_DEVPODS_DIR/setup.sh"

echo "Patches applied."


# 9. --- EXECUTION SEQUENCE ---
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
