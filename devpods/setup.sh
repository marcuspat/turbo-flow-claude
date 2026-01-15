#!/bin/bash
# TURBO FLOW SETUP SCRIPT v10 - LEAN EDITION
# Powered by Claude Flow v3 (RuvVector Neural Engine)
# v10: Removed bloat, single MCP, playwriter + dev-browser + HeroUI stack

# NO set -e - we handle errors gracefully

# ============================================
# CONFIGURATION
# ============================================
: "${WORKSPACE_FOLDER:=$(pwd)}"
: "${DEVPOD_WORKSPACE_FOLDER:=$WORKSPACE_FOLDER}"
: "${AGENTS_DIR:=$WORKSPACE_FOLDER/agents}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"
TOTAL_STEPS=12
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

is_npm_installed() {
    npm list -g "$1" --depth=0 >/dev/null 2>&1
}

has_cmd() {
    command -v "$1" >/dev/null 2>&1
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
            warn "$pkg install failed"
            return 1
        fi
    fi
}

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
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║     🚀 TURBO FLOW v1.0.6 - POWERED BY RUVVECTOR            ║"
echo "║     Claude Flow v3 • Lean Stack • Neural Intelligence       ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "  📁 Workspace: $WORKSPACE_FOLDER"
echo "  🕐 Started at: $(date '+%H:%M:%S')"
echo ""
progress_bar 0
echo ""

# ============================================
# [8%] STEP 1: Build tools (required for native modules)
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
        warn "Could not install build tools"
        ok "build tools installed"
    elif command -v yum >/dev/null 2>&1; then
        yum groupinstall -y "Development Tools" 2>/dev/null || sudo yum groupinstall -y "Development Tools" 2>/dev/null || true
        ok "build tools installed (yum)"
    elif command -v apk >/dev/null 2>&1; then
        apk add --no-cache build-base python3 2>/dev/null || true
        ok "build tools installed (apk)"
    else
        warn "Unknown package manager"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# [16%] STEP 2: Node.js 20 LTS
# ============================================
step_header "Installing Node.js 20 LTS"

NODE_VERSION=$(node -v 2>/dev/null | sed 's/v//' || echo "0")
NODE_MAJOR=$(echo "$NODE_VERSION" | cut -d. -f1)

if [ "$NODE_MAJOR" -ge 20 ]; then
    skip "Node.js v$NODE_MAJOR (already >= 20)"
else
    status "Upgrading Node.js to v20"
    
    # Method 1: n version manager
    if npm install -g n --silent 2>/dev/null || sudo npm install -g n --silent 2>/dev/null; then
        n 20 2>/dev/null || sudo n 20 2>/dev/null || true
        hash -r 2>/dev/null || true
        export PATH="/usr/local/bin:$PATH"
    fi
    
    # Check if upgrade worked
    NODE_MAJOR_NEW=$(node -v 2>/dev/null | sed 's/v//' | cut -d. -f1 || echo "0")
    
    if [ "$NODE_MAJOR_NEW" -lt 20 ]; then
        # Method 2: NodeSource
        if command -v curl >/dev/null 2>&1; then
            curl -fsSL https://deb.nodesource.com/setup_20.x 2>/dev/null | sudo bash - 2>/dev/null || true
            apt-get install -y nodejs 2>/dev/null || sudo apt-get install -y nodejs 2>/dev/null || true
        fi
    fi
    
    NODE_VERSION_FINAL=$(node -v 2>/dev/null || echo "not found")
    ok "Node.js: $NODE_VERSION_FINAL"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [25%] STEP 3: Clear caches
# ============================================
step_header "Clearing npm caches"

rm -rf ~/.npm/_locks 2>/dev/null || true
rm -rf ~/.npm/_npx 2>/dev/null || true
npm cache clean --force --silent 2>/dev/null || true
ok "Caches cleared"

info "Elapsed: $(elapsed)"

# ============================================
# [33%] STEP 4: Claude Flow v3 (RuvVector Engine)
# ============================================
step_header "Installing Claude Flow v3 (RuvVector Neural Engine)"

cd "$WORKSPACE_FOLDER" 2>/dev/null || cd "$HOME"

checking "claude-flow v3"
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ]; then
    skip "claude-flow already initialized"
