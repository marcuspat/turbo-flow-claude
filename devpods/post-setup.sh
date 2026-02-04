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
║                  Turbo Flow V3.0.0 Post-Setup                    ║
║              Configure & Enable Claude Flow Components            ║
╚══════════════════════════════════════════════════════════════════╝
EOF

echo ""
echo "WORKSPACE_FOLDER: ${WORKSPACE_FOLDER:=$(pwd)}"
echo "DEVPOD_DIR: $DEVPOD_DIR"
echo ""

# Helper function
skill_has_content() {
    local dir="$1"
    [ -d "$dir" ] && [ -n "$(ls -A "$dir" 2>/dev/null)" ]
}

# ============================================================================
# STEP 1: Verify Core Installations (delegated components)
# ============================================================================
info "Step 1: Verifying core installations (from claude-flow installer)..."

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

# Claude Code
if command -v claude >/dev/null 2>&1; then
    success "Claude Code: $(claude --version 2>/dev/null | head -1)"
else
    warning "Claude Code not found - run setup.sh first"
fi

# Claude Flow V3
CF_VERSION=$(npx -y claude-flow@alpha --version 2>/dev/null | head -1 || echo "")
if [ -n "$CF_VERSION" ]; then
    success "Claude Flow V3: $CF_VERSION"
else
    warning "Claude Flow not responding"
fi

# RuVector Neural Engine
if npm list -g ruvector --depth=0 >/dev/null 2>&1; then
    success "RuVector: $(npx ruvector --version 2>/dev/null | head -1 || echo 'installed')"
else
    warning "RuVector not installed"
fi

# @ruvector/cli (for hooks)
if npm list -g @ruvector/cli --depth=0 >/dev/null 2>&1; then
    success "@ruvector/cli: installed"
else
    warning "@ruvector/cli not installed"
fi

echo ""

# ============================================================================
# STEP 2: Verify Ecosystem Packages (unique to setup.sh)
# ============================================================================
info "Step 2: Verifying ecosystem packages..."

for pkg in agentic-qe @fission-ai/openspec uipro-cli @claude-flow/browser @ruvector/ruvllm; do
    if npm list -g "$pkg" --depth=0 >/dev/null 2>&1; then
        success "$pkg: installed"
    else
        warning "$pkg not installed"
    fi
done

# agent-browser (check command)
if command -v agent-browser >/dev/null 2>&1; then
    success "agent-browser: $(agent-browser --version 2>/dev/null || echo 'installed')"
else
    warning "agent-browser not found"
fi

# uv (Python package manager)
if command -v uv >/dev/null 2>&1; then
    success "uv: $(uv --version 2>/dev/null | head -1)"
else
    warning "uv not installed"
fi

# specify CLI (spec-kit)
if command -v specify >/dev/null 2>&1; then
    success "specify CLI: installed"
else
    warning "specify CLI not installed"
fi

echo ""

# ============================================================================
# STEP 3: Start Claude Flow Daemon
# ============================================================================
info "Step 3: Starting Claude Flow daemon..."

if npx -y claude-flow@alpha daemon status 2>/dev/null | grep -q "running"; then
    warning "Daemon already running - skipping"
else
    if npx -y claude-flow@alpha daemon start 2>/dev/null; then
        success "Daemon started"
    else
        warning "Daemon start failed (can be started later)"
    fi
fi

echo ""

# ============================================================================
# STEP 4: Initialize Memory
# ============================================================================
info "Step 4: Initializing Claude Flow memory..."

if [ -f "$HOME/.claude-flow/memory.db" ] || [ -f "$HOME/.claude-flow/data/memory.db" ]; then
    warning "Memory already initialized - skipping"
else
    if npx -y claude-flow@alpha memory init --force 2>/dev/null; then
        success "Memory initialized with HNSW indexing"
    else
        warning "Memory init failed - will initialize on first use"
    fi
fi

echo ""

# ============================================================================
# STEP 5: Initialize Swarm
# ============================================================================
info "Step 5: Initializing Claude Flow swarm..."

