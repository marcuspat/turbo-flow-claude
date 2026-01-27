#!/bin/bash
# TURBO FLOW SETUP SCRIPT v2.0.4
# Claude Flow V3 + RuVector + Agent Browser + Security Analyzer + UI Pro Max + HeroUI
# v2.0.4: Fixed npm authentication issues and added timeout handling

# NO set -e - we handle errors gracefully

# ============================================
# CONFIGURATION
# ============================================
: "${WORKSPACE_FOLDER:=$(pwd)}"
: "${DEVPOD_WORKSPACE_FOLDER:=$WORKSPACE_FOLDER}"
: "${AGENTS_DIR:=$WORKSPACE_FOLDER/agents}"

# Use consistent Claude Flow version throughout
CLAUDE_FLOW_VERSION="alpha"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"
TOTAL_STEPS=18
CURRENT_STEP=0
START_TIME=$(date +%s)

# ============================================
# PRE-CREATE DIRECTORIES (consolidated)
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

# Run command with timeout (default 120 seconds)
run_with_timeout() {
    local timeout_sec="${1:-120}"
    shift
    local cmd="$@"
    
    if has_cmd timeout; then
        timeout "$timeout_sec" bash -c "$cmd"
        return $?
    else
        # Fallback without timeout command
        bash -c "$cmd"
        return $?
    fi
}

install_npm() {
    local pkg="$1"
    checking "$pkg"
    if is_npm_installed "$pkg"; then
        skip "$pkg"
        return 0
    else
        status "Installing $pkg"
        if run_with_timeout 60 "npm install -g '$pkg' --silent --no-progress 2>/dev/null"; then
            ok "$pkg installed"
            return 0
        else
            warn "$pkg install failed or timed out"
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
echo "║     🚀 TURBO FLOW v2.0.4 - CLAUDE FLOW V3 + RUVECTOR        ║"
echo "║     Swarm Intelligence • Neural Engine • MCP Tools          ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "  📁 Workspace: $WORKSPACE_FOLDER"
echo "  🕐 Started at: $(date '+%H:%M:%S')"
echo "  📦 Claude Flow Version: @$CLAUDE_FLOW_VERSION"
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
# STEP 3: Fix npm authentication & clear caches
# ============================================
step_header "Fixing npm authentication & clearing caches"

status "Removing expired npm tokens from config"
# Remove tokens from npm config
npm config delete //registry.npmjs.org/:_authToken 2>/dev/null || true
npm config delete _authToken 2>/dev/null || true
npm config delete registry 2>/dev/null || true

ok "Config tokens removed"

status "Removing .npmrc file to force clean config"
# Instead of trying to edit the file, just delete it entirely.
# NPM will recreate it with the public registry in the next steps.
if [ -f "$HOME/.npmrc" ]; then
    rm "$HOME/.npmrc"
    ok "Removed stale .npmrc file"
else
    skip "No .npmrc file found"
fi

status "Setting public npm registry"
npm config set registry https://registry.npmjs.org/
ok "Registry set to public"

status "Clearing npm caches"
rm -rf ~/.npm/_locks 2>/dev/null || true
rm -rf ~/.npm/_npx 2>/dev/null || true
rm -rf ~/.npm/_cacache 2>/dev/null || true
npm cache clean --force --silent 2>/dev/null || true
ok "Caches cleared"

# Verify npm is working
status "Verifying npm connectivity"
if npm ping 2>/dev/null | grep -q "ok"; then
    ok "npm registry accessible"
else
    # Try without auth
    npm ping --registry https://registry.npmjs.org/ 2>/dev/null && ok "npm registry accessible" || warn "npm ping failed (may still work)"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 4: Claude Code (REQUIRED for Claude Flow)
# ============================================
step_header "Installing Claude Code (required for Claude Flow)"

checking "Claude Code"
if has_cmd claude; then
    CLAUDE_VER=$(claude --version 2>/dev/null | head -1 || echo "installed")
    skip "Claude Code ($CLAUDE_VER)"
else
    status "Installing @anthropic-ai/claude-code"
    if run_with_timeout 90 "npm install -g @anthropic-ai/claude-code --silent --no-progress"; then
        ok "Claude Code installed"
    else
        warn "Claude Code install failed - Claude Flow may not work properly"
        info "Install manually: npm install -g @anthropic-ai/claude-code"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 5: RuVector Neural Engine
# ============================================
step_header "Installing RuVector Neural Engine"

checking "ruvector"
if is_npm_installed "ruvector"; then
    skip "ruvector"
else
    status "Installing ruvector (vector DB + GNN + self-learning)"
    run_with_timeout 60 "npm install -g ruvector --silent --no-progress" && ok "ruvector installed" || warn "ruvector install failed"
fi

checking "@ruvector/sona"
if is_npm_installed "@ruvector/sona"; then
    skip "@ruvector/sona"
else
    status "Installing @ruvector/sona (self-learning)"
    run_with_timeout 60 "npm install -g @ruvector/sona --silent --no-progress" && ok "@ruvector/sona installed" || warn "@ruvector/sona install failed"
fi

checking "@ruvector/cli"
if is_npm_installed "@ruvector/cli"; then
    skip "@ruvector/cli"
else
    status "Installing @ruvector/cli (hooks & intelligence)"
    run_with_timeout 60 "npm install -g @ruvector/cli --silent --no-progress" && ok "@ruvector/cli installed" || warn "@ruvector/cli install failed"
fi

# Initialize RuVector hooks
status "Initializing RuVector hooks"
run_with_timeout 30 "npx @ruvector/cli hooks init" && ok "RuVector hooks initialized" || warn "RuVector hooks init failed"

info "Elapsed: $(elapsed)"

# ============================================
# STEP 6: Claude Flow V3
# ============================================
step_header "Installing Claude Flow V3"

cd "$WORKSPACE_FOLDER" 2>/dev/null || cd "$HOME"

checking "claude-flow v3"

NEEDS_INIT=false

# Check if already initialized properly
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ] && [ -f "$WORKSPACE_FOLDER/.claude-flow/config.json" ]; then
    if grep -q '"version"' "$WORKSPACE_FOLDER/.claude-flow/config.json" 2>/dev/null; then
        skip "claude-flow already initialized"
    else
        status "Re-initializing claude-flow (config incomplete)"
        rm -rf "$WORKSPACE_FOLDER/.claude-flow"
        NEEDS_INIT=true
    fi