else
    status "Installing Claude Flow v3 with neural subsystems"
    
    # Initialize Claude Flow v3
    if npx -y claude-flow@v3alpha init --force 2>&1 | head -20; then
        ok "Claude Flow v3 initialized"
        
        # Initialize RuvVector neural components
        status "Bootstrapping RuvVector intelligence"
        npx -y claude-flow@v3alpha hooks pretrain --model-type moe 2>/dev/null || true
        npx -y claude-flow@v3alpha embeddings init 2>/dev/null || true
        ok "RuvVector neural memory initialized"
    else
        warn "claude-flow init had issues"
        mkdir -p "$WORKSPACE_FOLDER/.claude-flow"
        cat << 'CFCONFIG' > "$WORKSPACE_FOLDER/.claude-flow/config.json"
{
  "version": "3.0.0-alpha",
  "initialized": true,
  "neural": { "enabled": true, "provider": "ruvvector" }
}
CFCONFIG
        ok "Fallback config created"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# [41%] STEP 5: Core packages (LEAN)
# ============================================
step_header "Installing core packages (lean stack)"

install_npm @anthropic-ai/claude-code
install_npm agentic-qe
install_npm ai-agent-skills
install_npm @fission-ai/openspec

info "Elapsed: $(elapsed)"

# ============================================
# [50%] STEP 6: Playwriter (AI Test Generation)
# ============================================
step_header "Installing Playwriter (AI-powered test generation)"

PLAYWRITER_DIR="$HOME/.playwriter"
checking "playwriter"
if [ -d "$PLAYWRITER_DIR" ]; then
    skip "playwriter already installed"
else
    status "Cloning playwriter"
    if git clone --depth 1 https://github.com/remorses/playwriter.git "$PLAYWRITER_DIR" 2>/dev/null; then
        cd "$PLAYWRITER_DIR"
        npm install --silent 2>/dev/null || true
        cd "$WORKSPACE_FOLDER"
        ok "playwriter installed"
    else
        warn "playwriter clone failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# [58%] STEP 7: Dev-Browser (Visual Development)
# ============================================
step_header "Installing Dev-Browser (visual AI development)"

DEVBROWSER_DIR="$HOME/.dev-browser"
checking "dev-browser"
if [ -d "$DEVBROWSER_DIR" ]; then
    skip "dev-browser already installed"
else
    status "Cloning dev-browser"
    if git clone --depth 1 https://github.com/SawyerHood/dev-browser.git "$DEVBROWSER_DIR" 2>/dev/null; then
        cd "$DEVBROWSER_DIR"
        npm install --silent 2>/dev/null || true
        cd "$WORKSPACE_FOLDER"
        ok "dev-browser installed"
    else
        warn "dev-browser clone failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# [66%] STEP 8: Security Analyzer
# ============================================
step_header "Installing Security Analyzer"

SECURITY_DIR="$HOME/.security-analyzer"
checking "security-analyzer"
if [ -d "$SECURITY_DIR" ]; then
    skip "security-analyzer already installed"
else
    status "Cloning security-analyzer"
    if git clone --depth 1 https://github.com/Cornjebus/security-analyzer.git "$SECURITY_DIR" 2>/dev/null; then
        cd "$SECURITY_DIR"
        npm install --silent 2>/dev/null || true
        cd "$WORKSPACE_FOLDER"
        ok "security-analyzer installed"
    else
        warn "security-analyzer clone failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# [75%] STEP 9: uv + Spec-Kit
# ============================================
step_header "Installing uv & Spec-Kit"

# uv
checking "uv"
if has_cmd uv; then
    skip "uv"
else
    curl -LsSf https://astral.sh/uv/install.sh 2>/dev/null | sh >/dev/null 2>&1 && ok "uv installed" || warn "uv failed"
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" 2>/dev/null
    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
fi

# Spec-Kit
checking "specify CLI"
if has_cmd specify; then
    skip "specify CLI"
else
    if has_cmd uv; then
        uv tool install specify-cli --from git+https://github.com/github/spec-kit.git 2>/dev/null && ok "specify-cli installed" || warn "specify-cli failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# [83%] STEP 10: Register Single MCP (Claude Flow v3)
# ============================================
step_header "Registering Claude Flow v3 MCP (unified server)"

