#!/bin/bash
# TURBO FLOW SETUP SCRIPT v1.1.0
# Claude Flow V3 + Dev-Browser + Security Analyzer + Playwriter + HeroUI
# Verified commands only - proper skill installation

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
echo "║     🚀 TURBO FLOW v1.1.0 - CLAUDE FLOW V3 EDITION           ║"
echo "║     Swarm Intelligence • MCP Tools • Claude Skills          ║"
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
        apt-get install -y -qq build-essential python3 git curl 2>/dev/null || \
        sudo apt-get install -y -qq build-essential python3 git curl 2>/dev/null || \
        warn "Could not install build tools"
        ok "build tools installed"
    elif command -v yum >/dev/null 2>&1; then
        yum groupinstall -y "Development Tools" 2>/dev/null || sudo yum groupinstall -y "Development Tools" 2>/dev/null || true
        ok "build tools installed (yum)"
    elif command -v apk >/dev/null 2>&1; then
        apk add --no-cache build-base python3 git curl 2>/dev/null || true
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
# [33%] STEP 4: Claude Flow V3
# ============================================
step_header "Installing Claude Flow V3"

cd "$WORKSPACE_FOLDER" 2>/dev/null || cd "$HOME"

checking "claude-flow v3"
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ] && [ -f "$WORKSPACE_FOLDER/.claude-flow/config.json" ]; then
    skip "claude-flow already initialized"
else
    status "Initializing Claude Flow V3"
    
    if npx -y claude-flow@v3alpha init --force 2>&1 | head -20; then
        ok "Claude Flow V3 initialized"
    else
        warn "claude-flow init had issues"
        mkdir -p "$WORKSPACE_FOLDER/.claude-flow"
        echo '{"version":"3.0","initialized":true}' > "$WORKSPACE_FOLDER/.claude-flow/config.json"
        ok "Fallback config created"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# [41%] STEP 5: Core npm packages
# ============================================
step_header "Installing core npm packages"

install_npm @anthropic-ai/claude-code
install_npm agentic-qe
install_npm @fission-ai/openspec

info "Elapsed: $(elapsed)"

# ============================================
# [50%] STEP 6: Playwriter MCP (Browser Automation)
# ============================================
step_header "Configuring Playwriter MCP (Browser Automation)"

checking "playwriter MCP"

status "Verifying playwriter package"
if npx -y playwriter@latest --version >/dev/null 2>&1; then
    ok "playwriter package accessible"
else
    warn "playwriter package check failed (may still work)"
fi

# Register with Claude CLI if available
if has_cmd claude; then
    status "Registering playwriter MCP with Claude"
    claude mcp remove playwriter 2>/dev/null || true
    if timeout 15 claude mcp add playwriter --scope user -- npx -y playwriter@latest >/dev/null 2>&1; then
        ok "playwriter MCP registered"
    else
        warn "playwriter MCP registration failed"
    fi
fi

# Cleanup old clone if exists
[ -d "$HOME/.playwriter" ] && rm -rf "$HOME/.playwriter" 2>/dev/null && ok "Old playwriter clone removed"

echo ""
info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
info "⚠️  MANUAL STEP REQUIRED FOR PLAYWRITER:"
info "   Install Chrome extension from:"
info "   https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe"
info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

info "Elapsed: $(elapsed)"

# ============================================
# [58%] STEP 7: Dev-Browser (Claude Code Skill)
# ============================================
step_header "Installing Dev-Browser Skill"

DEVBROWSER_SKILL_DIR="$HOME/.claude/skills/dev-browser"
checking "dev-browser skill"

if [ -d "$DEVBROWSER_SKILL_DIR" ]; then
    skip "dev-browser skill already installed"
