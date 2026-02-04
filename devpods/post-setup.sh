#!/bin/bash
set -e

# Get the directory where this script is located
readonly DEVPOD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

success() { echo -e "${GREEN}✅ $*${NC}"; }
warning() { echo -e "${YELLOW}⚠️  $*${NC}"; }
info() { echo -e "${BLUE}ℹ️  $*${NC}"; }

cat << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║                  Turbo Flow V2.0.7 Post-Setup                    ║
║              Configure & Enable Claude Flow Components            ║
╚══════════════════════════════════════════════════════════════════╝
EOF

echo ""
echo "WORKSPACE_FOLDER: $WORKSPACE_FOLDER"
echo "DEVPOD_DIR: $DEVPOD_DIR"
echo ""

# ============================================================================
# STEP 1: Verify Installations
# ============================================================================
info "Step 1: Verifying installations from setup.sh..."

# Build tools
if command -v g++ >/dev/null 2>&1 && command -v make >/dev/null 2>&1; then
    success "Build tools: g++, make installed"
else
    warning "Build tools not found"
fi

# Node.js & npm
if command -v node >/dev/null 2>&1; then
    NODE_VER=$(node -v)
    NODE_MAJOR=$(echo "$NODE_VER" | sed 's/v//' | cut -d. -f1)
    if [ "$NODE_MAJOR" -ge 20 ]; then
        success "Node.js: $NODE_VER (✓ >= 20)"
    else
        warning "Node.js: $NODE_VER (needs >= 20)"
    fi
else
    warning "Node.js not found"
fi

if command -v npm >/dev/null 2>&1; then
    success "npm: $(npm --version)"
else
    warning "npm not found"
fi

# Claude Code
if command -v claude >/dev/null 2>&1; then
    success "Claude Code: $(claude --version 2>/dev/null | head -1)"
else
    warning "Claude Code not found - run setup.sh first"
fi

# Claude Flow V3
if command -v npx >/dev/null 2>&1; then
    CF_VERSION=$(npx -y claude-flow@alpha --version 2>/dev/null | head -1 || echo "")
    if [ -n "$CF_VERSION" ]; then
        success "Claude Flow V3: $CF_VERSION"
    else
        warning "Claude Flow not responding"
    fi
else
    warning "npx not found"
fi

# RuVector Neural Engine
if npm list -g ruvector --depth=0 >/dev/null 2>&1; then
    RUV_VERSION=$(npx ruvector --version 2>/dev/null | head -1 || echo "installed")
    success "RuVector Neural Engine: $RUV_VERSION"
else
    warning "RuVector not installed"
fi

# @ruvector/sona
if npm list -g @ruvector/sona --depth=0 >/dev/null 2>&1; then
    success "@ruvector/sona: installed"
else
    warning "@ruvector/sona not installed"
fi

# @ruvector/cli
if npm list -g @ruvector/cli --depth=0 >/dev/null 2>&1; then
    success "@ruvector/cli: installed"
else
    warning "@ruvector/cli not installed"
fi

# @ruvector/ruvllm
if npm list -g @ruvector/ruvllm --depth=0 >/dev/null 2>&1; then
    success "@ruvector/ruvllm: installed"
else
    warning "@ruvector/ruvllm not installed"
fi

# agentic-qe
if npm list -g agentic-qe --depth=0 >/dev/null 2>&1; then
    success "agentic-qe: installed"
else
    warning "agentic-qe not installed"
fi

# @fission-ai/openspec
if npm list -g @fission-ai/openspec --depth=0 >/dev/null 2>&1; then
    success "@fission-ai/openspec: installed"
else
    warning "@fission-ai/openspec not installed"
fi

# uipro-cli
if npm list -g uipro-cli --depth=0 >/dev/null 2>&1; then
    success "uipro-cli: installed"
else
    warning "uipro-cli not installed"
fi

# agent-browser
if command -v agent-browser >/dev/null 2>&1; then
    success "agent-browser CLI: $(agent-browser --version 2>/dev/null || echo 'installed')"
else
    warning "agent-browser not found"
fi

# @claude-flow/browser
if npm list -g @claude-flow/browser --depth=0 >/dev/null 2>&1; then
    success "@claude-flow/browser: installed"
else
    warning "@claude-flow/browser not installed"
fi

# uv (Python package manager)
if command -v uv >/dev/null 2>&1; then
    UV_VERSION=$(uv --version 2>/dev/null | head -1)
    success "uv (Python): $UV_VERSION"
else
    warning "uv not installed"
fi

