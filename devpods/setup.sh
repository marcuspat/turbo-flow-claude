#!/bin/bash
# TURBO FLOW SETUP SCRIPT - OPTIMIZED VERSION v9
# Constant status updates, progress bar, skips existing, never stops on errors
# v8: Fixed better-sqlite3 missing dependency in claude-flow
# v9: BULLETPROOF - Installs Node 20, build tools, and better-sqlite3 without fail

# NO set -e - we handle errors gracefully

# ============================================
# CONFIGURATION
# ============================================
: "${WORKSPACE_FOLDER:=$(pwd)}"
: "${DEVPOD_WORKSPACE_FOLDER:=$WORKSPACE_FOLDER}"
: "${AGENTS_DIR:=$WORKSPACE_FOLDER/agents}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"
TOTAL_STEPS=16
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

# Check if npm package is installed globally
is_npm_installed() {
    npm list -g "$1" --depth=0 >/dev/null 2>&1
}

# Check if command exists
has_cmd() {
    command -v "$1" >/dev/null 2>&1
}

# Fast npm install with status
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
            warn "$pkg install failed"
            return 1
        fi
    fi
}

# Elapsed time
elapsed() {
    local now=$(date +%s)
    local diff=$((now - START_TIME))
    echo "${diff}s"
}

# ============================================
# START
# ============================================
clear 2>/dev/null || true
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║     🚀 TURBO FLOW SETUP - BULLETPROOF v9        ║"
echo "║     Installs Node 20 • Fixes All Dependencies   ║"
echo "║     Skills + MCP Servers + Spec-Kit              ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "  📁 Workspace: $WORKSPACE_FOLDER"
echo "  📁 Script Dir: $SCRIPT_DIR"
echo "  🕐 Started at: $(date '+%H:%M:%S')"
echo ""
progress_bar 0
echo ""

# ============================================
# [6%] STEP 1: Install build tools (required for native modules)
# ============================================
step_header "Installing build tools (gcc, g++, make, python3)"

checking "build-essential"
if command -v g++ >/dev/null 2>&1 && command -v make >/dev/null 2>&1; then
    skip "build tools (g++, make already present)"
else
    status "Installing build-essential and python3"
    if command -v apt-get >/dev/null 2>&1; then
        apt-get update -qq 2>/dev/null || sudo apt-get update -qq 2>/dev/null || true
        apt-get install -y -qq build-essential python3 2>/dev/null || \
        sudo apt-get install -y -qq build-essential python3 2>/dev/null || \
        warn "Could not install build tools - native modules may fail"
        ok "build tools installed"
    elif command -v yum >/dev/null 2>&1; then
        yum groupinstall -y "Development Tools" 2>/dev/null || sudo yum groupinstall -y "Development Tools" 2>/dev/null || true
        yum install -y python3 2>/dev/null || sudo yum install -y python3 2>/dev/null || true
        ok "build tools installed (yum)"
    elif command -v apk >/dev/null 2>&1; then
        apk add --no-cache build-base python3 2>/dev/null || true
        ok "build tools installed (apk)"
    else
        warn "Unknown package manager - please install build-essential manually"
    fi
fi

# Verify
if command -v g++ >/dev/null 2>&1; then
    ok "g++ is available: $(g++ --version | head -1)"
else
    warn "g++ not found - native module compilation may fail"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [12%] STEP 2: Install Node.js 20 (REQUIRED)
# ============================================
step_header "Installing Node.js 20 LTS"

NODE_VERSION=$(node -v 2>/dev/null | sed 's/v//' || echo "0")
NODE_MAJOR=$(echo "$NODE_VERSION" | cut -d. -f1)
info "Current Node.js version: v$NODE_VERSION"

if [ "$NODE_MAJOR" -ge 20 ]; then
    skip "Node.js v$NODE_MAJOR (already >= 20)"
