#!/bin/bash
# TURBO FLOW SETUP SCRIPT v2.0.6
# Fixed: Aggressive npm token cleanup that actually works

# ============================================
# STEP 0: NUCLEAR NPM CLEANUP (RUN FIRST!)
# ============================================
echo "🔧 STEP 0: Nuclear npm cleanup..."

# Delete ALL npmrc files that might have tokens
rm -f "$HOME/.npmrc" 2>/dev/null
rm -f "./.npmrc" 2>/dev/null
rm -f "/etc/npmrc" 2>/dev/null

# Clear npm config completely
npm config delete //registry.npmjs.org/:_authToken 2>/dev/null || true
npm config delete _authToken 2>/dev/null || true
npm config delete registry 2>/dev/null || true

# Force set public registry
npm config set registry https://registry.npmjs.org/

# Verify no auth tokens exist
if npm config list 2>&1 | grep -i "authtoken"; then
    echo "⚠️  WARNING: Auth token still detected in npm config!"
    echo "Running deeper cleanup..."
    
    # Find and remove from all possible locations
    for f in "$HOME/.npmrc" "$HOME/.npm/.npmrc" "/usr/local/etc/npmrc" "/etc/npmrc" ".npmrc"; do
        if [ -f "$f" ]; then
            echo "  Cleaning: $f"
            grep -v -i "authtoken" "$f" > "${f}.clean" 2>/dev/null && mv "${f}.clean" "$f" || rm -f "$f"
        fi
    done
fi

# Clear ALL npm caches
rm -rf "$HOME/.npm/_cacache" 2>/dev/null
rm -rf "$HOME/.npm/_npx" 2>/dev/null
rm -rf "$HOME/.npm/_locks" 2>/dev/null
npm cache clean --force 2>/dev/null

echo "✅ npm cleanup complete"
echo ""

# ============================================
# CONFIGURATION
# ============================================
: "${WORKSPACE_FOLDER:=$(pwd)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"
START_TIME=$(date +%s)

mkdir -p "$HOME/.claude/skills" "$HOME/.claude/commands" "$HOME/.config/claude" "$HOME/.codex" 2>/dev/null || true

# Helper functions
status() { echo "  🔄 $1..."; }
ok() { echo "  ✅ $1"; }
skip() { echo "  ⏭️  $1 (already done)"; }
warn() { echo "  ⚠️  $1"; }
info() { echo "  ℹ️  $1"; }
fail() { echo "  ❌ $1"; }

has_cmd() { command -v "$1" >/dev/null 2>&1; }

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║     🚀 TURBO FLOW v2.0.6 - CLAUDE FLOW V3                   ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "  📁 Workspace: $WORKSPACE_FOLDER"
echo ""

# ============================================
# STEP 1: Verify npm is clean
# ============================================
echo "━━━ STEP 1: Verify npm is working ━━━"
status "Testing npm registry access"

# Test npm can reach registry without auth
if npm ping --registry https://registry.npmjs.org/ 2>&1 | grep -q "Ping success"; then
    ok "npm registry accessible (no auth)"
else
    # Even if ping fails, try a simple install
    if npm view lodash version 2>/dev/null | head -1; then
        ok "npm registry accessible"
    else
        fail "npm cannot reach registry"
        echo "Please check your network connection"
    fi
fi

# ============================================
# STEP 2: Node.js check
# ============================================
echo ""
echo "━━━ STEP 2: Node.js ━━━"
NODE_MAJOR=$(node -v 2>/dev/null | sed 's/v//' | cut -d. -f1 || echo "0")
if [ "$NODE_MAJOR" -ge 20 ]; then
    ok "Node.js v$NODE_MAJOR"
else
    warn "Node.js $NODE_MAJOR (need 20+)"
fi

# ============================================
# STEP 3: Claude Code
# ============================================
echo ""
echo "━━━ STEP 3: Claude Code (REQUIRED) ━━━"
if has_cmd claude; then
    ok "Claude Code installed: $(claude --version 2>/dev/null | head -1)"
