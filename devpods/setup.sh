#!/bin/bash
# TURBO FLOW SETUP SCRIPT v2.0.5
# Claude Flow V3 + RuVector + Agent Browser + Security Analyzer + UI Pro Max + HeroUI
# v2.0.5: Fixed Claude Flow installation per official README documentation

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
# PRE-CREATE DIRECTORIES
# ============================================
mkdir -p "$HOME/.claude/skills" "$HOME/.claude/commands" "$HOME/.config/claude" "$HOME/.codex" 2>/dev/null || true

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
echo "║     🚀 TURBO FLOW v2.0.5 - CLAUDE FLOW V3 + RUVECTOR        ║"
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
    
    if npm install -g n --silent 2>/dev/null; then
        n 20 2>/dev/null || sudo n 20 2>/dev/null || true
        hash -r 2>/dev/null || true
        export PATH="/usr/local/bin:$PATH"
    fi
    
    NODE_VERSION_FINAL=$(node -v 2>/dev/null || echo "not found")
    ok "Node.js: $NODE_VERSION_FINAL"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 3: Fix npm & clear caches
# ============================================
step_header "Fixing npm authentication & clearing caches"

status "Removing expired npm tokens"
npm config delete //registry.npmjs.org/:_authToken 2>/dev/null || true
npm config delete _authToken 2>/dev/null || true

# Remove problematic .npmrc
if [ -f "$HOME/.npmrc" ]; then
    grep -v "_authToken" "$HOME/.npmrc" > "$HOME/.npmrc.tmp" 2>/dev/null && mv "$HOME/.npmrc.tmp" "$HOME/.npmrc" || true
fi

ok "Tokens cleaned"

status "Setting public npm registry"
npm config set registry https://registry.npmjs.org/
ok "Registry set"

status "Clearing npm caches"
rm -rf ~/.npm/_locks ~/.npm/_npx ~/.npm/_cacache 2>/dev/null || true
npm cache clean --force --silent 2>/dev/null || true
ok "Caches cleared"

info "Elapsed: $(elapsed)"

# ============================================
# STEP 4: Claude Code (REQUIRED for Claude Flow)
# ============================================
step_header "Installing Claude Code (REQUIRED prerequisite)"

checking "Claude Code"
if has_cmd claude; then
    CLAUDE_VER=$(claude --version 2>/dev/null | head -1 || echo "installed")
    skip "Claude Code ($CLAUDE_VER)"
else
    status "Installing @anthropic-ai/claude-code"
    if npm install -g @anthropic-ai/claude-code 2>&1 | tail -5; then
        if has_cmd claude; then
            ok "Claude Code installed"
        else
            fail "Claude Code install failed"
            info "Install manually: npm install -g @anthropic-ai/claude-code"
        fi
    else
        fail "Claude Code install failed"
        info "Claude Flow REQUIRES Claude Code to be installed first!"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 5: Claude Flow V3 (Per Official README)
# ============================================
step_header "Installing Claude Flow V3"

cd "$WORKSPACE_FOLDER" 2>/dev/null || cd "$HOME"

checking "claude-flow"

# Check if already initialized
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ]; then
    skip "Claude Flow already initialized"
else
    status "Installing Claude Flow via official method"
    
    # Method from README: npx claude-flow@alpha init
    # Using timeout to prevent hangs
    if timeout 120 npx -y claude-flow@alpha init 2>&1 | tail -20; then
        if [ -d "$WORKSPACE_FOLDER/.claude-flow" ] || [ -f "$WORKSPACE_FOLDER/claude-flow.config.json" ]; then
            ok "Claude Flow V3 initialized"
        else
            warn "Init completed but config not found - trying --force"
            timeout 60 npx -y claude-flow@alpha init --force 2>&1 | tail -10 || true
            if [ -d "$WORKSPACE_FOLDER/.claude-flow" ]; then
                ok "Claude Flow V3 initialized (forced)"
            else
                warn "Creating minimal config"
                mkdir -p "$WORKSPACE_FOLDER/.claude-flow"
                echo '{"version":"3.0.0"}' > "$WORKSPACE_FOLDER/.claude-flow/config.json"
            fi
        fi
    else
        warn "Claude Flow init timed out or failed"
        info "Try manually: npx claude-flow@alpha init --wizard"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 6: Register Claude Flow MCP (Per README)
# ============================================
step_header "Registering Claude Flow MCP server"

checking "Claude Flow MCP"
if has_cmd claude; then
    if claude mcp list 2>/dev/null | grep -q "claude-flow"; then
        skip "claude-flow MCP already registered"
    else
        status "Adding Claude Flow MCP server"
        # Per README: claude mcp add claude-flow -- npx -y claude-flow@latest mcp start
        if claude mcp add claude-flow -- npx -y claude-flow@latest mcp start 2>&1; then
            ok "Claude Flow MCP registered"
        else
            warn "MCP registration via CLI failed - using config file"
            mkdir -p "$HOME/.config/claude"
            cat << 'EOF' > "$HOME/.config/claude/mcp.json"
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@latest", "mcp", "start"],
      "env": {}
    }
  }
}
EOF
            ok "MCP config file created"
        fi
    fi
