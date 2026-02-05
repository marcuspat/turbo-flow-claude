#!/bin/bash
# TURBO FLOW SETUP SCRIPT v3.0.0
# Streamlined: Delegates core install to claude-flow, adds ecosystem extensions
# Claude Flow V3 + RuVector + Agent Browser + Security Analyzer + UI Pro Max + Codex

# ============================================
# CONFIGURATION
# ============================================
: "${WORKSPACE_FOLDER:=$(pwd)}"
: "${DEVPOD_WORKSPACE_FOLDER:=$WORKSPACE_FOLDER}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"
TOTAL_STEPS=10
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
        if npm install -g "$pkg" --silent --no-progress 2>/dev/null; then
            ok "$pkg installed"
            return 0
        else
            warn "$pkg install failed"
            return 1
        fi
    fi
}

# ============================================
# START
# ============================================
clear 2>/dev/null || true
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║     🚀 TURBO FLOW v3.0.0 - STREAMLINED INSTALLER            ║"
echo "║     Delegates to claude-flow • Adds ecosystem extensions    ║"
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
        (apt-get update -qq && apt-get install -y -qq build-essential python3 git curl) 2>/dev/null || \
        (sudo apt-get update -qq && sudo apt-get install -y -qq build-essential python3 git curl) 2>/dev/null || \
        warn "Could not install build tools"
        ok "build tools installed"
    elif has_cmd yum; then
        (yum groupinstall -y "Development Tools" || sudo yum groupinstall -y "Development Tools") 2>/dev/null
        ok "build tools installed (yum)"
    elif has_cmd apk; then
        apk add --no-cache build-base python3 git curl 2>/dev/null
        ok "build tools installed (apk)"
    else
        warn "Unknown package manager"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 2: Claude Flow V3 + RuVector (DELEGATED)
# Uses official installer which handles:
# - Node.js version check
# - Claude Code detection
# - RuVector installation
# - Claude Flow init
# - MCP registration
# - Doctor diagnostics
# ============================================
step_header "Installing Claude Flow V3 + RuVector (delegated)"

if [ -d "$WORKSPACE_FOLDER/.claude-flow" ] && has_cmd claude && is_npm_installed "ruvector"; then
    skip "Claude Flow + RuVector already installed"
else
    status "Running official claude-flow installer (--full mode)"
    echo ""
    
    # The --full flag does: global install + MCP setup + diagnostics
    curl -fsSL https://cdn.jsdelivr.net/gh/ruvnet/claude-flow@main/scripts/install.sh | bash -s -- --full 2>&1 | while IFS= read -r line; do
        # Pass through output but filter noise
        if [[ ! "$line" =~ "deprecated" ]] && [[ ! "$line" =~ "npm warn" ]]; then
            echo "    $line"
        fi
    done
    
    # Initialize in workspace if not done
    cd "$WORKSPACE_FOLDER" 2>/dev/null || true
    if [ ! -d ".claude-flow" ]; then
        status "Initializing Claude Flow in workspace"
        npx -y claude-flow@alpha init --force 2>/dev/null
    fi
    
    # Ensure RuVector hooks are initialized
    status "Ensuring RuVector hooks"
    npx @ruvector/cli hooks init 2>/dev/null || true
    
    ok "Claude Flow + RuVector installed"
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 3: Ecosystem npm packages (UNIQUE)
# ============================================
step_header "Installing ecosystem packages"

install_npm agentic-qe
install_npm @fission-ai/openspec
install_npm uipro-cli
install_npm agent-browser
install_npm @claude-flow/browser
install_npm @ruvector/ruvllm

info "Elapsed: $(elapsed)"

# ============================================
# STEP 4: Agent Browser Setup (UNIQUE)
# ============================================
step_header "Setting up Agent Browser"

checking "Chromium for agent-browser"
if has_cmd agent-browser; then
    status "Installing Chromium and dependencies"
    agent-browser install --with-deps 2>/dev/null && ok "Chromium installed" || warn "Chromium install failed"
else
    warn "agent-browser not available"
fi

AGENT_BROWSER_SKILL_DIR="$HOME/.claude/skills/agent-browser"
mkdir -p "$HOME/.claude/skills" 2>/dev/null

checking "agent-browser skill"
if skill_has_content "$AGENT_BROWSER_SKILL_DIR"; then
    skip "agent-browser skill already installed"