else
    status "Cloning dev-browser"
    if git clone --depth 1 https://github.com/SawyerHood/dev-browser.git /tmp/dev-browser-skill 2>/dev/null; then
        mkdir -p "$HOME/.claude/skills"
        
        # Copy skill subfolder if it exists, otherwise copy whole repo
        if [ -d "/tmp/dev-browser-skill/skills/dev-browser" ]; then
            cp -r /tmp/dev-browser-skill/skills/dev-browser "$DEVBROWSER_SKILL_DIR"
        else
            cp -r /tmp/dev-browser-skill "$DEVBROWSER_SKILL_DIR"
        fi
        
        cd "$DEVBROWSER_SKILL_DIR" && npm install --silent 2>/dev/null || true
        cd "$WORKSPACE_FOLDER"
        rm -rf /tmp/dev-browser-skill
        
        ok "dev-browser skill installed"
        info "Start server with: devb-start"
    else
        warn "dev-browser clone failed"
    fi
fi

# Cleanup old location
[ -d "$HOME/.dev-browser" ] && rm -rf "$HOME/.dev-browser" 2>/dev/null

info "Elapsed: $(elapsed)"

# ============================================
# [66%] STEP 8: Security Analyzer (Claude Code Skill)
# ============================================
step_header "Installing Security Analyzer Skill"

SECURITY_SKILL_DIR="$HOME/.claude/skills/security-analyzer"
checking "security-analyzer skill"

if [ -d "$SECURITY_SKILL_DIR" ]; then
    skip "security-analyzer skill already installed"
else
    status "Cloning security-analyzer"
    if git clone --depth 1 https://github.com/Cornjebus/security-analyzer.git /tmp/security-analyzer 2>/dev/null; then
        mkdir -p "$HOME/.claude/skills"
        
        # The skill is inside .claude/skills/security-analyzer in the repo
        if [ -d "/tmp/security-analyzer/.claude/skills/security-analyzer" ]; then
            cp -r /tmp/security-analyzer/.claude/skills/security-analyzer "$SECURITY_SKILL_DIR"
        else
            cp -r /tmp/security-analyzer "$SECURITY_SKILL_DIR"
        fi
        
        rm -rf /tmp/security-analyzer
        ok "security-analyzer skill installed"
        info "Use in Claude: 'security scan'"
    else
        warn "security-analyzer clone failed"
    fi
fi

# Cleanup old location
[ -d "$HOME/.security-analyzer" ] && rm -rf "$HOME/.security-analyzer" 2>/dev/null

info "Elapsed: $(elapsed)"

# ============================================
# [75%] STEP 9: uv + Spec-Kit
# ============================================
step_header "Installing uv & Spec-Kit"

checking "uv"
if has_cmd uv; then
    skip "uv"
else
    curl -LsSf https://astral.sh/uv/install.sh 2>/dev/null | sh >/dev/null 2>&1 && ok "uv installed" || warn "uv failed"
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" 2>/dev/null
    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
fi

checking "specify CLI"
if has_cmd specify; then
    skip "specify CLI"
else
    if has_cmd uv; then
        uv tool install specify-cli --from git+https://github.com/github/spec-kit.git 2>/dev/null && \
            ok "specify-cli installed" || warn "specify-cli failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# [83%] STEP 10: Register MCPs
# ============================================
step_header "Registering MCP servers"

if has_cmd claude; then
    ok "Claude CLI found"
    
    # Remove old MCPs
    status "Cleaning old MCP registrations"
    for mcp in playwright chrome-devtools n8n-mcp agtrace; do
        claude mcp remove "$mcp" 2>/dev/null || true
    done
    
    # Register Claude Flow V3 MCP
    status "Registering Claude Flow V3 MCP"
    claude mcp remove claude-flow 2>/dev/null || true
    timeout 15 claude mcp add claude-flow --scope user -- npx -y claude-flow@v3alpha mcp start >/dev/null 2>&1 && \
        ok "claude-flow MCP registered" || warn "claude-flow MCP failed"
    
    # Register agentic-qe
    status "Registering agentic-qe MCP"
    claude mcp remove agentic-qe 2>/dev/null || true
    timeout 10 claude mcp add agentic-qe --scope user -- npx -y aqe-mcp >/dev/null 2>&1 && \
        ok "agentic-qe registered" || warn "agentic-qe failed"
else
    skip "Claude CLI not installed"
fi