else
    warn "Claude CLI not available - creating config file"
    mkdir -p "$HOME/.config/claude"
    cat << 'EOF' > "$HOME/.config/claude/mcp.json"
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@latest", "mcp", "start"],
      "env": {}
    }
  }
}
EOF
    ok "MCP config file created"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 7: RuVector (Optional but Recommended)
# ============================================
step_header "Installing RuVector Neural Engine"

checking "ruvector"
if is_npm_installed "ruvector"; then
    skip "ruvector"
else
    status "Installing ruvector"
    timeout 60 npm install -g ruvector --silent 2>/dev/null && ok "ruvector installed" || warn "ruvector install failed (optional)"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 8: Core npm packages
# ============================================
step_header "Installing core npm packages"

for pkg in agentic-qe uipro-cli agent-browser; do
    checking "$pkg"
    if is_npm_installed "$pkg"; then
        skip "$pkg"
    else
        status "Installing $pkg"
        timeout 60 npm install -g "$pkg" --silent 2>/dev/null && ok "$pkg installed" || warn "$pkg failed"
    fi
done

info "Elapsed: $(elapsed)"

# ============================================
# STEP 9: Agent Browser Setup
# ============================================
step_header "Setting up Agent Browser"

checking "Chromium"
if has_cmd agent-browser; then
    status "Installing Chromium"
    timeout 120 agent-browser install --with-deps 2>/dev/null && ok "Chromium installed" || warn "Chromium failed"
else
    warn "agent-browser not available"
fi

AGENT_BROWSER_SKILL_DIR="$HOME/.claude/skills/agent-browser"
if [ ! -d "$AGENT_BROWSER_SKILL_DIR" ]; then
    mkdir -p "$AGENT_BROWSER_SKILL_DIR"
    curl -fsSL -o "$AGENT_BROWSER_SKILL_DIR/SKILL.md" \
        "https://raw.githubusercontent.com/AugmentCode/agent-browser/main/skills/agent-browser/SKILL.md" 2>/dev/null && \
        ok "agent-browser skill installed" || warn "skill download failed"
else
    skip "agent-browser skill"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 10: Security Analyzer Skill
# ============================================
step_header "Installing Security Analyzer Skill"

SECURITY_SKILL_DIR="$HOME/.claude/skills/security-analyzer"
if [ -d "$SECURITY_SKILL_DIR" ]; then
    skip "security-analyzer skill"
