#!/bin/bash
set -e

# Get the directory where this script is located
readonly DEVPOD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m' # No Color

success() { echo -e "${GREEN}✅ $*${NC}"; }
warning() { echo -e "${YELLOW}⚠️  $*${NC}"; }
info() { echo -e "${BLUE}ℹ️  $*${NC}"; }
section() { echo -e "${CYAN}━━━ $* ━━━${NC}"; }

cat << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║                  Turbo Flow V3.1.0 Post-Setup                    ║
║         Configure & Enable All Claude Flow Components            ║
║     + Worktree Manager + Vercel Deploy + RuV Viz + Statusline    ║
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

# jq (required for worktree-manager)
if command -v jq >/dev/null 2>&1; then
    success "jq: $(jq --version 2>/dev/null)"
else
    warning "jq not found (required for worktree-manager)"
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

for pkg in agentic-qe @fission-ai/openspec uipro-cli @ruvector/ruvllm; do
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

# @claude-flow/browser (part of claude-flow, not separate npm package)
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ]; then
    success "@claude-flow/browser: integrated (59 MCP tools)"
    info "  └─ Start MCP server with: cf-mcp"
else
    warning "@claude-flow/browser: requires claude-flow init"
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
# STEP 7: Verify Skills (ENHANCED - includes new skills)
# ============================================================================
info "Step 7: Verifying Claude Code skills..."

SKILLS_DIR="$HOME/.claude/skills"
SKILLS_DIR_LOCAL="$WORKSPACE_FOLDER/.claude/skills"

section "Core Skills"
for skill in agent-browser security-analyzer ui-ux-pro-max; do
    if skill_has_content "$SKILLS_DIR/$skill" || skill_has_content "$SKILLS_DIR_LOCAL/$skill"; then
        success "$skill skill installed"
    else
        warning "$skill skill missing or empty"
    fi
done

section "Claude Flow Browser Integration"
# @claude-flow/browser provides 59 MCP tools via claude-flow
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ]; then
    success "Claude Flow Browser: integrated"
    info "  └─ 59 MCP tools: browser/open, browser/snapshot, browser/click, etc."
    info "  └─ Features: trajectory learning, security scanning, element refs (@e1, @e2)"
    info "  └─ Memory: patterns saved to RuVector"
    # Check if MCP is configured
    if [ -f "$HOME/.config/claude/mcp.json" ] && grep -q "claude-flow" "$HOME/.config/claude/mcp.json" 2>/dev/null; then
        success "  └─ MCP server configured"
    else
        warning "  └─ MCP server not configured (run: claude mcp add claude-flow -- npx -y claude-flow@latest)"
    fi
else
    warning "Claude Flow Browser: requires cf-init"
fi

section "New Skills (v3.1.0)"
# Worktree Manager
if skill_has_content "$SKILLS_DIR/worktree-manager"; then
    success "worktree-manager skill installed"
    # Check config
    if [ -f "$SKILLS_DIR/worktree-manager/config.json" ]; then
        success "  └─ config.json present"
    fi
else
    warning "worktree-manager skill missing"
fi

# Vercel Deploy
if skill_has_content "$SKILLS_DIR/vercel-deploy"; then
    success "vercel-deploy skill installed"
else
    warning "vercel-deploy skill missing"
fi

# RuV Helpers (Visualization)
if skill_has_content "$SKILLS_DIR/rUv_helpers"; then
    success "rUv_helpers installed"
    # Check visualization component
    if [ -d "$SKILLS_DIR/rUv_helpers/claude-flow-ruvector-visualization" ]; then
        success "  └─ visualization dashboard present"
        if [ -d "$SKILLS_DIR/rUv_helpers/claude-flow-ruvector-visualization/node_modules" ]; then
            success "  └─ dependencies installed"
        else
            warning "  └─ dependencies not installed (run: cd ~/.claude/skills/rUv_helpers/claude-flow-ruvector-visualization && npm install)"
        fi
    fi
else
    warning "rUv_helpers missing"
fi

echo ""