else
    mkdir -p "$AGENT_BROWSER_SKILL_DIR"
    NPM_GLOBAL="$(npm root -g 2>/dev/null)"
    if [ -f "$NPM_GLOBAL/agent-browser/skills/agent-browser/SKILL.md" ]; then
        cp -r "$NPM_GLOBAL/agent-browser/skills/agent-browser/"* "$AGENT_BROWSER_SKILL_DIR/"
        ok "agent-browser skill installed"
    else
        curl -fsSL -o "$AGENT_BROWSER_SKILL_DIR/SKILL.md" \
            "https://raw.githubusercontent.com/AugmentCode/agent-browser/main/skills/agent-browser/SKILL.md" 2>/dev/null && \
            ok "agent-browser skill installed (from GitHub)" || warn "agent-browser skill install failed"
    fi
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
# STEP 6: uv + Spec-Kit (UNIQUE)
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

checking "specify CLI"
if has_cmd specify; then
    skip "specify CLI"
else
    if has_cmd uv; then
        uv tool install specify-cli --from git+https://github.com/github/spec-kit.git 2>/dev/null && \
            ok "specify-cli installed" || warn "specify-cli failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 7: UI UX Pro Max Skill (UNIQUE)
# ============================================
step_header "Installing UI UX Pro Max Skill"

UIPRO_SKILL_DIR="$HOME/.claude/skills/ui-ux-pro-max"
UIPRO_SKILL_DIR_LOCAL="$WORKSPACE_FOLDER/.claude/skills/ui-ux-pro-max"

checking "UI UX Pro Max skill"
if skill_has_content "$UIPRO_SKILL_DIR" || skill_has_content "$UIPRO_SKILL_DIR_LOCAL"; then
    skip "UI UX Pro Max skill already installed"
else
    # Clean up empty directories from failed installs
    [ -d "$UIPRO_SKILL_DIR" ] && [ -z "$(ls -A "$UIPRO_SKILL_DIR" 2>/dev/null)" ] && rm -rf "$UIPRO_SKILL_DIR"
    [ -d "$UIPRO_SKILL_DIR_LOCAL" ] && [ -z "$(ls -A "$UIPRO_SKILL_DIR_LOCAL" 2>/dev/null)" ] && rm -rf "$UIPRO_SKILL_DIR_LOCAL"
    
    status "Installing UI UX Pro Max skill"
    if has_cmd uipro; then
        uipro init --ai claude --offline 2>&1 | tail -3
    else
        npx -y uipro-cli init --ai claude --offline 2>&1 | tail -3
    fi
    
    if skill_has_content "$UIPRO_SKILL_DIR" || skill_has_content "$UIPRO_SKILL_DIR_LOCAL"; then
        ok "UI UX Pro Max skill installed"
    else
        warn "UI UX Pro Max skill may be incomplete"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# STEP 8: Workspace + HeroUI (UNIQUE frontend stack)
# ============================================
step_header "Setting up workspace with HeroUI"

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
    npm install @heroui/react framer-motion --save 2>&1 | tail -3
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
    
    [ -d "node_modules/@heroui" ] && ok "HeroUI installed" || warn "HeroUI installation incomplete"
fi

ok "Workspace configured"
info "Elapsed: $(elapsed)"

# ============================================
# STEP 9: Codex + prd2build (UNIQUE)
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
# STEP 10: Bash aliases (UNIQUE)
# ============================================
step_header "Installing bash aliases"

checking "TURBO FLOW aliases"
if grep -q "TURBO FLOW v3.0.0" ~/.bashrc 2>/dev/null; then
    skip "Bash aliases already installed"
else
    # Remove old versions
    sed -i '/# === TURBO FLOW/,/# === END TURBO FLOW/d' ~/.bashrc 2>/dev/null || true
    
    cat << 'ALIASES_EOF' >> ~/.bashrc

# === TURBO FLOW v3.0.0 (Streamlined) ===

# RUVECTOR
alias ruv="npx ruvector"
alias ruv-stats="npx @ruvector/cli hooks stats"
alias ruv-route="npx @ruvector/cli hooks route"
alias ruv-remember="npx @ruvector/cli hooks remember"
alias ruv-recall="npx @ruvector/cli hooks recall"
alias ruv-learn="npx @ruvector/cli hooks learn"
alias ruv-init="npx @ruvector/cli hooks init"

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