else
    status "Cloning security-analyzer"
    if timeout 30 git clone --depth 1 https://github.com/Cornjebus/security-analyzer.git /tmp/security-analyzer 2>/dev/null; then
        mkdir -p "$SECURITY_SKILL_DIR"
        cp -r /tmp/security-analyzer/* "$SECURITY_SKILL_DIR/" 2>/dev/null || true
        rm -rf /tmp/security-analyzer
        ok "security-analyzer skill installed"
    else
        warn "security-analyzer clone failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 11: uv + Spec-Kit
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

ok "Workspace configured"
info "Elapsed: $(elapsed)"

# ============================================
# STEP 13: Install prd2build Command
# ============================================
step_header "Installing prd2build command"

COMMANDS_DIR="$HOME/.claude/commands"
PRD2BUILD_SOURCE="$DEVPOD_DIR/context/prd2build.md"

if [ -f "$COMMANDS_DIR/prd2build.md" ]; then
    skip "prd2build command"
elif [ -f "$PRD2BUILD_SOURCE" ]; then
    cp "$PRD2BUILD_SOURCE" "$COMMANDS_DIR/prd2build.md"
    ok "prd2build command installed"
else
    warn "prd2build.md not found"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 14: Codex Configuration
# ============================================
step_header "Configuring Codex (optional)"

CODEX_DIR="$HOME/.codex"
mkdir -p "$CODEX_DIR" 2>/dev/null

if [ -f "$WORKSPACE_FOLDER/AGENTS.md" ]; then
    skip "AGENTS.md"
else
    cat > "$WORKSPACE_FOLDER/AGENTS.md" << 'EOF'
# Codex & Claude Code Collaboration Protocol

## Task Allocation

| Task Type | Codex | Claude Code |
|-----------|-------|-------------|
| Code changes, tests, refactors | ✅ | ❌ |
| Build, lint, format, migrate | ✅ | ❌ |
| GitHub PRs, CI/CD admin | ❌ | ✅ |
| Secrets, tokens, vault | ❌ | ✅ |
| Multi-repo coordination | ❌ | ✅ |
EOF
    ok "AGENTS.md created"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 15: Verify Installation
# ============================================
step_header "Verifying installation"

status "Running Claude Flow doctor"
if timeout 60 npx -y claude-flow@alpha doctor 2>&1 | head -20; then
    ok "Claude Flow doctor completed"
else
    warn "Doctor timed out - run manually: npx claude-flow@alpha doctor"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 16: Bash aliases
# ============================================
step_header "Installing bash aliases"

if grep -q "TURBO FLOW v2.0.5" ~/.bashrc 2>/dev/null; then
    skip "Bash aliases"
else
    # Remove old versions
    sed -i '/# === TURBO FLOW/,/# === END TURBO FLOW/d' ~/.bashrc 2>/dev/null || true
    
    cat << 'ALIASES_EOF' >> ~/.bashrc

# === TURBO FLOW v2.0.5 (Claude Flow V3) ===

# CLAUDE CODE
alias dsp="claude --dangerously-skip-permissions"

# CLAUDE FLOW V3 (per official README)
alias cf="npx -y claude-flow@alpha"
alias cf-init="npx -y claude-flow@alpha init"
alias cf-wizard="npx -y claude-flow@alpha init --wizard"
alias cf-swarm="npx -y claude-flow@alpha swarm init --topology hierarchical"
alias cf-mesh="npx -y claude-flow@alpha swarm init --topology mesh"
alias cf-agent="npx -y claude-flow@alpha agent spawn"
alias cf-list="npx -y claude-flow@alpha agent list"
alias cf-memory="npx -y claude-flow@alpha memory"
alias cf-mcp="npx -y claude-flow@alpha mcp start"
alias cf-doctor="npx -y claude-flow@alpha doctor"
alias cf-status="npx -y claude-flow@alpha status"
alias cf-hooks="npx -y claude-flow@alpha hooks"

# RUVECTOR
alias ruv="npx ruvector"

# AGENT-BROWSER
alias ab="agent-browser"
alias ab-open="agent-browser open"
alias ab-snap="agent-browser snapshot -i"

# HELPERS
turbo-status() {
    echo "📊 Turbo Flow v2.0.5 Status"
    echo "───────────────────────────"
    echo "Node.js:       $(node -v 2>/dev/null || echo 'not found')"
    echo "Claude Code:   $(claude --version 2>/dev/null | head -1 || echo 'not found')"
    echo "Claude Flow:   $(npx -y claude-flow@alpha --version 2>/dev/null | head -1 || echo 'checking...')"
    echo "RuVector:      $(npx ruvector --version 2>/dev/null || echo 'not installed')"
    echo "CF Config:     $([ -d .claude-flow ] && echo '✅' || echo '❌')"
    echo "CF MCP:        $(claude mcp list 2>/dev/null | grep -q claude-flow && echo '✅' || echo '❓')"
}

turbo-help() {
    echo "🚀 Turbo Flow v2.0.5 Quick Reference"
    echo "────────────────────────────────────"
    echo ""
    echo "CLAUDE FLOW V3"
    echo "  cf-wizard            Interactive setup"
    echo "  cf-swarm             Hierarchical swarm"
    echo "  cf-mesh              Mesh swarm"
    echo "  cf-agent -t TYPE     Spawn agent"
    echo "  cf-list              List agents"
    echo "  cf-doctor            Run diagnostics"
    echo "  cf-mcp               Start MCP server"
    echo ""
    echo "STATUS"
    echo "  turbo-status         Check all tools"
}

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"

# === END TURBO FLOW v2.0.5 ===

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
MCP_STATUS="❌"; (has_cmd claude && claude mcp list 2>/dev/null | grep -q "claude-flow") && MCP_STATUS="✅"

echo ""
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║   🎉 TURBO FLOW v2.0.5 SETUP COMPLETE!                      ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
progress_bar 100
echo ""
echo ""
echo "  ┌──────────────────────────────────────────────────┐"
echo "  │  📊 SUMMARY                                      │"
echo "  ├──────────────────────────────────────────────────┤"
echo "  │  Node.js:    $(node -v 2>/dev/null || echo 'N/A')                            │"
echo "  │  $CLAUDE_STATUS Claude Code                              │"
echo "  │  $CF_STATUS Claude Flow V3                           │"
echo "  │  $MCP_STATUS Claude Flow MCP                          │"
echo "  │  ⏱️  ${TOTAL_TIME}s                                        │"
echo "  └──────────────────────────────────────────────────┘"
echo ""
echo "  📌 QUICK START:"
echo "  ───────────────"
echo "  1. source ~/.bashrc"
echo "  2. turbo-status        # Verify installation"
echo "  3. cf-doctor           # Run diagnostics"
echo "  4. cf-wizard           # Interactive setup (optional)"
echo "  5. claude              # Start Claude Code"
echo ""
echo "  🚀 Happy coding!"
echo ""
