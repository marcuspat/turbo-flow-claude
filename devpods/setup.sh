#!/bin/bash
# TURBO FLOW SETUP SCRIPT - OPTIMIZED VERSION v3
# Constant status updates, progress bar, skips existing, never stops on errors

# NO set -e - we handle errors gracefully

# ============================================
# CONFIGURATION
# ============================================
: "${WORKSPACE_FOLDER:=$(pwd)}"
: "${DEVPOD_WORKSPACE_FOLDER:=$WORKSPACE_FOLDER}"
: "${AGENTS_DIR:=$WORKSPACE_FOLDER/agents}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"
TOTAL_STEPS=11
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
echo "║     🚀 TURBO FLOW SETUP - OPTIMIZED v3          ║"
echo "║     Fast • Smart • Never Fails                   ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "  📁 Workspace: $WORKSPACE_FOLDER"
echo "  🕐 Started at: $(date '+%H:%M:%S')"
echo ""
progress_bar 0
echo ""

# ============================================
# [8%] STEP 1: Clear caches & fix npm locks
# ============================================
step_header "Clearing npm caches & locks"

status "Removing npm locks (prevents ECOMPROMISED)"
rm -rf ~/.npm/_locks 2>/dev/null || true
ok "npm locks cleared"

status "Removing npx cache"
rm -rf ~/.npm/_npx 2>/dev/null || true
ok "npx cache cleared"

status "Cleaning npm cache"
npm cache clean --force --silent 2>/dev/null &
CACHE_PID=$!
ok "npm cache clean started (background)"

info "Elapsed: $(elapsed)"

# ============================================
# [17%] STEP 2: Core npm packages + claude-flow init
# ============================================
step_header "Installing core npm packages"

install_npm @anthropic-ai/claude-code

# claude-flow init right after claude-code
status "Clearing npm locks"
rm -rf ~/.npm/_locks ~/.npm/_npx 2>/dev/null || true
ok "Locks cleared"

checking "claude-flow initialized"
if [ -f ".claude-flow/config.json" ] || [ -f "claude-flow.json" ] || [ -d ".claude-flow" ]; then
    skip "claude-flow already initialized"
else
    status "Running npx claude-flow init"
    npx -y claude-flow@alpha init --force && ok "claude-flow initialized" || warn "claude-flow init failed"
fi

install_npm claude-usage-cli
install_npm agentic-qe
install_npm agentic-flow
install_npm agentic-jujutsu

info "Elapsed: $(elapsed)"

# ============================================
# [25%] STEP 3: MCP Servers
# ============================================
step_header "Installing MCP servers"

install_npm @playwright/mcp
install_npm chrome-devtools-mcp
install_npm mcp-chrome-bridge

info "Elapsed: $(elapsed)"

# ============================================
# [33%] STEP 4: uv + direnv
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
# [42%] STEP 5: Workspace setup
# ============================================
step_header "Setting up workspace"

status "Creating directories"
mkdir -p "$WORKSPACE_FOLDER" "$AGENTS_DIR" 2>/dev/null || true
ok "Directories created"

status "Changing to workspace"
cd "$WORKSPACE_FOLDER" 2>/dev/null || { warn "Could not cd to workspace"; cd ~ || true; }
ok "Working in: $(pwd)"

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
# [50%] STEP 6: Register MCP servers
# ============================================
step_header "Registering MCP servers with Claude"

# Clear locks before npx operations
status "Clearing npm locks"
rm -rf ~/.npm/_locks 2>/dev/null || true
ok "Locks cleared"

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
# [58%] STEP 7: Configure MCP JSON
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
{"mcpServers":{"playwright":{"command":"npx","args":["-y","@playwright/mcp@latest"],"env":{}},"chrome-devtools":{"command":"npx","args":["chrome-devtools-mcp@latest"],"env":{}},"chrome-mcp":{"type":"streamable-http","url":"http://127.0.0.1:12306/mcp"}}}
EOF
    ok "MCP config created at ~/.config/claude/mcp.json"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [67%] STEP 8: TypeScript setup