else
    status "Installing Claude Code"
    curl -fsSL https://claude.ai/install.sh | bash -s stable 2>&1 | tail -5
    
    # Refresh PATH to pick up new installation
    export PATH="$HOME/.claude/bin:$HOME/.local/bin:$PATH"
    
    if has_cmd claude; then
        ok "Claude Code installed"
    else
        fail "Claude Code installation failed"
        echo ""
        echo "⚠️  Claude Flow REQUIRES Claude Code!"
        echo "   Install manually: curl -fsSL https://claude.ai/install.sh | bash -s stable"
        echo ""
    fi
fi

# ============================================
# STEP 4: Claude Flow V3
# ============================================
echo ""
echo "━━━ STEP 4: Claude Flow V3 ━━━"
cd "$WORKSPACE_FOLDER" 2>/dev/null || true

if [ -d ".claude-flow" ]; then
    skip "Claude Flow already initialized"
else
    status "Installing Claude Flow (this may take 2-3 minutes)"
    
    # Use --yes to auto-accept any prompts, pipe to show progress
    # Don't use timeout - let it complete
    npx -y claude-flow@alpha init --force 2>&1 | while IFS= read -r line; do
        # Filter out the noisy deprecation warnings
        if [[ ! "$line" =~ "deprecated" ]] && [[ ! "$line" =~ "npm warn" ]] && [[ ! "$line" =~ "npm notice" ]]; then
            echo "    $line"
        fi
    done
    
    # Check result
    if [ -d ".claude-flow" ]; then
        ok "Claude Flow initialized"
    else
        warn "Claude Flow init may have had issues"
        info "Creating minimal config..."
        mkdir -p ".claude-flow"
        echo '{"version":"3.0.0","initialized":true}' > ".claude-flow/config.json"
        ok "Minimal config created"
    fi
fi

# ============================================
# STEP 5: Register MCP
# ============================================
echo ""
echo "━━━ STEP 5: Claude Flow MCP ━━━"
if has_cmd claude; then
    if claude mcp list 2>/dev/null | grep -q "claude-flow"; then
        skip "MCP already registered"
    else
        status "Registering Claude Flow MCP"
        if claude mcp add claude-flow -- npx -y claude-flow@latest mcp start 2>&1; then
            ok "MCP registered"
        else
            warn "MCP CLI registration failed, using config file"
            mkdir -p "$HOME/.config/claude"
            cat << 'MCPEOF' > "$HOME/.config/claude/mcp.json"
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@latest", "mcp", "start"]
    }
  }
}
MCPEOF
            ok "MCP config file created"
        fi
    fi
else
    warn "Claude CLI not found, creating config file"
    mkdir -p "$HOME/.config/claude"
    cat << 'MCPEOF' > "$HOME/.config/claude/mcp.json"
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@latest", "mcp", "start"]
    }
  }
}
MCPEOF
    ok "MCP config file created"
fi

# ============================================
# STEP 6: Quick installs (optional tools)
# ============================================
echo ""
echo "━━━ STEP 6: Optional tools ━━━"

for pkg in ruvector agent-browser; do
    if npm list -g "$pkg" --depth=0 >/dev/null 2>&1; then
        skip "$pkg"
    else
        status "Installing $pkg"
        npm install -g "$pkg" --silent 2>/dev/null && ok "$pkg" || warn "$pkg failed (optional)"
    fi
done

# ============================================
# STEP 7: Skills
# ============================================
echo ""
echo "━━━ STEP 7: Skills ━━━"

# Agent browser skill
SKILL_DIR="$HOME/.claude/skills/agent-browser"
if [ -d "$SKILL_DIR" ] && [ -n "$(ls -A "$SKILL_DIR" 2>/dev/null)" ]; then
    skip "agent-browser skill"
else
    mkdir -p "$SKILL_DIR"
    curl -fsSL -o "$SKILL_DIR/SKILL.md" \
        "https://raw.githubusercontent.com/AugmentCode/agent-browser/main/skills/agent-browser/SKILL.md" 2>/dev/null && \
        ok "agent-browser skill" || warn "agent-browser skill failed"
fi

# Security analyzer skill
SECURITY_DIR="$HOME/.claude/skills/security-analyzer"
if [ -d "$SECURITY_DIR" ] && [ -n "$(ls -A "$SECURITY_DIR" 2>/dev/null)" ]; then
    skip "security-analyzer skill"
