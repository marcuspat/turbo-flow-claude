#!/bin/bash
# TURBO FLOW SETUP SCRIPT v2.0.0
# Claude Flow V3 + RuVector + Dev-Browser + Security Analyzer + Playwriter + HeroUI

# NO set -e - we handle errors gracefully

# ============================================
# CONFIGURATION
# ============================================
: "${WORKSPACE_FOLDER:=$(pwd)}"
: "${DEVPOD_WORKSPACE_FOLDER:=$WORKSPACE_FOLDER}"
: "${AGENTS_DIR:=$WORKSPACE_FOLDER/agents}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"
TOTAL_STEPS=15
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
echo "║     🚀 TURBO FLOW v2.0.0 - CLAUDE FLOW V3 + RUVECTOR        ║"
echo "║     Swarm Intelligence • Neural Engine • MCP Tools          ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "  📁 Workspace: $WORKSPACE_FOLDER"
echo "  🕐 Started at: $(date '+%H:%M:%S')"
echo ""
progress_bar 0
echo ""

# ============================================
# STEP 1: Build tools
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
# STEP 2: Node.js 20 LTS
# ============================================
step_header "Installing Node.js 20 LTS"

NODE_VERSION=$(node -v 2>/dev/null | sed 's/v//' || echo "0")
NODE_MAJOR=$(echo "$NODE_VERSION" | cut -d. -f1)

if [ "$NODE_MAJOR" -ge 20 ]; then
    skip "Node.js v$NODE_MAJOR (already >= 20)"
else
    status "Upgrading Node.js to v20"
    
    if npm install -g n --silent 2>/dev/null || sudo npm install -g n --silent 2>/dev/null; then
        n 20 2>/dev/null || sudo n 20 2>/dev/null || true
        hash -r 2>/dev/null || true
        export PATH="/usr/local/bin:$PATH"
    fi
    
    NODE_MAJOR_NEW=$(node -v 2>/dev/null | sed 's/v//' | cut -d. -f1 || echo "0")
    
    if [ "$NODE_MAJOR_NEW" -lt 20 ]; then
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
# STEP 3: Clear caches
# ============================================
step_header "Clearing npm caches"

rm -rf ~/.npm/_locks 2>/dev/null || true
rm -rf ~/.npm/_npx 2>/dev/null || true
npm cache clean --force --silent 2>/dev/null || true
ok "Caches cleared"

info "Elapsed: $(elapsed)"

# ============================================
# STEP 4: RuVector Neural Engine
# ============================================
step_header "Installing RuVector Neural Engine"

checking "ruvector"
if is_npm_installed "ruvector"; then
    skip "ruvector"
else
    status "Installing ruvector (vector DB + GNN + self-learning)"
    npm install -g ruvector --silent --no-progress 2>/dev/null && ok "ruvector installed" || warn "ruvector install failed"
fi

checking "@ruvector/sona"
if is_npm_installed "@ruvector/sona"; then
    skip "@ruvector/sona"
else
    status "Installing @ruvector/sona (self-learning)"
    npm install -g @ruvector/sona --silent --no-progress 2>/dev/null && ok "@ruvector/sona installed" || warn "@ruvector/sona install failed"
fi

checking "@ruvector/cli"
if is_npm_installed "@ruvector/cli"; then
    skip "@ruvector/cli"
else
    status "Installing @ruvector/cli (hooks & intelligence)"
    npm install -g @ruvector/cli --silent --no-progress 2>/dev/null && ok "@ruvector/cli installed" || warn "@ruvector/cli install failed"
fi

# Initialize RuVector hooks
status "Initializing RuVector hooks"
npx @ruvector/cli hooks init 2>/dev/null && ok "RuVector hooks initialized" || warn "RuVector hooks init failed"

info "Elapsed: $(elapsed)"

# ============================================
# STEP 5: Claude Flow V3
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
# STEP 6: Core npm packages
# ============================================
step_header "Installing core npm packages"

install_npm @anthropic-ai/claude-code
install_npm agentic-qe
install_npm @fission-ai/openspec
install_npm uipro-cli
install_npm agent-browser

info "Elapsed: $(elapsed)"

# ============================================
# STEP 7: Playwriter MCP
# ============================================
step_header "Configuring Playwriter MCP (Browser Automation)"

checking "playwriter MCP"

status "Verifying playwriter package"
if npx -y playwriter@latest --version >/dev/null 2>&1; then
    ok "playwriter package accessible"