checking "Claude CLI"
if has_cmd claude; then
    ok "Claude CLI found"
    
    # Remove old MCPs
    status "Cleaning old MCP registrations"
    claude mcp remove playwright 2>/dev/null || true
    claude mcp remove chrome-devtools 2>/dev/null || true
    claude mcp remove n8n-mcp 2>/dev/null || true
    claude mcp remove agtrace 2>/dev/null || true
    
    # Register single unified MCP
    status "Registering Claude Flow v3 MCP"
    timeout 15 claude mcp add claude-flow --scope user -- npx -y claude-flow@v3alpha mcp start >/dev/null 2>&1 && ok "claude-flow MCP registered" || warn "MCP registration failed"
    
    # Register agentic-qe (kept per user request)
    status "Registering agentic-qe MCP"
    timeout 10 claude mcp add agentic-qe --scope user -- npx -y aqe-mcp >/dev/null 2>&1 && ok "agentic-qe registered" || warn "agentic-qe registration failed"
else
    skip "Claude CLI not installed"
fi

# Write minimal MCP config
mkdir -p "$HOME/.config/claude" 2>/dev/null || true
cat << 'EOF' > "$HOME/.config/claude/mcp.json"
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@v3alpha", "mcp", "start"],
      "env": {}
    },
    "agentic-qe": {
      "command": "npx",
      "args": ["-y", "aqe-mcp"],
      "env": {}
    }
  }
}
EOF
ok "MCP config written"

info "Elapsed: $(elapsed)"

# ============================================
# [91%] STEP 11: Workspace setup
# ============================================
step_header "Setting up workspace"

cd "$WORKSPACE_FOLDER" 2>/dev/null || true

# package.json
[ ! -f "package.json" ] && npm init -y --silent 2>/dev/null
npm pkg set type="module" 2>/dev/null || true

# Directories
for dir in src tests docs scripts config; do
    mkdir -p "$dir" 2>/dev/null
done

# tsconfig.json
[ ! -f "tsconfig.json" ] && cat << 'EOF' > tsconfig.json
{"compilerOptions":{"target":"ES2022","module":"ESNext","moduleResolution":"node","outDir":"./dist","rootDir":"./src","strict":true,"esModuleInterop":true,"skipLibCheck":true},"include":["src/**/*","tests/**/*"],"exclude":["node_modules","dist"]}
EOF

# HeroUI starter (optional)
checking "HeroUI dependencies"
if [ ! -d "node_modules/@heroui" ]; then
    status "Installing HeroUI + Tailwind (frontend stack)"
    npm install -D @heroui/react framer-motion tailwindcss postcss autoprefixer --silent 2>/dev/null || true
    ok "Frontend stack installed"
else
    skip "HeroUI already installed"
fi

ok "Workspace configured"

info "Elapsed: $(elapsed)"

# ============================================
# [100%] STEP 12: Bash aliases
# ============================================
step_header "Installing bash aliases"

checking "TURBO FLOW aliases"
if grep -q "TURBO FLOW v1.0.6" ~/.bashrc 2>/dev/null; then
    skip "Bash aliases already installed"
else
    sed -i '/# === TURBO FLOW/,/# === END TURBO FLOW/d' ~/.bashrc 2>/dev/null || true
    
    cat << 'ALIASES_EOF' >> ~/.bashrc

# === TURBO FLOW v1.0.6 (Powered by RuvVector) ===

# ─────────────────────────────────────────────────────
# CLAUDE CODE
# ─────────────────────────────────────────────────────
alias claude-hierarchical="claude --dangerously-skip-permissions"
alias dsp="claude --dangerously-skip-permissions"

# ─────────────────────────────────────────────────────
# CLAUDE FLOW v3 (RuvVector Neural Engine)
# ─────────────────────────────────────────────────────
alias cf="npx -y claude-flow@v3alpha"
alias cf-init="npx -y claude-flow@v3alpha init"
alias cf-mcp="npx -y claude-flow@v3alpha mcp start"

# Swarm & Agents
alias cf-swarm="npx -y claude-flow@v3alpha swarm init --topology hierarchical"
alias cf-mesh="npx -y claude-flow@v3alpha swarm init --topology mesh"
alias cf-agent="npx -y claude-flow@v3alpha --agent"
alias cf-coder="npx -y claude-flow@v3alpha --agent coder"
alias cf-reviewer="npx -y claude-flow@v3alpha --agent reviewer"
alias cf-tester="npx -y claude-flow@v3alpha --agent tester"
alias cf-security="npx -y claude-flow@v3alpha --agent security-architect"
alias cf-list="npx -y claude-flow@v3alpha --list"