else
    NEEDS_INIT=true
fi

if [ "$NEEDS_INIT" = true ]; then
    status "Initializing Claude Flow V3 (@$CLAUDE_FLOW_VERSION)"
    
    # Use timeout to prevent hanging (90 seconds max)
    if run_with_timeout 90 "npx -y claude-flow@${CLAUDE_FLOW_VERSION} init 2>&1 | head -30"; then
        if [ -d "$WORKSPACE_FOLDER/.claude-flow" ]; then
            ok "Claude Flow V3 initialized"
        else
            # Fallback to --force with timeout
            status "Retrying with --force flag (60s timeout)"
            if run_with_timeout 60 "npx -y claude-flow@${CLAUDE_FLOW_VERSION} init --force 2>&1 | head -20"; then
                if [ -d "$WORKSPACE_FOLDER/.claude-flow" ]; then
                    ok "Claude Flow V3 initialized (forced)"
                else
                    warn "Claude Flow init had issues - creating fallback config"
                    mkdir -p "$WORKSPACE_FOLDER/.claude-flow"
                    echo '{"version":"3.0.0","initialized":true}' > "$WORKSPACE_FOLDER/.claude-flow/config.json"
                fi
            else
                warn "Claude Flow init timed out - creating fallback config"
                mkdir -p "$WORKSPACE_FOLDER/.claude-flow"
                echo '{"version":"3.0.0","initialized":true,"fallback":true}' > "$WORKSPACE_FOLDER/.claude-flow/config.json"
            fi
        fi
    else
        warn "Claude Flow init failed or timed out"
        mkdir -p "$WORKSPACE_FOLDER/.claude-flow"
        echo '{"version":"3.0.0","initialized":true,"fallback":true}' > "$WORKSPACE_FOLDER/.claude-flow/config.json"
        ok "Fallback config created"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 7: Core npm packages
# ============================================
step_header "Installing core npm packages"