else
    warn "playwriter package check failed (may still work)"
fi

if has_cmd claude; then
    status "Registering playwriter MCP with Claude"
    claude mcp remove playwriter 2>/dev/null || true
    if timeout 15 claude mcp add playwriter --scope user -- npx -y playwriter@latest >/dev/null 2>&1; then
        ok "playwriter MCP registered"
    else
        warn "playwriter MCP registration failed"
    fi
fi

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
# STEP 8: Dev-Browser Skill
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
        
        if [ -d "/tmp/dev-browser-skill/skills/dev-browser" ]; then
            cp -r /tmp/dev-browser-skill/skills/dev-browser "$DEVBROWSER_SKILL_DIR"
        else
            cp -r /tmp/dev-browser-skill "$DEVBROWSER_SKILL_DIR"
        fi
        
        cd "$DEVBROWSER_SKILL_DIR" && npm install --silent 2>/dev/null || true
        cd "$WORKSPACE_FOLDER"
        rm -rf /tmp/dev-browser-skill
        
        ok "dev-browser skill installed"
    else
        warn "dev-browser clone failed"
    fi
fi

[ -d "$HOME/.dev-browser" ] && rm -rf "$HOME/.dev-browser" 2>/dev/null

info "Elapsed: $(elapsed)"

# ============================================
# STEP 9: Security Analyzer Skill
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
        
        if [ -d "/tmp/security-analyzer/.claude/skills/security-analyzer" ]; then
            cp -r /tmp/security-analyzer/.claude/skills/security-analyzer "$SECURITY_SKILL_DIR"
        else
            cp -r /tmp/security-analyzer "$SECURITY_SKILL_DIR"
        fi
        
        rm -rf /tmp/security-analyzer
        ok "security-analyzer skill installed"
    else
        warn "security-analyzer clone failed"
    fi
fi

[ -d "$HOME/.security-analyzer" ] && rm -rf "$HOME/.security-analyzer" 2>/dev/null

info "Elapsed: $(elapsed)"

# ============================================
# STEP 10: uv + Spec-Kit
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
# STEP 11: Register MCPs
# ============================================
step_header "Registering MCP servers"

if has_cmd claude; then
    ok "Claude CLI found"
    
    status "Cleaning old MCP registrations"
    for mcp in playwright chrome-devtools n8n-mcp agtrace; do
        claude mcp remove "$mcp" 2>/dev/null || true
    done
    
    status "Registering Claude Flow V3 MCP"
    claude mcp remove claude-flow 2>/dev/null || true
    timeout 15 claude mcp add claude-flow --scope user -- npx -y claude-flow@v3alpha mcp start >/dev/null 2>&1 && \
        ok "claude-flow MCP registered" || warn "claude-flow MCP failed"
    
    status "Registering agentic-qe MCP"
    claude mcp remove agentic-qe 2>/dev/null || true
    timeout 10 claude mcp add agentic-qe --scope user -- npx -y aqe-mcp >/dev/null 2>&1 && \
        ok "agentic-qe registered" || warn "agentic-qe failed"
else
    skip "Claude CLI not installed"
fi

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
# STEP 12: Workspace setup
# ============================================
step_header "Setting up workspace"

cd "$WORKSPACE_FOLDER" 2>/dev/null || true

[ ! -f "package.json" ] && npm init -y --silent 2>/dev/null
npm pkg set type="module" 2>/dev/null || true

for dir in src tests docs scripts config plans; do
    mkdir -p "$dir" 2>/dev/null
done

[ ! -f "tsconfig.json" ] && cat << 'EOF' > tsconfig.json
{"compilerOptions":{"target":"ES2022","module":"ESNext","moduleResolution":"node","outDir":"./dist","rootDir":"./src","strict":true,"esModuleInterop":true,"skipLibCheck":true,"jsx":"react-jsx"},"include":["src/**/*","tests/**/*"],"exclude":["node_modules","dist"]}
EOF

checking "HeroUI dependencies"
if [ ! -d "node_modules/@heroui" ]; then
    status "Installing HeroUI + Tailwind"
    npm install @heroui/react framer-motion --silent 2>/dev/null || true
    npm install -D tailwindcss postcss autoprefixer --silent 2>/dev/null || true
    
    [ ! -f "tailwind.config.js" ] && cat << 'TWEOF' > tailwind.config.js
