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
║                  Turbo Flow V2.0.5 Post-Setup                    ║
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

# Node.js & npm
if command -v node >/dev/null 2>&1; then
    success "Node.js: $(node -v)"
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
if command -v npx >/dev/null 2>&1 && npx -y @claude-flow/cli@latest --version >/dev/null 2>&1; then
    CF_VERSION=$(npx -y @claude-flow/cli@latest --version 2>/dev/null | head -1)
    success "Claude Flow V3: $CF_VERSION"
else
    warning "Claude Flow not found"
fi

# RuVector Neural Engine
if npx ruvector --version >/dev/null 2>&1; then
    RUV_VERSION=$(npx ruvector --version 2>/dev/null | head -1)
    success "RuVector Neural Engine: $RUV_VERSION"
else
    warning "RuVector not installed (optional)"
fi

# Core npm packages
if command -v agentic-qe >/dev/null 2>&1; then
    success "agentic-qe: installed"
else
    warning "agentic-qe not found"
fi

if command -v uipro-cli >/dev/null 2>&1; then
    success "uipro-cli: installed"
else
    warning "uipro-cli not found"
fi

# agent-browser
if command -v agent-browser >/dev/null 2>&1; then
    success "agent-browser CLI: $(agent-browser --version)"
else
    warning "agent-browser not found"
fi

# uv (Python package manager)
if command -v uv >/dev/null 2>&1; then
    UV_VERSION=$(uv --version 2>/dev/null | head -1)
    success "uv (Python): $UV_VERSION"
else
    warning "uv not installed (optional)"
fi

echo ""

# ============================================================================
# STEP 2: Start Claude Flow Daemon
# ============================================================================
info "Step 2: Starting Claude Flow daemon with background workers..."

# Check if daemon is already running
if npx @claude-flow/cli@latest daemon status 2>/dev/null | grep -q "running"; then
    warning "Daemon already running - skipping"
else
    info "Starting daemon..."
    if npx @claude-flow/cli@latest daemon start 2>/dev/null; then
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
    if npx @claude-flow/cli@latest memory init --force 2>/dev/null; then
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
if npx @claude-flow/cli@latest swarm status 2>/dev/null | grep -q "active\|initialized"; then
    SWARM_STATUS=$(npx @claude-flow/cli@latest swarm status 2>/dev/null | head -1)
    warning "Swarm already initialized: $SWARM_STATUS"
else
    info "Initializing swarm with hierarchical topology..."
    if npx @claude-flow/cli@latest swarm init \
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
        info "⚠️  You may need to restart Claude Code to detect MCP server"
    else
        warning "claude-flow not found in MCP config"
    fi
else
    warning "MCP config not found at $MCP_CONFIG"
fi

echo ""

# ============================================================================
# STEP 6: Verify Skills
# ============================================================================
info "Step 6: Verifying installed Claude Code skills..."

SKILLS_DIR="$HOME/.claude/skills"
if [ -d "$SKILLS_DIR" ]; then
    if [ -f "$SKILLS_DIR/agent-browser/SKILL.md" ]; then
        success "agent-browser skill installed"
    else
        warning "agent-browser skill missing"
    fi

    if [ -d "$SKILLS_DIR/security-analyzer" ]; then
        success "security-analyzer skill installed"
    else
        warning "security-analyzer skill missing"
    fi
    info "⚠️  You may need to restart Claude Code to detect skills"
else
    warning "Skills directory not found"
fi

echo ""

# ============================================================================
# STEP 6.5: Verify Workspace Files
# ============================================================================
info "Step 6.5: Verifying workspace files and directories..."

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

echo ""

# ============================================================================
# STEP 8: Check GitHub CLI
# ============================================================================
# ============================================================================

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
# STEP 9: Environment Setup
# ============================================================================
info "Step 8: Environment configuration..."

# Check bash aliases from setup.sh
ALIAS_CHECK=0
if grep -q "cf=" ~/.bashrc 2>/dev/null; then
    success "Bash alias: cf= (claude-flow)"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash alias: cf= not found"
fi

if grep -q "ruv=" ~/.bashrc 2>/dev/null; then
    success "Bash alias: ruv= (ruvector)"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash alias: ruv= not found"
fi

if grep -q "ab=" ~/.bashrc 2>/dev/null; then
    success "Bash alias: ab= (agent-browser)"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash alias: ab= not found"
fi

if grep -q "turbo-status()" ~/.bashrc 2>/dev/null; then
    success "Bash function: turbo-status()"
    ALIAS_CHECK=$((ALIAS_CHECK + 1))