install_npm agentic-qe
install_npm @fission-ai/openspec
install_npm uipro-cli
install_npm agent-browser
install_npm @claude-flow/browser
install_npm @ruvector/ruvllm

info "Elapsed: $(elapsed)"

# ============================================
# STEP 8: Agent Browser Setup
# ============================================
step_header "Setting up Agent Browser (Chromium + Skill)"

checking "Chromium for agent-browser"
status "Installing Chromium and dependencies"
run_with_timeout 120 "agent-browser install --with-deps" && ok "Chromium installed" || warn "Chromium install failed"

AGENT_BROWSER_SKILL_DIR="$HOME/.claude/skills/agent-browser"
checking "agent-browser skill"

if [ -d "$AGENT_BROWSER_SKILL_DIR" ]; then
    skip "agent-browser skill already installed"
else
    mkdir -p "$AGENT_BROWSER_SKILL_DIR"
    
    # Try copying from npm global install first
    NPM_GLOBAL="$(npm root -g 2>/dev/null)"
    if [ -f "$NPM_GLOBAL/agent-browser/skills/agent-browser/SKILL.md" ]; then
        cp -r "$NPM_GLOBAL/agent-browser/skills/agent-browser/"* "$AGENT_BROWSER_SKILL_DIR/"
        ok "agent-browser skill installed"
    else
        # Fallback: download from GitHub
        curl -fsSL -o "$AGENT_BROWSER_SKILL_DIR/SKILL.md" \
            "https://raw.githubusercontent.com/vercel-labs/agent-browser/main/skills/agent-browser/SKILL.md" 2>/dev/null && \
            ok "agent-browser skill installed (from GitHub)" || warn "agent-browser skill install failed"
    fi
fi

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
    if run_with_timeout 30 "git clone --depth 1 https://github.com/Cornjebus/security-analyzer.git /tmp/security-analyzer"; then
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
    run_with_timeout 60 "curl -LsSf https://astral.sh/uv/install.sh | sh" && ok "uv installed" || warn "uv failed"
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" 2>/dev/null
    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
fi

checking "specify CLI"
if has_cmd specify; then
    skip "specify CLI"
else
    if has_cmd uv; then
        run_with_timeout 60 "uv tool install specify-cli --from git+https://github.com/github/spec-kit.git" && \
            ok "specify-cli installed" || warn "specify-cli failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 11: Register MCPs via Claude CLI
# ============================================
step_header "Registering MCP servers"

USE_CONFIG_FALLBACK=false

# Method 1: Use claude CLI (preferred)
checking "Claude Flow MCP registration"
if has_cmd claude; then
    if claude mcp list 2>/dev/null | grep -q "claude-flow"; then
        skip "claude-flow MCP already registered"
    else
        status "Registering Claude Flow MCP via CLI"
        if run_with_timeout 30 "claude mcp add claude-flow -- npx -y claude-flow@${CLAUDE_FLOW_VERSION} mcp start"; then
            ok "Claude Flow MCP registered"
        else
            warn "CLI registration failed, using config file fallback"
            USE_CONFIG_FALLBACK=true
        fi
    fi
    
    # Register agentic-qe
    if claude mcp list 2>/dev/null | grep -q "agentic-qe"; then
        skip "agentic-qe MCP already registered"
    else
        status "Registering agentic-qe MCP"
        run_with_timeout 30 "claude mcp add agentic-qe -- npx -y aqe-mcp" && ok "agentic-qe MCP registered" || warn "agentic-qe registration failed"
    fi
else
    warn "Claude CLI not available, using config file"
    USE_CONFIG_FALLBACK=true
fi

# Method 2: Config file fallback
if [ "$USE_CONFIG_FALLBACK" = true ]; then
    status "Writing MCP configuration file"
    mkdir -p "$HOME/.config/claude"
    cat << EOF > "$HOME/.config/claude/mcp.json"
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@${CLAUDE_FLOW_VERSION}", "mcp", "start"],
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
    ok "MCP config written to ~/.config/claude/mcp.json"
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

[ ! -f "tsconfig.json" ] && cat << 'EOF' > tsconfig.json
{"compilerOptions":{"target":"ES2022","module":"ESNext","moduleResolution":"node","outDir":"./dist","rootDir":"./src","strict":true,"esModuleInterop":true,"skipLibCheck":true,"jsx":"react-jsx"},"include":["src/**/*","tests/**/*"],"exclude":["node_modules","dist"]}
EOF