# ============================================================================
# STEP 8: Verify Ultimate Cyberpunk Statusline (NEW)
# ============================================================================
info "Step 8: Checking Ultimate Cyberpunk Statusline (15 Components)..."

CLAUDE_SETTINGS="$HOME/.claude/settings.json"
STATUSLINE_SCRIPT="$HOME/.claude/turbo-flow-statusline.sh"
STATUSLINE_CONFIG="$HOME/.claude/statusline-pro/config.toml"

section "Statusline Script"
if [ -f "$STATUSLINE_SCRIPT" ]; then
    success "Statusline script: $STATUSLINE_SCRIPT"
    if [ -x "$STATUSLINE_SCRIPT" ]; then
        success "  └─ Script is executable"
    else
        warning "  └─ Script not executable, fixing..."
        chmod +x "$STATUSLINE_SCRIPT"
    fi
else
    warning "Statusline script not found"
    info "  └─ Run install-v3.1.0.sh to create"
fi

section "Settings Configuration"
if [ -f "$CLAUDE_SETTINGS" ]; then
    if grep -q "turbo-flow-statusline" "$CLAUDE_SETTINGS" 2>/dev/null; then
        success "Statusline: configured in settings.json"
    elif grep -q "statusline" "$CLAUDE_SETTINGS" 2>/dev/null; then
        warning "Statusline: using different script"
        info "  └─ Update to use: $STATUSLINE_SCRIPT"
    else
        warning "Statusline: not configured"
    fi
else
    warning "Claude settings.json not found"
fi

section "Cyberpunk Theme Config"
if [ -f "$STATUSLINE_CONFIG" ]; then
    success "Config file: ~/.claude/statusline-pro/config.toml"
else
    info "Config reference not found (script is self-contained)"
fi

section "Dependencies"
if command -v jq &>/dev/null; then
    success "jq: $(jq --version 2>/dev/null || echo 'installed')"
else
    warning "jq: not installed (needed for statusline)"
    info "  └─ Install with: sudo apt install jq"
fi

if command -v ccusage &>/dev/null || npm list -g ccusage &>/dev/null 2>&1; then
    success "ccusage: installed (cost tracking)"
else
    info "ccusage: not installed (optional, for enhanced cost tracking)"
    info "  └─ Install with: npm install -g ccusage"
fi

section "15 Component Layout"
echo ""
info "  ╔═══════════════════════════════════════════════════════════════════════╗"
info "  ║  LINE 1: Identity & Navigation                                        ║"
info "  ║  📁 Project │ 🤖 Model │ 🌿 Branch │ 📟 Version │ 🎨 Style │ 🔗 Session║"
info "  ╠═══════════════════════════════════════════════════════════════════════╣"
info "  ║  LINE 2: Resources & Costs                                            ║"
info "  ║  📊 Tokens │ 🧠 Context Bar │ 💾 Cache │ 💰 Cost │ 🔥 Burn │ ⏱️ Duration║"
info "  ╠═══════════════════════════════════════════════════════════════════════╣"
info "  ║  LINE 3: Activity & Status                                            ║"
info "  ║  ➕ Added │ ➖ Removed │ 📂 Git │ 🌳 Worktree │ 🔌 MCP │ ✅ Status     ║"
info "  ╚═══════════════════════════════════════════════════════════════════════╝"
echo ""

section "Color Palette"
info "  Magenta (#FF00FF) • Cyan (#00FFFF) • Neon Green (#39FF14)"
info "  Yellow (#FFE600) • Hot Pink (#FF1493) • Electric Blue (#0080FF)"
info "  Neon Orange (#FFA500) • Neon Red (#FF3232)"

echo ""

# ============================================================================
# STEP 9: Verify Workspace Files
# ============================================================================
info "Step 9: Verifying workspace files..."

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
# STEP 10: Check External Tools
# ============================================================================
info "Step 10: Checking external tools..."

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
# STEP 11: Check Environment (ENHANCED)
# ============================================================================
info "Step 11: Checking environment..."

