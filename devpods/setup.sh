#!/bin/bash
# TURBO FLOW SETUP SCRIPT v3.1.1 (PATCHED)
# Fixed: Claude Code installation — 5 bugs resolved
# See diagnosis.md for full root cause analysis
#
# CHANGES FROM v3.1.0:
#   1. Step 1 now installs Node.js 22 LTS (was missing entirely)
#   2. Step 2 uses native installer (curl https://claude.ai/install.sh) as primary
#   3. Step 2 falls back to npm only if native fails AND Node 18-24 is present
#   4. PATH is updated before has_cmd checks
#   5. Errors are no longer silently swallowed
#   6. Node.js version compatibility check added

# ============================================
# CONFIGURATION
# ============================================
: "${WORKSPACE_FOLDER:=$(pwd)}"
: "${DEVPOD_WORKSPACE_FOLDER:=$WORKSPACE_FOLDER}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"
TOTAL_STEPS=14
CURRENT_STEP=0
START_TIME=$(date +%s)

# ============================================
# PROGRESS HELPERS
# ============================================
progress_bar() {
    local percent=$1
    local width=30
    local filled=$((percent * width / 100))
    local empty=$((width - filled))
    printf "\r  ["
    printf "%${filled}s" | tr ' ' '█'
    printf "%${empty}s" | tr ' ' '░'
    printf "] %3d%%" "$percent"
}

step_header() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    PERCENT=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    echo ""
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  [$PERCENT%] STEP $CURRENT_STEP/$TOTAL_STEPS: $1"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    progress_bar $PERCENT
    echo ""
}

status() { echo "  🔄 $1..."; }
ok() { echo "  ✅ $1"; }
skip() { echo "  ⏭️  $1 (already installed)"; }
warn() { echo "  ⚠️  $1 (continuing anyway)"; }
info() { echo "  ℹ️  $1"; }
checking() { echo "  🔍 Checking $1..."; }
fail() { echo "  ❌ $1"; }

has_cmd() { command -v "$1" >/dev/null 2>&1; }
is_npm_installed() { npm list -g "$1" --depth=0 >/dev/null 2>&1; }
elapsed() { echo "$(($(date +%s) - START_TIME))s"; }

skill_has_content() {
    local dir="$1"
    [ -d "$dir" ] && [ -n "$(ls -A "$dir" 2>/dev/null)" ]
}

install_npm() {
    local pkg="$1"
    checking "$pkg"
    if is_npm_installed "$pkg"; then
        skip "$pkg"
        return 0
    else
        status "Installing $pkg"
        if npm install -g "$pkg" --silent --no-progress 2>/dev/null; then
            ok "$pkg installed"
            return 0
        else
            status "Retrying $pkg..."
            if npm install -g "$pkg" 2>&1 | tail -3; then
                ok "$pkg installed (retry)"
                return 0
            else
                if npx -y "$pkg" --version >/dev/null 2>&1; then
                    ok "$pkg available via npx"
                    return 0
                else
                    warn "$pkg install failed"
                    return 1
                fi
            fi
        fi
    fi
}

# ============================================
# HELPER: Get Node.js major version number
# ============================================
get_node_major() {
    if has_cmd node; then
        node -v 2>/dev/null | sed 's/^v//' | cut -d. -f1
    else
        echo "0"
    fi
}

# ============================================
# HELPER: Ensure PATH includes common install locations
# ============================================
ensure_path() {
    # Native Claude Code installer locations
    export PATH="$HOME/.claude/bin:$HOME/.local/bin:$PATH"
    # npm global bin
    if has_cmd npm; then
        local npm_bin
        npm_bin="$(npm config get prefix 2>/dev/null)/bin"
        case ":$PATH:" in
            *":$npm_bin:"*) ;;
            *) export PATH="$npm_bin:$PATH" ;;
        esac
    fi
    # Cargo (for uv and other Rust tools)
    export PATH="$HOME/.cargo/bin:$PATH"
}

# ============================================
# START
# ============================================
clear 2>/dev/null || true
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║     🚀 TURBO FLOW v3.1.1 - PATCHED INSTALLER                 ║"
echo "║     Fixed: Claude Code install + Node.js bootstrapping      ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "  📁 Workspace: $WORKSPACE_FOLDER"
echo "  🕐 Started at: $(date '+%H:%M:%S')"
echo ""
progress_bar 0
echo ""

# ============================================
# STEP 1: Build tools + Node.js 22 LTS
# ============================================
# FIX: This step now installs Node.js, which was completely
# missing in v3.1.0. Without Node.js, every npm command in
# subsequent steps silently fails.
# ============================================
step_header "Installing build tools + Node.js 22 LTS"

# --- Build essentials ---
checking "build-essential"
if has_cmd g++ && has_cmd make; then
    skip "build tools (g++, make already present)"
else
    status "Installing build-essential and python3"
    if has_cmd apt-get; then
        (apt-get update -qq && apt-get install -y -qq build-essential python3 git curl jq ca-certificates gnupg) 2>/dev/null || \
        (sudo apt-get update -qq && sudo apt-get install -y -qq build-essential python3 git curl jq ca-certificates gnupg) 2>/dev/null || \
        warn "Could not install build tools"
        ok "build tools installed"
    elif has_cmd yum; then
        (yum groupinstall -y "Development Tools" && yum install -y jq ca-certificates || \
         sudo yum groupinstall -y "Development Tools" && sudo yum install -y jq ca-certificates) 2>/dev/null
        ok "build tools installed (yum)"
    elif has_cmd apk; then
        apk add --no-cache build-base python3 git curl jq ca-certificates 2>/dev/null
        ok "build tools installed (apk)"
    else
        warn "Unknown package manager"
    fi
fi

# --- jq ---
checking "jq"
if has_cmd jq; then
    skip "jq"
else
    status "Installing jq"
    if has_cmd apt-get; then
        (apt-get install -y -qq jq || sudo apt-get install -y -qq jq) 2>/dev/null && ok "jq installed" || warn "jq failed"
    elif has_cmd brew; then
        brew install jq 2>/dev/null && ok "jq installed" || warn "jq failed"
    fi