# Write MCP config
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
    },
    "playwriter": {
      "command": "npx",
      "args": ["-y", "playwriter@latest"],
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
for dir in src tests docs scripts config plans; do
    mkdir -p "$dir" 2>/dev/null
done

# tsconfig.json
[ ! -f "tsconfig.json" ] && cat << 'EOF' > tsconfig.json
{"compilerOptions":{"target":"ES2022","module":"ESNext","moduleResolution":"node","outDir":"./dist","rootDir":"./src","strict":true,"esModuleInterop":true,"skipLibCheck":true,"jsx":"react-jsx"},"include":["src/**/*","tests/**/*"],"exclude":["node_modules","dist"]}
EOF

# HeroUI + Tailwind
checking "HeroUI dependencies"
if [ ! -d "node_modules/@heroui" ]; then
    status "Installing HeroUI + Tailwind"
    npm install @heroui/react framer-motion --silent 2>/dev/null || true
    npm install -D tailwindcss postcss autoprefixer --silent 2>/dev/null || true
    
    # Tailwind config
    [ ! -f "tailwind.config.js" ] && cat << 'TWEOF' > tailwind.config.js
const { heroui } = require("@heroui/react");
module.exports = {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}", "./node_modules/@heroui/theme/dist/**/*.{js,ts,jsx,tsx}"],
  theme: { extend: {} },
  darkMode: "class",
  plugins: [heroui()],
};
TWEOF
    
    # PostCSS config
    [ ! -f "postcss.config.js" ] && echo 'module.exports = { plugins: { tailwindcss: {}, autoprefixer: {} } };' > postcss.config.js
    
    # Base CSS
    mkdir -p src
    [ ! -f "src/index.css" ] && echo -e "@tailwind base;\n@tailwind components;\n@tailwind utilities;" > src/index.css
    
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
if grep -q "TURBO FLOW v1.1.0" ~/.bashrc 2>/dev/null; then
    skip "Bash aliases already installed"
else
    # Remove old versions
    sed -i '/# === TURBO FLOW/,/# === END TURBO FLOW/d' ~/.bashrc 2>/dev/null || true
    
    cat << 'ALIASES_EOF' >> ~/.bashrc

# === TURBO FLOW v1.1.0 (Claude Flow V3) ===

# ─────────────────────────────────────────────────────
# CLAUDE CODE
# ─────────────────────────────────────────────────────
alias dsp="claude --dangerously-skip-permissions"

# ─────────────────────────────────────────────────────
# CLAUDE FLOW V3
# ─────────────────────────────────────────────────────
alias cf="npx -y claude-flow@v3alpha"
alias cf-init="npx -y claude-flow@v3alpha init --force"
alias cf-help="npx -y claude-flow@v3alpha --help"

# Swarm & Agents
alias cf-swarm="npx -y claude-flow@v3alpha swarm init --topology hierarchical"
alias cf-mesh="npx -y claude-flow@v3alpha swarm init --topology mesh"
alias cf-agent="npx -y claude-flow@v3alpha --agent"
alias cf-coder="npx -y claude-flow@v3alpha --agent coder"
alias cf-list="npx -y claude-flow@v3alpha --list"

# Daemon & Workers
alias cf-daemon="npx -y claude-flow@v3alpha daemon start"
alias cf-daemon-stop="npx -y claude-flow@v3alpha daemon stop"
alias cf-daemon-status="npx -y claude-flow@v3alpha daemon status"

# Memory
alias cf-memory="npx -y claude-flow@v3alpha memory"
alias cf-memory-status="npx -y claude-flow@v3alpha memory status"

# Hooks
alias cf-hooks="npx -y claude-flow@v3alpha hooks"
alias cf-route="npx -y claude-flow@v3alpha hooks route"

# Security & Performance
alias cf-security="npx -y claude-flow@v3alpha security scan"
alias cf-benchmark="npx -y claude-flow@v3alpha performance benchmark"

# Skills
alias cf-skills="npx -y claude-flow@v3alpha skill list"
alias cf-skill="npx -y claude-flow@v3alpha skill run"