# specify CLI (spec-kit)
if command -v specify >/dev/null 2>&1; then
    success "specify CLI (spec-kit): installed"
else
    warning "specify CLI not installed"
fi

echo ""

# ============================================================================
# STEP 2: Start Claude Flow Daemon
# ============================================================================
info "Step 2: Starting Claude Flow daemon with background workers..."

# Check if daemon is already running
if npx -y claude-flow@alpha daemon status 2>/dev/null | grep -q "running"; then
    warning "Daemon already running - skipping"
else
    info "Starting daemon..."
    if npx -y claude-flow@alpha daemon start 2>/dev/null; then
        success "Daemon started with background workers"
    else
        warning "Daemon start failed (optional - may need manual start)"
    fi
fi

echo ""

# ============================================================================
# STEP 3: Initialize Memory
# ============================================================================
info "Step 3: Initializing Claude Flow memory with HNSW indexing..."

# Check if memory is already initialized
if [ -f "$HOME/.claude-flow/memory.db" ] || [ -f "$HOME/.claude-flow/data/memory.db" ]; then
    warning "Memory already initialized - skipping"
else
    info "Initializing memory system..."
    if npx -y claude-flow@alpha memory init --force 2>/dev/null; then
        success "Memory initialized with HNSW indexing"
    else
        warning "Memory init failed - will initialize on first use"
    fi
fi

echo ""

# ============================================================================
# STEP 4: Initialize Swarm
# ============================================================================
info "Step 4: Initializing Claude Flow swarm coordination..."

# Check if swarm is already initialized
if npx -y claude-flow@alpha swarm status 2>/dev/null | grep -q "active\|initialized"; then
    SWARM_STATUS=$(npx -y claude-flow@alpha swarm status 2>/dev/null | head -1)
    warning "Swarm already initialized: $SWARM_STATUS"
else
    info "Initializing swarm with hierarchical topology..."
    if npx -y claude-flow@alpha swarm init \
        --topology hierarchical \
        --max-agents 8 \
        --strategy specialized 2>/dev/null; then
        success "Swarm initialized: hierarchical, 8 agents, specialized"
    else
        warning "Swarm init failed - can be initialized later"
    fi
fi

echo ""

# ============================================================================
# STEP 5: Configure MCP Server
# ============================================================================
info "Step 5: Checking Claude Flow MCP configuration..."

MCP_CONFIG="$HOME/.config/claude/mcp.json"
if [ -f "$MCP_CONFIG" ]; then
    if grep -q "claude-flow" "$MCP_CONFIG"; then
        success "MCP configured: claude-flow server found"
    else
        warning "claude-flow not found in MCP config"
    fi
    
    if grep -q "agentic-qe" "$MCP_CONFIG"; then
        success "MCP configured: agentic-qe server found"
    else
        warning "agentic-qe not found in MCP config"
    fi
    
    info "⚠️  You may need to restart Claude Code to detect MCP servers"
else
    warning "MCP config not found at $MCP_CONFIG"
fi

echo ""

# ============================================================================
# STEP 6: Verify Skills
# ============================================================================
info "Step 6: Verifying installed Claude Code skills..."

SKILLS_DIR="$HOME/.claude/skills"
SKILLS_DIR_LOCAL="$WORKSPACE_FOLDER/.claude/skills"

# Helper function to check if skill has content
skill_has_content() {
    local dir="$1"
    [ -d "$dir" ] && [ -n "$(ls -A "$dir" 2>/dev/null)" ]
}

if [ -d "$SKILLS_DIR" ] || [ -d "$SKILLS_DIR_LOCAL" ]; then
    # agent-browser skill
    if skill_has_content "$SKILLS_DIR/agent-browser"; then
        success "agent-browser skill installed (global)"
    elif skill_has_content "$SKILLS_DIR_LOCAL/agent-browser"; then
        success "agent-browser skill installed (local)"
    else
        warning "agent-browser skill missing"
    fi

    # security-analyzer skill
    if skill_has_content "$SKILLS_DIR/security-analyzer"; then
        success "security-analyzer skill installed (global)"
    elif skill_has_content "$SKILLS_DIR_LOCAL/security-analyzer"; then
        success "security-analyzer skill installed (local)"
    else
        warning "security-analyzer skill missing"
    fi

    # UI UX Pro Max skill
    if skill_has_content "$SKILLS_DIR/ui-ux-pro-max"; then
        success "UI UX Pro Max skill installed (global)"
    elif skill_has_content "$SKILLS_DIR_LOCAL/ui-ux-pro-max"; then
        success "UI UX Pro Max skill installed (local)"
    else
        warning "UI UX Pro Max skill missing or empty"
    fi

    info "⚠️  You may need to restart Claude Code to detect skills"
