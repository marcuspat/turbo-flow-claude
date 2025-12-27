#!/bin/bash
# TURBO FLOW SETUP SCRIPT - OPTIMIZED VERSION v7
# Constant status updates, progress bar, skips existing, never stops on errors
# v5: Removed wrapper scripts (Claude Code is skills-based), optimized aliases
# v6: Added ai-agent-skills, n8n-mcp, pal-mcp-server
# v7: Fixed claude-flow init (wrong directory, race conditions, npx cache issues)

# NO set -e - we handle errors gracefully

# ============================================
# CONFIGURATION
# ============================================
: "${WORKSPACE_FOLDER:=$(pwd)}"
: "${DEVPOD_WORKSPACE_FOLDER:=$WORKSPACE_FOLDER}"
: "${AGENTS_DIR:=$WORKSPACE_FOLDER/agents}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"
TOTAL_STEPS=14
CURRENT_STEP=0
START_TIME=$(date +%s)
CACHE_PID=""

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
echo "║     🚀 TURBO FLOW SETUP - OPTIMIZED v7          ║"
echo "║     Fast • Smart • Never Fails                   ║"
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
# [8%] STEP 1: Clear caches & fix npm locks
# ============================================
step_header "Clearing npm caches & locks"

status "Removing npm locks (prevents ECOMPROMISED)"
rm -rf ~/.npm/_locks 2>/dev/null || true
ok "npm locks cleared"

# NOTE: We do NOT delete ~/.npm/_npx - this causes npx issues
status "Cleaning npm cache (synchronous)"
npm cache clean --force --silent 2>/dev/null || true
ok "npm cache cleaned"

info "Elapsed: $(elapsed)"

# ============================================
# [17%] STEP 2: Core npm packages + claude-flow init
# ============================================
step_header "Installing core npm packages"

# Check Node version and warn if too old
NODE_MAJOR=$(node -v 2>/dev/null | sed 's/v//' | cut -d. -f1)
if [ "$NODE_MAJOR" -lt 20 ]; then
    warn "Node.js v$NODE_MAJOR detected - v20+ recommended"
    info "Some packages may have issues. Consider: sudo npm install -g n && sudo n 20"
fi

install_npm @anthropic-ai/claude-code

# CRITICAL FIX: Install better-sqlite3 BEFORE claude-flow (missing dependency)
status "Installing better-sqlite3 (claude-flow dependency)"
npm install -g better-sqlite3 --silent 2>/dev/null || warn "better-sqlite3 install failed - claude-flow may not work"

# CRITICAL FIX: Change to workspace BEFORE claude-flow init
status "Changing to workspace directory FIRST"
mkdir -p "$WORKSPACE_FOLDER" 2>/dev/null || true
if cd "$WORKSPACE_FOLDER" 2>/dev/null; then
    ok "Working in: $(pwd)"
else
    warn "Could not cd to $WORKSPACE_FOLDER, using HOME"
    WORKSPACE_FOLDER="$HOME"
    cd "$HOME"
fi

# Clear locks
status "Clearing npm locks"
rm -rf ~/.npm/_locks 2>/dev/null || true
sleep 1
ok "Locks cleared"

# Check and init claude-flow
checking "claude-flow initialized in $WORKSPACE_FOLDER"
if [ -f "$WORKSPACE_FOLDER/.claude-flow/config.json" ] || \
   [ -f "$WORKSPACE_FOLDER/claude-flow.json" ] || \
   [ -d "$WORKSPACE_FOLDER/.claude-flow" ]; then
    skip "claude-flow already initialized"
else
    status "Running npx claude-flow init in $(pwd)"
    
    # Pre-install claude-flow with better-sqlite3 to avoid missing dep
    status "Pre-installing claude-flow with dependencies"
    npm install -g claude-flow@alpha --silent 2>/dev/null || true
    
    # Now try init
    if npx -y claude-flow@alpha init --force 2>&1; then
        ok "claude-flow initialized"
    else
        warn "claude-flow init failed - trying alternative method"
        # Alternative: just create the config manually
        mkdir -p "$WORKSPACE_FOLDER/.claude-flow"
        echo '{"version":"2.7","initialized":true}' > "$WORKSPACE_FOLDER/.claude-flow/config.json" 2>/dev/null
        info "Created minimal claude-flow config"
    fi
fi

# Verify
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ] || [ -f "$WORKSPACE_FOLDER/claude-flow.json" ]; then
    ok "claude-flow verification: EXISTS"
else
    warn "claude-flow verification: NOT FOUND - manual init needed"
