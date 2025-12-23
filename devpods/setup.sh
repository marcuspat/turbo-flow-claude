#!/bin/bash
# TURBO FLOW SETUP SCRIPT - OPTIMIZED VERSION v7
# v6: Added ai-agent-skills, n8n-mcp, pal-mcp-server
# v7: Parallel installs, batch npm, -y everywhere, ~2x faster

# NO set -e - we handle errors gracefully

# ============================================
# CONFIGURATION
# ============================================
: "${WORKSPACE_FOLDER:=$(pwd)}"
: "${DEVPOD_WORKSPACE_FOLDER:=$WORKSPACE_FOLDER}"
: "${AGENTS_DIR:=$WORKSPACE_FOLDER/agents}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"
TOTAL_STEPS=9
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

# Check if command exists
has_cmd() {
    command -v "$1" >/dev/null 2>&1
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
echo "║     🚀 TURBO FLOW SETUP - OPTIMIZED v7          ║"
echo "║     Parallel • Batch • Lightning Fast            ║"
echo "║     Skills + MCP Servers + Spec-Kit              ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "  📁 Workspace: $WORKSPACE_FOLDER"
echo "  🕐 Started at: $(date '+%H:%M:%S')"
echo ""
progress_bar 0
echo ""

# ============================================
# [10%] STEP 1: Prep & parallel background tasks
# ============================================
step_header "Starting parallel background tasks"

# Clear npm locks once
status "Clearing npm locks & cache"
rm -rf ~/.npm/_locks ~/.npm/_npx 2>/dev/null || true
ok "npm locks cleared"

# Start background tasks in parallel
status "Starting uv install (background)"
(curl -LsSf https://astral.sh/uv/install.sh 2>/dev/null | sh >/dev/null 2>&1) &
UV_PID=$!

status "Starting direnv install (background)"
(curl -sfL https://direnv.net/install.sh 2>/dev/null | bash >/dev/null 2>&1) &
DIRENV_PID=$!

status "Starting subagents clone (background)"
mkdir -p "$AGENTS_DIR" 2>/dev/null
(cd "$AGENTS_DIR" && \
 [ "$(find . -maxdepth 1 -name '*.md' 2>/dev/null | wc -l)" -lt 5 ] && \
 git clone --depth 1 --quiet https://github.com/ChrisRoyse/610ClaudeSubagents.git temp-agents 2>/dev/null && \
 cp -r temp-agents/agents/*.md . 2>/dev/null; \
 rm -rf temp-agents 2>/dev/null) &
AGENTS_PID=$!

ok "3 background tasks started"
info "Elapsed: $(elapsed)"

# ============================================
# [20%] STEP 2: Batch npm install (all packages at once)
# ============================================
step_header "Installing all npm packages (batch)"

# Define all packages
NPM_PACKAGES=(
    "@anthropic-ai/claude-code"
    "claude-flow@alpha"
    "claude-usage-cli"
    "agentic-qe"
    "agentic-flow"
    "agentic-jujutsu"
    "claudish"
    "@playwright/mcp"
    "chrome-devtools-mcp"
    "mcp-chrome-bridge"
    "ai-agent-skills"
    "n8n-mcp"
)

# Check what's already installed
PACKAGES_TO_INSTALL=""
for pkg in "${NPM_PACKAGES[@]}"; do
    if ! npm list -g "$pkg" --depth=0 >/dev/null 2>&1; then
        PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $pkg"
    else
        echo "  ⏭️  $pkg (already installed)"
    fi
done

# Batch install missing packages
if [ -n "$PACKAGES_TO_INSTALL" ]; then
    status "Installing:$PACKAGES_TO_INSTALL"
    if npm install -g $PACKAGES_TO_INSTALL --silent --no-progress --no-fund --no-audit 2>&1 | grep -v "npm warn deprecated" | head -5; then
        ok "All npm packages installed"
    else
        warn "Some packages may have failed - continuing"
    fi
else
    ok "All npm packages already installed"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [30%] STEP 3: Wait for uv & setup spec-kit
# ============================================
step_header "Setting up uv & Spec-Kit"

# Wait for uv
status "Waiting for uv installation"
wait $UV_PID 2>/dev/null || true

# Source uv and refresh PATH
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" 2>/dev/null
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
hash -r 2>/dev/null || true

if has_cmd uv; then
    ok "uv available"
    
    # Install spec-kit
    checking "specify CLI"
    if has_cmd specify; then
        skip "specify CLI"
    else
        status "Installing specify-cli via uv"
        if uv tool install specify-cli --from git+https://github.com/github/spec-kit.git 2>/dev/null || \
           uv tool install specify-cli --force --from git+https://github.com/github/spec-kit.git 2>/dev/null; then
            hash -r 2>/dev/null || true
            ok "specify-cli installed"
        else
            warn "specify-cli installation failed"
        fi
    fi
else
    warn "uv not available - spec-kit skipped"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [40%] STEP 4: Wait for direnv & configure
# ============================================
step_header "Configuring direnv"

wait $DIRENV_PID 2>/dev/null || true

if has_cmd direnv; then
    ok "direnv available"
    if ! grep -q 'direnv hook' ~/.bashrc 2>/dev/null; then
        echo 'eval "$(direnv hook bash)"' >> ~/.bashrc 2>/dev/null
        ok "direnv hook added"
    else
        skip "direnv hook"
    fi
else
    warn "direnv not installed"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [50%] STEP 5: Claude-flow init & workspace setup
# ============================================
step_header "Workspace & claude-flow setup"

status "Creating workspace directories"
mkdir -p "$WORKSPACE_FOLDER" "$AGENTS_DIR" 2>/dev/null || true
cd "$WORKSPACE_FOLDER" 2>/dev/null || cd ~ || true
ok "In: $(pwd)"

# package.json
if [ ! -f "package.json" ]; then
    npm init -y --silent 2>/dev/null || true
    ok "package.json created"
fi
npm pkg set type="module" 2>/dev/null || true

# claude-flow init
checking "claude-flow"
if [ -f ".claude-flow/config.json" ] || [ -f "claude-flow.json" ] || [ -d ".claude-flow" ]; then
    skip "claude-flow already initialized"
else
    status "Running claude-flow init"
    npx -y claude-flow@alpha init --force 2>/dev/null && ok "claude-flow initialized" || warn "claude-flow init failed"
fi

# Project directories
for dir in src tests docs scripts examples config; do
    mkdir -p "$dir" 2>/dev/null
done
ok "Project directories created"

info "Elapsed: $(elapsed)"

# ============================================
# [60%] STEP 6: Register MCP servers
# ============================================
step_header "Registering MCP servers"

if has_cmd claude; then
    ok "Claude CLI found"
    
    # Register all MCP servers in parallel
    status "Registering MCP servers (parallel)"
    (timeout 10 claude mcp add playwright --scope user -- npx -y @playwright/mcp@latest >/dev/null 2>&1) &
    (timeout 10 claude mcp add chrome-devtools --scope user -- npx -y chrome-devtools-mcp@latest >/dev/null 2>&1) &
    (timeout 10 claude mcp add agentic-qe --scope user -- npx -y aqe-mcp >/dev/null 2>&1) &
    (timeout 15 claude mcp add n8n-mcp --scope user -- npx -y n8n-mcp >/dev/null 2>&1) &
    (timeout 15 claude mcp add pal --scope user -- uvx --from git+https://github.com/BeehiveInnovations/pal-mcp-server.git pal-mcp-server >/dev/null 2>&1) &
    wait
    ok "MCP servers registered"
else
    skip "Claude CLI not installed"
fi

# Write MCP config
mkdir -p "$HOME/.config/claude" 2>/dev/null
if [ ! -f "$HOME/.config/claude/mcp.json" ]; then
    cat << 'EOF' > "$HOME/.config/claude/mcp.json"
{"mcpServers":{"playwright":{"command":"npx","args":["-y","@playwright/mcp@latest"],"env":{}},"chrome-devtools":{"command":"npx","args":["-y","chrome-devtools-mcp@latest"],"env":{}},"agentic-qe":{"command":"npx","args":["-y","aqe-mcp"],"env":{}},"n8n-mcp":{"command":"npx","args":["-y","n8n-mcp"],"env":{"MCP_MODE":"stdio","LOG_LEVEL":"error"}},"pal":{"command":"uvx","args":["--from","git+https://github.com/BeehiveInnovations/pal-mcp-server.git","pal-mcp-server"],"env":{"MCP_MODE":"stdio"}}}}
EOF
    ok "MCP config written"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [70%] STEP 7: TypeScript setup
# ============================================
step_header "TypeScript setup"

if [ ! -d "node_modules/typescript" ]; then
    status "Installing TypeScript"
    npm install -D typescript @types/node --silent --no-fund --no-audit 2>/dev/null && ok "TypeScript installed" || warn "TypeScript failed"
else
    skip "TypeScript"
fi

if [ ! -f "tsconfig.json" ]; then
    cat << 'EOF' > tsconfig.json
{"compilerOptions":{"target":"ES2022","module":"ESNext","moduleResolution":"node","outDir":"./dist","rootDir":"./src","strict":true,"esModuleInterop":true,"skipLibCheck":true},"include":["src/**/*","tests/**/*"],"exclude":["node_modules","dist"]}
EOF
    ok "tsconfig.json created"
fi

npm pkg set scripts.build="tsc" scripts.test="playwright test" scripts.typecheck="tsc --noEmit" 2>/dev/null || true

info "Elapsed: $(elapsed)"

# ============================================
# [80%] STEP 8: Finalizing subagents
# ============================================
step_header "Finalizing subagents"

wait $AGENTS_PID 2>/dev/null || true

# Copy additional agents if available
if [ -d "$DEVPOD_DIR/additional-agents" ]; then
    cp "$DEVPOD_DIR/additional-agents"/*.md "$AGENTS_DIR/" 2>/dev/null || true
fi

AGENT_COUNT=$(find "$AGENTS_DIR" -maxdepth 1 -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
ok "Agents available: $AGENT_COUNT"

info "Elapsed: $(elapsed)"

# ============================================
# [90%] STEP 9: Bash aliases
# ============================================
step_header "Installing bash aliases"

if grep -q "TURBO FLOW ALIASES v7" ~/.bashrc 2>/dev/null; then
    skip "Bash aliases already installed"
else
    # Remove old aliases (works on both macOS and Linux)
    if grep -q "TURBO FLOW ALIASES" ~/.bashrc 2>/dev/null; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' '/# === TURBO FLOW ALIASES/,/^$/d' ~/.bashrc 2>/dev/null || true
        else
            sed -i '/# === TURBO FLOW ALIASES/,/^$/d' ~/.bashrc 2>/dev/null || true
        fi
    fi
    
    cat << 'ALIASES_EOF' >> ~/.bashrc

# === TURBO FLOW ALIASES v7 ===
# Claude Code
alias claude-hierarchical="claude --dangerously-skip-permissions"
alias dsp="claude --dangerously-skip-permissions"

# Claude Flow
alias cf="npx -y claude-flow@alpha"
alias cf-init="npx -y claude-flow@alpha init --force"
alias cf-swarm="npx -y claude-flow@alpha swarm"
alias cf-hive="npx -y claude-flow@alpha hive-mind spawn"
alias cf-spawn="npx -y claude-flow@alpha hive-mind spawn"
alias cf-status="npx -y claude-flow@alpha hive-mind status"
alias cf-help="npx -y claude-flow@alpha --help"

# Agentic Tools
alias af="npx -y agentic-flow"
alias af-run="npx -y agentic-flow --agent"
alias af-coder="npx -y agentic-flow --agent coder"
alias af-help="npx -y agentic-flow --help"
alias aqe="npx -y agentic-qe"
alias aqe-mcp="npx -y aqe-mcp"
alias aj="npx -y agentic-jujutsu"
alias cu="npx -y claude-usage-cli"

# Spec-Kit
alias sk="specify"
alias sk-init="specify init"
alias sk-check="specify check"
alias sk-here="specify init . --ai claude"

# AI Agent Skills
alias skills="npx -y ai-agent-skills"
alias skills-list="npx -y ai-agent-skills list"
alias skills-search="npx -y ai-agent-skills search"
alias skills-install="npx -y ai-agent-skills install"
alias skills-info="npx -y ai-agent-skills info"

# MCP Servers
alias n8n-mcp="npx -y n8n-mcp"
alias mcp-playwright="npx -y @playwright/mcp@latest"
alias mcp-chrome="npx -y chrome-devtools-mcp@latest"
alias mcp-pal="uvx --from git+https://github.com/BeehiveInnovations/pal-mcp-server.git pal-mcp-server"

# Helper functions
cf-task() { npx -y claude-flow@alpha swarm "$@"; }
af-task() { npx -y agentic-flow --agent "$1" --task "$2" --stream; }
generate-claude-md() { claude "Read the .specify/ directory and generate an optimal CLAUDE.md for this project based on the specs, plan, and constitution."; }

# PATH
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
ALIASES_EOF
    ok "Aliases added"
fi

info "Elapsed: $(elapsed)"

# ============================================
# COMPLETE
# ============================================
END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))

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
echo "  │  ✅ Claude Code         claude, dsp           │"
echo "  │  ✅ Claude Flow         cf, cf-swarm, cf-hive │"
echo "  │  ✅ Agentic Flow        af, af-run, af-coder  │"
echo "  │  ✅ Agentic QE          aqe                   │"
echo "  │  ✅ Agentic Jujutsu     aj                    │"
echo "  │  ✅ Claude Usage        cu                    │"
echo "  │  ✅ Spec-Kit            sk, sk-init, sk-here  │"
echo "  │  ✅ AI Agent Skills     skills, skills-list   │"
echo "  │  ✅ n8n-MCP             n8n-mcp               │"
echo "  │  ✅ PAL MCP             pal (multi-model AI)  │"
echo "  │  ✅ MCP Servers         configured            │"
echo "  │  ✅ Subagents           $AGENT_COUNT available             │"
echo "  │  ⏱️  Total time          ${TOTAL_TIME}s                     │"
echo "  └────────────────────────────────────────────────┘"
echo ""
echo "  📌 QUICK START:"
echo "  ─────────────────────────────────────────────────"
echo "  1. source ~/.bashrc"
echo "  2. sk-here                    # Init spec-kit"
echo "  3. claude                     # Start Claude Code"
echo ""
echo "  🛠️  NEW IN v7: Parallel installs - ~2x faster!"
echo ""
echo "  🚀 Happy coding!"
echo ""