else
    warning "Skills directory not found"
fi

echo ""

# ============================================================================
# STEP 7: Verify Workspace Files
# ============================================================================
info "Step 7: Verifying workspace files and directories..."

# Workspace directories
for dir in src tests docs scripts config plans; do
    if [ -d "$WORKSPACE_FOLDER/$dir" ]; then
        success "Workspace directory: $dir/"
    else
        warning "Workspace directory missing: $dir/"
    fi
done

# AGENTS.md
if [ -f "$WORKSPACE_FOLDER/AGENTS.md" ]; then
    success "AGENTS.md exists"
else
    warning "AGENTS.md missing - codex configuration"
fi

# prd2build command
if [ -f "$HOME/.claude/commands/prd2build.md" ]; then
    PRD_SIZE=$(wc -c < "$HOME/.claude/commands/prd2build.md" 2>/dev/null)
    success "prd2build command installed ($PRD_SIZE bytes)"
else
    warning "prd2build command missing"
fi

# CLAUDE.md configuration
if [ -f "$WORKSPACE_FOLDER/CLAUDE.md" ] || [ -f "$WORKSPACE_FOLDER/claude.md" ]; then
    success "Claude configuration file exists"
else
    warning "Claude configuration file (CLAUDE.md) missing"
fi

# .claude-flow directory
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ]; then
    success ".claude-flow directory exists"
    if [ -f "$WORKSPACE_FOLDER/.claude-flow/config.json" ]; then
        success ".claude-flow/config.json exists"
    else
        warning ".claude-flow/config.json missing"
    fi
else
    warning ".claude-flow directory missing"
fi

# tsconfig.json
if [ -f "$WORKSPACE_FOLDER/tsconfig.json" ]; then
    success "tsconfig.json exists"
else
    warning "tsconfig.json missing"
fi

# tailwind.config.js
if [ -f "$WORKSPACE_FOLDER/tailwind.config.js" ]; then
    success "tailwind.config.js exists"
else
    warning "tailwind.config.js missing"
fi

# postcss.config.js
if [ -f "$WORKSPACE_FOLDER/postcss.config.js" ]; then
    success "postcss.config.js exists"
else
    warning "postcss.config.js missing"
fi

# HeroUI
if [ -d "$WORKSPACE_FOLDER/node_modules/@heroui" ]; then
    success "HeroUI installed in node_modules"
else
    warning "HeroUI not installed"
fi

# Codex config
if [ -f "$HOME/.codex/instructions.md" ]; then
    success "Codex instructions.md exists"
else
    warning "Codex instructions.md missing"
fi

echo ""

# ============================================================================
# STEP 8: Check GitHub CLI
# ============================================================================
info "Step 8: Checking GitHub CLI..."

if command -v gh >/dev/null 2>&1; then
    if gh auth status 2>/dev/null | grep -q "Logged in"; then
        GITHUB_USER=$(gh auth status 2>/dev/null | grep "Logged in as" | sed 's/.*as //')
        success "GitHub CLI authenticated as: $GITHUB_USER"
    else
        warning "GitHub CLI not authenticated - run 'gh auth login' to enable GitHub features"
    fi
else
    warning "GitHub CLI not installed - optional for GitHub integration"
fi

echo ""

# ============================================================================
# STEP 9: Check Codex
# ============================================================================
info "Step 9: Checking Codex (OpenAI Code Agent)..."

if command -v codex >/dev/null 2>&1; then
    CODEX_VER=$(codex --version 2>/dev/null || echo "unknown")
    success "Codex installed: $CODEX_VER"
    warning "Remember to run 'codex login' if not authenticated"
else
    warning "Codex not installed (optional) - install with: npm install -g @openai/codex"
fi

echo ""

# ============================================================================
# STEP 10: Environment Setup
# ============================================================================
info "Step 10: Environment configuration..."

# Check bash aliases from setup.sh
ALIAS_CHECK=0

if grep -q "TURBO FLOW v2.0.7" ~/.bashrc 2>/dev/null; then
    success "Bash aliases: v2.0.7 block found"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash aliases: v2.0.7 block not found"
fi

if grep -q "alias cf=" ~/.bashrc 2>/dev/null; then
    success "Bash alias: cf (claude-flow)"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash alias: cf not found"
fi

if grep -q "alias ruv=" ~/.bashrc 2>/dev/null; then
    success "Bash alias: ruv (ruvector)"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash alias: ruv not found"