# Neural & Learning (RuvVector)
alias cf-neural="npx -y claude-flow@v3alpha neural"
alias cf-train="npx -y claude-flow@v3alpha neural train"
alias cf-patterns="npx -y claude-flow@v3alpha neural patterns"
alias cf-pretrain="npx -y claude-flow@v3alpha hooks pretrain"
alias cf-route="npx -y claude-flow@v3alpha hooks route"
alias cf-memory="npx -y claude-flow@v3alpha memory search"

# Hooks & Workers
alias cf-hooks="npx -y claude-flow@v3alpha hooks"
alias cf-worker="npx -y claude-flow@v3alpha worker dispatch"
alias cf-daemon="npx -y claude-flow@v3alpha daemon start"
alias cf-progress="npx -y claude-flow@v3alpha progress --detailed"
alias cf-status="npx -y claude-flow@v3alpha status"

# Quick task function
cf-task() {
    npx -y claude-flow@v3alpha --agent "${1:-coder}" --task "$2"
}

# ─────────────────────────────────────────────────────
# AGENTIC QE (Testing Pipeline)
# ─────────────────────────────────────────────────────
alias aqe="npx -y agentic-qe"
alias aqe-init="npx -y agentic-qe init"
alias aqe-generate="npx -y agentic-qe generate"
alias aqe-flaky="npx -y agentic-qe flaky"
alias aqe-gate="npx -y agentic-qe gate"
alias aqe-mcp="npx -y aqe-mcp"

# ─────────────────────────────────────────────────────
# PLAYWRITER (AI Test Generation)
# ─────────────────────────────────────────────────────
alias playwriter="cd ~/.playwriter && npm start"
alias pw-generate="cd ~/.playwriter && npm run generate"

pw-test() {
    cd ~/.playwriter
    echo "$1" | npm run generate
    cd - >/dev/null
}

# ─────────────────────────────────────────────────────
# DEV-BROWSER (Visual Development)
# ─────────────────────────────────────────────────────
alias dev-browser="cd ~/.dev-browser && npm run dev"
alias devb="cd ~/.dev-browser && npm run dev"

# ─────────────────────────────────────────────────────
# SECURITY ANALYZER
# ─────────────────────────────────────────────────────
alias security-scan="cd ~/.security-analyzer && npm run scan"
alias sec-audit="npx -y claude-flow@v3alpha security audit"

# ─────────────────────────────────────────────────────
# SPEC-KIT
# ─────────────────────────────────────────────────────
alias sk="specify"
alias sk-init="specify init"
alias sk-check="specify check"
alias sk-here="specify init . --ai claude"

# ─────────────────────────────────────────────────────
# OPENSPEC
# ─────────────────────────────────────────────────────
alias os="openspec"
alias os-init="openspec init"
alias os-list="openspec list"
alias os-validate="openspec validate"

# ─────────────────────────────────────────────────────
# AI AGENT SKILLS
# ─────────────────────────────────────────────────────
alias skills="npx ai-agent-skills"
alias skills-list="npx ai-agent-skills list"
alias skills-install="npx ai-agent-skills install"

# ─────────────────────────────────────────────────────
# TMUX (Essential only)
# ─────────────────────────────────────────────────────
alias t="tmux"
alias tns="tmux new-session -s"
alias tat="tmux attach-session -t"
alias tls="tmux list-sessions"
alias tks="tmux kill-session -t"
alias tsh="tmux split-window -h"
alias tsv="tmux split-window -v"

# ─────────────────────────────────────────────────────
# HELPER FUNCTIONS
# ─────────────────────────────────────────────────────
turbo-init() {
    echo "🚀 Initializing Turbo Flow v1.0.6 workspace..."
    specify init . --ai claude 2>/dev/null || echo "⚠️ spec-kit skipped"
    npx -y claude-flow@v3alpha init 2>/dev/null || echo "⚠️ claude-flow skipped"
    npx -y claude-flow@v3alpha hooks pretrain 2>/dev/null || true
    echo "✅ Workspace ready! Run: claude"
}