if npx -y claude-flow@alpha swarm status 2>/dev/null | grep -q "active\|initialized"; then
    warning "Swarm already initialized"
else
    if npx -y claude-flow@alpha swarm init --topology hierarchical --max-agents 8 --strategy specialized 2>/dev/null; then
        success "Swarm initialized: hierarchical, 8 agents"
    else
        warning "Swarm init failed - can be initialized later"
    fi
fi

echo ""

# ============================================================================
# STEP 6: Check MCP Configuration
# ============================================================================
info "Step 6: Checking MCP configuration..."

MCP_CONFIG="$HOME/.config/claude/mcp.json"
if [ -f "$MCP_CONFIG" ]; then
    grep -q "claude-flow" "$MCP_CONFIG" && success "MCP: claude-flow configured" || warning "MCP: claude-flow missing"
    grep -q "agentic-qe" "$MCP_CONFIG" && success "MCP: agentic-qe configured" || warning "MCP: agentic-qe missing"
    info "Restart Claude Code to detect MCP servers"
else
    warning "MCP config not found at $MCP_CONFIG"
fi

echo ""

# ============================================================================
# STEP 7: Verify Skills
# ============================================================================
info "Step 7: Verifying Claude Code skills..."

SKILLS_DIR="$HOME/.claude/skills"
SKILLS_DIR_LOCAL="$WORKSPACE_FOLDER/.claude/skills"

for skill in agent-browser security-analyzer ui-ux-pro-max; do
    if skill_has_content "$SKILLS_DIR/$skill" || skill_has_content "$SKILLS_DIR_LOCAL/$skill"; then
        success "$skill skill installed"
    else
        warning "$skill skill missing or empty"
    fi
done

echo ""

# ============================================================================
# STEP 8: Verify Workspace Files
# ============================================================================
info "Step 8: Verifying workspace files..."

# Directories
for dir in src tests docs scripts config plans; do
    [ -d "$WORKSPACE_FOLDER/$dir" ] && success "Directory: $dir/" || warning "Missing: $dir/"
done

# Key files
[ -f "$WORKSPACE_FOLDER/AGENTS.md" ] && success "AGENTS.md exists" || warning "AGENTS.md missing"
[ -f "$HOME/.claude/commands/prd2build.md" ] && success "prd2build command installed" || warning "prd2build missing"
[ -d "$WORKSPACE_FOLDER/.claude-flow" ] && success ".claude-flow directory exists" || warning ".claude-flow missing"
[ -f "$WORKSPACE_FOLDER/tsconfig.json" ] && success "tsconfig.json exists" || warning "tsconfig.json missing"
[ -f "$WORKSPACE_FOLDER/tailwind.config.js" ] && success "tailwind.config.js exists" || warning "tailwind.config.js missing"
[ -d "$WORKSPACE_FOLDER/node_modules/@heroui" ] && success "HeroUI installed" || warning "HeroUI missing"
[ -f "$HOME/.codex/instructions.md" ] && success "Codex instructions exist" || warning "Codex instructions missing"

echo ""

# ============================================================================
# STEP 9: Check External Tools
# ============================================================================
info "Step 9: Checking external tools..."

# GitHub CLI
if command -v gh >/dev/null 2>&1; then
    if gh auth status 2>/dev/null | grep -q "Logged in"; then
        success "GitHub CLI: authenticated"
    else
        warning "GitHub CLI: not authenticated (run 'gh auth login')"
    fi
else
    warning "GitHub CLI: not installed (optional)"
fi

# Codex
if command -v codex >/dev/null 2>&1; then
    success "Codex: $(codex --version 2>/dev/null || echo 'installed')"
    info "Run 'codex login' if not authenticated"
else
    warning "Codex: not installed (optional)"
fi

echo ""

# ============================================================================
# STEP 10: Check Environment
# ============================================================================
info "Step 10: Checking environment..."

# Bash aliases
if grep -q "TURBO FLOW v3.0.0" ~/.bashrc 2>/dev/null; then
    success "Bash aliases: v3.0.0 installed"