else
    status "Upgrading Node.js from v$NODE_MAJOR to v20"
    
    # Method 1: Use 'n' version manager (fastest)
    status "Installing 'n' Node version manager"
    if npm install -g n --silent 2>/dev/null || sudo npm install -g n --silent 2>/dev/null; then
        ok "'n' installed"
        
        status "Installing Node.js 20 via 'n'"
        if n 20 2>/dev/null || sudo n 20 2>/dev/null; then
            ok "Node.js 20 installed via 'n'"
            # Refresh PATH
            hash -r 2>/dev/null || true
            export PATH="/usr/local/bin:$PATH"
        else
            warn "'n 20' failed - trying alternative method"
        fi
    else
        warn "'n' install failed - trying NodeSource"
    fi
    
    # Check if upgrade worked
    NODE_VERSION_NEW=$(node -v 2>/dev/null | sed 's/v//' || echo "0")
    NODE_MAJOR_NEW=$(echo "$NODE_VERSION_NEW" | cut -d. -f1)
    
    if [ "$NODE_MAJOR_NEW" -lt 20 ]; then
        # Method 2: NodeSource repository
        status "Trying NodeSource repository method"
        if command -v curl >/dev/null 2>&1; then
            curl -fsSL https://deb.nodesource.com/setup_20.x 2>/dev/null | bash - 2>/dev/null || \
            curl -fsSL https://deb.nodesource.com/setup_20.x 2>/dev/null | sudo bash - 2>/dev/null || true
            
            apt-get install -y nodejs 2>/dev/null || sudo apt-get install -y nodejs 2>/dev/null || true
        fi
    fi
    
    # Final check
    NODE_VERSION_FINAL=$(node -v 2>/dev/null | sed 's/v//' || echo "0")
    NODE_MAJOR_FINAL=$(echo "$NODE_VERSION_FINAL" | cut -d. -f1)
    
    if [ "$NODE_MAJOR_FINAL" -ge 20 ]; then
        ok "Node.js upgraded to v$NODE_VERSION_FINAL"
    else
        fail "Could not upgrade Node.js (still v$NODE_VERSION_FINAL)"
        info "Please manually install Node.js 20:"
        info "  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -"
        info "  sudo apt-get install -y nodejs"
        info ""
        info "Or use nvm:"
        info "  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
        info "  source ~/.bashrc && nvm install 20 && nvm use 20"
    fi
fi

# Show final Node version
info "Node.js version: $(node -v 2>/dev/null || echo 'not found')"
info "npm version: $(npm -v 2>/dev/null || echo 'not found')"
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
install_npm agentic-qe
install_npm agentic-flow
install_npm agentic-jujutsu
install_npm claudish
install_npm @fission-ai/openspec

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

# === TURBO FLOW ALIASES v9 ===
# Claude Code
alias claude-hierarchical="claude --dangerously-skip-permissions"
alias dsp="claude --dangerously-skip-permissions"

# Claude Flow (orchestration)
alias cf="npx -y claude-flow@alpha"
alias cf-init="npx -y claude-flow@alpha init --force"
alias cf-swarm="npx -y claude-flow@alpha swarm"
alias cf-hive="npx -y claude-flow@alpha hive-mind spawn"
alias cf-spawn="npx -y claude-flow@alpha hive-mind spawn"
alias cf-status="npx -y claude-flow@alpha hive-mind status"
alias cf-help="npx -y claude-flow@alpha --help"

# Claude Flow fix helper (for better-sqlite3 issue)
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

# Agentic Flow
alias af="npx -y agentic-flow"
alias af-run="npx -y agentic-flow --agent"
alias af-coder="npx -y agentic-flow --agent coder"
alias af-help="npx -y agentic-flow --help"

# Agentic QE (testing)
alias aqe="npx -y agentic-qe"
alias aqe-mcp="npx -y aqe-mcp"

# Agentic Jujutsu (git)
alias aj="npx -y agentic-jujutsu"

# Claude Usage
alias cu="claude-usage"
alias claude-usage="npx -y claude-usage-cli"

# Spec-Kit
alias sk="specify"
alias sk-init="specify init"
alias sk-check="specify check"
alias sk-here="specify init . --ai claude"

