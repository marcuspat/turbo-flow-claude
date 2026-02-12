#!/bin/bash
# TURBO FLOW SETUP SCRIPT v3.1.0 (LEAN)
# Streamlined: Delegates core install to claude-flow, adds ecosystem extensions
# Claude Flow V3 + RuVector + Security Analyzer + UI Pro Max + Codex
# NEW: Worktree Manager + Vercel Deploy + RuV Helpers Visualization + Statusline Pro

# ============================================
# CONFIGURATION
# ============================================
: "${WORKSPACE_FOLDER:=$(pwd)}"
: "${DEVPOD_WORKSPACE_FOLDER:=$WORKSPACE_FOLDER}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"
TOTAL_STEPS=13
CURRENT_STEP=0
START_TIME=$(date +%s)

# ============================================
# PATH SETUP - ensure npm global bin is discoverable
# ============================================
if [ -n "$npm_config_prefix" ]; then
    export PATH="$npm_config_prefix/bin:$PATH"
elif [ -f "$HOME/.npmrc" ]; then
    _NPM_PREFIX=$(grep '^prefix=' "$HOME/.npmrc" 2>/dev/null | cut -d= -f2)
    [ -n "$_NPM_PREFIX" ] && export PATH="$_NPM_PREFIX/bin:$PATH"
fi
export PATH="$HOME/.local/bin:$HOME/.claude/bin:$PATH"

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

has_cmd() { command -v "$1" >/dev/null 2>&1; }
is_npm_installed() { npm list -g "$1" --depth=0 >/dev/null 2>&1; }
elapsed() { echo "$(($(date +%s) - START_TIME))s"; }

skill_has_content() {
    local dir="$1"
    [ -d "$dir" ] && [ -n "$(ls -A "$dir" 2>/dev/null)" ]
}

install_npm() {
    local pkg="$1"
    checking "$pkg"
    if is_npm_installed "$pkg"; then
        skip "$pkg"
        return 0
    else
        status "Installing $pkg"
        # Try with npm install first
        if npm install -g "$pkg" --silent --no-progress 2>/dev/null; then
            ok "$pkg installed"
            return 0
        else
            # Retry without silent flag to see errors
            status "Retrying $pkg..."
            if npm install -g "$pkg" 2>&1 | tail -3; then
                ok "$pkg installed (retry)"
                return 0
            else
                # Try npx as fallback
                if npx -y "$pkg" --version >/dev/null 2>&1; then
                    ok "$pkg available via npx"
                    return 0
                else
                    warn "$pkg install failed"
                    return 1
                fi
            fi
        fi
    fi
}

# ============================================
# START
# ============================================
clear 2>/dev/null || true
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║     🚀 TURBO FLOW v3.1.0 - LEAN INSTALLER                   ║"
echo "║     Core + Extensions + Visualization + Statusline Pro      ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "  📁 Workspace: $WORKSPACE_FOLDER"
echo "  🕐 Started at: $(date '+%H:%M:%S')"
echo ""
progress_bar 0
echo ""

# ============================================
# STEP 1: Build tools (UNIQUE - not in claude-flow)
# ============================================
step_header "Installing build tools"

checking "build-essential"
if has_cmd g++ && has_cmd make; then
    skip "build tools (g++, make already present)"
else
    status "Installing build-essential and python3"
    if has_cmd apt-get; then
        (apt-get update -qq && apt-get install -y -qq build-essential python3 git curl jq) 2>/dev/null || \
        (sudo apt-get update -qq && sudo apt-get install -y -qq build-essential python3 git curl jq) 2>/dev/null || \
        warn "Could not install build tools"
        ok "build tools installed"
    elif has_cmd yum; then
        (yum groupinstall -y "Development Tools" && yum install -y jq || sudo yum groupinstall -y "Development Tools" && sudo yum install -y jq) 2>/dev/null
        ok "build tools installed (yum)"
    elif has_cmd apk; then
        apk add --no-cache build-base python3 git curl jq 2>/dev/null
        ok "build tools installed (apk)"
    else
        warn "Unknown package manager"
    fi
fi

# Ensure jq is installed (needed for worktree-manager)
checking "jq"
if has_cmd jq; then
    skip "jq"
else
    status "Installing jq"
    if has_cmd apt-get; then
        (apt-get install -y -qq jq || sudo apt-get install -y -qq jq) 2>/dev/null && ok "jq installed" || warn "jq failed"
    elif has_cmd brew; then
        brew install jq 2>/dev/null && ok "jq installed" || warn "jq failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 2: Claude Flow V3 + RuVector (DELEGATED)
# ============================================
step_header "Installing Claude Flow V3 + RuVector (delegated)"

# ── Validate Node.js version (Claude Code requires 18+) ──
checking "Node.js version"
NODE_MAJOR=$(node -v 2>/dev/null | sed 's/v//' | cut -d. -f1)
if [ -z "$NODE_MAJOR" ]; then
    fail "Node.js not found"
    info "Install Node.js 20+ before continuing"
elif [ "$NODE_MAJOR" -lt 18 ]; then
    warn "Node.js $(node -v) found, Claude Code requires 18+"
    status "Installing Node.js 20 via nodesource"
    curl -fsSL https://deb.nodesource.com/setup_20.x 2>/dev/null | sudo -E bash - 2>/dev/null
    sudo apt-get install -y nodejs 2>/dev/null
    ok "Node.js $(node -v) installed"
else
    ok "Node.js $(node -v)"
fi

# ── Install Claude Code CLI ──
checking "Claude Code CLI"
if has_cmd claude; then
    skip "Claude Code already installed"
else
    # Method 1: Native installer (recommended by Anthropic)
    status "Installing Claude Code CLI (native installer)"
    if curl -fsSL https://claude.ai/install.sh | sh 2>&1; then
        # Refresh PATH to find the new binary
        export PATH="$HOME/.local/bin:$HOME/.claude/bin:$PATH"
        [ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc" 2>/dev/null || true
    fi

    if has_cmd claude; then
        ok "Claude Code installed ($(claude --version 2>/dev/null | head -1))"
    else
        # Method 2: npm fallback (uses npm_config_prefix from devcontainer)
        status "Native installer did not place binary in PATH, trying npm fallback..."
        INSTALL_OUTPUT=$(npm install -g @anthropic-ai/claude-code 2>&1)
        INSTALL_EXIT=$?

        if [ $INSTALL_EXIT -eq 0 ] && has_cmd claude; then
            ok "Claude Code installed via npm ($(claude --version 2>/dev/null | head -1))"
        else
            echo "$INSTALL_OUTPUT" | tail -5 | sed 's/^/    /'
            status "Retrying with --unsafe-perm..."
            INSTALL_OUTPUT=$(npm install -g @anthropic-ai/claude-code --unsafe-perm 2>&1)
            INSTALL_EXIT=$?

            if [ $INSTALL_EXIT -eq 0 ] && has_cmd claude; then
                ok "Claude Code installed (retry)"
            else
                echo "$INSTALL_OUTPUT" | tail -5 | sed 's/^/    /'
                fail "Claude Code install failed"
                info "Debug: node $(node -v 2>/dev/null || echo 'missing'), npm $(npm -v 2>/dev/null || echo 'missing')"
                info "npm prefix: $(npm config get prefix 2>/dev/null)"
                info "Try manually: curl -fsSL https://claude.ai/install.sh | sh"
            fi
        fi
    fi
fi

# Check if already fully installed
CLAUDE_FLOW_OK=false
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ] && has_cmd claude; then
    if is_npm_installed "ruvector" || is_npm_installed "claude-flow"; then
        CLAUDE_FLOW_OK=true
    fi