else
    warning "Bash aliases: not found (run setup.sh or source ~/.bashrc)"
fi

# Key aliases
for alias in cf ruv ab aqe; do
    grep -q "alias $alias=" ~/.bashrc 2>/dev/null && success "Alias: $alias" || warning "Alias: $alias missing"
done

# Functions
for func in turbo-status turbo-help; do
    grep -q "${func}()" ~/.bashrc 2>/dev/null && success "Function: $func()" || warning "Function: $func() missing"
done

# API key
[ -n "$ANTHROPIC_API_KEY" ] && success "ANTHROPIC_API_KEY is set" || warning "ANTHROPIC_API_KEY not set"

# PATH
echo "$PATH" | grep -q "$HOME/.local/bin" && success "PATH: ~/.local/bin" || warning "PATH missing ~/.local/bin"
echo "$PATH" | grep -q "$HOME/.cargo/bin" && success "PATH: ~/.cargo/bin" || warning "PATH missing ~/.cargo/bin"
echo "$PATH" | grep -q "$HOME/.claude/bin" && success "PATH: ~/.claude/bin" || warning "PATH missing ~/.claude/bin"

echo ""

# ============================================================================
# STEP 11: Run Doctor
# ============================================================================
info "Step 11: Running Claude Flow doctor..."

DOCTOR_OUTPUT=$(npx -y claude-flow@alpha doctor 2>&1 || true)
if echo "$DOCTOR_OUTPUT" | grep -qi "error\|failed\|missing"; then
    warning "Doctor found issues:"
    echo "$DOCTOR_OUTPUT" | head -20
else
    success "Doctor check passed"
    echo "$DOCTOR_OUTPUT" | head -15
fi

echo ""

# ============================================================================
# STEP 12: Generate Prompts
# ============================================================================
info "Step 12: Generating Claude prompts..."

PROMPT_FILE="$WORKSPACE_FOLDER/.claude-flow-prompts.md"
cat > "$PROMPT_FILE" << 'PROMPT_EOF'
# Claude Post-Setup Prompts (v3.0.0)

## Quick Verification
```
Run turbo-status to check all installed components.
```

## Restart MCP
```
Restart the MCP server connection to detect claude-flow and agentic-qe.
```

## Full Doctor Check
```
Run Claude Flow doctor and show complete status.
```

## Test Swarm
```
Spawn a test agent to verify swarm is working.
```

## Test RuVector
```
Run ruv-stats to check learning statistics.
```

## Test Agent Browser
```
Open https://example.com with agent-browser and take a snapshot.
```

## Generate Tests
```
Use agentic-qe to generate tests for this codebase.
```
PROMPT_EOF

success "Prompts saved to: $PROMPT_FILE"

echo ""

# ============================================================================
# SUMMARY
# ============================================================================
cat << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║                 Post-Setup Complete! (v3.0.0)                    ║
╚══════════════════════════════════════════════════════════════════╝

Components Verified:
  • Core: Node.js 20+, Claude Code, Claude Flow V3, RuVector
  • Ecosystem: agentic-qe, openspec, uipro-cli, agent-browser, uv, specify
  • Skills: agent-browser, security-analyzer, UI UX Pro Max
  • Workspace: src, tests, docs, scripts, config, plans, HeroUI
  • Config: AGENTS.md, prd2build, Codex, MCP servers

Next Steps:

  1. RESTART CLAUDE CODE → Required for MCP & skills
  2. RELOAD SHELL → source ~/.bashrc
  3. SET API KEY → export ANTHROPIC_API_KEY="sk-ant-..."
  4. VERIFY → turbo-status

Quick Reference:

  CLAUDE FLOW     cf, cf-init, cf-wizard, cf-swarm, cf-doctor
  RUVECTOR        ruv, ruv-stats, ruv-route, ruv-recall
  AGENT-BROWSER   ab-open, ab-snap, ab-click, ab-fill
  TESTING         aqe-generate, aqe-gate
  STATUS          turbo-status, turbo-help

EOF

success "Post-setup completed!"
echo ""