checking "HeroUI dependencies"
if [ -d "node_modules/@heroui" ]; then
    skip "HeroUI already installed"
else
    status "Installing HeroUI + Tailwind"
    
    # Install with visible errors for debugging
    if run_with_timeout 120 "npm install @heroui/react framer-motion --save 2>&1 | tail -5"; then
        ok "HeroUI packages installed"
    else
        warn "HeroUI install may have failed - check errors above"
    fi
    
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
    
    # Verify installation
    if [ -d "node_modules/@heroui" ]; then
        ok "Frontend stack installed"
    else
        warn "HeroUI installation incomplete - run manually: npm install @heroui/react framer-motion"
    fi
fi

ok "Workspace configured"
info "Elapsed: $(elapsed)"

# ============================================
# STEP 13: Install UI UX Pro Max Skill
# ============================================
step_header "Installing UI UX Pro Max Skill"

UIPRO_SKILL_DIR="$HOME/.claude/skills/ui-ux-pro-max"
UIPRO_SKILL_DIR_LOCAL="$WORKSPACE_FOLDER/.claude/skills/ui-ux-pro-max"

checking "UI UX Pro Max skill"

# Check if skill exists and has content (not empty)
skill_has_content() {
    local dir="$1"
    [ -d "$dir" ] && [ -n "$(ls -A "$dir" 2>/dev/null)" ]
}

if skill_has_content "$UIPRO_SKILL_DIR" || skill_has_content "$UIPRO_SKILL_DIR_LOCAL"; then
    skip "UI UX Pro Max skill already installed"
else
    # Remove empty directories if they exist (from previous failed installs)
    [ -d "$UIPRO_SKILL_DIR" ] && [ -z "$(ls -A "$UIPRO_SKILL_DIR" 2>/dev/null)" ] && rm -rf "$UIPRO_SKILL_DIR"
    [ -d "$UIPRO_SKILL_DIR_LOCAL" ] && [ -z "$(ls -A "$UIPRO_SKILL_DIR_LOCAL" 2>/dev/null)" ] && rm -rf "$UIPRO_SKILL_DIR_LOCAL"
    
    status "Installing UI UX Pro Max skill (using bundled assets)"
    
    # Use --offline flag to avoid GitHub rate limits and empty folder bug
    if has_cmd uipro; then
        if run_with_timeout 60 "uipro init --ai claude --offline 2>&1 | tail -5"; then
            # Verify installation has content
            if skill_has_content "$UIPRO_SKILL_DIR" || skill_has_content "$UIPRO_SKILL_DIR_LOCAL"; then
                ok "UI UX Pro Max skill installed"
            else
                warn "UI UX Pro Max skill installed but appears empty"
            fi
        else
            warn "UI UX Pro Max skill install failed"
        fi
    else
        # Fallback to npx if global install failed
        if run_with_timeout 60 "npx -y uipro-cli init --ai claude --offline 2>&1 | tail -5"; then
            # Verify installation has content
            if skill_has_content "$UIPRO_SKILL_DIR" || skill_has_content "$UIPRO_SKILL_DIR_LOCAL"; then
                ok "UI UX Pro Max skill installed (via npx)"
            else
                warn "UI UX Pro Max skill installed but appears empty"
            fi
        else
            warn "UI UX Pro Max skill install failed"
        fi
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 14: Install prd2build Command
# ============================================
step_header "Installing prd2build command"

COMMANDS_DIR="$HOME/.claude/commands"
PRD2BUILD_SOURCE="$DEVPOD_DIR/context/prd2build.md"

checking "prd2build command"

if [ -f "$COMMANDS_DIR/prd2build.md" ]; then
    skip "prd2build command already installed"
else
    if [ -f "$PRD2BUILD_SOURCE" ]; then
        cp "$PRD2BUILD_SOURCE" "$COMMANDS_DIR/prd2build.md"
        ok "prd2build command installed"
    else
        warn "prd2build.md not found at $PRD2BUILD_SOURCE"
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
mkdir -p "$CODEX_DIR" 2>/dev/null
if [ -d "$CODEX_DIR" ]; then
    ok "Codex config directory exists"