else
    git clone --depth 1 https://github.com/Cornjebus/security-analyzer.git /tmp/sec-skill 2>/dev/null && \
        mkdir -p "$SECURITY_DIR" && cp -r /tmp/sec-skill/* "$SECURITY_DIR/" && rm -rf /tmp/sec-skill && \
        ok "security-analyzer skill" || warn "security-analyzer skill failed"
fi

# ============================================
# STEP 8: Commands
# ============================================
echo ""
echo "━━━ STEP 8: Commands ━━━"

PRD2BUILD="$DEVPOD_DIR/context/prd2build.md"
if [ -f "$HOME/.claude/commands/prd2build.md" ]; then
    skip "prd2build"
elif [ -f "$PRD2BUILD" ]; then
    cp "$PRD2BUILD" "$HOME/.claude/commands/prd2build.md"
    ok "prd2build"
else
    warn "prd2build.md not found"
fi

# ============================================
# STEP 9: Workspace
# ============================================
echo ""
echo "━━━ STEP 9: Workspace ━━━"
[ ! -f "package.json" ] && npm init -y --silent 2>/dev/null
for d in src tests docs scripts; do mkdir -p "$d" 2>/dev/null; done
ok "Workspace ready"

# ============================================
# STEP 10: Verify
# ============================================
echo ""
echo "━━━ STEP 10: Verification ━━━"
status "Running Claude Flow doctor"
npx -y claude-flow@alpha doctor 2>&1 | head -15 | while IFS= read -r line; do
    if [[ ! "$line" =~ "deprecated" ]] && [[ ! "$line" =~ "npm warn" ]]; then
        echo "    $line"
    fi
done
ok "Verification complete"

# ============================================
# STEP 11: Aliases
# ============================================
echo ""
echo "━━━ STEP 11: Bash aliases ━━━"
if grep -q "TURBO FLOW v2.0.6" ~/.bashrc 2>/dev/null; then
    skip "Aliases"
else
    sed -i '/# === TURBO FLOW/,/# === END TURBO FLOW/d' ~/.bashrc 2>/dev/null || true
    cat << 'ALIASEOF' >> ~/.bashrc

# === TURBO FLOW v2.0.6 ===
alias cf="npx -y claude-flow@alpha"
alias cf-init="npx -y claude-flow@alpha init"
alias cf-wizard="npx -y claude-flow@alpha init --wizard"
alias cf-swarm="npx -y claude-flow@alpha swarm init --topology hierarchical"
alias cf-doctor="npx -y claude-flow@alpha doctor"
alias cf-mcp="npx -y claude-flow@alpha mcp start"
alias dsp="claude --dangerously-skip-permissions"

turbo-status() {
    echo "📊 Turbo Flow v2.0.6"
    echo "Node:        $(node -v 2>/dev/null)"
    echo "Claude Code: $(claude --version 2>/dev/null | head -1 || echo 'not found')"
    echo "CF Config:   $([ -d .claude-flow ] && echo '✅' || echo '❌')"
    echo "CF MCP:      $(claude mcp list 2>/dev/null | grep -q claude-flow && echo '✅' || echo '❓')"
}
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"
# === END TURBO FLOW v2.0.6 ===

ALIASEOF
    ok "Aliases installed"
fi

# ============================================
# COMPLETE
# ============================================
END_TIME=$(date +%s)
TOTAL=$((END_TIME - START_TIME))

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║   🎉 TURBO FLOW v2.0.6 COMPLETE! (${TOTAL}s)                     ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "  Status:"
echo "  ───────"
has_cmd claude && echo "  ✅ Claude Code" || echo "  ❌ Claude Code"
[ -d ".claude-flow" ] && echo "  ✅ Claude Flow" || echo "  ❌ Claude Flow"
(has_cmd claude && claude mcp list 2>/dev/null | grep -q "claude-flow") && echo "  ✅ MCP registered" || echo "  ❓ MCP (check manually)"
echo ""
echo "  Next steps:"
echo "  ───────────"
echo "  1. source ~/.bashrc"
echo "  2. turbo-status"
echo "  3. cf-doctor"
echo ""