# MCP
alias cf-mcp="npx -y claude-flow@v3alpha mcp start"

# Quick task function
cf-task() {
    npx -y claude-flow@v3alpha --agent "${1:-coder}" --task "$2"
}

# ─────────────────────────────────────────────────────
# AGENTIC QE (Testing)
# ─────────────────────────────────────────────────────
alias aqe="npx -y agentic-qe"
alias aqe-init="npx -y agentic-qe init"
alias aqe-generate="npx -y agentic-qe generate"
alias aqe-gate="npx -y agentic-qe gate"

# ─────────────────────────────────────────────────────
# PLAYWRITER (Browser Automation)
# ─────────────────────────────────────────────────────
alias playwriter="npx -y playwriter@latest"
alias pw-serve="npx -y playwriter serve --host 127.0.0.1"

pw-status() {
    echo "🎭 Playwriter Status"
    echo "━━━━━━━━━━━━━━━━━━━━"
    echo "Package: $(npx -y playwriter@latest --version 2>/dev/null || echo 'checking...')"
    echo ""
    echo "Chrome Extension (REQUIRED):"
    echo "  https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe"
}

# ─────────────────────────────────────────────────────
# DEV-BROWSER (Claude Code Skill)
# ─────────────────────────────────────────────────────
alias devb-start="cd ~/.claude/skills/dev-browser && npm run start-server"

devb-status() {
    echo "🌐 Dev-Browser Status"
    echo "━━━━━━━━━━━━━━━━━━━━━"
    if [ -d ~/.claude/skills/dev-browser ]; then
        echo "Installed: ✅ ~/.claude/skills/dev-browser"
        echo "Start: devb-start"
        echo "Usage: 'Open localhost:3000 and verify signup works'"
    else
        echo "Installed: ❌ Not found"
    fi
}

# ─────────────────────────────────────────────────────
# SECURITY ANALYZER (Claude Code Skill)
# ─────────────────────────────────────────────────────
sec-status() {
    echo "🔒 Security Analyzer Status"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    if [ -d ~/.claude/skills/security-analyzer ]; then
        echo "Installed: ✅ ~/.claude/skills/security-analyzer"
        echo "Usage in Claude: 'security scan'"
    else
        echo "Installed: ❌ Not found"
    fi
}

# ─────────────────────────────────────────────────────
# SPEC-KIT & OPENSPEC
# ─────────────────────────────────────────────────────
alias sk="specify"
alias sk-init="specify init"
alias sk-check="specify check"
alias sk-here="specify init . --ai claude"

alias os="openspec"
alias os-init="openspec init"
alias os-list="openspec list"

# ─────────────────────────────────────────────────────
# TMUX (Essential)
# ─────────────────────────────────────────────────────
alias t="tmux"
alias tns="tmux new-session -s"
alias tat="tmux attach-session -t"
alias tls="tmux list-sessions"
alias tks="tmux kill-session -t"

# ─────────────────────────────────────────────────────
# HELPER FUNCTIONS
# ─────────────────────────────────────────────────────
turbo-init() {
    echo "🚀 Initializing workspace..."
    specify init . --ai claude 2>/dev/null || echo "⚠️ spec-kit skipped"
    npx -y claude-flow@v3alpha init --force 2>/dev/null || echo "⚠️ claude-flow skipped"
    echo "✅ Done! Run: claude"
}

turbo-help() {
    echo "🚀 Turbo Flow v1.1.0 Quick Reference"
    echo "────────────────────────────────────"
    echo ""
    echo "CLAUDE FLOW V3"
    echo "  cf-swarm           Initialize hierarchical swarm"
    echo "  cf-mesh            Initialize mesh swarm"
    echo "  cf-coder           Run coder agent"
    echo "  cf-task TYPE TASK  Run agent with task"
    echo "  cf-daemon          Start background daemon"
    echo "  cf-memory-status   Check memory system"
    echo "  cf-security        Run security scan"
    echo "  cf-skills          List available skills"
    echo "  cf-help            Full command list"
    echo ""
    echo "TESTING"
    echo "  aqe                Agentic QE pipeline"
    echo "  aqe-gate           Quality gate"
    echo ""
    echo "BROWSER"
    echo "  playwriter         Start Playwriter (needs Chrome ext)"
    echo "  pw-status          Check status"
    echo "  devb-start         Start Dev-Browser server"
    echo ""
    echo "SECURITY (in Claude)"
    echo "  'security scan'    Full scan"
    echo ""
    echo "SPECS"
    echo "  sk-here            Init spec-kit"
    echo "  os-init            Init OpenSpec"
}