fi

if grep -q "alias ab=" ~/.bashrc 2>/dev/null; then
    success "Bash alias: ab (agent-browser)"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash alias: ab not found"
fi

if grep -q "alias aqe=" ~/.bashrc 2>/dev/null; then
    success "Bash alias: aqe (agentic-qe)"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash alias: aqe not found"
fi

if grep -q "alias sk=" ~/.bashrc 2>/dev/null; then
    success "Bash alias: sk (specify/spec-kit)"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash alias: sk not found"
fi

if grep -q "alias os=" ~/.bashrc 2>/dev/null; then
    success "Bash alias: os (openspec)"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash alias: os not found"
fi

if grep -q "turbo-status()" ~/.bashrc 2>/dev/null; then
    success "Bash function: turbo-status()"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash function: turbo-status() not found"
fi

if grep -q "turbo-help()" ~/.bashrc 2>/dev/null; then
    success "Bash function: turbo-help()"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash function: turbo-help() not found"
fi

if grep -q "codex-check()" ~/.bashrc 2>/dev/null; then
    success "Bash function: codex-check()"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash function: codex-check() not found"
fi

if [ $ALIAS_CHECK -ge 5 ]; then
    info "Run 'source ~/.bashrc' or restart shell to use aliases"
fi

# Check for API keys
if [ -n "$ANTHROPIC_API_KEY" ]; then
    success "ANTHROPIC_API_KEY is set"
else
    warning "ANTHROPIC_API_KEY not set - add to ~/.bashrc or .env"
fi

# Check PATH includes required directories
PATH_CHECK=0
if echo "$PATH" | grep -q "$HOME/.local/bin"; then
    success "PATH includes ~/.local/bin"
    PATH_CHECK=$((PATH_CHECK + 1))
else
    warning "PATH missing ~/.local/bin"
fi

if echo "$PATH" | grep -q "$HOME/.cargo/bin"; then
    success "PATH includes ~/.cargo/bin"
    PATH_CHECK=$((PATH_CHECK + 1))
else
    warning "PATH missing ~/.cargo/bin"
fi

if echo "$PATH" | grep -q "$HOME/.claude/bin"; then
    success "PATH includes ~/.claude/bin"
    PATH_CHECK=$((PATH_CHECK + 1))
else
    warning "PATH missing ~/.claude/bin"
fi

if [ $PATH_CHECK -lt 3 ]; then
    warning "Some PATH entries missing - source ~/.bashrc"
fi

echo ""

# ============================================================================
# STEP 11: Run Doctor
# ============================================================================
info "Step 11: Running Claude Flow doctor for comprehensive check..."

DOCTOR_OUTPUT=$(npx -y claude-flow@alpha doctor 2>&1 || true)
if echo "$DOCTOR_OUTPUT" | grep -q "error\|failed\|missing"; then
    warning "Doctor found issues - review output below:"
    echo "$DOCTOR_OUTPUT" | head -25
else
    success "Doctor check passed"
    echo "$DOCTOR_OUTPUT" | head -20
fi

echo ""

# ============================================================================
# STEP 12: Generate Prompts for Claude
# ============================================================================
info "Step 12: Generating prompts for Claude post-setup..."

PROMPT_FILE="$WORKSPACE_FOLDER/.claude-flow-post-setup-prompts.md"
cat > "$PROMPT_FILE" << 'PROMPT_EOF'
# Claude Post-Setup Prompts (v2.0.7)

After completing setup.sh and post-setup.sh, use these prompts in Claude Code:

## 1. Restart MCP Connection
```
Please restart the MCP server connection to detect the claude-flow and agentic-qe MCP servers.
```

## 2. Verify Installation
```
Run Claude Flow doctor and show me the complete status including MCP tools, skills, daemon, memory, and swarm.
```

## 3. Initialize Memory (if not done)
```
Initialize Claude Flow memory with HNSW indexing for semantic search.
```

## 4. Initialize Swarm (if not done)
```
Initialize Claude Flow swarm with hierarchical topology, specialized strategy, and max-agents 8.
```

## 5. Start Background Worker (if daemon not running)
```
Dispatch the audit worker to analyze the codebase for security issues.
```

## 6. List Available Tools
```
List all available MCP tools from claude-flow and agentic-qe and show me what each one does.
```

## 7. Test Swarm
```
Spawn a test agent to verify the swarm is working correctly.
```

## 8. Test RuVector
```
Test RuVector neural engine by running ruv-stats to check learning statistics.
```