# Bash aliases - check for new version
if grep -q "TURBO FLOW v3.1.0" ~/.bashrc 2>/dev/null; then
    success "Bash aliases: v3.1.0 installed"
elif grep -q "TURBO FLOW v3.0.0" ~/.bashrc 2>/dev/null; then
    warning "Bash aliases: v3.0.0 (upgrade to v3.1.0 by re-running setup.sh)"
else
    warning "Bash aliases: not found (run setup.sh or source ~/.bashrc)"
fi

section "Core Aliases"
for alias in cf ruv ab aqe dsp; do
    grep -q "alias $alias=" ~/.bashrc 2>/dev/null && success "Alias: $alias" || warning "Alias: $alias missing"
done

section "Claude Flow Browser Aliases (NEW)"
for alias in cfb-open cfb-snap cfb-click cfb-trajectory cfb-learn; do
    grep -q "alias $alias=" ~/.bashrc 2>/dev/null && success "Alias: $alias" || warning "Alias: $alias missing"
done

section "New Aliases (v3.1.0)"
for alias in ruv-viz wt-status wt-clean deploy deploy-preview; do
    grep -q "alias $alias=" ~/.bashrc 2>/dev/null && success "Alias: $alias" || warning "Alias: $alias missing"
done

section "Functions"
for func in turbo-status turbo-help; do
    grep -q "${func}()" ~/.bashrc 2>/dev/null && success "Function: $func()" || warning "Function: $func() missing"
done

section "Environment Variables"
# API key
[ -n "$ANTHROPIC_API_KEY" ] && success "ANTHROPIC_API_KEY is set" || warning "ANTHROPIC_API_KEY not set"

# PATH
echo "$PATH" | grep -q "$HOME/.local/bin" && success "PATH: ~/.local/bin" || warning "PATH missing ~/.local/bin"
echo "$PATH" | grep -q "$HOME/.cargo/bin" && success "PATH: ~/.cargo/bin" || warning "PATH missing ~/.cargo/bin"
echo "$PATH" | grep -q "$HOME/.claude/bin" && success "PATH: ~/.claude/bin" || warning "PATH missing ~/.claude/bin"

echo ""

# ============================================================================
# STEP 12: Run Doctor
# ============================================================================
info "Step 12: Running Claude Flow doctor..."

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
# STEP 13: Test New Components (NEW)
# ============================================================================
info "Step 13: Testing new v3.1.0 components..."

section "Claude Flow Browser (59 MCP Tools)"
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ]; then
    success "Claude Flow initialized"
    # Check MCP configuration
    if npx -y claude-flow@alpha mcp status 2>/dev/null | grep -q "running\|active"; then
        success "MCP server running"
        info "  └─ Browser tools available: browser/open, browser/snapshot, etc."
    else
        info "MCP server not running"
        info "  └─ Start with: cf-mcp"
    fi
    info "  └─ CLI aliases: ab-open, ab-snap, ab-click, ab-fill"
    info "  └─ MCP aliases: cfb-open, cfb-snap, cfb-trajectory, cfb-learn"
else
    warning "Claude Flow not initialized - run cf-init"
fi

section "RuVector Visualization"
if [ -f "$HOME/.claude/skills/rUv_helpers/claude-flow-ruvector-visualization/server.js" ]; then
    success "Visualization server script found"
    info "  └─ Start with: ruv-viz (opens http://localhost:3333)"
else
    warning "Visualization server not found"
fi

section "Worktree Manager"
if [ -f "$HOME/.claude/skills/worktree-manager/SKILL.md" ]; then
    success "Worktree manager skill ready"
    # Check worktree base directory config
    if [ -f "$HOME/.claude/skills/worktree-manager/config.json" ]; then
        WORKTREE_BASE=$(grep -o '"worktreeBase"[[:space:]]*:[[:space:]]*"[^"]*"' "$HOME/.claude/skills/worktree-manager/config.json" 2>/dev/null | cut -d'"' -f4 || echo "~/tmp/worktrees")
        info "  └─ Worktree base: $WORKTREE_BASE"
    fi