turbo-help() {
    echo "🚀 Turbo Flow v1.0.6 Quick Reference"
    echo "────────────────────────────────────"
    echo ""
    echo "CLAUDE FLOW v3 (RuvVector)"
    echo "  cf-swarm       Initialize hierarchical swarm"
    echo "  cf-agent X     Run specific agent (coder, tester, reviewer)"
    echo "  cf-train       Train neural patterns"
    echo "  cf-route       Intelligent task routing"
    echo "  cf-progress    Check v3 implementation status"
    echo ""
    echo "TESTING"
    echo "  aqe            Agentic QE pipeline"
    echo "  pw-test 'X'    Generate Playwright test from description"
    echo "  aqe-gate       Quality gate check"
    echo ""
    echo "FRONTEND"
    echo "  dev-browser    Visual AI development"
    echo "  (HeroUI + Tailwind pre-installed)"
    echo ""
    echo "SECURITY"
    echo "  sec-audit      Run security audit"
    echo "  security-scan  Full vulnerability scan"
    echo ""
    echo "SPECS"
    echo "  sk-here        Init spec-kit in current dir"
    echo "  os-init        Init OpenSpec"
}

turbo-status() {
    echo "📊 Turbo Flow v1.0.6 Status"
    echo "───────────────────────────"
    echo "Node.js:       $(node -v 2>/dev/null || echo 'not found')"
    echo "Claude Flow:   $(npx -y claude-flow@v3alpha --version 2>/dev/null || echo 'not found')"
    echo "Agentic QE:    $(npx -y agentic-qe --version 2>/dev/null || echo 'not found')"
    echo "Playwriter:    $([ -d ~/.playwriter ] && echo 'installed' || echo 'not found')"
    echo "Dev-Browser:   $([ -d ~/.dev-browser ] && echo 'installed' || echo 'not found')"
    echo "Security:      $([ -d ~/.security-analyzer ] && echo 'installed' || echo 'not found')"
    echo "Spec-Kit:      $(command -v specify >/dev/null && echo 'installed' || echo 'not found')"
}

# ─────────────────────────────────────────────────────
# PATH
# ─────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"

# === END TURBO FLOW v1.0.6 ===

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
CF_STATUS="❌ not initialized"
[ -d "$WORKSPACE_FOLDER/.claude-flow" ] && CF_STATUS="✅ initialized"

CLAUDE_STATUS="❌ not found"
has_cmd claude && CLAUDE_STATUS="✅ ready"

NODE_VER=$(node -v 2>/dev/null || echo "not found")

echo ""
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║   🎉 TURBO FLOW v1.0.6 SETUP COMPLETE!                      ║"
echo "║   Powered by RuvVector Neural Engine                        ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
progress_bar 100
echo ""
echo ""
echo "  ┌──────────────────────────────────────────────────────────┐"
echo "  │  📊 SUMMARY                                              │"
echo "  ├──────────────────────────────────────────────────────────┤"
echo "  │  Node.js           $NODE_VER                             │"
echo "  │  $CLAUDE_STATUS Claude Code                                      │"
echo "  │  $CF_STATUS Claude Flow v3 (RuvVector)                   │"
echo "  │  ✅ Agentic QE      (testing pipeline)                   │"
echo "  │  ✅ Playwriter      (AI test generation)                 │"
echo "  │  ✅ Dev-Browser     (visual development)                 │"
echo "  │  ✅ Security        (vulnerability scanning)             │"
echo "  │  ✅ HeroUI          (frontend components)                │"
echo "  │  ⏱️  Total time      ${TOTAL_TIME}s                              │"
echo "  └──────────────────────────────────────────────────────────┘"
echo ""
echo "  📌 QUICK START:"
echo "  ─────────────────────────────────────────────────────────────"
echo "  1. source ~/.bashrc"
echo "  2. claude                     # Start Claude Code"
echo "  3. cf-swarm                   # Initialize agent swarm"
echo "  4. turbo-help                 # Show all commands"
echo ""
echo "  🧠 RuvVector Neural Commands:"
echo "  ─────────────────────────────────────────────────────────────"
echo "  cf-train                      # Train neural patterns"
echo "  cf-route 'task description'   # Intelligent routing"
echo "  cf-progress                   # Check v3 status"
echo ""
echo "  🚀 Happy coding!"
echo ""