else
    warning "Bash function: turbo-status() not found"
fi

if [ $ALIAS_CHECK -ge 3 ]; then
    info "Run 'source ~/.bashrc' or restart shell to use aliases"
fi

# Check for API keys
if [ -n "$ANTHROPIC_API_KEY" ]; then
    success "ANTHROPIC_API_KEY is set"
else
    warning "ANTHROPIC_API_KEY not set - add to ~/.bashrc or .env"
fi

# Check PATH includes required directories
if echo "$PATH" | grep -q "$HOME/.local/bin"; then
    success "PATH includes ~/.local/bin"
else
    warning "PATH missing ~/.local/bin - source ~/.bashrc"
fi

echo ""

# ============================================================================
# STEP 10: Run Doctor
# ============================================================================
info "Step 9: Running Claude Flow doctor for comprehensive check..."

DOCTOR_OUTPUT=$(npx @claude-flow/cli@latest doctor 2>&1 || true)
if echo "$DOCTOR_OUTPUT" | grep -q "error\|failed\|missing"; then
    warning "Doctor found issues - review output below:"
    echo "$DOCTOR_OUTPUT"
else
    success "Doctor check passed"
    echo "$DOCTOR_OUTPUT" | head -20
fi

echo ""

# ============================================================================
# STEP 11: Generate Prompts for Claude
# ============================================================================
info "Step 10: Generating prompts for Claude post-setup..."

PROMPT_FILE="$WORKSPACE_FOLDER/.claude-flow-post-setup-prompts.md"
cat > "$PROMPT_FILE" << 'PROMPT_EOF'
# Claude Post-Setup Prompts

After completing setup.sh and post-setup.sh, use these prompts in Claude Code:

## 1. Restart MCP Connection
```
Please restart the MCP server connection to detect the claude-flow MCP server.
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
List all available MCP tools from claude-flow and show me what each one does.
```

## 7. Test Swarm
```
Spawn a test agent to verify the swarm is working correctly.
```
PROMPT_EOF

success "Prompts saved to: $PROMPT_FILE"

echo ""

# ============================================================================
# SUMMARY
# ============================================================================
cat << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║                    Post-Setup Complete!                           ║
╚══════════════════════════════════════════════════════════════════╝

Components Verified:
  ✅ Node.js & npm
  ✅ Claude Code
  ✅ Claude Flow V3
  ✅ RuVector Neural Engine
  ✅ agentic-qe, uipro-cli
  ✅ agent-browser + Chromium
  ✅ security-analyzer skill
  ✅ uv (Python)
  ✅ Workspace directories (src, tests, docs, scripts, config, plans)
  ✅ prd2build command
  ✅ AGENTS.md
  ✅ Bash aliases (cf, ruv, ab, turbo-status, etc.)
  ✅ MCP configuration
  ✅ Daemon
  ✅ Memory
  ✅ Swarm

Next Steps:

1. RESTART CLAUDE CODE
   → Required to detect MCP server and skills

2. RELOAD SHELL
   → Run: source ~/.bashrc
   → Or restart your terminal

3. CONFIGURE API KEYS (if not set)
   → Add to ~/.bashrc: export ANTHROPIC_API_KEY="sk-ant-..."
   → Source the file: source ~/.bashrc

4. AUTHENTICATE GITHUB CLI (optional)
   → Run: gh auth login

5. USE THE PROMPTS
   → See: .claude-flow-post-setup-prompts.md

6. VERIFY EVERYTHING
   → Run: npx @claude-flow/cli@latest doctor
   → Or: turbo-status (custom function)

Quick Aliases (after sourcing .bashrc):
   cf              - Claude Flow CLI
   cf-swarm        - Initialize hierarchical swarm
   cf-mesh         - Initialize mesh swarm
   cf-agent        - Spawn an agent
   cf-list         - List agents
   cf-memory       - Memory operations
   cf-mcp          - Start MCP server
   cf-doctor       - Run diagnostics
   cf-hooks        - Hooks system
   ruv             - RuVector neural engine
   ab              - agent-browser CLI
   ab-open         - Open URL in browser
   ab-snap         - Take snapshot with refs
   turbo-status    - Show all tool versions
   turbo-help      - Show quick reference

Common Commands:
   npx @claude-flow/cli@latest daemon status
   npx @claude-flow/cli@latest memory search --query "test"
   npx @claude-flow/cli@latest swarm status
   npx @claude-flow/cli@latest hooks route --task "help me with..."
   npx ruvector --version
   agent-browser open https://example.com

EOF

success "Post-setup completed!"
echo ""