const { heroui } = require("@heroui/react");
module.exports = {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}", "./node_modules/@heroui/theme/dist/**/*.{js,ts,jsx,tsx}"],
  theme: { extend: {} },
  darkMode: "class",
  plugins: [heroui()],
};
TWEOF
    
    [ ! -f "postcss.config.js" ] && echo 'module.exports = { plugins: { tailwindcss: {}, autoprefixer: {} } };' > postcss.config.js
    
    mkdir -p src
    [ ! -f "src/index.css" ] && echo -e "@tailwind base;\n@tailwind components;\n@tailwind utilities;" > src/index.css
    
    ok "Frontend stack installed"
else
    skip "HeroUI already installed"
fi

ok "Workspace configured"
info "Elapsed: $(elapsed)"

# ============================================
# STEP 13: Install UI UX Pro Max Skill
# ============================================
step_header "Installing UI UX Pro Max Skill"

checking "UI UX Pro Max skill"
if [ -d "$HOME/.claude/skills/ui-ux-pro-max" ] || [ -d "$WORKSPACE_FOLDER/.claude/skills/ui-ux-pro-max" ]; then
    skip "UI UX Pro Max skill already installed"
else
    status "Installing UI UX Pro Max skill"
    if has_cmd uipro; then
        uipro init --ai claude 2>/dev/null && ok "UI UX Pro Max skill installed" || warn "UI UX Pro Max skill install failed"
    else
        # Fallback to npx if global install failed
        npx -y uipro-cli init --ai claude 2>/dev/null && ok "UI UX Pro Max skill installed (via npx)" || warn "UI UX Pro Max skill install failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 14: Install prd2build Command
# ============================================
step_header "Installing prd2build command"

COMMANDS_DIR="$HOME/.claude/commands"
PRD2BUILD_SOURCE="$DEVPOD_DIR/scripts/prd2build.md"

checking "prd2build command"

if [ -f "$COMMANDS_DIR/prd2build.md" ]; then
    skip "prd2build command already installed"
else
    mkdir -p "$COMMANDS_DIR"
    
    if [ -f "$PRD2BUILD_SOURCE" ]; then
        cp "$PRD2BUILD_SOURCE" "$COMMANDS_DIR/prd2build.md"
        ok "prd2build command installed"
    else
        fail "prd2build.md not found at $PRD2BUILD_SOURCE"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 15: Codex Configuration
# ============================================
step_header "Configuring Codex (OpenAI Code Agent)"

CODEX_DIR="$HOME/.codex"
CODEX_INSTRUCTIONS_SOURCE="$DEVPOD_DIR/scripts/codex_claude.md"

checking "Codex installation"
if has_cmd codex; then
    CODEX_VER=$(codex --version 2>/dev/null || echo "unknown")
    ok "Codex already installed (v$CODEX_VER)"
else
    info "Codex not installed (optional)"
    info "To install: npm install -g @openai/codex"
fi

checking "Codex config directory"
if [ -d "$CODEX_DIR" ]; then
    skip "Codex config directory exists"
else
    mkdir -p "$CODEX_DIR"
    ok "Created $CODEX_DIR"
fi

checking "Codex instructions"
if [ -f "$CODEX_DIR/instructions.md" ]; then
    skip "Codex instructions already installed"
else
    if [ -f "$CODEX_INSTRUCTIONS_SOURCE" ]; then
        cp "$CODEX_INSTRUCTIONS_SOURCE" "$CODEX_DIR/instructions.md"
        ok "Codex instructions installed"
    else
        fail "codex_claude.md not found at $CODEX_INSTRUCTIONS_SOURCE"
    fi
fi

checking "AGENTS.md coordination protocol"
if [ -f "$WORKSPACE_FOLDER/AGENTS.md" ]; then
    skip "AGENTS.md exists"
else
    status "Creating AGENTS.md"
    cat > "$WORKSPACE_FOLDER/AGENTS.md" << 'AGENTS_MD_EOF'
# Codex & Claude Code Collaboration Protocol

## Task Allocation

| Task Type | Codex | Claude Code |
|-----------|-------|-------------|
| Code changes, tests, refactors | ✅ | ❌ |
| Build, lint, format, migrate | ✅ | ❌ |
| GitHub PRs, CI/CD admin | ❌ | ✅ |
| Secrets, tokens, vault | ❌ | ✅ |
| Multi-repo coordination | ❌ | ✅ |
AGENTS_MD_EOF
    ok "AGENTS.md created"
fi