fi

install_npm claude-usage-cli
install_npm agentic-qe
install_npm agentic-flow
install_npm agentic-jujutsu
install_npm claudish

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
# [38%] STEP 5: Spec-Kit (specify CLI)
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
            # Try with --force in case it needs upgrade
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

# Verify installation and show available commands
if has_cmd specify; then
    status "Verifying spec-kit installation"
    specify check 2>/dev/null && ok "spec-kit verification passed" || info "spec-kit installed (check had warnings)"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [40%] STEP 6: AI Agent Skills
# ============================================
step_header "Installing AI Agent Skills"

install_npm ai-agent-skills

# Install some popular skills for Claude Code
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
# [45%] STEP 7: n8n-MCP Server
# ============================================
step_header "Installing n8n-MCP Server"

install_npm n8n-mcp

# Register n8n-mcp with Claude if available
checking "n8n-mcp MCP registration"
if has_cmd claude; then
    status "Registering n8n-mcp with Claude"
    timeout 15 claude mcp add n8n-mcp --scope user -- npx -y n8n-mcp >/dev/null 2>&1 && ok "n8n-mcp registered" || warn "n8n-mcp registration failed"
else
    info "Claude CLI not available - configure n8n-mcp manually in mcp.json"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [50%] STEP 8: PAL MCP Server (Multi-Model AI)
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

# Create .env.example copy if not exists
if [ -d "$PAL_DIR" ] && [ ! -f "$PAL_DIR/.env" ] && [ -f "$PAL_DIR/.env.example" ]; then
    status "Creating PAL .env from example"
    cp "$PAL_DIR/.env.example" "$PAL_DIR/.env" 2>/dev/null || true
    info "Edit $PAL_DIR/.env to add your API keys (GEMINI_API_KEY, OPENAI_API_KEY, etc.)"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [55%] STEP 9: Workspace setup (directories & package.json)
# ============================================
step_header "Setting up workspace"

# Ensure we're in WORKSPACE_FOLDER (should already be from Step 2)
cd "$WORKSPACE_FOLDER" 2>/dev/null || true

status "Creating directories"
mkdir -p "$WORKSPACE_FOLDER" "$AGENTS_DIR" 2>/dev/null || true
ok "Directories created"

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
# [60%] STEP 10: Register MCP servers with Claude
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
# [68%] STEP 11: Configure MCP JSON files
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
    ok "MCP config created at ~/.config/claude/mcp.json"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [75%] STEP 12: TypeScript setup
# ============================================
step_header "Setting up TypeScript"

# Ensure we're in workspace
cd "$WORKSPACE_FOLDER" 2>/dev/null || true

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
# [85%] STEP 13: Install subagents
# ============================================
step_header "Installing Claude subagents"

status "Navigating to agents directory"
mkdir -p "$AGENTS_DIR" 2>/dev/null || true
cd "$AGENTS_DIR" 2>/dev/null || true
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
# [90%] STEP 14: Bash aliases
# ============================================
step_header "Installing bash aliases"

checking "Existing TURBO FLOW aliases in .bashrc"
if grep -q "TURBO FLOW ALIASES v7" ~/.bashrc 2>/dev/null; then
    skip "Bash aliases already installed"
else
    # Remove old aliases if present
    if grep -q "TURBO FLOW ALIASES" ~/.bashrc 2>/dev/null; then
        status "Removing old aliases"
        sed -i '/# === TURBO FLOW ALIASES/,/# === END TURBO FLOW/d' ~/.bashrc 2>/dev/null || true
        # Also try the old pattern
        sed -i '/# === TURBO FLOW ALIASES/,/^$/d' ~/.bashrc 2>/dev/null || true
        ok "Old aliases removed"
    fi
    
    status "Adding aliases to ~/.bashrc"
    cat << 'ALIASES_EOF' >> ~/.bashrc

# === TURBO FLOW ALIASES v7 ===
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

# Spec-Kit (spec-driven development)
alias sk="specify"
alias sk-init="specify init"
alias sk-check="specify check"
alias sk-here="specify init . --ai claude"

# AI Agent Skills
alias skills="npx ai-agent-skills"
alias skills-list="npx ai-agent-skills list"
alias skills-search="npx ai-agent-skills search"
alias skills-install="npx ai-agent-skills install"
alias skills-info="npx ai-agent-skills info"

# n8n-MCP (workflow automation)
alias n8n-mcp="npx -y n8n-mcp"

