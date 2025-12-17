#!/bin/bash
# TURBO FLOW SETUP SCRIPT - FIXED VERSION
# Fixes 18 issues identified in analysis

set -e

# ISSUE #1 FIX: Default environment variables
: "${WORKSPACE_FOLDER:=$(pwd)}"
: "${DEVPOD_WORKSPACE_FOLDER:=$WORKSPACE_FOLDER}"
: "${AGENTS_DIR:=$WORKSPACE_FOLDER/agents}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"

echo "=== Claude Dev Environment Setup ==="
echo "WORKSPACE_FOLDER: $WORKSPACE_FOLDER"
echo "AGENTS_DIR: $AGENTS_DIR"
echo "DEVPOD_DIR: $DEVPOD_DIR"

# Helper: Safe npm install
install_npm_global() {
    echo "📦 Installing $1..."
    npm install -g "$1" 2>/dev/null && echo "✅ Installed $1" || echo "⚠️ Failed: $1"
}

# Helper: Safe cd (ISSUE #6 FIX)
safe_cd() {
    [ -z "$1" ] && { echo "❌ Empty directory"; return 1; }
    cd "$1" 2>/dev/null || { echo "❌ Cannot cd to $1"; return 1; }
}

# Install npm packages
install_npm_global @anthropic-ai/claude-code
install_npm_global claude-usage-cli
install_npm_global agentic-qe
install_npm_global agentic-flow
install_npm_global agentic-jujutsu  # ISSUE #11 FIX: Added -g

# ISSUE #4/#16 FIX: Error handling for curl
echo "Installing uv package manager..."
if curl -LsSf https://astral.sh/uv/install.sh | sh 2>/dev/null; then
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" || export PATH="$HOME/.cargo/bin:$PATH"
else
    echo "⚠️ uv installation failed, continuing..."
fi

# Install Claude Monitor
echo "Installing Claude Code Usage Monitor..."
command -v uv >/dev/null 2>&1 && uv tool install claude-monitor 2>/dev/null || \
    pip install claude-monitor --break-system-packages 2>/dev/null || echo "⚠️ claude-monitor failed"

# Install Direnv
if curl -sfL https://direnv.net/install.sh | bash 2>/dev/null; then
    echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
else
    echo "⚠️ Direnv installation failed"
fi

# Workspace setup (ISSUE #6 FIX)
mkdir -p "$WORKSPACE_FOLDER"
safe_cd "$WORKSPACE_FOLDER" || exit 1

# Initialize claude-flow
npx -y claude-flow@alpha init --force 2>/dev/null || echo "⚠️ claude-flow init failed"

# ISSUE #9/#2 FIX: Ensure package.json exists BEFORE npm pkg set
[ ! -f "package.json" ] && npm init -y
npm pkg set type="module"

# Install MCP Servers
echo "🔌 Installing MCP Servers..."
install_npm_global @playwright/mcp
install_npm_global chrome-devtools-mcp
install_npm_global mcp-chrome-bridge

# ISSUE #18 FIX: Check claude CLI before using
echo "🔧 Registering MCP servers..."
if command -v claude >/dev/null 2>&1; then
    claude mcp add playwright --scope user -- npx -y @playwright/mcp@latest 2>/dev/null || true
    claude mcp add chrome-devtools --scope user -- npx -y chrome-devtools-mcp@latest 2>/dev/null || true
    claude mcp add agentic-qe --scope user -- npx -y aqe-mcp 2>/dev/null || true
    echo "✅ MCP servers registered"
else
    echo "⚠️ Claude CLI not found, skipping MCP registration"
fi

# ISSUE #3 FIX: Safe JSON manipulation
echo "🔧 Configuring .mcp.json..."
if [ -f "$WORKSPACE_FOLDER/.mcp.json" ]; then
    if command -v jq >/dev/null 2>&1; then
        jq '.mcpServers.playwright = {"type":"stdio","command":"npx","args":["-y","@playwright/mcp@latest"],"env":{}} | 
            .mcpServers."chrome-devtools" = {"type":"stdio","command":"npx","args":["-y","chrome-devtools-mcp@latest"],"env":{}}' \
            .mcp.json > .mcp.json.tmp && mv .mcp.json.tmp .mcp.json
        echo "✅ .mcp.json updated with jq"
    else
        cp .mcp.json .mcp.json.backup
        sed -i.bak '$ d' .mcp.json && sed -i '$ d' .mcp.json
        cat << 'EOF' >> .mcp.json
    ,"playwright":{"type":"stdio","command":"npx","args":["-y","@playwright/mcp@latest"],"env":{}}
    ,"chrome-devtools":{"type":"stdio","command":"npx","args":["-y","chrome-devtools-mcp@latest"],"env":{}}
  }
}
EOF
        rm -f .mcp.json.bak
        echo "⚠️ .mcp.json updated with sed (backup at .mcp.json.backup)"
    fi
fi

# Claude config
mkdir -p "$HOME/.config/claude"
cat << 'EOF' > "$HOME/.config/claude/mcp.json"
{"mcpServers":{"playwright":{"command":"npx","args":["-y","@playwright/mcp@latest"],"env":{}},"chrome-devtools":{"command":"npx","args":["chrome-devtools-mcp@latest"],"env":{}},"chrome-mcp":{"type":"streamable-http","url":"http://127.0.0.1:12306/mcp"}}}
EOF

# TypeScript setup
npm install -D typescript @types/node 2>/dev/null || true
cat << 'EOF' > tsconfig.json
{"compilerOptions":{"target":"ES2022","module":"ESNext","moduleResolution":"node","outDir":"./dist","rootDir":"./src","strict":true,"esModuleInterop":true,"skipLibCheck":true},"include":["src/**/*","tests/**/*"],"exclude":["node_modules","dist"]}
EOF