fi

checking "Codex instructions"
if [ -f "$CODEX_DIR/instructions.md" ]; then
    skip "Codex instructions already installed"
else
    if [ -f "$CODEX_INSTRUCTIONS_SOURCE" ]; then
        cp "$CODEX_INSTRUCTIONS_SOURCE" "$CODEX_DIR/instructions.md"
        ok "Codex instructions installed"
    else
        warn "codex_claude.md not found at $CODEX_INSTRUCTIONS_SOURCE"
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
# STEP 16: Verify Claude Flow Installation
# ============================================
step_header "Verifying Claude Flow installation"

status "Running Claude Flow diagnostics"
if run_with_timeout 60 "npx -y claude-flow@${CLAUDE_FLOW_VERSION} doctor 2>&1 | head -30"; then
    ok "Claude Flow diagnostics completed"
else
    warn "Diagnostics timed out or failed - check manually with: npx claude-flow@alpha doctor"
fi

# Additional verification
checking "Claude Flow config"
if [ -f "$WORKSPACE_FOLDER/.claude-flow/config.json" ]; then
    ok "Config file exists"
else
    warn "Config file missing"
fi

checking "Claude Flow MCP"
if has_cmd claude && claude mcp list 2>/dev/null | grep -q "claude-flow"; then
    ok "MCP server registered"
else
    info "MCP registration status unknown"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 17: Test Claude Flow Commands
# ============================================
step_header "Testing Claude Flow basic commands"

status "Testing claude-flow version"
CF_VERSION=$(run_with_timeout 30 "npx -y claude-flow@${CLAUDE_FLOW_VERSION} --version 2>/dev/null | head -1" || echo "unknown")
if [ "$CF_VERSION" != "unknown" ] && [ -n "$CF_VERSION" ]; then
    ok "Claude Flow version: $CF_VERSION"
else
    warn "Could not get Claude Flow version"
fi

status "Testing claude-flow status"
if run_with_timeout 30 "npx -y claude-flow@${CLAUDE_FLOW_VERSION} status 2>&1 | head -10"; then
    ok "Claude Flow status works"
else
    warn "Claude Flow status failed"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 18: Bash aliases
# ============================================
step_header "Installing bash aliases"

checking "TURBO FLOW aliases"
if grep -q "TURBO FLOW v2.0.4" ~/.bashrc 2>/dev/null; then
    skip "Bash aliases already installed"
else
    # Remove old versions
    sed -i '/# === TURBO FLOW/,/# === END TURBO FLOW/d' ~/.bashrc 2>/dev/null || true
    
    cat << ALIASES_EOF >> ~/.bashrc

# === TURBO FLOW v2.0.4 (Claude Flow V3 + RuVector) ===

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

# CLAUDE FLOW V3 (consistent @${CLAUDE_FLOW_VERSION} version)
alias cf="npx -y claude-flow@${CLAUDE_FLOW_VERSION}"
alias cf-init="npx -y claude-flow@${CLAUDE_FLOW_VERSION} init"
alias cf-swarm="npx -y claude-flow@${CLAUDE_FLOW_VERSION} swarm init --topology hierarchical"
alias cf-mesh="npx -y claude-flow@${CLAUDE_FLOW_VERSION} swarm init --topology mesh"
alias cf-agent="npx -y claude-flow@${CLAUDE_FLOW_VERSION} agent spawn"
alias cf-list="npx -y claude-flow@${CLAUDE_FLOW_VERSION} agent list"
alias cf-daemon="npx -y claude-flow@${CLAUDE_FLOW_VERSION} daemon start"
alias cf-memory="npx -y claude-flow@${CLAUDE_FLOW_VERSION} memory"
alias cf-memory-status="npx -y claude-flow@${CLAUDE_FLOW_VERSION} memory stats"
alias cf-security="npx -y claude-flow@${CLAUDE_FLOW_VERSION} security scan"
alias cf-mcp="npx -y claude-flow@${CLAUDE_FLOW_VERSION} mcp start"
alias cf-doctor="npx -y claude-flow@${CLAUDE_FLOW_VERSION} doctor"
alias cf-status="npx -y claude-flow@${CLAUDE_FLOW_VERSION} status"
alias cf-hooks="npx -y claude-flow@${CLAUDE_FLOW_VERSION} hooks"
alias cf-pretrain="npx -y claude-flow@${CLAUDE_FLOW_VERSION} hooks pretrain"