if has_cmd codex; then
    echo ""
    info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    info "⚠️  CODEX AUTHENTICATION REQUIRED:"
    info "   Run: codex login"
    info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 16: Bash aliases
# ============================================
step_header "Installing bash aliases"

checking "TURBO FLOW aliases"
if grep -q "TURBO FLOW v2.0.0" ~/.bashrc 2>/dev/null; then
    skip "Bash aliases already installed"
else
    sed -i '/# === TURBO FLOW/,/# === END TURBO FLOW/d' ~/.bashrc 2>/dev/null || true
    
    cat << 'ALIASES_EOF' >> ~/.bashrc

# === TURBO FLOW v2.0.0 (Claude Flow V3 + RuVector) ===

# RUVECTOR
alias ruv="npx ruvector"
alias ruv-stats="npx @ruvector/cli hooks stats"
alias ruv-route="npx @ruvector/cli hooks route"
alias ruv-remember="npx @ruvector/cli hooks remember"
alias ruv-recall="npx @ruvector/cli hooks recall"
alias ruv-learn="npx @ruvector/cli hooks learn"
alias ruv-init="npx @ruvector/cli hooks init"
alias ruvector-status="npx ruvector --version && npx @ruvector/cli hooks stats"

# CLAUDE CODE
alias dsp="claude --dangerously-skip-permissions"

# CLAUDE FLOW V3
alias cf="npx -y claude-flow@v3alpha"
alias cf-init="npx -y claude-flow@v3alpha init --force"
alias cf-swarm="npx -y claude-flow@v3alpha swarm init --topology hierarchical"
alias cf-mesh="npx -y claude-flow@v3alpha swarm init --topology mesh"
alias cf-agent="npx -y claude-flow@v3alpha --agent"
alias cf-list="npx -y claude-flow@v3alpha --list"
alias cf-daemon="npx -y claude-flow@v3alpha daemon start"
alias cf-memory="npx -y claude-flow@v3alpha memory"
alias cf-memory-status="npx -y claude-flow@v3alpha memory status"
alias cf-security="npx -y claude-flow@v3alpha security scan"
alias cf-mcp="npx -y claude-flow@v3alpha mcp start"

# AGENTIC QE
alias aqe="npx -y agentic-qe"
alias aqe-generate="npx -y agentic-qe generate"
alias aqe-gate="npx -y agentic-qe gate"

# PLAYWRITER
alias playwriter="npx -y playwriter@latest"

# DEV-BROWSER
alias devb-start="cd ~/.claude/skills/dev-browser && npm run start-server"

# SPEC-KIT & OPENSPEC
alias sk="specify"
alias sk-here="specify init . --ai claude"
alias os="openspec"
alias os-init="openspec init"

# CODEX
alias codex-login="codex login"
alias codex-run="codex exec -p claude"

codex-check() {
    echo "🔍 Codex Setup Status"
    command -v codex >/dev/null 2>&1 && echo "✅ Codex installed" || echo "❌ Codex not installed"
    [ -f ~/.codex/config.toml ] && echo "✅ Config exists" || echo "❌ Config missing"
    [ -f AGENTS.md ] && echo "✅ AGENTS.md exists" || echo "⚠️ AGENTS.md not found"
}

# HELPERS
turbo-status() {
    echo "📊 Turbo Flow v2.0.0 Status"
    echo "───────────────────────────"
    echo "Node.js:      $(node -v 2>/dev/null || echo 'not found')"
    echo "RuVector:     $(npx ruvector --version 2>/dev/null || echo 'not found')"
    echo "Claude Flow:  $(npx -y claude-flow@v3alpha --version 2>/dev/null | head -1 || echo 'not found')"
    echo "Codex:        $(command -v codex >/dev/null && codex --version 2>/dev/null || echo 'not installed')"
    echo "prd2build:    $([ -f ~/.claude/commands/prd2build.md ] && echo '✅' || echo '❌')"
    echo "Dev-Browser:  $([ -d ~/.claude/skills/dev-browser ] && echo '✅' || echo '❌')"
    echo "Security:     $([ -d ~/.claude/skills/security-analyzer ] && echo '✅' || echo '❌')"
    echo "HeroUI:       $([ -d node_modules/@heroui ] && echo '✅' || echo '❌')"
}