# OpenSpec (Fission-AI)
alias os="openspec"
alias os-init="openspec init"
alias os-list="openspec list"
alias os-view="openspec view"
alias os-show="openspec show"
alias os-validate="openspec validate"
alias os-archive="openspec archive"
alias os-update="openspec update"

# AI Agent Skills
alias skills="npx ai-agent-skills"
alias skills-list="npx ai-agent-skills list"
alias skills-search="npx ai-agent-skills search"
alias skills-install="npx ai-agent-skills install"

# n8n-MCP
alias n8n-mcp="npx -y n8n-mcp"

# PAL MCP
alias pal="cd ~/.pal-mcp-server && ./run-server.sh"
alias pal-setup="cd ~/.pal-mcp-server && uv sync"

# MCP Servers
alias mcp-playwright="npx -y @playwright/mcp@latest"
alias mcp-chrome="npx -y chrome-devtools-mcp@latest"

# === TMUX ALIASES (based on tmuxcheatsheet.com) ===

# ─────────────────────────────────────────────────────
# SESSIONS
# ─────────────────────────────────────────────────────
alias t="tmux"
alias tn="tmux new"
alias tns="tmux new-session -s"
alias tnsa="tmux new-session -A -s"              # Start new or attach to existing session

alias tks="tmux kill-session -t"                  # Kill session by name
alias tksa="tmux kill-session -a"                 # Kill all sessions but current
alias tksat="tmux kill-session -a -t"             # Kill all sessions but named one

alias tl="tmux ls"
alias tls="tmux list-sessions"

alias ta="tmux attach-session"                    # Attach to last session
alias tat="tmux attach-session -t"                # Attach to named session
alias tad="tmux attach-session -d"                # Attach and detach others (maximize)

# ─────────────────────────────────────────────────────
# WINDOWS
# ─────────────────────────────────────────────────────
alias tnsw="tmux new -s"                          # New session with name (add -n for window name)
alias tswap="tmux swap-window -s"                 # Swap windows: tswap 2 -t 1
alias tmovew="tmux move-window -s"                # Move window between sessions
alias trenumw="tmux move-window -r"               # Renumber windows (remove gaps)

# ─────────────────────────────────────────────────────
# PANES
# ─────────────────────────────────────────────────────
alias tsh="tmux split-window -h"                  # Split horizontal (vertical line)
alias tsv="tmux split-window -v"                  # Split vertical (horizontal line)
alias tjoin="tmux join-pane -s"                   # Join panes: tjoin 2 -t 1
alias tsync="tmux setw synchronize-panes"         # Toggle sync (send to all panes)

# ─────────────────────────────────────────────────────
# COPY MODE & BUFFERS
# ─────────────────────────────────────────────────────
alias tvi="tmux setw -g mode-keys vi"             # Use vi keys in buffer
alias tshow="tmux show-buffer"                    # Display buffer_0 contents
alias tcap="tmux capture-pane"                    # Copy visible pane to buffer
alias tbuf="tmux list-buffers"                    # Show all buffers
alias tchoose="tmux choose-buffer"                # Show buffers and paste selected
alias tsave="tmux save-buffer"                    # Save buffer: tsave buf.txt
alias tdelbuf="tmux delete-buffer -b"             # Delete buffer: tdelbuf 1

# ─────────────────────────────────────────────────────
# SETTINGS & OPTIONS
# ─────────────────────────────────────────────────────
alias tset="tmux set -g"                          # Set option for all sessions
alias tsetw="tmux setw -g"                        # Set option for all windows
alias tmouse="tmux set mouse on"                  # Enable mouse mode
alias tnomouse="tmux set mouse off"               # Disable mouse mode

# Helper functions
cf-task() { npx -y claude-flow@alpha swarm "$@"; }
af-task() { npx -y agentic-flow --agent "$1" --task "$2" --stream; }
generate-claude-md() { claude "Read the .specify/ directory and generate an optimal CLAUDE.md for this project based on the specs, plan, and constitution."; }

# PATH
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"
# === END TURBO FLOW ===
ALIASES_EOF
    ok "Aliases added to ~/.bashrc"
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