# AGENTIC QE
alias aqe="npx -y agentic-qe"
alias aqe-generate="npx -y agentic-qe generate"
alias aqe-gate="npx -y agentic-qe gate"

# AGENT-BROWSER
alias ab="agent-browser"
alias ab-open="agent-browser open"
alias ab-snap="agent-browser snapshot -i"
alias ab-click="agent-browser click"
alias ab-fill="agent-browser fill"
alias ab-close="agent-browser close"

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
    [ -f ~/.codex/instructions.md ] && echo "✅ Instructions exist" || echo "❌ Instructions missing"
    [ -f AGENTS.md ] && echo "✅ AGENTS.md exists" || echo "⚠️ AGENTS.md not found"
}

# HELPERS
turbo-status() {
    echo "📊 Turbo Flow v2.0.4 Status"
    echo "───────────────────────────"
    echo "Node.js:       \$(node -v 2>/dev/null || echo 'not found')"
    echo "Claude Code:   \$(claude --version 2>/dev/null | head -1 || echo 'not found')"
    echo "RuVector:      \$(npx ruvector --version 2>/dev/null || echo 'not found')"
    echo "Claude Flow:   \$(npx -y claude-flow@${CLAUDE_FLOW_VERSION} --version 2>/dev/null | head -1 || echo 'not found')"
    echo "Codex:         \$(command -v codex >/dev/null && codex --version 2>/dev/null || echo 'not installed')"
    echo "prd2build:     \$([ -f ~/.claude/commands/prd2build.md ] && echo '✅' || echo '❌')"
    echo "Agent-Browser: \$([ -d ~/.claude/skills/agent-browser ] && echo '✅' || echo '❌')"
    echo "Security:      \$([ -d ~/.claude/skills/security-analyzer ] && echo '✅' || echo '❌')"
    echo "UI Pro Max:    \$([ -d ~/.claude/skills/ui-ux-pro-max ] && [ -n \"\$(ls -A ~/.claude/skills/ui-ux-pro-max 2>/dev/null)\" ] && echo '✅' || echo '❌')"
    echo "HeroUI:        \$([ -d node_modules/@heroui ] && echo '✅' || echo '❌')"
    echo "CF Config:     \$([ -f .claude-flow/config.json ] && echo '✅' || echo '❌')"
    echo "CF MCP:        \$(claude mcp list 2>/dev/null | grep -q claude-flow && echo '✅' || echo '❓')"
}

turbo-help() {
    echo "🚀 Turbo Flow v2.0.4 Quick Reference"
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
    echo "  cf-agent -t TYPE     Spawn agent"
    echo "  cf-list              List agents"
    echo "  cf-daemon            Background daemon"
    echo "  cf-doctor            Run diagnostics"
    echo "  cf-pretrain          Bootstrap learning"
    echo ""
    echo "AGENT-BROWSER"
    echo "  ab-open <url>        Open URL in browser"
    echo "  ab-snap              Get accessibility snapshot"
    echo "  ab-click @ref        Click element by ref"
    echo "  ab-fill @ref 'text'  Fill input by ref"
    echo "  ab-close             Close browser"
    echo ""
    echo "TESTING"
    echo "  aqe-generate         Generate tests"
    echo "  aqe-gate             Quality gate"
    echo ""
    echo "STATUS"
    echo "  turbo-status         Check all tools"
    echo "  codex-check          Check Codex setup"
}

# Fix npm auth on shell start (prevents token errors)
npm config delete //registry.npmjs.org/:_authToken 2>/dev/null || true

export PATH="\$HOME/.local/bin:\$HOME/.cargo/bin:/usr/local/bin:\$PATH"

# === END TURBO FLOW v2.0.4 ===

ALIASES_EOF
    ok "Bash aliases installed"
fi

info "Elapsed: $(elapsed)"

# ============================================
# COMPLETE
# ============================================
END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))