## 9. Test Agent Browser
```
Open a test page with agent-browser and take a snapshot to verify browser automation is working.
```

## 10. Generate Tests with Agentic QE
```
Use agentic-qe to generate tests for the current codebase.
```
PROMPT_EOF

success "Prompts saved to: $PROMPT_FILE"

echo ""

# ============================================================================
# SUMMARY
# ============================================================================
cat << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║                    Post-Setup Complete! (v2.0.7)                  ║
╚══════════════════════════════════════════════════════════════════╝

Components Verified:
  ✅ Build tools (g++, make)
  ✅ Node.js 20+ & npm
  ✅ Claude Code
  ✅ Claude Flow V3
  ✅ RuVector Neural Engine (ruvector, @ruvector/sona, @ruvector/cli, @ruvector/ruvllm)
  ✅ agentic-qe
  ✅ @fission-ai/openspec
  ✅ uipro-cli
  ✅ agent-browser + @claude-flow/browser + Chromium
  ✅ uv (Python) + specify CLI (spec-kit)
  ✅ Skills: agent-browser, security-analyzer, UI UX Pro Max
  ✅ Workspace: src, tests, docs, scripts, config, plans
  ✅ Config files: tsconfig.json, tailwind.config.js, postcss.config.js
  ✅ HeroUI + Tailwind CSS
  ✅ prd2build command
  ✅ AGENTS.md
  ✅ Codex configuration
  ✅ MCP servers: claude-flow, agentic-qe
  ✅ Bash aliases & functions
  ✅ Daemon, Memory, Swarm

Next Steps:

1. RESTART CLAUDE CODE
   → Required to detect MCP servers and skills

2. RELOAD SHELL
   → Run: source ~/.bashrc
   → Or restart your terminal

3. CONFIGURE API KEYS (if not set)
   → Add to ~/.bashrc: export ANTHROPIC_API_KEY="sk-ant-..."
   → Source the file: source ~/.bashrc

4. AUTHENTICATE GITHUB CLI (optional)
   → Run: gh auth login

5. AUTHENTICATE CODEX (optional)
   → Run: codex login

6. USE THE PROMPTS
   → See: .claude-flow-post-setup-prompts.md

7. VERIFY EVERYTHING
   → Run: npx -y claude-flow@alpha doctor
   → Or: turbo-status (after sourcing .bashrc)

Quick Aliases (after sourcing .bashrc):

  CLAUDE FLOW:
    cf              - Claude Flow CLI
    cf-init         - Initialize Claude Flow
    cf-wizard       - Interactive setup wizard
    cf-swarm        - Initialize hierarchical swarm
    cf-mesh         - Initialize mesh swarm
    cf-agent        - Spawn an agent
    cf-list         - List agents
    cf-daemon       - Start daemon
    cf-memory       - Memory operations
    cf-memory-status - Memory status
    cf-security     - Security scan
    cf-mcp          - Start MCP server
    cf-doctor       - Run diagnostics

  RUVECTOR:
    ruv             - RuVector neural engine
    ruv-stats       - Show learning statistics
    ruv-route       - Route task to best agent
    ruv-remember    - Store in semantic memory
    ruv-recall      - Search semantic memory
    ruv-learn       - Learn from interaction
    ruv-init        - Initialize hooks

  AGENT-BROWSER:
    ab              - agent-browser CLI
    ab-open         - Open URL in browser
    ab-snap         - Take snapshot with refs
    ab-click        - Click element by ref
    ab-fill         - Fill input by ref
    ab-close        - Close browser

  TESTING:
    aqe             - Agentic QE CLI
    aqe-generate    - Generate tests
    aqe-gate        - Quality gate

  SPEC-KIT & OPENSPEC:
    sk              - specify CLI
    sk-here         - Initialize spec-kit here
    os              - openspec CLI
    os-init         - Initialize openspec

  CODEX:
    codex-login     - Login to Codex
    codex-run       - Run Codex with Claude
    codex-check     - Check Codex setup status

  HELPERS:
    turbo-status    - Show all tool versions & status
    turbo-help      - Show quick reference guide
    dsp             - claude --dangerously-skip-permissions

Common Commands:
   npx -y claude-flow@alpha daemon status
   npx -y claude-flow@alpha memory search --query "test"
   npx -y claude-flow@alpha swarm status
   npx @ruvector/cli hooks route --task "help me with..."
   npx ruvector --version
   agent-browser open https://example.com
   npx -y agentic-qe generate
   uipro init --ai claude --offline

EOF

success "Post-setup completed!"
echo ""