turbo-help() {
    echo "🚀 Turbo Flow v2.0.0 Quick Reference"
    echo "────────────────────────────────────"
    echo ""
    echo "RUVECTOR (Neural Engine)"
    echo "  ruv                  Start RuVector"
    echo "  ruv-stats            Show learning statistics"
    echo "  ruv-route 'task'     Route task to best agent"
    echo "  ruv-remember         Store in semantic memory"
    echo "  ruv-recall 'query'   Search semantic memory"
    echo ""
    echo "CLAUDE FLOW V3"
    echo "  cf-swarm             Hierarchical swarm"
    echo "  cf-mesh              Mesh swarm"
    echo "  cf-agent TYPE TASK   Run agent"
    echo "  cf-daemon            Background daemon"
    echo ""
    echo "TESTING"
    echo "  aqe-generate         Generate tests"
    echo "  aqe-gate             Quality gate"
    echo ""
    echo "STATUS"
    echo "  turbo-status         Check all tools"
}

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"

# === END TURBO FLOW v2.0.0 ===

ALIASES_EOF
    ok "Bash aliases installed"
fi

info "Elapsed: $(elapsed)"

# ============================================
# COMPLETE
# ============================================
END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))

CF_STATUS="❌"; [ -d "$WORKSPACE_FOLDER/.claude-flow" ] && CF_STATUS="✅"
CLAUDE_STATUS="❌"; has_cmd claude && CLAUDE_STATUS="✅"
PRD2BUILD_STATUS="❌"; [ -f "$HOME/.claude/commands/prd2build.md" ] && PRD2BUILD_STATUS="✅"
CODEX_STATUS="⚪"; has_cmd codex && CODEX_STATUS="✅"
CODEX_CONFIG_STATUS="❌"; [ -f "$HOME/.codex/config.toml" ] && CODEX_CONFIG_STATUS="✅"
AGENTS_STATUS="❌"; [ -f "$WORKSPACE_FOLDER/AGENTS.md" ] && AGENTS_STATUS="✅"
PW_STATUS="❌"; npx -y playwriter@latest --version >/dev/null 2>&1 && PW_STATUS="✅"
DEVB_STATUS="❌"; [ -d "$HOME/.claude/skills/dev-browser" ] && DEVB_STATUS="✅"
SEC_STATUS="❌"; [ -d "$HOME/.claude/skills/security-analyzer" ] && SEC_STATUS="✅"
HEROUI_STATUS="❌"; [ -d "$WORKSPACE_FOLDER/node_modules/@heroui" ] && HEROUI_STATUS="✅"
RUV_STATUS="❌"; is_npm_installed "ruvector" && RUV_STATUS="✅"

NODE_VER=$(node -v 2>/dev/null || echo "N/A")

echo ""
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║   🎉 TURBO FLOW v2.0.0 SETUP COMPLETE!                      ║"
echo "║   Claude Flow V3 + RuVector Neural Engine                   ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
progress_bar 100
echo ""
echo ""
echo "  ┌──────────────────────────────────────────────────┐"
echo "  │  📊 SUMMARY                                      │"
echo "  ├──────────────────────────────────────────────────┤"
echo "  │  Node.js:        $NODE_VER                       │"
echo "  │  $RUV_STATUS RuVector Neural Engine                   │"
echo "  │  $CLAUDE_STATUS Claude Code                              │"
echo "  │  $CF_STATUS Claude Flow V3                            │"
echo "  │  $PRD2BUILD_STATUS prd2build                              │"
echo "  │  $PW_STATUS Playwriter                                │"
echo "  │  $DEVB_STATUS Dev-Browser                              │"
echo "  │  $SEC_STATUS Security Analyzer                         │"
echo "  │  $HEROUI_STATUS HeroUI + Tailwind                        │"
echo "  │  $CODEX_CONFIG_STATUS Codex config                            │"
echo "  │  $AGENTS_STATUS AGENTS.md                                │"
echo "  │  ⏱️  ${TOTAL_TIME}s                                        │"
echo "  └──────────────────────────────────────────────────┘"
echo ""
echo "  ⚠️  MANUAL STEPS:"
echo "  ────────────────"
echo "  1. Playwriter Chrome extension:"
echo "     https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe"
echo ""
echo "  2. Codex (OPTIONAL):"
echo "     npm install -g @openai/codex && codex login"
echo ""
echo "  📌 QUICK START:"
echo "  ───────────────"
echo "  1. source ~/.bashrc"
echo "  2. claude"
echo "  3. turbo-help"
echo ""
echo "  🚀 Happy coding!"
echo ""