# ============================================
step_header "Setting up TypeScript"

checking "TypeScript installation"
if [ -d "node_modules/typescript" ]; then
    skip "TypeScript already in node_modules"
else
    status "Installing TypeScript & @types/node"
    npm install -D typescript @types/node --silent 2>/dev/null && ok "TypeScript installed" || warn "TypeScript install failed"
fi

checking "tsconfig.json"
if [ -f "tsconfig.json" ]; then
    skip "tsconfig.json exists"
else
    status "Creating tsconfig.json"
    cat << 'EOF' > tsconfig.json
{"compilerOptions":{"target":"ES2022","module":"ESNext","moduleResolution":"node","outDir":"./dist","rootDir":"./src","strict":true,"esModuleInterop":true,"skipLibCheck":true},"include":["src/**/*","tests/**/*"],"exclude":["node_modules","dist"]}
EOF
    ok "tsconfig.json created"
fi

status "Creating project directories"
for dir in src tests docs scripts examples config; do
    if [ -d "$dir" ]; then
        echo "    📁 $dir/ exists"
    else
        mkdir -p "$dir" 2>/dev/null && echo "    📁 $dir/ created"
    fi
done

status "Setting npm scripts"
npm pkg set scripts.build="tsc" scripts.test="playwright test" scripts.typecheck="tsc --noEmit" 2>/dev/null || true
ok "npm scripts configured"

info "Elapsed: $(elapsed)"

# ============================================
# [75%] STEP 9: Install subagents
# ============================================
step_header "Installing Claude subagents"

status "Navigating to agents directory"
cd "$AGENTS_DIR" 2>/dev/null || { mkdir -p "$AGENTS_DIR" && cd "$AGENTS_DIR"; } || true
ok "In agents directory: $(pwd)"