fi

if $CLAUDE_FLOW_OK; then
    skip "Claude Flow + RuVector already installed"
else
    status "Running official claude-flow installer (--full mode)"
    echo ""
    
    # Run claude-flow installer
    curl -fsSL https://cdn.jsdelivr.net/gh/ruvnet/claude-flow@main/scripts/install.sh 2>/dev/null | bash -s -- --full 2>&1 | while IFS= read -r line; do
        if [[ ! "$line" =~ "deprecated" ]] && [[ ! "$line" =~ "npm warn" ]]; then
            echo "    $line"
        fi
    done || true
    
    cd "$WORKSPACE_FOLDER" 2>/dev/null || true
    
    # Ensure claude-flow is installed
    status "Ensuring claude-flow@alpha is installed"
    npm install -g claude-flow@alpha --silent 2>/dev/null || true
    
    if [ ! -d ".claude-flow" ]; then
        status "Initializing Claude Flow in workspace"
        npx -y claude-flow@alpha init --force 2>/dev/null || true
    fi
    
    # Explicitly install RuVector (standalone package)
    status "Installing RuVector neural engine"
    npm install -g ruvector --silent 2>/dev/null || {
        warn "ruvector install failed - trying npx"
        npx -y ruvector --version 2>/dev/null || true
    }
    
    # Install @ruvector/cli for hooks
    status "Installing @ruvector/cli"
    npm install -g @ruvector/cli --silent 2>/dev/null || true
    
    # Install sql.js for memory database (WASM fallback)
    status "Installing sql.js for memory database"
    npm install -g sql.js --silent 2>/dev/null || true
    
    # Also install locally in workspace for memory operations
    if [ -f "package.json" ]; then
        npm install sql.js --save-dev --silent 2>/dev/null || true
    fi
    
    # Initialize RuVector hooks
    status "Initializing RuVector hooks"
    npx -y @ruvector/cli hooks init 2>/dev/null || true
    
    ok "Claude Flow + RuVector installed"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 3: Ecosystem npm packages (UNIQUE)
# ============================================
step_header "Installing ecosystem packages"

install_npm agentic-qe
install_npm @fission-ai/openspec
install_npm @ruvector/ruvllm

# Install AgentDB for vector memory (NEW - was missing!)
status "Installing AgentDB (vector memory with HNSW)"
npm install -g agentdb --silent 2>/dev/null && ok "agentdb installed" || warn "agentdb install failed"

# Note: @claude-flow/browser is included in claude-flow package (not separate npm package)
# It provides 59 MCP browser tools, trajectory learning, and security scanning
info "@claude-flow/browser: included in claude-flow (59 MCP tools)"

info "Elapsed: $(elapsed)"

# ============================================
# STEP 4: Claude Flow Browser Setup
# ============================================
step_header "Verifying Claude Flow Browser"

# @claude-flow/browser provides:
# - 59 MCP browser tools (included in claude-flow, no extra install)
# - Trajectory learning (records successful patterns)
# - Security scanning (URL/PII checks)
# - Memory integration with RuVector
# - Element refs (@e1, @e2) instead of full DOM

checking "Claude Flow Browser integration"
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ]; then
    ok "Claude Flow Browser: integrated (59 MCP tools available via cf-mcp)"
    info "  └─ Tools: browser/open, browser/snapshot, browser/click, browser/fill, etc."
    info "  └─ Features: trajectory learning, security scanning, element refs"
else
    warn "Claude Flow not initialized - run cf-init first"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 5: Security Analyzer Skill (UNIQUE)
# ============================================
step_header "Installing Security Analyzer Skill"

SECURITY_SKILL_DIR="$HOME/.claude/skills/security-analyzer"

checking "security-analyzer skill"
if skill_has_content "$SECURITY_SKILL_DIR"; then
    skip "security-analyzer skill already installed"