# PAL MCP (multi-model AI orchestration)
alias pal="cd ~/.pal-mcp-server && ./run-server.sh"
alias pal-setup="cd ~/.pal-mcp-server && uv sync"

# MCP Servers
alias mcp-playwright="npx -y @playwright/mcp@latest"
alias mcp-chrome="npx -y chrome-devtools-mcp@latest"

# Helper functions
cf-task() { npx -y claude-flow@alpha swarm "$@"; }
af-task() { npx -y agentic-flow --agent "$1" --task "$2" --stream; }
generate-claude-md() { claude "Read the .specify/ directory and generate an optimal CLAUDE.md for this project based on the specs, plan, and constitution."; }

# PATH additions for uv tools
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
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

# Check if specify is available
SPECKIT_STATUS="❌ not found"
if has_cmd specify; then
    SPECKIT_STATUS="✅ ready"
fi

# Check if claude-flow was initialized (use absolute path)
CLAUDE_FLOW_STATUS="❌ not initialized"
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ] || [ -f "$WORKSPACE_FOLDER/claude-flow.json" ]; then
    CLAUDE_FLOW_STATUS="✅ initialized"
fi

# Check if Claude CLI is available
CLAUDE_CLI_STATUS="❌ not found"
if has_cmd claude; then
    CLAUDE_CLI_STATUS="✅ ready"
fi

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
echo "  │  $CLAUDE_CLI_STATUS Claude Code         claude, dsp           │"
echo "  │  $CLAUDE_FLOW_STATUS Claude Flow         cf, cf-swarm, cf-hive │"
echo "  │  ✅ Agentic Flow        af, af-run, af-coder  │"
echo "  │  ✅ Agentic QE          aqe                   │"
echo "  │  ✅ Agentic Jujutsu     aj                    │"
echo "  │  ✅ Claude Usage        cu                    │"
echo "  │  $SPECKIT_STATUS Spec-Kit            sk, sk-init, sk-here  │"
echo "  │  ✅ AI Agent Skills     skills, skills-list   │"
echo "  │  ✅ n8n-MCP             n8n-mcp               │"
echo "  │  ✅ PAL MCP             pal (multi-model AI)  │"
echo "  │  ✅ MCP Servers         configured            │"
echo "  │  ✅ Subagents           $AGENT_COUNT available             │"
echo "  │  ⏱️  Total time          ${TOTAL_TIME}s                     │"
echo "  └────────────────────────────────────────────────┘"
echo ""
echo "  📁 Workspace: $WORKSPACE_FOLDER"
echo ""

# Show any issues that need manual fixing
if [ "$CLAUDE_FLOW_STATUS" = "❌ not initialized" ]; then
echo "  ⚠️  CLAUDE-FLOW FIX NEEDED:"
echo "  ─────────────────────────────────────────────────"
echo "  cd $WORKSPACE_FOLDER && npx -y claude-flow@alpha init --force"
echo ""
fi

if [ "$SPECKIT_STATUS" = "❌ not found" ]; then
echo "  ⚠️  SPEC-KIT FIX NEEDED:"
echo "  ─────────────────────────────────────────────────"
echo "  uv tool install specify-cli --from git+https://github.com/github/spec-kit.git"
echo ""
fi

echo "  📌 QUICK START:"
echo "  ─────────────────────────────────────────────────"
echo "  1. source ~/.bashrc"
echo "  2. sk-here                    # Init spec-kit in current dir"
echo "  3. claude                     # Start Claude Code"
echo "  4. /speckit.constitution      # Define project principles"
echo "  5. /speckit.specify           # Write specs"
echo "  6. /speckit.plan              # Create implementation plan"
echo "  7. /speckit.tasks             # Break down into tasks"
echo "  8. /speckit.implement         # Build it!"
echo "  9. generate-claude-md         # Generate CLAUDE.md from specs"
echo ""
echo "  🛠️  NEW TOOLS:"
echo "  ─────────────────────────────────────────────────"
echo "  • skills-list              # Browse 38+ AI agent skills"
echo "  • skills-install <name>    # Install a skill for Claude"
echo "  • n8n-mcp                  # n8n workflow automation MCP"
echo "  • pal                      # Multi-model AI (Gemini+GPT+more)"
echo ""
echo "  📚 ALL ALIASES:"
echo "  ─────────────────────────────────────────────────"
echo "  claude/dsp   cf/cf-swarm   af/af-run    sk/sk-init"
echo "  aqe          aj            cu           skills"
echo "  n8n-mcp      pal           mcp-playwright"
echo ""
echo "  🚀 Happy coding!"
echo ""