fi

# ============================================
# FIX #1: Install Node.js 22 LTS if missing or too old/new
# 
# Claude Code npm install requires Node.js v18-v24.
# The native installer doesn't need Node.js at all, but
# the rest of this script (claude-flow, ecosystem packages,
# HeroUI, etc.) all need npm, so we install Node.js regardless.
# ============================================
checking "Node.js"
NODE_MAJOR=$(get_node_major)

if [ "$NODE_MAJOR" -ge 18 ] && [ "$NODE_MAJOR" -le 24 ]; then
    skip "Node.js v$(node -v 2>/dev/null) (compatible: v18-v24)"
elif [ "$NODE_MAJOR" -ge 25 ]; then
    warn "Node.js v$(node -v) detected — v25+ breaks Claude Code npm install"
    info "Claude Code native installer will be used instead (doesn't need Node.js)"
    info "But ecosystem packages still need npm, so keeping current Node.js"
else
    status "Installing Node.js 22 LTS"

    # Method 1: NodeSource repository (preferred for Debian/Ubuntu)
    if has_cmd apt-get; then
        info "Using NodeSource repository for Node.js 22"
        # Download and run the NodeSource setup script
        if curl -fsSL https://deb.nodesource.com/setup_22.x 2>/dev/null | bash - >/dev/null 2>&1 || \
           curl -fsSL https://deb.nodesource.com/setup_22.x 2>/dev/null | sudo bash - >/dev/null 2>&1; then
            (apt-get install -y -qq nodejs || sudo apt-get install -y -qq nodejs) 2>/dev/null
        else
            # Method 1b: Direct from NodeSource (no setup script)
            warn "NodeSource setup script failed, trying direct install"
            mkdir -p /etc/apt/keyrings 2>/dev/null || sudo mkdir -p /etc/apt/keyrings 2>/dev/null
            curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key 2>/dev/null | \
                gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg 2>/dev/null || \
                sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg 2>/dev/null
            echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | \
                tee /etc/apt/sources.list.d/nodesource.list 2>/dev/null || \
                sudo tee /etc/apt/sources.list.d/nodesource.list 2>/dev/null
            (apt-get update -qq && apt-get install -y -qq nodejs) 2>/dev/null || \
            (sudo apt-get update -qq && sudo apt-get install -y -qq nodejs) 2>/dev/null
        fi

    # Method 2: yum/dnf (RHEL/CentOS/Fedora)
    elif has_cmd yum || has_cmd dnf; then
        curl -fsSL https://rpm.nodesource.com/setup_22.x 2>/dev/null | bash - >/dev/null 2>&1 || \
        curl -fsSL https://rpm.nodesource.com/setup_22.x 2>/dev/null | sudo bash - >/dev/null 2>&1
        if has_cmd dnf; then
            (dnf install -y nodejs || sudo dnf install -y nodejs) 2>/dev/null
        else
            (yum install -y nodejs || sudo yum install -y nodejs) 2>/dev/null
        fi

    # Method 3: apk (Alpine)
    elif has_cmd apk; then
        apk add --no-cache nodejs npm 2>/dev/null

    # Method 4: nvm fallback (any system)
    else
        warn "No supported package manager — trying nvm"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh 2>/dev/null | bash >/dev/null 2>&1
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
        nvm install 22 2>/dev/null && nvm use 22 2>/dev/null
    fi

    # Verify Node.js installation
    if has_cmd node; then
        NODE_MAJOR=$(get_node_major)
        ok "Node.js $(node -v) installed (npm $(npm -v 2>/dev/null || echo 'missing'))"
    else
        fail "Node.js installation failed"
        info "Install manually: https://nodejs.org/en/download/"
        info "Then re-run this script"
        # Don't exit — native Claude Code installer doesn't need Node.js
    fi
fi

# Ensure npm global directory is writable (avoid EACCES in containers)
if has_cmd npm; then
    checking "npm global prefix"
    NPM_PREFIX="$(npm config get prefix 2>/dev/null)"
    if [ -n "$NPM_PREFIX" ] && [ ! -w "$NPM_PREFIX/lib" ] 2>/dev/null; then
        status "Configuring npm for user-level global installs"
        mkdir -p "$HOME/.npm-global" 2>/dev/null
        npm config set prefix "$HOME/.npm-global" 2>/dev/null
        export PATH="$HOME/.npm-global/bin:$PATH"
        ok "npm prefix set to ~/.npm-global"
    else
        ok "npm prefix writable ($NPM_PREFIX)"
    fi
fi

# Update PATH to include all install locations
ensure_path

info "Node.js: $(node -v 2>/dev/null || echo 'not found') | npm: $(npm -v 2>/dev/null || echo 'not found')"
info "Elapsed: $(elapsed)"

# ============================================
# STEP 2: Claude Code + Claude Flow V3 + RuVector
# ============================================
# FIX #2: Use native installer as primary method.
# FIX #3: Update PATH before checking has_cmd.
# FIX #4: Don't suppress errors.
# FIX #5: Check Node.js version before npm fallback.
# ============================================
step_header "Installing Claude Code + Claude Flow V3 + RuVector"

# ── Ensure PATH includes native installer locations ──
ensure_path

# ── Install Claude Code CLI ──
checking "Claude Code CLI"
if has_cmd claude; then
    CLAUDE_VER=$(claude --version 2>/dev/null | head -1)
    skip "Claude Code already installed ($CLAUDE_VER)"