else
    status "Cloning security-analyzer"
    if git clone --depth 1 https://github.com/Cornjebus/security-analyzer.git /tmp/security-analyzer 2>/dev/null; then
        mkdir -p "$SECURITY_SKILL_DIR"
        if [ -d "/tmp/security-analyzer/.claude/skills/security-analyzer" ]; then
            cp -r /tmp/security-analyzer/.claude/skills/security-analyzer/* "$SECURITY_SKILL_DIR/"
        else
            cp -r /tmp/security-analyzer/* "$SECURITY_SKILL_DIR/"
        fi
        rm -rf /tmp/security-analyzer
        ok "security-analyzer skill installed"
    else
        warn "security-analyzer clone failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 6: UI UX Pro Max Skill (UNIQUE)
# ============================================
step_header "Installing UI UX Pro Max Skill"

UIPRO_SKILL_DIR="$HOME/.claude/skills/ui-ux-pro-max"
UIPRO_SKILL_DIR_LOCAL="$WORKSPACE_FOLDER/.claude/skills/ui-ux-pro-max"

checking "UI UX Pro Max skill"
if skill_has_content "$UIPRO_SKILL_DIR" || skill_has_content "$UIPRO_SKILL_DIR_LOCAL"; then
    skip "UI UX Pro Max skill already installed"
else
    [ -d "$UIPRO_SKILL_DIR" ] && [ -z "$(ls -A "$UIPRO_SKILL_DIR" 2>/dev/null)" ] && rm -rf "$UIPRO_SKILL_DIR"
    [ -d "$UIPRO_SKILL_DIR_LOCAL" ] && [ -z "$(ls -A "$UIPRO_SKILL_DIR_LOCAL" 2>/dev/null)" ] && rm -rf "$UIPRO_SKILL_DIR_LOCAL"
    
    status "Installing UI UX Pro Max skill"
    npx -y uipro-cli init --ai claude --offline 2>&1 | tail -3
    
    if skill_has_content "$UIPRO_SKILL_DIR" || skill_has_content "$UIPRO_SKILL_DIR_LOCAL"; then
        ok "UI UX Pro Max skill installed"
    else
        warn "UI UX Pro Max skill may be incomplete"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 7: Worktree Manager Skill (NEW)
# ============================================
step_header "Installing Worktree Manager Skill"

WORKTREE_SKILL_DIR="$HOME/.claude/skills/worktree-manager"

checking "worktree-manager skill"
if skill_has_content "$WORKTREE_SKILL_DIR" && [ -f "$WORKTREE_SKILL_DIR/SKILL.md" ]; then
    skip "worktree-manager skill already installed"
else
    mkdir -p "$WORKTREE_SKILL_DIR"
    status "Cloning worktree-manager (HTTPS)"
    # Try HTTPS first (more reliable in containers)
    if git clone --depth 1 https://github.com/Wirasm/worktree-manager-skill.git "$WORKTREE_SKILL_DIR" 2>/dev/null; then
        ok "worktree-manager skill installed"
    else
        # Try SSH as fallback
        status "Trying SSH..."
        if git clone --depth 1 git@github.com:Wirasm/worktree-manager-skill.git "$WORKTREE_SKILL_DIR" 2>/dev/null; then
            ok "worktree-manager skill installed via SSH"
        else
            # Manual creation as last fallback
            warn "Git clone failed - creating minimal skill"
            cat > "$WORKTREE_SKILL_DIR/SKILL.md" << 'WORKTREE_SKILL'
---
name: worktree-manager
description: Create, manage, and cleanup git worktrees with Claude Code agents. USE THIS SKILL when user says "create worktree", "spin up worktrees", "new worktree for X", "worktree status", "cleanup worktrees", or wants parallel development branches.
---

# Worktree Manager

Manage parallel development environments using git worktrees.

## Commands

### Create Worktree
```bash
git worktree add ~/tmp/worktrees/<branch-name> -b <branch-name>
cd ~/tmp/worktrees/<branch-name>
cp ../.env . 2>/dev/null || true
npm install
```

### List Worktrees
```bash
git worktree list
```

### Remove Worktree
```bash
git worktree remove ~/tmp/worktrees/<branch-name>
git branch -d <branch-name>
```

### Port Allocation
Use ports 8100-8199 for worktree dev servers to avoid conflicts.

## Configuration
Edit ~/.claude/skills/worktree-manager/config.json:
```json
{
  "terminal": "ghostty",
  "portPool": { "start": 8100, "end": 8199 },
  "worktreeBase": "~/tmp/worktrees"
}
```
WORKTREE_SKILL
            # Create default config
            cat > "$WORKTREE_SKILL_DIR/config.json" << 'WORKTREE_CONFIG'
{
  "terminal": "tmux",
  "shell": "bash",
  "claudeCommand": "claude --dangerously-skip-permissions",
  "portPool": { "start": 8100, "end": 8199 },
  "portsPerWorktree": 2,
  "worktreeBase": "~/tmp/worktrees"
}
WORKTREE_CONFIG
            ok "worktree-manager minimal skill created"
        fi
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 8: Vercel Deploy Skill (NEW)
# ============================================
step_header "Installing Vercel Deploy Skill"

VERCEL_SKILL_DIR="$HOME/.claude/skills/vercel-deploy"

checking "vercel-deploy skill"
if skill_has_content "$VERCEL_SKILL_DIR"; then
    skip "vercel-deploy skill already installed"
else
    status "Installing vercel-deploy skill via npx skills"
    # Use the new Vercel skills CLI (non-interactive mode)
    if npx -y skills add vercel-labs/agent-skills --skill vercel-deploy-claimable -a claude-code -y 2>/dev/null; then
        ok "vercel-deploy skill installed via skills CLI"
    else
        # Fallback: manual clone with correct path
        status "Fallback: Cloning vercel-deploy skill manually"
        if git clone --depth 1 https://github.com/vercel-labs/agent-skills.git /tmp/agent-skills 2>/dev/null; then
            mkdir -p "$VERCEL_SKILL_DIR"
            # Check both possible locations
            if [ -d "/tmp/agent-skills/skills/claude.ai/vercel-deploy-claimable" ]; then
                cp -r /tmp/agent-skills/skills/claude.ai/vercel-deploy-claimable/* "$VERCEL_SKILL_DIR/"
                ok "vercel-deploy skill installed (claude.ai path)"
            elif [ -d "/tmp/agent-skills/skills/vercel-deploy" ]; then
                cp -r /tmp/agent-skills/skills/vercel-deploy/* "$VERCEL_SKILL_DIR/"
                ok "vercel-deploy skill installed"
            elif [ -d "/tmp/agent-skills/skills/vercel-deploy-claimable" ]; then
                cp -r /tmp/agent-skills/skills/vercel-deploy-claimable/* "$VERCEL_SKILL_DIR/"
                ok "vercel-deploy skill installed"
            else
                warn "vercel-deploy skill not found in repo (structure may have changed)"
                info "  └─ Install manually: npx skills add vercel-labs/agent-skills --skill vercel-deploy-claimable"
            fi
            rm -rf /tmp/agent-skills
        else
            warn "vercel-deploy clone failed"
        fi
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 9: RuV Helpers Visualization (NEW)
# ============================================
step_header "Installing RuV Helpers Visualization"

RUV_HELPERS_DIR="$HOME/.claude/skills/rUv_helpers"

checking "rUv_helpers visualization"
if skill_has_content "$RUV_HELPERS_DIR"; then
    skip "rUv_helpers already installed"
else
    status "Cloning rUv_helpers"
    if git clone --depth 1 https://github.com/Jordi-Izquierdo-DDS/rUv_helpers.git "$RUV_HELPERS_DIR" 2>/dev/null; then
        # Install visualization dependencies
        if [ -d "$RUV_HELPERS_DIR/claude-flow-ruvector-visualization" ]; then
            cd "$RUV_HELPERS_DIR/claude-flow-ruvector-visualization"
            npm install --silent 2>/dev/null
            cd "$WORKSPACE_FOLDER"
        fi
        ok "rUv_helpers installed"
    else
        warn "rUv_helpers clone failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 10: Statusline Pro - ULTIMATE CYBERPUNK EDITION (NEW)
# ============================================
step_header "Installing Statusline Pro - Ultimate Cyberpunk Edition"

checking "statusline-pro"
CLAUDE_SETTINGS="$HOME/.claude/settings.json"
STATUSLINE_CONFIG_DIR="$HOME/.claude/statusline-pro"
STATUSLINE_SCRIPT="$HOME/.claude/turbo-flow-statusline.sh"

# Create statusline config directory
mkdir -p "$STATUSLINE_CONFIG_DIR" 2>/dev/null

# Install ccusage for advanced cost tracking
status "Installing ccusage for cost tracking"
npm install -g ccusage 2>/dev/null || true

# Create ULTIMATE Cyberpunk statusline shell script
status "Creating Ultimate Cyberpunk statusline script"
cat > "$STATUSLINE_SCRIPT" << 'STATUSLINE_SCRIPT'
#!/bin/bash
# ╔═══════════════════════════════════════════════════════════════════════════╗
# ║  TURBO FLOW v3.1.0 - ULTIMATE CYBERPUNK STATUSLINE                        ║
# ║  Multi-line powerline with 15+ components                                 ║
# ╚═══════════════════════════════════════════════════════════════════════════╝

# Read JSON from Claude Code stdin
INPUT=$(cat)

# ═══════════════════════════════════════════════════════════════════════════
# CYBERPUNK COLOR PALETTE (Truecolor - 24bit)
# ═══════════════════════════════════════════════════════════════════════════
# Backgrounds
BG_DEEP="\033[48;2;13;2;33m"        # #0D0221 - Deep purple-black
BG_DARK="\033[48;2;26;10;46m"       # #1A0A2E - Dark purple
BG_MID="\033[48;2;45;10;60m"        # #2D0A3C - Mid purple

# Neon Foregrounds
FG_MAGENTA="\033[38;2;255;0;255m"   # #FF00FF - Hot Magenta
FG_CYAN="\033[38;2;0;255;255m"      # #00FFFF - Electric Cyan
FG_GREEN="\033[38;2;57;255;20m"     # #39FF14 - Neon Green
FG_YELLOW="\033[38;2;255;230;0m"    # #FFE600 - Electric Yellow
FG_PINK="\033[38;2;255;20;147m"     # #FF1493 - Hot Pink
FG_BLUE="\033[38;2;0;128;255m"      # #0080FF - Electric Blue
FG_ORANGE="\033[38;2;255;165;0m"    # #FFA500 - Neon Orange
FG_RED="\033[38;2;255;50;50m"       # #FF3232 - Neon Red
FG_WHITE="\033[38;2;255;255;255m"   # #FFFFFF - White
FG_GRAY="\033[38;2;128;128;128m"    # #808080 - Gray

# Background versions of neon colors
BG_MAGENTA="\033[48;2;255;0;255m"
BG_CYAN="\033[48;2;0;255;255m"
BG_GREEN="\033[48;2;57;255;20m"
BG_YELLOW="\033[48;2;255;230;0m"
BG_PINK="\033[48;2;255;20;147m"
BG_BLUE="\033[48;2;0;128;255m"

# Reset
RST="\033[0m"
BOLD="\033[1m"

# Powerline separators
SEP=""
SEP_THIN=""

# ═══════════════════════════════════════════════════════════════════════════
# EXTRACT DATA FROM CLAUDE CODE JSON
# ═══════════════════════════════════════════════════════════════════════════

# Basic info
MODEL=$(echo "$INPUT" | jq -r '.model.display_name // "Claude"' 2>/dev/null)
MODEL_ID=$(echo "$INPUT" | jq -r '.model.id // ""' 2>/dev/null)
VERSION=$(echo "$INPUT" | jq -r '.version // ""' 2>/dev/null)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // ""' 2>/dev/null | cut -c1-8)
OUTPUT_STYLE=$(echo "$INPUT" | jq -r '.output_style.name // "default"' 2>/dev/null)

# Workspace
CWD=$(echo "$INPUT" | jq -r '.workspace.current_dir // .cwd // "~"' 2>/dev/null)
PROJECT_DIR=$(echo "$INPUT" | jq -r '.workspace.project_dir // ""' 2>/dev/null)
PROJECT_NAME=$(basename "$CWD" 2>/dev/null || echo "project")

# Cost data
COST_USD=$(echo "$INPUT" | jq -r '.cost.total_cost_usd // 0' 2>/dev/null)
DURATION_MS=$(echo "$INPUT" | jq -r '.cost.total_duration_ms // 0' 2>/dev/null)
API_DURATION_MS=$(echo "$INPUT" | jq -r '.cost.total_api_duration_ms // 0' 2>/dev/null)
LINES_ADDED=$(echo "$INPUT" | jq -r '.cost.total_lines_added // 0' 2>/dev/null)
LINES_REMOVED=$(echo "$INPUT" | jq -r '.cost.total_lines_removed // 0' 2>/dev/null)

# Context window
CTX_INPUT=$(echo "$INPUT" | jq -r '.context_window.total_input_tokens // 0' 2>/dev/null)
CTX_OUTPUT=$(echo "$INPUT" | jq -r '.context_window.total_output_tokens // 0' 2>/dev/null)
CTX_SIZE=$(echo "$INPUT" | jq -r '.context_window.context_window_size // 200000' 2>/dev/null)
CTX_USED_PCT=$(echo "$INPUT" | jq -r '.context_window.used_percentage // 0' 2>/dev/null | cut -d. -f1)
CTX_REMAIN_PCT=$(echo "$INPUT" | jq -r '.context_window.remaining_percentage // 100' 2>/dev/null | cut -d. -f1)

# Cache tokens
CACHE_CREATE=$(echo "$INPUT" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0' 2>/dev/null)
CACHE_READ=$(echo "$INPUT" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0' 2>/dev/null)

# ═══════════════════════════════════════════════════════════════════════════
# GIT INFORMATION
# ═══════════════════════════════════════════════════════════════════════════
GIT_BRANCH=""
GIT_STATUS=""
GIT_AHEAD=""
GIT_BEHIND=""
GIT_DIRTY=""
GIT_WORKTREE=""

if command -v git &>/dev/null && git -C "$CWD" rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
    GIT_BRANCH=$(git -C "$CWD" branch --show-current 2>/dev/null || echo "")
    
    # Check for worktree
    GIT_WORKTREE=$(git -C "$CWD" rev-parse --show-toplevel 2>/dev/null | xargs basename 2>/dev/null || echo "")
    
    # Ahead/behind
    GIT_AHEAD=$(git -C "$CWD" rev-list --count @{upstream}..HEAD 2>/dev/null || echo "0")
    GIT_BEHIND=$(git -C "$CWD" rev-list --count HEAD..@{upstream} 2>/dev/null || echo "0")
    
    # Dirty status
    if [[ -n $(git -C "$CWD" status --porcelain 2>/dev/null) ]]; then
        GIT_DIRTY="●"
    else
        GIT_DIRTY="✓"
    fi
    
    # Staged/unstaged counts
    STAGED=$(git -C "$CWD" diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    UNSTAGED=$(git -C "$CWD" diff --numstat 2>/dev/null | wc -l | tr -d ' ')
    UNTRACKED=$(git -C "$CWD" ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
fi

# ═══════════════════════════════════════════════════════════════════════════
# HELPER FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════

format_duration() {
    local ms=$1
    local secs=$((ms / 1000))
    local mins=$((secs / 60))
    local hours=$((mins / 60))
    mins=$((mins % 60))
    secs=$((secs % 60))
    
    if [ $hours -gt 0 ]; then
        echo "${hours}h${mins}m"
    elif [ $mins -gt 0 ]; then
        echo "${mins}m${secs}s"
    else
        echo "${secs}s"
    fi
}

format_tokens() {
    local tokens=$1
    if [ $tokens -ge 1000000 ]; then
        echo "$((tokens / 1000000))M"
    elif [ $tokens -ge 1000 ]; then
        echo "$((tokens / 1000))k"
    else
        echo "$tokens"
    fi
}

progress_bar() {
    local pct=$1
    local width=${2:-15}
    local filled=$((pct * width / 100))
    local empty=$((width - filled))
    
    local bar_color=""
    if [ $pct -lt 50 ]; then
        bar_color="$FG_GREEN"
    elif [ $pct -lt 70 ]; then
        bar_color="$FG_CYAN"
    elif [ $pct -lt 85 ]; then
        bar_color="$FG_YELLOW"
    elif [ $pct -lt 95 ]; then
        bar_color="$FG_ORANGE"
    else
        bar_color="$FG_RED"
    fi
    
    printf "${bar_color}"
    for ((i=0; i<filled; i++)); do printf "█"; done
    printf "${FG_GRAY}"
    for ((i=0; i<empty; i++)); do printf "░"; done
    printf "${RST}"
}

abbrev_model() {
    local model="$1"
    case "$model" in
        *"Opus"*"4.5"*) echo "O4.5" ;;
        *"Opus"*"4"*) echo "O4" ;;
        *"Sonnet"*"4.5"*) echo "S4.5" ;;
        *"Sonnet"*"4"*) echo "S4" ;;
        *"Haiku"*"4.5"*) echo "H4.5" ;;
        *"Haiku"*"4"*) echo "H4" ;;
        *"Opus"*) echo "Op" ;;
        *"Sonnet"*) echo "So" ;;
        *"Haiku"*) echo "Ha" ;;
        *) echo "$model" | cut -c1-8 ;;
    esac
}

# ═══════════════════════════════════════════════════════════════════════════
# BUILD STATUS LINE COMPONENTS
# ═══════════════════════════════════════════════════════════════════════════

DURATION_FMT=$(format_duration $DURATION_MS)
API_DURATION_FMT=$(format_duration $API_DURATION_MS)
CTX_TOTAL=$((CTX_INPUT + CTX_OUTPUT))
CTX_TOTAL_FMT=$(format_tokens $CTX_TOTAL)
CTX_SIZE_FMT=$(format_tokens $CTX_SIZE)
CACHE_HIT_PCT=0
if [ $((CACHE_READ + CACHE_CREATE)) -gt 0 ]; then
    CACHE_HIT_PCT=$((CACHE_READ * 100 / (CACHE_READ + CACHE_CREATE + 1)))
fi
MODEL_ABBREV=$(abbrev_model "$MODEL")
COST_FMT=$(printf "%.2f" $COST_USD 2>/dev/null || echo "0.00")

if [ $DURATION_MS -gt 0 ]; then
    BURN_RATE=$(echo "scale=2; $COST_USD * 3600000 / $DURATION_MS" | bc 2>/dev/null || echo "0.00")
else
    BURN_RATE="0.00"
fi

# LINE 1
LINE1=""
LINE1+="${BG_MAGENTA}${FG_WHITE}${BOLD} 📁 ${PROJECT_NAME} ${RST}"
LINE1+="${FG_MAGENTA}${BG_CYAN}${SEP}${RST}"
LINE1+="${BG_CYAN}${FG_WHITE}${BOLD} 🤖 ${MODEL_ABBREV} ${RST}"
LINE1+="${FG_CYAN}${BG_GREEN}${SEP}${RST}"
if [ -n "$GIT_BRANCH" ]; then
    GIT_INFO="${GIT_BRANCH}"
    [ "$GIT_AHEAD" != "0" ] && GIT_INFO+="↑${GIT_AHEAD}"
    [ "$GIT_BEHIND" != "0" ] && GIT_INFO+="↓${GIT_BEHIND}"
    GIT_INFO+=" ${GIT_DIRTY}"
    LINE1+="${BG_GREEN}${FG_WHITE}${BOLD} 🌿 ${GIT_INFO} ${RST}"
else
    LINE1+="${BG_GREEN}${FG_WHITE}${BOLD} 🌿 no-git ${RST}"
fi
LINE1+="${FG_GREEN}${BG_BLUE}${SEP}${RST}"
if [ -n "$VERSION" ]; then
    LINE1+="${BG_BLUE}${FG_WHITE} 📟 v${VERSION} ${RST}"
    LINE1+="${FG_BLUE}${BG_PINK}${SEP}${RST}"
fi
LINE1+="${BG_PINK}${FG_WHITE} 🎨 ${OUTPUT_STYLE} ${RST}"
LINE1+="${FG_PINK}${BG_DEEP}${SEP}${RST}"
if [ -n "$SESSION_ID" ]; then
    LINE1+="${BG_DEEP}${FG_GRAY} 🔗 ${SESSION_ID} ${RST}"
fi

# LINE 2
LINE2=""
LINE2+="${BG_YELLOW}${FG_WHITE}${BOLD} 📊 ${CTX_TOTAL_FMT}/${CTX_SIZE_FMT} ${RST}"
LINE2+="${FG_YELLOW}${BG_DARK}${SEP}${RST}"
LINE2+="${BG_DARK}${FG_WHITE} 🧠 $(progress_bar $CTX_USED_PCT 20) ${CTX_USED_PCT}% ${RST}"
LINE2+="${FG_DARK}${BG_CYAN}${SEP}${RST}"
if [ $CACHE_HIT_PCT -gt 0 ]; then
    LINE2+="${BG_CYAN}${FG_WHITE} 💾 ${CACHE_HIT_PCT}% hit ${RST}"
else
    LINE2+="${BG_CYAN}${FG_WHITE} 💾 cold ${RST}"
fi
LINE2+="${FG_CYAN}${BG_PINK}${SEP}${RST}"
LINE2+="${BG_PINK}${FG_WHITE}${BOLD} 💰 \$${COST_FMT} ${RST}"
LINE2+="${FG_PINK}${BG_ORANGE}${SEP}${RST}"
if [ $(echo "$BURN_RATE > 0" | bc 2>/dev/null) -eq 1 ] 2>/dev/null; then
    LINE2+="${BG_ORANGE}${FG_WHITE} 🔥 \$${BURN_RATE}/hr ${RST}"
    LINE2+="${FG_ORANGE}${BG_DEEP}${SEP}${RST}"
fi
LINE2+="${BG_DEEP}${FG_CYAN} ⏱️ ${DURATION_FMT} ${RST}"

# LINE 3
LINE3=""
if [ $LINES_ADDED -gt 0 ] || [ $LINES_REMOVED -gt 0 ]; then
    LINE3+="${BG_GREEN}${FG_WHITE} ➕${LINES_ADDED} ${RST}"
    LINE3+="${FG_GREEN}${BG_RED}${SEP}${RST}"
    LINE3+="${BG_RED}${FG_WHITE} ➖${LINES_REMOVED} ${RST}"
    LINE3+="${FG_RED}${BG_BLUE}${SEP}${RST}"
else
    LINE3+="${BG_BLUE}${FG_WHITE}"
fi
if [ -n "$GIT_BRANCH" ]; then
    GIT_DETAIL=""
    [ "$STAGED" != "0" ] && GIT_DETAIL+="S:${STAGED} "
    [ "$UNSTAGED" != "0" ] && GIT_DETAIL+="U:${UNSTAGED} "
    [ "$UNTRACKED" != "0" ] && GIT_DETAIL+="?:${UNTRACKED}"
    if [ -n "$GIT_DETAIL" ]; then
        LINE3+="${BG_BLUE}${FG_WHITE} 📂 ${GIT_DETAIL}${RST}"
        LINE3+="${FG_BLUE}${BG_MAGENTA}${SEP}${RST}"
    fi
fi
if [ -n "$GIT_WORKTREE" ] && [ "$GIT_WORKTREE" != "$PROJECT_NAME" ]; then
    LINE3+="${BG_MAGENTA}${FG_WHITE} 🌳 wt:${GIT_WORKTREE} ${RST}"
    LINE3+="${FG_MAGENTA}${BG_CYAN}${SEP}${RST}"
fi
MCP_COUNT=0
if command -v claude &>/dev/null; then
    MCP_COUNT=$(claude mcp list 2>/dev/null | grep -c "running" 2>/dev/null || echo "0")
fi
if [ "$MCP_COUNT" -gt 0 ]; then
    LINE3+="${BG_CYAN}${FG_WHITE} 🔌 ${MCP_COUNT} MCPs ${RST}"
    LINE3+="${FG_CYAN}${BG_GREEN}${SEP}${RST}"
fi
LINE3+="${BG_GREEN}${FG_WHITE}${BOLD} ✅ READY ${RST}"
LINE3+="${FG_GREEN}${RST}"

echo -e "${LINE1}"
echo -e "${LINE2}"
echo -e "${LINE3}"
STATUSLINE_SCRIPT
chmod +x "$STATUSLINE_SCRIPT"
ok "Ultimate Cyberpunk statusline script created"

# Create Cyberpunk theme config.toml for fallback/reference
status "Creating Cyberpunk config reference"
cat > "$STATUSLINE_CONFIG_DIR/config.toml" << 'STATUSLINE_CONFIG'
# TURBO FLOW v3.1.0 - ULTIMATE CYBERPUNK STATUSLINE CONFIG
# 15+ Components | 3 Lines | Neon on Dark

[display]
multiline = true
lines = 3
powerline = true
padding = 0

[colors]
deep_purple = "#0D0221"
dark_purple = "#1A0A2E"
magenta = "#FF00FF"
cyan = "#00FFFF"
neon_green = "#39FF14"
electric_yellow = "#FFE600"
hot_pink = "#FF1493"
electric_blue = "#0080FF"
neon_orange = "#FFA500"
neon_red = "#FF3232"

[terminal]
truecolor = true
force_emoji = true
separator = ""
separator_thin = ""
STATUSLINE_CONFIG
ok "Cyberpunk config reference created"

# Configure settings.json to use our script
status "Configuring Statusline in settings.json"

if [ ! -f "$CLAUDE_SETTINGS" ]; then
    mkdir -p "$HOME/.claude"
    echo '{}' > "$CLAUDE_SETTINGS"
fi

node -e "
const fs = require('fs');
const settings = JSON.parse(fs.readFileSync('$CLAUDE_SETTINGS', 'utf8'));
settings.statusLine = {
    type: 'command',
    command: '$STATUSLINE_SCRIPT',
    padding: 0
};
fs.writeFileSync('$CLAUDE_SETTINGS', JSON.stringify(settings, null, 2));
" 2>/dev/null && ok "Statusline configured in settings.json" || warn "settings.json config failed"

echo ""
info "ULTIMATE CYBERPUNK STATUSLINE - 15+ COMPONENTS ON 3 LINES"
info "LINE 1: 📁 Project │ 🤖 Model │ 🌿 Branch │ 📟 Version │ 🎨 Style"
info "LINE 2: 📊 Tokens │ 🧠 Context Bar │ 💾 Cache │ 💰 Cost │ 🔥 Burn"
info "LINE 3: ➕ Added │ ➖ Removed │ 📂 Git │ 🌳 Worktree │ 🔌 MCP │ ✅"
info "Elapsed: $(elapsed)"

# ============================================
# STEP 11: Workspace setup (LEAN)
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
# STEP 12: Codex + prd2build (UNIQUE)
# ============================================
step_header "Configuring Codex & prd2build"

mkdir -p "$HOME/.claude/commands" "$HOME/.codex" 2>/dev/null

# prd2build command
PRD2BUILD_SOURCE="$DEVPOD_DIR/context/prd2build.md"
checking "prd2build command"
if [ -f "$HOME/.claude/commands/prd2build.md" ]; then
    skip "prd2build command"
elif [ -f "$PRD2BUILD_SOURCE" ]; then
    cp "$PRD2BUILD_SOURCE" "$HOME/.claude/commands/prd2build.md"
    ok "prd2build command installed"
else
    warn "prd2build.md not found at $PRD2BUILD_SOURCE"
fi

# Codex instructions
CODEX_INSTRUCTIONS_SOURCE="$DEVPOD_DIR/context/codex_claude.md"
checking "Codex instructions"
if [ -f "$HOME/.codex/instructions.md" ]; then
    skip "Codex instructions"
elif [ -f "$CODEX_INSTRUCTIONS_SOURCE" ]; then
    cp "$CODEX_INSTRUCTIONS_SOURCE" "$HOME/.codex/instructions.md"
    ok "Codex instructions installed"
else
    warn "codex_claude.md not found"
fi

# AGENTS.md
checking "AGENTS.md"
if [ -f "$WORKSPACE_FOLDER/AGENTS.md" ]; then
    skip "AGENTS.md"
else
    cat > "$WORKSPACE_FOLDER/AGENTS.md" << 'AGENTS_EOF'
# Codex & Claude Code Collaboration Protocol

## Task Allocation

| Task Type | Codex | Claude Code |
|-----------|-------|-------------|
| Code changes, tests, refactors | ✅ | ❌ |
| Build, lint, format, migrate | ✅ | ❌ |
| GitHub PRs, CI/CD admin | ❌ | ✅ |
| Secrets, tokens, vault | ❌ | ✅ |
| Multi-repo coordination | ❌ | ✅ |
AGENTS_EOF
    ok "AGENTS.md created"
fi

if has_cmd codex; then
    info "Codex installed - run 'codex login' to authenticate"
else
    info "Codex not installed (optional): npm install -g @openai/codex"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 13: Bash aliases (UNIQUE - ENHANCED)
# ============================================
step_header "Installing bash aliases"

checking "TURBO FLOW aliases"
if grep -q "TURBO FLOW v3.1.0 LEAN" ~/.bashrc 2>/dev/null; then
    skip "Bash aliases already installed"
else
    # Remove old versions
    sed -i '/# === TURBO FLOW/,/# === END TURBO FLOW/d' ~/.bashrc 2>/dev/null || true
    
    cat << 'ALIASES_EOF' >> ~/.bashrc

# === TURBO FLOW v3.1.0 LEAN ===

# RUVECTOR
alias ruv="npx ruvector"
alias ruv-stats="npx @ruvector/cli hooks stats"
alias ruv-route="npx @ruvector/cli hooks route"
alias ruv-remember="npx @ruvector/cli hooks remember"
alias ruv-recall="npx @ruvector/cli hooks recall"
alias ruv-learn="npx @ruvector/cli hooks learn"
alias ruv-init="npx @ruvector/cli hooks init"

# RUVECTOR VISUALIZATION
alias ruv-viz="cd ~/.claude/skills/rUv_helpers/claude-flow-ruvector-visualization && node server.js &"
alias ruv-viz-stop="pkill -f 'node server.js' 2>/dev/null; echo 'Visualization stopped'"

# CLAUDE CODE
alias dsp="claude --dangerously-skip-permissions"

# CLAUDE FLOW V3
alias cf="npx -y claude-flow@alpha"
alias cf-init="npx -y claude-flow@alpha init --force"
alias cf-wizard="npx -y claude-flow@alpha init --wizard"
alias cf-swarm="npx -y claude-flow@alpha swarm init --topology hierarchical"
alias cf-mesh="npx -y claude-flow@alpha swarm init --topology mesh"
alias cf-agent="npx -y claude-flow@alpha --agent"
alias cf-list="npx -y claude-flow@alpha --list"
alias cf-daemon="npx -y claude-flow@alpha daemon start"
alias cf-memory="npx -y claude-flow@alpha memory"
alias cf-doctor="npx -y claude-flow@alpha doctor"
alias cf-mcp="npx -y claude-flow@alpha mcp start"

# AGENTIC QE
alias aqe="npx -y agentic-qe"
alias aqe-generate="npx -y agentic-qe generate"
alias aqe-gate="npx -y agentic-qe gate"

# CLAUDE FLOW BROWSER (59 MCP tools via claude-flow - no extra install)
# These work when cf-mcp is running
alias cfb-open="npx -y claude-flow@alpha mcp call browser/open"
alias cfb-snap="npx -y claude-flow@alpha mcp call browser/snapshot"
alias cfb-click="npx -y claude-flow@alpha mcp call browser/click"
alias cfb-fill="npx -y claude-flow@alpha mcp call browser/fill"
alias cfb-trajectory="npx -y claude-flow@alpha mcp call browser/trajectory-start"
alias cfb-learn="npx -y claude-flow@alpha mcp call browser/trajectory-save"

# OPENSPEC
alias os="openspec"
alias os-init="openspec init"

# CODEX
alias codex-login="codex login"
alias codex-run="codex exec -p claude"

# WORKTREE MANAGER
alias wt-status="claude 'What is the status of my worktrees?'"
alias wt-clean="claude 'Clean up completed worktrees'"
alias wt-create="claude 'Create a worktree for'"

# DEPLOYMENT
alias deploy="claude 'Deploy this app'"
alias deploy-preview="claude 'Deploy and give me the preview URL'"

# HOOKS INTELLIGENCE
alias hooks-pre="npx -y claude-flow@alpha hooks pre-edit"
alias hooks-post="npx -y claude-flow@alpha hooks post-edit"
alias hooks-train="npx -y claude-flow@alpha hooks pretrain --depth deep"
alias hooks-intel="npx -y claude-flow@alpha hooks intelligence --status"
alias hooks-route="npx -y claude-flow@alpha hooks route"

# MEMORY VECTOR OPERATIONS
alias mem-search="npx -y claude-flow@alpha memory search"
alias mem-vsearch="npx -y claude-flow@alpha memory vector-search"
alias mem-vstore="npx -y claude-flow@alpha memory store-vector"
alias mem-store="npx -y claude-flow@alpha memory store"
alias mem-stats="npx -y claude-flow@alpha memory stats"
alias mem-hnsw="npx -y claude-flow@alpha memory search --build-hnsw"

# NEURAL OPERATIONS
alias neural-train="npx -y claude-flow@alpha neural train"
alias neural-status="npx -y claude-flow@alpha neural status"
alias neural-patterns="npx -y claude-flow@alpha neural patterns"
alias neural-predict="npx -y claude-flow@alpha neural predict"

# AGENTDB
alias agentdb="npx -y agentdb"
alias agentdb-init="npx -y agentdb init"
alias agentdb-stats="npx -y agentdb stats"
alias agentdb-mcp="npx -y agentdb mcp"

# STATUS HELPERS
turbo-status() {
    echo "📊 Turbo Flow v3.1.0 (Lean) Status"
    echo "────────────────────────────────────"
    echo ""
    echo "Core:"
    echo "  Node.js:       $(node -v 2>/dev/null || echo 'not found')"
    echo "  RuVector:      $(npm list -g ruvector --depth=0 2>/dev/null | grep ruvector | head -1 || npx ruvector --version 2>/dev/null || echo 'not found')"
    echo "  Claude Code:   $(claude --version 2>/dev/null | head -1 || echo 'not found')"
    echo "  Claude Flow:   $(npx -y claude-flow@alpha --version 2>/dev/null | head -1 || echo 'not found')"
    echo "  AgentDB:       $(npm list -g agentdb --depth=0 2>/dev/null | grep agentdb | head -1 || echo 'not installed')"
    echo "  Codex:         $(command -v codex >/dev/null && codex --version 2>/dev/null || echo 'not installed')"
    echo ""
    echo "Skills:"
    local uipro_status="❌"
    if [ -d ~/.claude/skills/ui-ux-pro-max ] && [ -n "$(ls -A ~/.claude/skills/ui-ux-pro-max 2>/dev/null)" ]; then
        uipro_status="✅"
    fi
    echo "  prd2build:       $([ -f ~/.claude/commands/prd2build.md ] && echo '✅' || echo '❌')"
    echo "  Security:        $([ -d ~/.claude/skills/security-analyzer ] && echo '✅' || echo '❌')"
    echo "  UI Pro Max:      $uipro_status"
    echo "  Worktree Mgr:    $([ -f ~/.claude/skills/worktree-manager/SKILL.md ] && echo '✅' || echo '❌')"
    echo "  Vercel Deploy:   $([ -f ~/.claude/skills/vercel-deploy/SKILL.md ] && echo '✅' || echo '❌')"
    echo "  RuV Viz:         $([ -d ~/.claude/skills/rUv_helpers ] && echo '✅' || echo '❌')"
    echo ""
    local statusline_status="❌"
    if [ -f ~/.claude/turbo-flow-statusline.sh ] && [ -x ~/.claude/turbo-flow-statusline.sh ]; then
        statusline_status="✅ Configured"
    fi
    echo "Statusline:        $statusline_status"
}

turbo-help() {
    echo "🚀 Turbo Flow v3.1.0 (Lean) Quick Reference"
    echo "─────────────────────────────────────────────"
    echo ""
    echo "RUVECTOR:     ruv, ruv-stats, ruv-route, ruv-remember, ruv-recall"
    echo "              ruv-viz (start 3D visualization)"
    echo ""
    echo "CLAUDE FLOW:  cf-init, cf-wizard, cf-swarm, cf-mesh, cf-doctor"
    echo ""
    echo "BROWSER (MCP): cfb-open, cfb-snap, cfb-click, cfb-fill"
    echo "               cfb-trajectory (start), cfb-learn (save pattern)"
    echo ""
    echo "TESTING:      aqe-generate, aqe-gate"
    echo ""
    echo "WORKTREE:     wt-status, wt-clean, wt-create"
    echo ""
    echo "DEPLOY:       deploy, deploy-preview"
    echo ""
    echo "HOOKS:        hooks-pre, hooks-post, hooks-train, hooks-intel"
    echo ""
    echo "MEMORY:       mem-search, mem-vsearch, mem-vstore, mem-stats"
    echo ""
    echo "NEURAL:       neural-train, neural-status, neural-patterns"
    echo ""
    echo "AGENTDB:      agentdb, agentdb-init, agentdb-stats, agentdb-mcp"
    echo ""
    echo "STATUS:       turbo-status, turbo-help"
}

export PATH="$HOME/.claude/bin:$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"
# Also include npm global prefix if set
[ -n "$npm_config_prefix" ] && export PATH="$npm_config_prefix/bin:$PATH"

# === END TURBO FLOW v3.1.0 LEAN ===

ALIASES_EOF
    ok "Bash aliases installed"
fi

info "Elapsed: $(elapsed)"

# ============================================
# COMPLETE
# ============================================
END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))

# Status checks
CF_STATUS="❌"; [ -d "$WORKSPACE_FOLDER/.claude-flow" ] && CF_STATUS="✅"
CLAUDE_STATUS="❌"; has_cmd claude && CLAUDE_STATUS="✅"
RUV_STATUS="❌"; is_npm_installed "ruvector" && RUV_STATUS="✅"
PRD2BUILD_STATUS="❌"; [ -f "$HOME/.claude/commands/prd2build.md" ] && PRD2BUILD_STATUS="✅"
SEC_STATUS="❌"; skill_has_content "$HOME/.claude/skills/security-analyzer" && SEC_STATUS="✅"
UIPRO_STATUS="❌"; (skill_has_content "$HOME/.claude/skills/ui-ux-pro-max" || skill_has_content "$WORKSPACE_FOLDER/.claude/skills/ui-ux-pro-max") && UIPRO_STATUS="✅"
WORKTREE_STATUS="❌"; skill_has_content "$HOME/.claude/skills/worktree-manager" && WORKTREE_STATUS="✅"
VERCEL_STATUS="❌"; skill_has_content "$HOME/.claude/skills/vercel-deploy" && VERCEL_STATUS="✅"
RUVIZ_STATUS="❌"; skill_has_content "$HOME/.claude/skills/rUv_helpers" && RUVIZ_STATUS="✅"
STATUSLINE_STATUS="❌"; [ -f ~/.claude/turbo-flow-statusline.sh ] && [ -x ~/.claude/turbo-flow-statusline.sh ] && STATUSLINE_STATUS="✅"
CODEX_STATUS="❌"; [ -f "$HOME/.codex/instructions.md" ] && CODEX_STATUS="✅"
AGENTS_STATUS="❌"; [ -f "$WORKSPACE_FOLDER/AGENTS.md" ] && AGENTS_STATUS="✅"

echo ""
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║   🎉 TURBO FLOW v3.1.0 (LEAN) SETUP COMPLETE!               ║"
echo "║   Core + Skills + Visualization + Statusline                ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
progress_bar 100
echo ""
echo ""
echo "  ┌──────────────────────────────────────────────────┐"
echo "  │  📊 SUMMARY                                      │"
echo "  ├──────────────────────────────────────────────────┤"
echo "  │  CORE                                            │"
echo "  │  $RUV_STATUS RuVector Neural Engine                   │"
echo "  │  $CLAUDE_STATUS Claude Code                              │"
echo "  │  $CF_STATUS Claude Flow V3                            │"
echo "  │                                                  │"
echo "  │  SKILLS                                          │"
echo "  │  $PRD2BUILD_STATUS prd2build command                      │"
echo "  │  $SEC_STATUS Security Analyzer                         │"
echo "  │  $UIPRO_STATUS UI UX Pro Max                           │"
echo "  │  $WORKTREE_STATUS Worktree Manager                      │"
echo "  │  $VERCEL_STATUS Vercel Deploy                          │"
echo "  │  $RUVIZ_STATUS RuV Visualization                       │"
echo "  │                                                  │"
echo "  │  CONFIG                                          │"
echo "  │  $STATUSLINE_STATUS Statusline Pro                        │"
echo "  │  $CODEX_STATUS Codex config                            │"
echo "  │  $AGENTS_STATUS AGENTS.md                                │"
echo "  │                                                  │"
echo "  │  ⏱️  ${TOTAL_TIME}s                                        │"
echo "  └──────────────────────────────────────────────────┘"
echo ""
echo "  📌 QUICK START:"
echo "  ───────────────"
echo "  1. source ~/.bashrc"
echo "  2. turbo-status"
echo "  3. turbo-help"
echo ""
echo "  🚀 Happy coding!"
echo ""