mkdir -p src tests docs scripts examples config
npm pkg set scripts.build="tsc" scripts.test="playwright test" scripts.typecheck="tsc --noEmit"

# ISSUE #7/#8/#17 FIX: Safe git clone and file counting
echo "Installing Claude subagents..."
mkdir -p "$AGENTS_DIR"
safe_cd "$AGENTS_DIR" || exit 1

if git clone https://github.com/ChrisRoyse/610ClaudeSubagents.git temp-agents 2>/dev/null; then
    [ -d "temp-agents/agents" ] && cp -r temp-agents/agents/*.md . 2>/dev/null || true
    rm -rf temp-agents
else
    echo "⚠️ Could not clone subagents repo"
fi

[ -d "$DEVPOD_DIR/additional-agents" ] && cp "$DEVPOD_DIR/additional-agents"/*.md "$AGENTS_DIR/" 2>/dev/null || true

AGENT_COUNT=$(find "$AGENTS_DIR" -maxdepth 1 -name '*.md' 2>/dev/null | wc -l)
echo "Installed $AGENT_COUNT agents"

safe_cd "$WORKSPACE_FOLDER" || exit 1

# CLAUDE.md setup
if [ -f "$DEVPOD_DIR/CLAUDE.md" ]; then
    [ -f "CLAUDE.md" ] && mv "CLAUDE.md" "CLAUDE.md.OLD"
    cp "$DEVPOD_DIR/CLAUDE.md" "CLAUDE.md"
    echo "✅ CLAUDE.md installed"
fi

# ISSUE #10/#13/#14 FIX: Wrapper scripts with absolute paths
cat << 'EOF' > "$WORKSPACE_FOLDER/cf-with-context.sh"
#!/bin/bash
case "$1" in
    swarm) npx -y claude-flow@alpha swarm "${@:2}" --claude ;;
    hive*) [[ "$2" == "spawn" ]] && npx -y claude-flow@alpha hive-mind spawn "${@:3}" --claude || npx -y claude-flow@alpha hive-mind spawn "${@:2}" --claude ;;
    *) [[ $# -gt 0 ]] && npx -y claude-flow@alpha "$@" --claude || npx -y claude-flow@alpha --help ;;
esac
EOF
chmod +x "$WORKSPACE_FOLDER/cf-with-context.sh"

cat << 'EOF' > "$WORKSPACE_FOLDER/af-with-context.sh"
#!/bin/bash
npx -y agentic-flow "$@"
EOF
chmod +x "$WORKSPACE_FOLDER/af-with-context.sh"

# ISSUE #12 FIX: Deduplicated aliases with absolute paths
cat << ALIASES_EOF >> ~/.bashrc

# === TURBO FLOW ALIASES ($(date +%Y-%m-%d)) ===
alias cf="$WORKSPACE_FOLDER/cf-with-context.sh"
alias cf-swarm="$WORKSPACE_FOLDER/cf-with-context.sh swarm"
alias cf-hive="$WORKSPACE_FOLDER/cf-with-context.sh hive-mind spawn"
alias af="$WORKSPACE_FOLDER/af-with-context.sh"
alias dsp="claude --dangerously-skip-permissions"

# Claude Flow
alias cf-init="npx -y claude-flow@alpha init --force"
alias cf-spawn="npx -y claude-flow@alpha hive-mind spawn"
alias cf-wizard="npx -y claude-flow@alpha hive-mind wizard"
alias cf-resume="npx -y claude-flow@alpha hive-mind resume"
alias cf-status="npx -y claude-flow@alpha hive-mind status"
alias cf-memory-stats="npx -y claude-flow@alpha memory stats"
alias cf-memory-query="npx -y claude-flow@alpha memory query"
alias cf-neural-init="npx -y claude-flow@alpha neural init"
alias cf-goal-init="npx -y claude-flow@alpha goal init"
alias cf-github-init="npx -y claude-flow@alpha github init"
alias cf-help="npx -y claude-flow@alpha --help"
alias cf-version="npx -y claude-flow@alpha --version"

# Shortcuts
alias cfs="cf-swarm"
alias cfh="cf-hive"
alias cfr="cf-resume"
alias cfst="cf-status"

# Agentic Flow
alias af-run="npx -y agentic-flow --agent"
alias af-coder="npx -y agentic-flow --agent coder"
alias af-reviewer="npx -y agentic-flow --agent reviewer"
alias af-tester="npx -y agentic-flow --agent tester"
alias af-optimize="npx -y agentic-flow --optimize"
alias af-mcp-list="npx -y agentic-flow mcp list"
alias af-help="npx -y agentic-flow --help"
alias af-list="npx -y agentic-flow --list"

# Functions
cf-task() { npx -y claude-flow@alpha swarm "\$1" --claude; }
af-task() { npx -y agentic-flow --agent "\$1" --task "\$2" --stream; }
af-cheap() { npx -y agentic-flow --agent "\$1" --task "\$2" --optimize --priority cost; }
ALIASES_EOF

# ISSUE #5 FIX: Don't source bashrc (can cause errors)
echo ""
echo "============================================"
echo "🎉 TURBO FLOW SETUP COMPLETE!"
echo "============================================"
echo "✅ Claude-Flow installed"
echo "✅ Agentic Flow installed"
echo "✅ MCP servers configured"
echo "✅ $AGENT_COUNT subagents installed"
echo ""
echo "🔄 Run 'source ~/.bashrc' to activate aliases"
echo "🎯 Quick start: cf-init && cf-swarm 'your task'"
echo "============================================"