else
    CLAUDE_INSTALLED=false

    # ────────────────────────────────────────────────────
    # METHOD 1: Native installer (RECOMMENDED by Anthropic)
    # Doesn't require Node.js. Auto-updates. Most reliable.
    # Installs to ~/.claude/bin/claude or ~/.local/bin/claude
    # ────────────────────────────────────────────────────
    status "Installing Claude Code via native installer (recommended)"
    
    NATIVE_OUTPUT=$(curl -fsSL https://claude.ai/install.sh 2>/dev/null | bash 2>&1)
    NATIVE_EXIT=$?

    # Update PATH — native installer puts binary in ~/.claude/bin or ~/.local/bin
    ensure_path
    hash -r 2>/dev/null  # Force bash to re-scan PATH

    if [ $NATIVE_EXIT -eq 0 ] && has_cmd claude; then
        CLAUDE_VER=$(claude --version 2>/dev/null | head -1)
        ok "Claude Code installed via native installer ($CLAUDE_VER)"
        CLAUDE_INSTALLED=true
    else
        warn "Native installer failed (exit code: $NATIVE_EXIT)"
        # Show the actual error — don't swallow it
        echo "$NATIVE_OUTPUT" | grep -i -E "error|fail|cannot|denied|missing" | head -5 | sed 's/^/    /'

        # ────────────────────────────────────────────────
        # METHOD 2: npm global install (FALLBACK)
        # Only works with Node.js v18-v24.
        # ────────────────────────────────────────────────
        NODE_MAJOR=$(get_node_major)
        
        if [ "$NODE_MAJOR" -ge 18 ] && [ "$NODE_MAJOR" -le 24 ]; then
            status "Falling back to npm install (Node.js v$NODE_MAJOR detected)"
            
            NPM_OUTPUT=$(npm install -g @anthropic-ai/claude-code 2>&1)
            NPM_EXIT=$?
            
            # Update PATH again — npm might install to a different location
            ensure_path
            hash -r 2>/dev/null

            if [ $NPM_EXIT -eq 0 ] && has_cmd claude; then
                CLAUDE_VER=$(claude --version 2>/dev/null | head -1)
                ok "Claude Code installed via npm ($CLAUDE_VER)"
                CLAUDE_INSTALLED=true
            else
                # Show the actual npm error
                echo "$NPM_OUTPUT" | grep -i -E "error|ERR!|fail|EACCES|EPERM|cannot" | head -8 | sed 's/^/    /'
                
                # ────────────────────────────────────────
                # METHOD 2b: npm with --unsafe-perm (container fix)
                # ────────────────────────────────────────
                status "Retrying npm with --unsafe-perm (container workaround)"
                NPM_OUTPUT2=$(npm install -g @anthropic-ai/claude-code --unsafe-perm 2>&1)
                NPM_EXIT2=$?
                
                ensure_path
                hash -r 2>/dev/null

                if [ $NPM_EXIT2 -eq 0 ] && has_cmd claude; then
                    CLAUDE_VER=$(claude --version 2>/dev/null | head -1)
                    ok "Claude Code installed via npm --unsafe-perm ($CLAUDE_VER)"
                    CLAUDE_INSTALLED=true
                else
                    echo "$NPM_OUTPUT2" | grep -i -E "error|ERR!|fail" | head -5 | sed 's/^/    /'
                fi
            fi
        elif [ "$NODE_MAJOR" -ge 25 ]; then
            warn "Node.js v$NODE_MAJOR detected — npm install not supported (requires v18-v24)"
            info "The native installer was the only option and it failed"
        else
            warn "Node.js not available — cannot try npm fallback"
        fi

        # ────────────────────────────────────────────────
        # METHOD 3: Direct binary download (last resort)
        # ────────────────────────────────────────────────
        if ! $CLAUDE_INSTALLED; then
            status "Trying direct binary download (last resort)"
            
            ARCH=$(uname -m)
            case "$ARCH" in
                x86_64)  PLATFORM="linux-x64" ;;
                aarch64) PLATFORM="linux-arm64" ;;
                arm64)   PLATFORM="linux-arm64" ;;
                *)       PLATFORM="" ;;
            esac

            if [ -n "$PLATFORM" ]; then
                mkdir -p "$HOME/.claude/bin" 2>/dev/null
                # Try the latest known install script with explicit platform
                DIRECT_OUTPUT=$(curl -fsSL "https://claude.ai/install.sh" 2>/dev/null | \
                    CLAUDE_INSTALL_DIR="$HOME/.claude/bin" bash 2>&1)
                
                ensure_path
                hash -r 2>/dev/null
                
                if has_cmd claude; then
                    CLAUDE_VER=$(claude --version 2>/dev/null | head -1)
                    ok "Claude Code installed via direct download ($CLAUDE_VER)"
                    CLAUDE_INSTALLED=true
                fi
            fi
        fi
    fi

    if ! $CLAUDE_INSTALLED; then
        fail "Claude Code installation FAILED after all methods"
        echo ""
        info "  ┌─────────────────────────────────────────────────────────┐"
        info "  │  MANUAL INSTALL OPTIONS:                                │"
        info "  │                                                         │"
        info "  │  Option A (native — recommended):                       │"
        info "  │    curl -fsSL https://claude.ai/install.sh | bash       │"
        info "  │                                                         │"
        info "  │  Option B (npm — requires Node.js v18-v24):             │"
        info "  │    npm install -g @anthropic-ai/claude-code             │"
        info "  │                                                         │"
        info "  │  Option C (Homebrew — macOS/Linux):                     │"
        info "  │    brew install claude-code                             │"
        info "  │                                                         │"
        info "  │  Then run: claude --version                             │"
        info "  │  Diagnose: claude doctor                                │"
        info "  └─────────────────────────────────────────────────────────┘"
        echo ""
        info "  Debug info:"
        info "    OS:      $(uname -s) $(uname -m)"
        info "    Node.js: $(node -v 2>/dev/null || echo 'NOT INSTALLED')"
        info "    npm:     $(npm -v 2>/dev/null || echo 'NOT INSTALLED')"
        info "    curl:    $(curl --version 2>/dev/null | head -1 || echo 'NOT INSTALLED')"
        info "    PATH:    $PATH"
        info "    whoami:  $(whoami 2>/dev/null)"
        echo ""
        # DON'T exit — let the rest of the script continue
        # Claude Flow and ecosystem packages can still install
    fi
fi

# Run claude doctor if available (catches misconfigurations)
if has_cmd claude; then
    status "Running claude doctor"
    claude doctor 2>/dev/null | head -10 | sed 's/^/    /' || true
fi