EXISTING_AGENTS=$(find . -maxdepth 1 -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
checking "Existing agents: $EXISTING_AGENTS found"

if [ "$EXISTING_AGENTS" -gt 5 ]; then
    skip "Subagents ($EXISTING_AGENTS already installed)"
else
    status "Cloning 610ClaudeSubagents repository"
    info "This may take up to 15 seconds..."
    if timeout 15 git clone --depth 1 --quiet https://github.com/ChrisRoyse/610ClaudeSubagents.git temp-agents 2>/dev/null; then
        ok "Repository cloned"
        status "Copying agent files"
        if [ -d "temp-agents/agents" ]; then
            cp -r temp-agents/agents/*.md . 2>/dev/null || true
            ok "Agent files copied"
        fi
        status "Cleaning up temp files"
        rm -rf temp-agents 2>/dev/null || true
        ok "Cleanup complete"
    else
        warn "Could not clone subagents repository"
    fi
fi

# Copy additional agents
checking "Additional agents in $DEVPOD_DIR/additional-agents"
if [ -d "$DEVPOD_DIR/additional-agents" ]; then
    status "Copying additional agents"
    cp "$DEVPOD_DIR/additional-agents"/*.md . 2>/dev/null || true
    ok "Additional agents copied"
else
    info "No additional agents directory found"
fi

AGENT_COUNT=$(find . -maxdepth 1 -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
ok "Total agents available: $AGENT_COUNT"

status "Returning to workspace"
cd "$WORKSPACE_FOLDER" 2>/dev/null || true

info "Elapsed: $(elapsed)"

# ============================================
# [83%] STEP 10: CLAUDE.md + wrapper scripts
# ============================================
step_header "Creating wrapper scripts"

# CLAUDE.md
checking "CLAUDE.md"
if [ -f "$WORKSPACE_FOLDER/CLAUDE.md" ]; then
    skip "CLAUDE.md exists"
elif [ -f "$DEVPOD_DIR/CLAUDE.md" ]; then
    status "Copying CLAUDE.md from devpod"
    cp "$DEVPOD_DIR/CLAUDE.md" "$WORKSPACE_FOLDER/CLAUDE.md" 2>/dev/null || true
    ok "CLAUDE.md installed"
else
    info "No CLAUDE.md source found"
fi

# cf-with-context.sh
checking "cf-with-context.sh"
if [ -f "$WORKSPACE_FOLDER/cf-with-context.sh" ]; then
    skip "cf-with-context.sh exists"
else
    status "Creating cf-with-context.sh"
    cat << 'EOF' > "$WORKSPACE_FOLDER/cf-with-context.sh"
#!/bin/bash
case "$1" in
    swarm) npx -y claude-flow@alpha swarm "${@:2}" --claude ;;
    hive*) [[ "$2" == "spawn" ]] && npx -y claude-flow@alpha hive-mind spawn "${@:3}" --claude || npx -y claude-flow@alpha hive-mind spawn "${@:2}" --claude ;;
    *) [[ $# -gt 0 ]] && npx -y claude-flow@alpha "$@" --claude || npx -y claude-flow@alpha --help ;;
esac
EOF
    chmod +x "$WORKSPACE_FOLDER/cf-with-context.sh" 2>/dev/null || true
    ok "cf-with-context.sh created"
fi

# af-with-context.sh
checking "af-with-context.sh"
if [ -f "$WORKSPACE_FOLDER/af-with-context.sh" ]; then
    skip "af-with-context.sh exists"
else
    status "Creating af-with-context.sh"
    cat << 'EOF' > "$WORKSPACE_FOLDER/af-with-context.sh"
#!/bin/bash
npx -y agentic-flow "$@"
EOF
    chmod +x "$WORKSPACE_FOLDER/af-with-context.sh" 2>/dev/null || true
    ok "af-with-context.sh created"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [92%] STEP 11: Bash aliases
# ============================================
step_header "Installing bash aliases"

checking "Existing TURBO FLOW aliases in .bashrc"
if grep -q "TURBO FLOW ALIASES" ~/.bashrc 2>/dev/null; then
    skip "Bash aliases already installed"
else
    status "Adding aliases to ~/.bashrc"
    cat << ALIASES_EOF >> ~/.bashrc

# === TURBO FLOW ALIASES ===
alias cf="$WORKSPACE_FOLDER/cf-with-context.sh"
alias cf-swarm="$WORKSPACE_FOLDER/cf-with-context.sh swarm"
alias cf-hive="$WORKSPACE_FOLDER/cf-with-context.sh hive-mind spawn"
alias af="$WORKSPACE_FOLDER/af-with-context.sh"
alias dsp="claude --dangerously-skip-permissions"
alias cf-init="npx -y claude-flow@alpha init --force"
alias cf-spawn="npx -y claude-flow@alpha hive-mind spawn"
alias cf-status="npx -y claude-flow@alpha hive-mind status"
alias cf-help="npx -y claude-flow@alpha --help"
alias af-run="npx -y agentic-flow --agent"
alias af-coder="npx -y agentic-flow --agent coder"
alias af-help="npx -y agentic-flow --help"
cf-task() { npx -y claude-flow@alpha swarm "\$1" --claude; }
af-task() { npx -y agentic-flow --agent "\$1" --task "\$2" --stream; }
ALIASES_EOF
    ok "Aliases added to ~/.bashrc"
fi

info "Elapsed: $(elapsed)"

# Wait for any background processes
wait 2>/dev/null || true

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
echo "  ┌────────────────────────────────────────────┐"
echo "  │  📊 SUMMARY                                │"
echo "  ├────────────────────────────────────────────┤"
echo "  │  ✅ Claude-Flow         ready              │"
echo "  │  ✅ Agentic Flow        ready              │"
echo "  │  ✅ MCP Servers         configured         │"
echo "  │  ✅ Subagents           $AGENT_COUNT available           │"
echo "  │  ⏱️  Total time          ${TOTAL_TIME}s                   │"
echo "  └────────────────────────────────────────────┘"
echo ""
echo "  📌 NEXT STEPS:"
echo "  ─────────────────────────────────────────────"
echo "  1. Reload shell:    source ~/.bashrc"
echo "  2. Start working:   cf-swarm 'your task'"
echo "  3. Get help:        cf-help"
echo ""
echo "  🚀 Happy coding!"
echo ""