# STATUS HELPERS
turbo-status() {
    echo "📊 Turbo Flow v3.0.0 Status"
    echo "───────────────────────────"
    echo "Node.js:       $(node -v 2>/dev/null || echo 'not found')"
    echo "RuVector:      $(npx ruvector --version 2>/dev/null || echo 'not found')"
    echo "Claude Code:   $(claude --version 2>/dev/null | head -1 || echo 'not found')"
    echo "Claude Flow:   $(npx -y claude-flow@alpha --version 2>/dev/null | head -1 || echo 'not found')"
    echo "Codex:         $(command -v codex >/dev/null && codex --version 2>/dev/null || echo 'not installed')"
    echo "prd2build:     $([ -f ~/.claude/commands/prd2build.md ] && echo '✅' || echo '❌')"
    echo "Agent-Browser: $([ -d ~/.claude/skills/agent-browser ] && echo '✅' || echo '❌')"
    echo "Security:      $([ -d ~/.claude/skills/security-analyzer ] && echo '✅' || echo '❌')"
    echo "UI Pro Max:    $([ -d ~/.claude/skills/ui-ux-pro-max ] && [ -n \"\$(ls -A ~/.claude/skills/ui-ux-pro-max 2>/dev/null)\" ] && echo '✅' || echo '❌')"
    echo "HeroUI:        $([ -d node_modules/@heroui ] && echo '✅' || echo '❌')"
}

turbo-help() {
    echo "🚀 Turbo Flow v3.0.0 Quick Reference"
    echo "────────────────────────────────────"
    echo ""
    echo "RUVECTOR:  ruv, ruv-stats, ruv-route, ruv-remember, ruv-recall"
    echo "CLAUDE:    cf-init, cf-wizard, cf-swarm, cf-mesh, cf-doctor"
    echo "BROWSER:   ab-open <url>, ab-snap, ab-click, ab-fill, ab-close"
    echo "TESTING:   aqe-generate, aqe-gate"
    echo "STATUS:    turbo-status, turbo-help"
}

export PATH="$HOME/.claude/bin:$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"

# === END TURBO FLOW v3.0.0 ===

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
AB_STATUS="❌"; skill_has_content "$HOME/.claude/skills/agent-browser" && AB_STATUS="✅"
SEC_STATUS="❌"; skill_has_content "$HOME/.claude/skills/security-analyzer" && SEC_STATUS="✅"
UIPRO_STATUS="❌"; (skill_has_content "$HOME/.claude/skills/ui-ux-pro-max" || skill_has_content "$WORKSPACE_FOLDER/.claude/skills/ui-ux-pro-max") && UIPRO_STATUS="✅"
HEROUI_STATUS="❌"; [ -d "$WORKSPACE_FOLDER/node_modules/@heroui" ] && HEROUI_STATUS="✅"
CODEX_STATUS="❌"; [ -f "$HOME/.codex/instructions.md" ] && CODEX_STATUS="✅"
AGENTS_STATUS="❌"; [ -f "$WORKSPACE_FOLDER/AGENTS.md" ] && AGENTS_STATUS="✅"

echo ""
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║   🎉 TURBO FLOW v3.0.0 SETUP COMPLETE!                      ║"
echo "║   Streamlined: Core delegated, extensions added             ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
progress_bar 100
echo ""
echo ""
echo "  ┌──────────────────────────────────────────────────┐"
echo "  │  📊 SUMMARY                                      │"
echo "  ├──────────────────────────────────────────────────┤"
echo "  │  $RUV_STATUS RuVector Neural Engine                   │"
echo "  │  $CLAUDE_STATUS Claude Code                              │"
echo "  │  $CF_STATUS Claude Flow V3                            │"
echo "  │  $PRD2BUILD_STATUS prd2build command                      │"
echo "  │  $AB_STATUS Agent Browser                            │"
echo "  │  $SEC_STATUS Security Analyzer                         │"
echo "  │  $UIPRO_STATUS UI UX Pro Max                           │"
echo "  │  $HEROUI_STATUS HeroUI + Tailwind                        │"
echo "  │  $CODEX_STATUS Codex config                            │"
echo "  │  $AGENTS_STATUS AGENTS.md                                │"
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