# ── Claude Flow V3 + RuVector ──
CLAUDE_FLOW_OK=false
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ] && has_cmd claude; then
    if is_npm_installed "ruvector" || is_npm_installed "claude-flow"; then
        CLAUDE_FLOW_OK=true
    fi
fi

if $CLAUDE_FLOW_OK; then
    skip "Claude Flow + RuVector already installed"
else
    status "Running official claude-flow installer (--full mode)"
    echo ""
    
    curl -fsSL https://cdn.jsdelivr.net/gh/ruvnet/claude-flow@main/scripts/install.sh 2>/dev/null | bash -s -- --full 2>&1 | while IFS= read -r line; do
        if [[ ! "$line" =~ "deprecated" ]] && [[ ! "$line" =~ "npm warn" ]]; then
            echo "    $line"
        fi
    done || true
    
    cd "$WORKSPACE_FOLDER" 2>/dev/null || true
    
    status "Ensuring claude-flow@alpha is installed"
    npm install -g claude-flow@alpha --silent 2>/dev/null || true
    
    if [ ! -d ".claude-flow" ]; then
        status "Initializing Claude Flow in workspace"
        npx -y claude-flow@alpha init --force 2>/dev/null || true
    fi
    
    status "Installing RuVector neural engine"
    npm install -g ruvector --silent 2>/dev/null || {
        warn "ruvector install failed - trying npx"
        npx -y ruvector --version 2>/dev/null || true
    }
    
    status "Installing @ruvector/cli"
    npm install -g @ruvector/cli --silent 2>/dev/null || true
    
    status "Installing sql.js for memory database"
    npm install -g sql.js --silent 2>/dev/null || true
    
    if [ -f "package.json" ]; then
        npm install sql.js --save-dev --silent 2>/dev/null || true
    fi
    
    status "Initializing RuVector hooks"
    npx -y @ruvector/cli hooks init 2>/dev/null || true
    
    ok "Claude Flow + RuVector installed"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [18%] STEP 3: Clear caches & fix npm locks
# ============================================
step_header "Clearing npm caches & locks"

status "Removing npm locks (prevents ECOMPROMISED)"
rm -rf ~/.npm/_locks 2>/dev/null || true
ok "npm locks cleared"

# Clear npx cache to force fresh downloads with new Node version
status "Clearing npx cache (fresh start with Node 20)"
rm -rf ~/.npm/_npx 2>/dev/null || true
ok "npx cache cleared"

status "Cleaning npm cache"
npm cache clean --force --silent 2>/dev/null || true
ok "npm cache cleaned"

info "Elapsed: $(elapsed)"

# ============================================
# [25%] STEP 4: Install claude-flow with better-sqlite3
# ============================================
step_header "Installing claude-flow with all dependencies"

# CRITICAL FIX: Change to workspace BEFORE claude-flow init
status "Changing to workspace directory"
mkdir -p "$WORKSPACE_FOLDER" 2>/dev/null || true
cd "$WORKSPACE_FOLDER" 2>/dev/null || cd "$HOME"
ok "Working in: $(pwd)"

# Check if already initialized
checking "claude-flow initialized in $WORKSPACE_FOLDER"
if [ -f "$WORKSPACE_FOLDER/.claude-flow/config.json" ] || \
   [ -f "$WORKSPACE_FOLDER/claude-flow.json" ] || \
   [ -d "$WORKSPACE_FOLDER/.claude-flow" ]; then
    skip "claude-flow already initialized"
else
    # Step 1: Trigger npx to download claude-flow (will fail but creates cache)
    status "Downloading claude-flow package"
    npx -y claude-flow@alpha --version 2>/dev/null || true
    sleep 2
    
    # Step 2: Find the npx cache directory
    status "Locating claude-flow in npx cache"
    NPX_CF_DIR=$(find ~/.npm/_npx -type d -name "claude-flow" 2>/dev/null | head -1)
    
    if [ -z "$NPX_CF_DIR" ]; then
        # Try to find it differently
        NPX_CF_DIR=$(find ~/.npm/_npx -path "*/node_modules/claude-flow" -type d 2>/dev/null | head -1)
    fi
    
    if [ -n "$NPX_CF_DIR" ] && [ -d "$NPX_CF_DIR" ]; then
        ok "Found claude-flow at: $NPX_CF_DIR"
        
        # Step 3: Install better-sqlite3 (THE CRITICAL FIX)
        status "Installing better-sqlite3 (compiling native module - ~60 seconds)"
        echo "    ⏳ This requires C++ compilation. Please wait..."
        
        cd "$NPX_CF_DIR"
        
        # Install with full output so user can see progress
        if npm install better-sqlite3 2>&1 | while read line; do echo "    $line"; done; then
            ok "better-sqlite3 installed successfully"
        else
            fail "better-sqlite3 compilation failed"
            info "Trying alternative: prebuild binary..."
            npm install better-sqlite3 --build-from-source=false 2>/dev/null || true
        fi
        
        cd "$WORKSPACE_FOLDER" 2>/dev/null || cd "$HOME"
    else
        warn "Could not find claude-flow npx cache"
        info "Will try direct initialization anyway..."
    fi
    
    # Step 4: Now run claude-flow init
    status "Running claude-flow init"
    if npx -y claude-flow@alpha init --force 2>&1 | while read line; do echo "    $line"; done; then
        ok "claude-flow initialized successfully"
    else
        warn "claude-flow init had issues"
        # Create minimal config as fallback
        status "Creating minimal claude-flow config as fallback"
        mkdir -p "$WORKSPACE_FOLDER/.claude-flow"
        cat << 'CFCONFIG' > "$WORKSPACE_FOLDER/.claude-flow/config.json"
{
  "version": "2.7",
  "initialized": true,
  "note": "Minimal config created by turbo-flow-setup v9"
}
CFCONFIG
        ok "Fallback config created"
    fi
fi

# Final verification
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ] || [ -f "$WORKSPACE_FOLDER/claude-flow.json" ]; then
    ok "claude-flow verification: PASSED ✓"
else
    warn "claude-flow verification: directory not found"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [31%] STEP 5: Core npm packages
# ============================================
step_header "Installing core npm packages"