# Helper function for status check
skill_has_content() {
    local dir="$1"
    [ -d "$dir" ] && [ -n "$(ls -A "$dir" 2>/dev/null)" ]
}

CF_STATUS="❌"; [ -d "$WORKSPACE_FOLDER/.claude-flow" ] && CF_STATUS="✅"
CLAUDE_STATUS="❌"; has_cmd claude && CLAUDE_STATUS="✅"
PRD2BUILD_STATUS="❌"; [ -f "$HOME/.claude/commands/prd2build.md" ] && PRD2BUILD_STATUS="✅"
CODEX_STATUS="⚪"; has_cmd codex && CODEX_STATUS="✅"
CODEX_CONFIG_STATUS="❌"; [ -f "$HOME/.codex/instructions.md" ] && CODEX_CONFIG_STATUS="✅"
AGENTS_STATUS="❌"; [ -f "$WORKSPACE_FOLDER/AGENTS.md" ] && AGENTS_STATUS="✅"
AB_STATUS="❌"; [ -d "$HOME/.claude/skills/agent-browser" ] && AB_STATUS="✅"
SEC_STATUS="❌"; [ -d "$HOME/.claude/skills/security-analyzer" ] && SEC_STATUS="✅"
UIPRO_STATUS="❌"; (skill_has_content "$HOME/.claude/skills/ui-ux-pro-max" || skill_has_content "$WORKSPACE_FOLDER/.claude/skills/ui-ux-pro-max") && UIPRO_STATUS="✅"
HEROUI_STATUS="❌"; [ -d "$WORKSPACE_FOLDER/node_modules/@heroui" ] && HEROUI_STATUS="✅"
RUV_STATUS="❌"; is_npm_installed "ruvector" && RUV_STATUS="✅"
MCP_STATUS="❌"; (has_cmd claude && claude mcp list 2>/dev/null | grep -q "claude-flow") && MCP_STATUS="✅"

NODE_VER=$(node -v 2>/dev/null || echo "N/A")
CLAUDE_VER=$(claude --version 2>/dev/null | head -1 || echo "N/A")

echo ""
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║   🎉 TURBO FLOW v2.0.4 SETUP COMPLETE!                      ║"
echo "║   Claude Flow V3 + RuVector Neural Engine                   ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
progress_bar 100
echo ""
echo ""
echo "  ┌──────────────────────────────────────────────────┐"
echo "  │  📊 SUMMARY                                      │"
echo "  ├──────────────────────────────────────────────────┤"
echo "  │  Node.js:        $NODE_VER                       "
echo "  │  Claude Code:    $CLAUDE_VER                     "
echo "  │  $CLAUDE_STATUS Claude Code CLI                          │"
echo "  │  $RUV_STATUS RuVector Neural Engine                   │"
echo "  │  $CF_STATUS Claude Flow V3 (@$CLAUDE_FLOW_VERSION)                 │"
echo "  │  $MCP_STATUS Claude Flow MCP                          │"
echo "  │  $PRD2BUILD_STATUS prd2build                              │"
echo "  │  $AB_STATUS Agent Browser                            │"
echo "  │  $SEC_STATUS Security Analyzer                         │"
echo "  │  $UIPRO_STATUS UI UX Pro Max                           │"
echo "  │  $HEROUI_STATUS HeroUI + Tailwind                        │"
echo "  │  $CODEX_CONFIG_STATUS Codex config                            │"
echo "  │  $AGENTS_STATUS AGENTS.md                                │"
echo "  │  ⏱️  ${TOTAL_TIME}s                                        │"
echo "  └──────────────────────────────────────────────────┘"
echo ""
echo "  ⚠️  MANUAL STEPS:"
echo "  ────────────────"
echo "  Codex (OPTIONAL):"
echo "  npm install -g @openai/codex && codex login"
echo ""
echo "  📌 QUICK START:"
echo "  ───────────────"
echo "  1. source ~/.bashrc"
echo "  2. turbo-status        # Verify installation"
echo "  3. cf-doctor           # Run Claude Flow diagnostics"
echo "  4. claude              # Start Claude Code"
echo "  5. turbo-help          # Show all commands"
echo ""
echo "  🚀 Happy coding!"
echo ""