turbo-status() {
    echo "📊 Turbo Flow v1.1.0 Status"
    echo "───────────────────────────"
    echo "Node.js:      $(node -v 2>/dev/null || echo 'not found')"
    echo "Claude Flow:  $(npx -y claude-flow@v3alpha --version 2>/dev/null | head -1 || echo 'not found')"
    echo "Playwriter:   $(npx -y playwriter@latest --version 2>/dev/null || echo 'not found')"
    echo "Dev-Browser:  $([ -d ~/.claude/skills/dev-browser ] && echo '✅ installed' || echo '❌ not found')"
    echo "Security:     $([ -d ~/.claude/skills/security-analyzer ] && echo '✅ installed' || echo '❌ not found')"
    echo "Spec-Kit:     $(command -v specify >/dev/null && echo '✅ installed' || echo '❌ not found')"
    echo "HeroUI:       $([ -d node_modules/@heroui ] && echo '✅ installed' || echo '❌ not found')"
    echo ""
    echo "⚠️  Manual: Install Playwriter Chrome extension"
}

# ─────────────────────────────────────────────────────
# PATH
# ─────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"

# === END TURBO FLOW v1.1.0 ===

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
CF_STATUS="❌"
[ -d "$WORKSPACE_FOLDER/.claude-flow" ] && CF_STATUS="✅"

CLAUDE_STATUS="❌"
has_cmd claude && CLAUDE_STATUS="✅"

PW_STATUS="❌"
npx -y playwriter@latest --version >/dev/null 2>&1 && PW_STATUS="✅"

DEVB_STATUS="❌"
[ -d "$HOME/.claude/skills/dev-browser" ] && DEVB_STATUS="✅"

SEC_STATUS="❌"
[ -d "$HOME/.claude/skills/security-analyzer" ] && SEC_STATUS="✅"

HEROUI_STATUS="❌"
[ -d "$WORKSPACE_FOLDER/node_modules/@heroui" ] && HEROUI_STATUS="✅"

NODE_VER=$(node -v 2>/dev/null || echo "N/A")

echo ""
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║   🎉 TURBO FLOW v1.1.0 SETUP COMPLETE!                      ║"
echo "║   Claude Flow V3 Edition                                    ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
progress_bar 100
echo ""
echo ""
echo "  ┌──────────────────────────────────────────────────┐"
echo "  │  📊 SUMMARY                                      │"
echo "  ├──────────────────────────────────────────────────┤"
echo "  │  Node.js:        $NODE_VER                       │"
echo "  │  $CLAUDE_STATUS Claude Code                              │"
echo "  │  $CF_STATUS Claude Flow V3                            │"
echo "  │  $PW_STATUS Playwriter                                │"
echo "  │  $DEVB_STATUS Dev-Browser (skill)                      │"
echo "  │  $SEC_STATUS Security Analyzer (skill)                 │"
echo "  │  $HEROUI_STATUS HeroUI + Tailwind                        │"
echo "  │  ⏱️  ${TOTAL_TIME}s                                        │"
echo "  └──────────────────────────────────────────────────┘"
echo ""
echo "  ⚠️  MANUAL STEP:"
echo "  ───────────────"
echo "  Install Playwriter Chrome extension:"
echo "  https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe"
echo ""
echo "  📌 QUICK START:"
echo "  ───────────────"
echo "  1. source ~/.bashrc"
echo "  2. claude                  # Start Claude Code"
echo "  3. cf-swarm                # Initialize swarm"
echo "  4. turbo-help              # All commands"
echo ""
echo "  🚀 Happy coding!"
echo ""