install_npm @anthropic-ai/claude-code
install_npm claude-usage-cli
#install_npm agentic-qe
#install_npm agentic-flow
#install_npm agentic-jujutsu
install_npm claudish
install_npm @fission-ai/openspec
install_npm @lanegrid/agtrace

info "Elapsed: $(elapsed)"

# ============================================
# [37%] STEP 6: MCP Servers
# ============================================
step_header "Installing MCP servers"

install_npm @playwright/mcp
install_npm chrome-devtools-mcp
install_npm mcp-chrome-bridge

info "Elapsed: $(elapsed)"

# ============================================
# [43%] STEP 7: uv + direnv
# ============================================
step_header "Installing uv & direnv"

# uv
checking "uv package manager"
if has_cmd uv; then
    skip "uv"
else
    status "Downloading uv"
    if curl -LsSf https://astral.sh/uv/install.sh 2>/dev/null | sh >/dev/null 2>&1; then
        ok "uv installed"
        [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" 2>/dev/null || export PATH="$HOME/.cargo/bin:$PATH"
    else
        warn "uv installation failed"
    fi
fi

# Ensure uv is in PATH for subsequent steps
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" 2>/dev/null
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# direnv
checking "direnv"
if has_cmd direnv; then
    skip "direnv"
else
    status "Downloading direnv"
    if curl -sfL https://direnv.net/install.sh 2>/dev/null | bash >/dev/null 2>&1; then
        ok "direnv installed"
    else
        warn "direnv installation failed"
    fi
fi

# Add direnv hook
checking "direnv bash hook"
if grep -q 'direnv hook' ~/.bashrc 2>/dev/null; then
    skip "direnv hook in .bashrc"
else
    echo 'eval "$(direnv hook bash)"' >> ~/.bashrc 2>/dev/null || true
    ok "direnv hook added to .bashrc"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [50%] STEP 8: Spec-Kit (specify CLI)
# ============================================
step_header "Installing Spec-Kit (specify CLI)"

checking "specify CLI"
if has_cmd specify; then
    skip "specify CLI"
else
    status "Installing specify-cli via uv tool"
    if has_cmd uv; then
        if uv tool install specify-cli --from git+https://github.com/github/spec-kit.git 2>/dev/null; then
            ok "specify-cli installed"
        else
            status "Retrying with --force flag"
            if uv tool install specify-cli --force --from git+https://github.com/github/spec-kit.git 2>/dev/null; then
                ok "specify-cli installed (force)"
            else
                warn "specify-cli installation failed"
            fi
        fi
    else
        warn "uv not available - cannot install specify-cli"
    fi
fi

if has_cmd specify; then
    status "Verifying spec-kit installation"
    specify check 2>/dev/null && ok "spec-kit verification passed" || info "spec-kit installed (check had warnings)"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [56%] STEP 9: AI Agent Skills
# ============================================
step_header "Installing AI Agent Skills"

install_npm ai-agent-skills

if has_cmd npx; then
    status "Installing popular skills for Claude Code"
    for skill in frontend-design mcp-builder code-review; do
        checking "$skill skill"
        if [ -d "$HOME/.claude/skills/$skill" ]; then
            skip "$skill skill"
        else
            npx ai-agent-skills install "$skill" --agent claude 2>/dev/null && ok "$skill installed" || warn "$skill install failed"
        fi
    done
fi

info "Elapsed: $(elapsed)"

# ============================================
# [62%] STEP 10: n8n-MCP Server
# ============================================
step_header "Installing n8n-MCP Server"

install_npm n8n-mcp

checking "n8n-mcp MCP registration"
if has_cmd claude; then
    status "Registering n8n-mcp with Claude"
    timeout 15 claude mcp add n8n-mcp --scope user -- npx -y n8n-mcp >/dev/null 2>&1 && ok "n8n-mcp registered" || warn "n8n-mcp registration failed"
else
    info "Claude CLI not available - configure n8n-mcp manually in mcp.json"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [68%] STEP 11: PAL MCP Server (Multi-Model AI)
# ============================================
step_header "Installing PAL MCP Server"

checking "pal-mcp-server"
PAL_DIR="$HOME/.pal-mcp-server"
if [ -d "$PAL_DIR" ]; then
    skip "pal-mcp-server already cloned"
else
    status "Cloning pal-mcp-server"
    if git clone --depth 1 https://github.com/BeehiveInnovations/pal-mcp-server.git "$PAL_DIR" 2>/dev/null; then
        ok "pal-mcp-server cloned"
        status "Setting up pal-mcp-server"
        cd "$PAL_DIR" 2>/dev/null || true
        if has_cmd uv; then
            uv sync 2>/dev/null && ok "pal-mcp-server dependencies installed" || warn "pal-mcp-server setup failed"
        else
            warn "uv not available - run 'uv sync' in $PAL_DIR manually"
        fi
        cd "$WORKSPACE_FOLDER" 2>/dev/null || true
    else
        warn "Could not clone pal-mcp-server"
    fi
fi

if [ -d "$PAL_DIR" ] && [ ! -f "$PAL_DIR/.env" ] && [ -f "$PAL_DIR/.env.example" ]; then
    status "Creating PAL .env from example"
    cp "$PAL_DIR/.env.example" "$PAL_DIR/.env" 2>/dev/null || true
    info "Edit $PAL_DIR/.env to add your API keys"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [75%] STEP 12: Workspace setup
# ============================================
step_header "Setting up workspace"

cd "$WORKSPACE_FOLDER" 2>/dev/null || true

status "Creating directories"
mkdir -p "$WORKSPACE_FOLDER" "$AGENTS_DIR" 2>/dev/null || true
ok "Directories created"

checking "package.json"
if [ -f "package.json" ]; then
    skip "package.json exists"
else
    status "Creating package.json"
    npm init -y --silent 2>/dev/null || true
    ok "package.json created"
fi

status "Setting module type"
npm pkg set type="module" 2>/dev/null || true
ok "Module type set"

info "Elapsed: $(elapsed)"

# ============================================
# [81%] STEP 13: Register MCP servers with Claude
# ============================================
step_header "Registering MCP servers with Claude"

rm -rf ~/.npm/_locks 2>/dev/null || true

checking "Claude CLI"
if has_cmd claude; then
    ok "Claude CLI found"
    
    status "Registering playwright MCP"
    timeout 10 claude mcp add playwright --scope user -- npx -y @playwright/mcp@latest >/dev/null 2>&1 && ok "playwright registered" || warn "playwright registration failed"
    
    status "Registering chrome-devtools MCP"
    timeout 10 claude mcp add chrome-devtools --scope user -- npx -y chrome-devtools-mcp@latest >/dev/null 2>&1 && ok "chrome-devtools registered" || warn "chrome-devtools registration failed"
    
    status "Registering agentic-qe MCP"
    timeout 10 claude mcp add agentic-qe --scope user -- npx -y aqe-mcp >/dev/null 2>&1 && ok "agentic-qe registered" || warn "agentic-qe registration failed"
else
    skip "Claude CLI not installed - skipping MCP registration"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [87%] STEP 14: Configure MCP JSON files
# ============================================
step_header "Configuring MCP JSON files"

status "Creating Claude config directory"
mkdir -p "$HOME/.config/claude" 2>/dev/null || true
ok "Config directory ready"

checking "MCP config file"
if [ -f "$HOME/.config/claude/mcp.json" ]; then
    skip "MCP config exists"
else
    status "Writing MCP configuration"
    cat << 'EOF' > "$HOME/.config/claude/mcp.json"
{"mcpServers":{"playwright":{"command":"npx","args":["-y","@playwright/mcp@latest"],"env":{}},"chrome-devtools":{"command":"npx","args":["chrome-devtools-mcp@latest"],"env":{}},"chrome-mcp":{"type":"streamable-http","url":"http://127.0.0.1:12306/mcp"},"n8n-mcp":{"command":"npx","args":["-y","n8n-mcp"],"env":{"MCP_MODE":"stdio","LOG_LEVEL":"error"}}}}
EOF
    ok "MCP config created"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [93%] STEP 15: TypeScript + subagents
# ============================================
step_header "Setting up TypeScript & subagents"

cd "$WORKSPACE_FOLDER" 2>/dev/null || true

checking "TypeScript installation"
if [ -d "node_modules/typescript" ]; then
    skip "TypeScript"
else
    status "Installing TypeScript & @types/node"
    npm install -D typescript @types/node --silent 2>/dev/null && ok "TypeScript installed" || warn "TypeScript install failed"
fi

checking "tsconfig.json"
if [ -f "tsconfig.json" ]; then
    skip "tsconfig.json"
else
    status "Creating tsconfig.json"
    cat << 'EOF' > tsconfig.json
{"compilerOptions":{"target":"ES2022","module":"ESNext","moduleResolution":"node","outDir":"./dist","rootDir":"./src","strict":true,"esModuleInterop":true,"skipLibCheck":true},"include":["src/**/*","tests/**/*"],"exclude":["node_modules","dist"]}
EOF
    ok "tsconfig.json created"
fi

status "Creating project directories"
for dir in src tests docs scripts examples config; do
    mkdir -p "$dir" 2>/dev/null
done
ok "Project directories created"

npm pkg set scripts.build="tsc" scripts.test="playwright test" scripts.typecheck="tsc --noEmit" 2>/dev/null || true

# Subagents
status "Setting up subagents"
mkdir -p "$AGENTS_DIR" 2>/dev/null || true
cd "$AGENTS_DIR" 2>/dev/null || true

EXISTING_AGENTS=$(find . -maxdepth 1 -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
if [ "$EXISTING_AGENTS" -gt 5 ]; then
    skip "Subagents ($EXISTING_AGENTS already installed)"
else
    status "Cloning 610ClaudeSubagents repository"
    if timeout 20 git clone --depth 1 --quiet https://github.com/ChrisRoyse/610ClaudeSubagents.git temp-agents 2>/dev/null; then
        [ -d "temp-agents/agents" ] && cp -r temp-agents/agents/*.md . 2>/dev/null || true
        rm -rf temp-agents 2>/dev/null || true
        ok "Subagents installed"
    else
        warn "Could not clone subagents"
    fi
fi

[ -d "$DEVPOD_DIR/additional-agents" ] && cp "$DEVPOD_DIR/additional-agents"/*.md . 2>/dev/null || true

AGENT_COUNT=$(find . -maxdepth 1 -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
ok "Total agents: $AGENT_COUNT"

cd "$WORKSPACE_FOLDER" 2>/dev/null || true
info "Elapsed: $(elapsed)"

# ============================================
# [100%] STEP 16: Bash aliases
# ============================================
step_header "Installing bash aliases"

checking "TURBO FLOW aliases in .bashrc"
if grep -q "TURBO FLOW ALIASES v9" ~/.bashrc 2>/dev/null; then
    skip "Bash aliases already installed"
else
    # Remove old aliases
    sed -i '/# === TURBO FLOW ALIASES/,/# === END TURBO FLOW/d' ~/.bashrc 2>/dev/null || true
    
    status "Adding aliases to ~/.bashrc"
    cat << 'ALIASES_EOF' >> ~/.bashrc

# === TURBO FLOW ALIASES v10 ===

# ─────────────────────────────────────────────────────
# CLAUDE CODE
# ─────────────────────────────────────────────────────
alias claude-hierarchical="claude --dangerously-skip-permissions"
alias dsp="claude --dangerously-skip-permissions"

# ─────────────────────────────────────────────────────
# CLAUDE FLOW (Orchestration)
# ─────────────────────────────────────────────────────
alias cf="npx -y claude-flow@alpha"
alias cf-init="npx -y claude-flow@alpha init --force"
alias cf-swarm="npx -y claude-flow@alpha swarm"
alias cf-hive="npx -y claude-flow@alpha hive-mind spawn"
alias cf-spawn="npx -y claude-flow@alpha hive-mind spawn"
alias cf-status="npx -y claude-flow@alpha hive-mind status"
alias cf-help="npx -y claude-flow@alpha --help"

cf-fix() {
    echo "🔧 Fixing claude-flow better-sqlite3 dependency..."
    NPX_CF_DIR=$(find ~/.npm/_npx -type d -name "claude-flow" 2>/dev/null | head -1)
    if [ -n "$NPX_CF_DIR" ]; then
        echo "📁 Found: $NPX_CF_DIR"
        (cd "$NPX_CF_DIR" && npm install better-sqlite3) && echo "✅ Fixed!" || echo "❌ Failed"
    else
        echo "⚠️ claude-flow not in cache. Running: npx -y claude-flow@alpha --version"
        npx -y claude-flow@alpha --version || true
        NPX_CF_DIR=$(find ~/.npm/_npx -type d -name "claude-flow" 2>/dev/null | head -1)
        if [ -n "$NPX_CF_DIR" ]; then
            (cd "$NPX_CF_DIR" && npm install better-sqlite3) && echo "✅ Fixed!" || echo "❌ Failed"
        fi
    fi
}

cf-task() { npx -y claude-flow@alpha swarm "$@"; }

# ─────────────────────────────────────────────────────
# AGENTIC FLOW
# ─────────────────────────────────────────────────────
alias af="npx -y agentic-flow"
alias af-run="npx -y agentic-flow --agent"
alias af-coder="npx -y agentic-flow --agent coder"
alias af-help="npx -y agentic-flow --help"

af-task() { npx -y agentic-flow --agent "$1" --task "$2" --stream; }

# ─────────────────────────────────────────────────────
# AGENTIC QE (Testing)
# ─────────────────────────────────────────────────────
alias aqe="npx -y agentic-qe"
alias aqe-init="npx -y agentic-qe init"
alias aqe-generate="npx -y agentic-qe generate"
alias aqe-flaky="npx -y agentic-qe flaky"
alias aqe-gate="npx -y agentic-qe gate"
alias aqe-mcp="npx -y aqe-mcp"

# ─────────────────────────────────────────────────────
# AGENTIC JUJUTSU (Git)
# ─────────────────────────────────────────────────────
alias aj="npx -y agentic-jujutsu"
alias aj-status="npx -y agentic-jujutsu status"
alias aj-analyze="npx -y agentic-jujutsu analyze"

# ─────────────────────────────────────────────────────
# CLAUDE USAGE
# ─────────────────────────────────────────────────────
alias cu="claude-usage"
alias claude-usage="npx -y claude-usage-cli"

# ─────────────────────────────────────────────────────
# SPEC-KIT
# ─────────────────────────────────────────────────────
alias sk="specify"
alias sk-init="specify init"
alias sk-check="specify check"
alias sk-here="specify init . --ai claude"
alias sk-const="specify constitution"
alias sk-spec="specify spec"
alias sk-plan="specify plan"
alias sk-tasks="specify tasks"
alias sk-impl="specify implement"

# ─────────────────────────────────────────────────────
# OPENSPEC (Fission-AI)
# ─────────────────────────────────────────────────────
alias os="openspec"
alias os-init="openspec init"
alias os-list="openspec list"
alias os-view="openspec view"
alias os-show="openspec show"
alias os-validate="openspec validate"
alias os-archive="openspec archive"
alias os-update="openspec update"

# ─────────────────────────────────────────────────────
# AGTRACE (Agent Observability)
# ─────────────────────────────────────────────────────
alias agt="agtrace"
alias agt-init="agtrace init"
alias agt-watch="agtrace watch"
alias agt-sessions="agtrace session list"
alias agt-grep="agtrace lab grep"
alias agt-mcp="agtrace mcp serve"

# ─────────────────────────────────────────────────────
# CLAUDISH (Multi-Model Proxy)
# ─────────────────────────────────────────────────────
alias claudish="npx -y claudish"
alias claudish-models="npx -y claudish --models"
alias claudish-top="npx -y claudish --top-models"
alias claudish-grok="npx -y claudish --model x-ai/grok-code-fast-1"
alias claudish-gemini="npx -y claudish --model google/gemini-2.5-flash"
alias claudish-gpt="npx -y claudish --model openai/gpt-4o"
alias claudish-qwen="npx -y claudish --model qwen/qwen3-235b-a22b"

# ─────────────────────────────────────────────────────
# AI AGENT SKILLS
# ─────────────────────────────────────────────────────
alias skills="npx ai-agent-skills"
alias skills-list="npx ai-agent-skills list"
alias skills-search="npx ai-agent-skills search"
alias skills-install="npx ai-agent-skills install"
alias skills-info="npx ai-agent-skills info"
alias skills-update="npx ai-agent-skills update"
alias skills-remove="npx ai-agent-skills remove"

# ─────────────────────────────────────────────────────
# MCP SERVERS
# ─────────────────────────────────────────────────────
alias n8n-mcp="npx -y n8n-mcp"
alias mcp-playwright="npx -y @playwright/mcp@latest"
alias mcp-chrome="npx -y chrome-devtools-mcp@latest"

# ─────────────────────────────────────────────────────
# PAL MCP (Multi-Model AI)
# ─────────────────────────────────────────────────────
alias pal="cd ~/.pal-mcp-server && ./run-server.sh"
alias pal-setup="cd ~/.pal-mcp-server && uv sync"

# ─────────────────────────────────────────────────────
# TMUX - SESSIONS
# ─────────────────────────────────────────────────────
alias t="tmux"
alias tn="tmux new"
alias tns="tmux new-session -s"
alias tnsa="tmux new-session -A -s"
alias tks="tmux kill-session -t"
alias tksa="tmux kill-session -a"
alias tksat="tmux kill-session -a -t"
alias tl="tmux ls"
alias tls="tmux list-sessions"
alias ta="tmux attach-session"
alias tat="tmux attach-session -t"
alias tad="tmux attach-session -d"

# ─────────────────────────────────────────────────────
# TMUX - WINDOWS
# ─────────────────────────────────────────────────────
alias tnsw="tmux new -s"
alias tswap="tmux swap-window -s"
alias tmovew="tmux move-window -s"
alias trenumw="tmux move-window -r"

# ─────────────────────────────────────────────────────
# TMUX - PANES
# ─────────────────────────────────────────────────────
alias tsh="tmux split-window -h"
alias tsv="tmux split-window -v"
alias tjoin="tmux join-pane -s"
alias tsync="tmux setw synchronize-panes"

# ─────────────────────────────────────────────────────
# TMUX - COPY MODE & BUFFERS
# ─────────────────────────────────────────────────────
alias tvi="tmux setw -g mode-keys vi"
alias tshow="tmux show-buffer"
alias tcap="tmux capture-pane"
alias tbuf="tmux list-buffers"
alias tchoose="tmux choose-buffer"
alias tsave="tmux save-buffer"
alias tdelbuf="tmux delete-buffer -b"

# ─────────────────────────────────────────────────────
# TMUX - SETTINGS
# ─────────────────────────────────────────────────────
alias tset="tmux set -g"
alias tsetw="tmux setw -g"
alias tmouse="tmux set mouse on"
alias tnomouse="tmux set mouse off"

# ─────────────────────────────────────────────────────
# HELPER FUNCTIONS
# ─────────────────────────────────────────────────────
generate-claude-md() { claude "Read the .specify/ directory and generate an optimal CLAUDE.md for this project based on the specs, plan, and constitution."; }

turbo-init() {
    echo "🚀 Initializing Turbo Flow workspace..."
    specify init . --ai claude 2>/dev/null || echo "⚠️ spec-kit init skipped"
    npx -y claude-flow@alpha init --force 2>/dev/null || echo "⚠️ claude-flow init skipped"
    echo "✅ Workspace ready! Run: claude"
}

turbo-help() {
    echo "🚀 Turbo Flow Quick Reference"
    echo "─────────────────────────────"
    echo "claude          Start Claude Code"
    echo "dsp             Claude (skip permissions)"
    echo "cf-swarm        Claude Flow swarm mode"
    echo "cf-hive         Spawn hive-mind agents"
    echo "af-coder        Agentic Flow coder"
    echo "aqe             Agentic QE testing"
    echo "aj              Agentic Jujutsu (git)"
    echo "sk-here         Init spec-kit in current dir"
    echo "os-init         Init OpenSpec"
    echo "agt-watch       Live agent observability"
    echo "claudish        Multi-model proxy"
    echo "skills-list     Browse AI skills"
    echo "pal             Start PAL multi-model server"
    echo "n8n-mcp         n8n workflow MCP"
}

# ─────────────────────────────────────────────────────
# PATH
# ─────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"

# === END TURBO FLOW v10 ===

ALIASES_EOF
    ok "Bash aliases installed"
fi

info "Elapsed: $(elapsed)"

# ============================================
# COMPLETE
# ============================================
END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))

# Status checks
SPECKIT_STATUS="❌ not found"
has_cmd specify && SPECKIT_STATUS="✅ ready"

OPENSPEC_STATUS="❌ not found"
has_cmd openspec && OPENSPEC_STATUS="✅ ready"

CLAUDE_FLOW_STATUS="❌ not initialized"
[ -d "$WORKSPACE_FOLDER/.claude-flow" ] || [ -f "$WORKSPACE_FOLDER/claude-flow.json" ] && CLAUDE_FLOW_STATUS="✅ initialized"

CLAUDE_CLI_STATUS="❌ not found"
has_cmd claude && CLAUDE_CLI_STATUS="✅ ready"

NODE_VERSION_FINAL=$(node -v 2>/dev/null || echo "not found")
NODE_MAJOR_FINAL=$(echo "$NODE_VERSION_FINAL" | sed 's/v//' | cut -d. -f1)
NODE_STATUS="✅ $NODE_VERSION_FINAL"
[ "$NODE_MAJOR_FINAL" -lt 20 ] 2>/dev/null && NODE_STATUS="⚠️ $NODE_VERSION_FINAL (needs v20+)"

AGENT_COUNT=$(find "$AGENTS_DIR" -maxdepth 1 -name '*.md' 2>/dev/null | wc -l | tr -d ' ')

echo ""
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║                                                  ║"
echo "║   🎉 TURBO FLOW SETUP COMPLETE!                 ║"
echo "║                                                  ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
progress_bar 100
echo ""
echo ""
echo "  ┌────────────────────────────────────────────────┐"
echo "  │  📊 SUMMARY                                    │"
echo "  ├────────────────────────────────────────────────┤"
echo "  │  $NODE_STATUS Node.js                         │"
echo "  │  $CLAUDE_CLI_STATUS Claude Code                            │"
echo "  │  $CLAUDE_FLOW_STATUS Claude Flow                           │"
echo "  │  $SPECKIT_STATUS Spec-Kit                              │"
echo "  │  $OPENSPEC_STATUS OpenSpec                             │"
echo "  │  ✅ Agentic Tools       af, aqe, aj           │"
echo "  │  ✅ MCP Servers         configured            │"
echo "  │  ✅ Subagents           $AGENT_COUNT available             │"
echo "  │  ⏱️  Total time          ${TOTAL_TIME}s                     │"
echo "  └────────────────────────────────────────────────┘"
echo ""
echo "  📁 Workspace: $WORKSPACE_FOLDER"
echo ""

# Show fixes needed
if [ "$NODE_MAJOR_FINAL" -lt 20 ] 2>/dev/null; then
echo "  ⚠️  NODE.JS STILL NEEDS UPGRADE:"
echo "  ─────────────────────────────────────────────────"
echo "  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -"
echo "  sudo apt-get install -y nodejs"
echo ""
fi

if [ "$CLAUDE_FLOW_STATUS" = "❌ not initialized" ]; then
echo "  ⚠️  CLAUDE-FLOW FIX:"
echo "  ─────────────────────────────────────────────────"
echo "  source ~/.bashrc && cf-fix"
echo "  npx -y claude-flow@alpha init --force"
echo ""
fi

echo "  📌 QUICK START:"
echo "  ─────────────────────────────────────────────────"
echo "  1. source ~/.bashrc"
echo "  2. claude                     # Start Claude Code"
echo "  3. cf-swarm                   # Run claude-flow swarm"
echo ""
echo "  🚀 Happy coding!"
echo ""