else
    warning "Worktree manager skill not found"
fi

section "Vercel Deploy"
if [ -f "$HOME/.claude/skills/vercel-deploy/SKILL.md" ]; then
    success "Vercel deploy skill ready"
    info "  └─ Usage: 'Deploy my app' or 'Deploy and give me the preview URL'"
else
    warning "Vercel deploy skill not found"
fi

echo ""

# ============================================================================
# STEP 14: Generate Prompts (ENHANCED)
# ============================================================================
info "Step 14: Generating Claude prompts..."

PROMPT_FILE="$WORKSPACE_FOLDER/.claude-flow-prompts.md"
cat > "$PROMPT_FILE" << 'PROMPT_EOF'
# Claude Post-Setup Prompts (v3.1.0)

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

## Test Claude Flow Browser (MCP)
```
Start the Claude Flow MCP server and use browser/open to navigate to https://example.com, then take a snapshot with browser/snapshot.
```

## Start Trajectory Learning
```
Start a browser trajectory to learn the login flow pattern.
```

## Generate Tests
```
Use agentic-qe to generate tests for this codebase.
```

---

## NEW v3.1.0 Prompts

### Start Visualization Dashboard
```
Start the RuVector visualization dashboard at localhost:3333.
```

### Create Parallel Worktree
```
Create a worktree for feature/my-new-feature so I can work on it in parallel.
```

### Check Worktree Status
```
What is the status of my worktrees?
```

### Deploy to Vercel
```
Deploy this app to Vercel and give me the preview URL.
```

### Quick Deploy
```
Deploy my app.
```

### Statusline Configuration
```
Show me how to customize my Claude Code statusline.
```
PROMPT_EOF

success "Prompts saved to: $PROMPT_FILE"

echo ""

# ============================================================================
# SUMMARY (ENHANCED)
# ============================================================================
cat << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║                 Post-Setup Complete! (v3.1.0)                    ║
╚══════════════════════════════════════════════════════════════════╝

Components Verified:

  CORE:
  • Node.js 20+, Claude Code, Claude Flow V3, RuVector
  • jq (for worktree-manager)

  ECOSYSTEM:
  • agentic-qe, openspec, uipro-cli, agent-browser, uv, specify

  BROWSER AUTOMATION:
  • agent-browser CLI (ab-open, ab-snap, ab-click, ab-fill)
  • @claude-flow/browser (59 MCP tools, trajectory learning, security)

  SKILLS (Original):
  • agent-browser, security-analyzer, UI UX Pro Max

  SKILLS (NEW in v3.1.0):
  • worktree-manager   - Parallel development with git worktrees
  • vercel-deploy      - One-command Vercel deployment
  • rUv_helpers        - 3D visualization dashboard

  WORKSPACE:
  • src, tests, docs, scripts, config, plans, HeroUI

  CONFIG:
  • AGENTS.md, prd2build, Codex, MCP servers
  • Statusline Pro (NEW)

Next Steps:

  1. RESTART CLAUDE CODE → Required for MCP & skills
  2. RELOAD SHELL → source ~/.bashrc
  3. SET API KEY → export ANTHROPIC_API_KEY="sk-ant-..."
  4. VERIFY → turbo-status

Quick Reference:

  CLAUDE FLOW     cf, cf-init, cf-wizard, cf-swarm, cf-doctor
  RUVECTOR        ruv, ruv-stats, ruv-route, ruv-recall
  
  BROWSER (CLI)   ab-open, ab-snap, ab-click, ab-fill
  BROWSER (MCP)   cfb-open, cfb-snap, cfb-trajectory, cfb-learn
  
  TESTING         aqe-generate, aqe-gate
  STATUS          turbo-status, turbo-help

  NEW in v3.1.0:
  VISUALIZATION   ruv-viz, ruv-viz-stop
  WORKTREE        wt-status, wt-clean, wt-create
  DEPLOYMENT      deploy, deploy-preview

EOF

success "Post-setup completed!"
echo ""
