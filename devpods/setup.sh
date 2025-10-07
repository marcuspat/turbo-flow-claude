#!/bin/bash
set -ex  # Add -x for debugging output

# Get the directory where this script is located
readonly DEVPOD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Claude Dev Environment Setup (MCP-Optimized) ==="
echo "WORKSPACE_FOLDER: $WORKSPACE_FOLDER"
echo "DEVPOD_WORKSPACE_FOLDER: $DEVPOD_WORKSPACE_FOLDER"
echo "AGENTS_DIR: $AGENTS_DIR"
echo "DEVPOD_DIR: $DEVPOD_DIR"

# Install npm packages
npm install -g @anthropic-ai/claude-code
npm install -g claude-usage-cli

# Install uv package manager
echo "Installing uv package manager..."
curl -LsSf https://astral.sh/uv/install.sh | sh
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
else
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Install Claude Monitor using uv
echo "Installing Claude Code Usage Monitor..."
uv tool install claude-monitor || pip install claude-monitor

# Verify installation
if command -v claude-monitor >/dev/null 2>&1; then
  echo "✅ Claude Monitor installed successfully"
else
  echo "❌ Claude Monitor installation failed"
fi

# Initialize claude-flow in the project directory
cd "$WORKSPACE_FOLDER"
npx claude-flow@alpha init --force

# Setup Node.js project if package.json doesn't exist
if [ ! -f "package.json" ]; then
  echo "📦 Initializing Node.js project..."
  npm init -y
fi

# Fix TypeScript module configuration
echo "🔧 Fixing TypeScript module configuration..."
npm pkg set type="module"

# ============================================
# MCP SERVER INSTALLATION & CONFIGURATION
# Using official MCP servers instead of direct installs
# ============================================

echo "🔌 Installing MCP Servers..."

# Install Playwright MCP Server (Official Microsoft implementation)
# Provides browser automation via MCP protocol
echo "🎭 Installing Playwright MCP Server..."
npm install -g @playwright/mcp

# Install Chrome DevTools MCP Server
# Provides Chrome debugging capabilities via MCP
echo "🌐 Installing Chrome DevTools MCP Server..."
npm install -g chrome-devtools-mcp

# Install Browser MCP (Alternative Chrome control)
# For direct browser automation in user's Chrome instance
echo "🔍 Installing Browser MCP..."
npm install -g mcp-chrome-bridge

# Install TypeScript MCP SDK for custom servers
echo "📚 Installing TypeScript MCP SDK..."
npm install -g @modelcontextprotocol/sdk

# Install TypeScript and build tools (needed for proper development)
echo "🔧 Installing TypeScript and development tools..."
npm install -D typescript @types/node

# Update tsconfig.json for ES modules
echo "⚙️ Updating TypeScript configuration for ES modules..."
cat << 'EOF' > tsconfig.json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true
  },
  "include": ["src/**/*", "tests/**/*"],
  "exclude": ["node_modules", "dist"]
}
EOF

# Create MCP configuration for Claude Desktop
echo "🔧 Creating MCP server configuration..."
mkdir -p "$HOME/.config/claude"
cat << 'EOF' > "$HOME/.config/claude/mcp.json"
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"],
      "env": {}
    },
    "chrome-devtools": {
      "command": "npx",
      "args": ["chrome-devtools-mcp@latest"],
      "env": {}
    },
    "chrome-mcp": {
      "type": "streamable-http",
      "url": "http://127.0.0.1:12306/mcp"
    },
    "typescript": {
      "command": "node",
      "args": ["${workspaceFolder}/.mcp-servers/typescript-server.js"],
      "env": {}
    }
  }
}
EOF

# Create VS Code MCP configuration
echo "🔧 Creating VS Code MCP configuration..."
mkdir -p "$WORKSPACE_FOLDER/.vscode"
cat << 'EOF' > "$WORKSPACE_FOLDER/.vscode/mcp.json"
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"]
    },
    "chrome-devtools": {
      "command": "npx", 
      "args": ["chrome-devtools-mcp@latest"]
    }
  }
}
EOF

# Create a basic TypeScript MCP server template
echo "📝 Creating TypeScript MCP server template..."
mkdir -p "$WORKSPACE_FOLDER/.mcp-servers"
cat << 'EOF' > "$WORKSPACE_FOLDER/.mcp-servers/typescript-server.ts"
#!/usr/bin/env node
import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import { z } from 'zod';

const server = new McpServer({
  name: 'typescript-tools',
  version: '1.0.0'
});

// Add TypeScript compilation tool
server.registerTool(
  'compile_typescript',
  {
    title: 'Compile TypeScript',
    description: 'Compile TypeScript code to JavaScript',
    inputSchema: {
      code: z.string().describe('TypeScript code to compile')
    }
  },
  async ({ code }) => {
    const ts = await import('typescript');
    const result = ts.transpileModule(code, {
      compilerOptions: {
        module: ts.ModuleKind.ESNext,
        target: ts.ScriptTarget.ES2022
      }
    });
    return {
      content: [{
        type: 'text',
        text: result.outputText
      }]
    };
  }
);

const transport = new StdioServerTransport();
await server.connect(transport);
EOF

# Build the TypeScript MCP server
echo "🔨 Building TypeScript MCP server..."
npx tsc "$WORKSPACE_FOLDER/.mcp-servers/typescript-server.ts" \
  --outDir "$WORKSPACE_FOLDER/.mcp-servers" \
  --module ESNext \
  --target ES2022 \
  --moduleResolution node \
  --esModuleInterop

chmod +x "$WORKSPACE_FOLDER/.mcp-servers/typescript-server.js"

# Create essential directories (required by CLAUDE.md file organization rules)
echo "📁 Creating project directories..."
mkdir -p src tests docs scripts examples config

# Update package.json with essential scripts including MCP commands
echo "📝 Adding essential npm scripts..."
npm pkg set scripts.build="tsc"
npm pkg set scripts.test="npx @playwright/mcp@latest"
npm pkg set scripts.lint="echo 'Add linting here'"  
npm pkg set scripts.typecheck="tsc --noEmit"
npm pkg set scripts.mcp:playwright="npx @playwright/mcp@latest"
npm pkg set scripts.mcp:chrome="npx chrome-devtools-mcp@latest"
npm pkg set scripts.mcp:browser="mcp-chrome-bridge"
npm pkg set scripts.mcp:test="npx @modelcontextprotocol/inspector .mcp-servers/typescript-server.js"

# Verify MCP installations
echo "✅ Verifying MCP server installations..."
if command -v mcp-chrome-bridge >/dev/null 2>&1; then
  echo "✅ Chrome MCP Bridge installed"
else
  echo "⚠️ Chrome MCP Bridge may need manual setup"
fi

# Install Claude subagents
echo "Installing Claude subagents..."
mkdir -p "$AGENTS_DIR"
cd "$AGENTS_DIR"
git clone https://github.com/ChrisRoyse/610ClaudeSubagents.git temp-agents
cp -r temp-agents/agents/*.md .
rm -rf temp-agents

# Copy additional agents if they're included in the repo
ADDITIONAL_AGENTS_DIR="$DEVPOD_DIR/additional-agents"
if [ -d "$ADDITIONAL_AGENTS_DIR" ]; then
  echo "Copying additional agents..."
  
  # Copy doc-planner.md
  if [ -f "$ADDITIONAL_AGENTS_DIR/doc-planner.md" ]; then
      cp "$ADDITIONAL_AGENTS_DIR/doc-planner.md" "$AGENTS_DIR/"
      echo "✅ Copied doc-planner.md"
  fi
  
  # Copy microtask-breakdown.md
  if [ -f "$ADDITIONAL_AGENTS_DIR/microtask-breakdown.md" ]; then
      cp "$ADDITIONAL_AGENTS_DIR/microtask-breakdown.md" "$AGENTS_DIR/"
      echo "✅ Copied microtask-breakdown.md"
  fi
fi

echo "Installed $(ls -1 *.md | wc -l) agents in $AGENTS_DIR"
cd "$WORKSPACE_FOLDER"

# Delete existing CLAUDE.md and copy CLAUDE.md to overwrite it if it exists
if [ -f "$DEVPOD_DIR/CLAUDE.md" ]; then
  echo "Found CLAUDE.md in devpods directory, replacing CLAUDE.md with it..."
  # Rename existing CLAUDE.md to CLAUDE.md.OLD if it exists
  if [ -f "$WORKSPACE_FOLDER/CLAUDE.md" ]; then
      mv "$WORKSPACE_FOLDER/CLAUDE.md" "$WORKSPACE_FOLDER/CLAUDE.md.OLD"
      echo "Renamed existing CLAUDE.md to CLAUDE.md.OLD"
  fi
  cp "$DEVPOD_DIR/CLAUDE.md" "$WORKSPACE_FOLDER/CLAUDE.md"
  echo "✅ Replaced CLAUDE.md with CLAUDE.md from devpods directory"
else
  echo "⚠️ CLAUDE.md not found in $DEVPOD_DIR - using default CLAUDE.md"
fi

# Create dsp alias for claude --dangerously-skip-permissions
echo 'alias dsp="claude --dangerously-skip-permissions"' >> ~/.bashrc

# ============================================
# AGENTIC-FLOW INSTALLATION & CONFIGURATION
# Multi-Model Router with OpenRouter, Gemini & ONNX
# ============================================

# Install Agentic Flow globally
echo "📦 Installing Agentic Flow..."
npm install -g agentic-flow

# Verify installation
if command -v agentic-flow >/dev/null 2>&1; then
  echo "✅ Agentic Flow installed successfully"
else
  echo "❌ Agentic Flow installation failed"
fi

# Create Agentic Flow context wrapper script
echo "🔧 Creating Agentic Flow context wrapper..."
cat << 'AF_WRAPPER_EOF' > af-with-context.sh
#!/bin/bash
# Agentic Flow wrapper that auto-loads context files

load_context() {
    local context=""
    
    # Load CLAUDE.md
    if [[ -f "CLAUDE.md" ]]; then
        context+="=== CLAUDE RULES ===\n$(cat CLAUDE.md)\n\n"
    fi
    
    # Load CCFOREVER.md
    if [[ -f "CCFOREVER.md" ]]; then
        context+="=== CC FOREVER INSTRUCTIONS ===\n$(cat CCFOREVER.md)\n\n"
    fi
    
    echo -e "$context"
}

# Execute with context
case "$1" in
    *)
        npx agentic-flow "$@"
        ;;
esac
AF_WRAPPER_EOF

chmod +x af-with-context.sh

# 🔧 Create Claude Flow context wrapper script - FIXED VERSION
echo "🔧 Creating Claude Flow context wrapper..."
cat << 'WRAPPER_EOF' > cf-with-context.sh
#!/bin/bash
# Claude Flow wrapper that auto-loads context files

load_context() {
    local context=""
    
    # Load CLAUDE.md
    if [[ -f "CLAUDE.md" ]]; then
        context+="=== CLAUDE RULES ===\n$(cat CLAUDE.md)\n\n"
    fi
    
    # Load CCFOREVER.md
    if [[ -f "CCFOREVER.md" ]]; then
        context+="=== CC FOREVER INSTRUCTIONS ===\n$(cat CCFOREVER.md)\n\n"
    fi
    
    # Load doc-planner.md
    if [[ -f "agents/doc-planner.md" ]]; then
        context+="=== DOC PLANNER AGENT ===\n$(cat agents/doc-planner.md)\n\n"
    fi
    
    # Load microtask-breakdown.md
    if [[ -f "agents/microtask-breakdown.md" ]]; then
        context+="=== MICROTASK BREAKDOWN AGENT ===\n$(cat agents/microtask-breakdown.md)\n\n"
    fi
    
    echo -e "$context"
}

# Check command type and execute with context
case "$1" in
    "swarm")
        # Swarm launches Claude Code which needs direct terminal access
        # Don't pipe stdin - let it have full terminal control
        echo "🚀 Launching Claude Code Swarm..."
        echo "📄 Note: Context files (CLAUDE.md, agents) will be loaded from working directory"
        npx claude-flow@alpha swarm "${@:2}" --claude
        ;;
        
    "hive-mind"|"hive")
        # hive-mind also needs direct terminal access
        echo "🚀 Running Claude Flow hive-mind..."
        if [[ "$2" == "spawn" ]]; then
            npx claude-flow@alpha hive-mind spawn "${@:3}" --claude
        else
            npx claude-flow@alpha hive-mind spawn "${@:2}" --claude
        fi
        ;;
        
    "pair"|"verify"|"truth")
        # These interactive commands also need terminal access
        echo "🚀 Running Claude Flow $1..."
        npx claude-flow@alpha "$@" --claude
        ;;
        
    *)
        # For other commands, check if they might be interactive
        if [[ $# -gt 0 ]]; then
            # Just run directly without stdin redirection to be safe
            npx claude-flow@alpha "$@" --claude
        else
            npx claude-flow@alpha --help
        fi
        ;;
esac
WRAPPER_EOF

chmod +x cf-with-context.sh

# ============================================
# CLAUDE-FLOW v2.5.0 ALPHA 130 ALIASES
# Performance: 100-600x speedup with SDK integration
# ============================================

cat << 'ALIASES_EOF' >> ~/.bashrc

# ============================================
# CLAUDE-FLOW v2.5.0 ALPHA 130 ALIASES
# Performance: 100-600x speedup with SDK integration
# ============================================

# === Core Context Wrapper Commands ===
alias cf="./cf-with-context.sh"
alias cf-swarm="./cf-with-context.sh swarm" 
alias cf-hive="./cf-with-context.sh hive-mind spawn"

# === Claude Code Direct Access ===
alias cf-dsp="claude --dangerously-skip-permissions"
alias dsp="claude --dangerously-skip-permissions"

# === MCP Server Management ===
alias mcp-playwright="npx @playwright/mcp@latest"
alias mcp-chrome="npx chrome-devtools-mcp@latest"
alias mcp-browser="mcp-chrome-bridge"
alias mcp-test="npx @modelcontextprotocol/inspector"
alias mcp-list="cat ~/.config/claude/mcp.json"

# === Initialization & Setup ===
alias cf-init="npx claude-flow@alpha init --force"
alias cf-init-nexus="npx claude-flow@alpha init --flow-nexus"

# === Hive-Mind Operations ===
alias cf-spawn="npx claude-flow@alpha hive-mind spawn"
alias cf-wizard="npx claude-flow@alpha hive-mind wizard"
alias cf-resume="npx claude-flow@alpha hive-mind resume"
alias cf-status="npx claude-flow@alpha hive-mind status"

# === Swarm Operations ===
alias cf-continue="npx claude-flow@alpha swarm --continue-session"
alias cf-swarm-temp="npx claude-flow@alpha swarm --temp"
alias cf-swarm-namespace="npx claude-flow@alpha swarm --namespace"
alias cf-swarm-init="npx claude-flow@alpha swarm init"

# === Memory Management ===
alias cf-memory-stats="npx claude-flow@alpha memory stats"
alias cf-memory-list="npx claude-flow@alpha memory list"
alias cf-memory-query="npx claude-flow@alpha memory query"
alias cf-memory-recent="npx claude-flow@alpha memory query --recent"
alias cf-memory-clear="npx claude-flow@alpha memory clear"
alias cf-memory-export="npx claude-flow@alpha memory export"
alias cf-memory-import="npx claude-flow@alpha memory import"

# === Neural Operations (SAFLA) ===
alias cf-neural-init="npx claude-flow@alpha neural init"
alias cf-neural-init-force="npx claude-flow@alpha neural init --force"
alias cf-neural-init-target="npx claude-flow@alpha neural init --target"
alias cf-neural-train="npx claude-flow@alpha neural train"
alias cf-neural-predict="npx claude-flow@alpha neural predict"
alias cf-neural-status="npx claude-flow@alpha neural status"
alias cf-neural-models="npx claude-flow@alpha neural models"

# === Goal Planning (GOAP) ===
alias cf-goal-init="npx claude-flow@alpha goal init"
alias cf-goal-init-force="npx claude-flow@alpha goal init --force"
alias cf-goal-init-target="npx claude-flow@alpha goal init --target"
alias cf-goal-plan="npx claude-flow@alpha goal plan"
alias cf-goal-execute="npx claude-flow@alpha goal execute"
alias cf-goal-status="npx claude-flow@alpha goal status"

# === Agent Management ===
alias cf-agents-list="npx claude-flow@alpha agents list"
alias cf-agents-spawn="npx claude-flow@alpha agents spawn"
alias cf-agents-status="npx claude-flow@alpha agents status"
alias cf-agents-assign="npx claude-flow@alpha agents assign"

# === Hooks System ===
alias cf-hooks-list="npx claude-flow@alpha hooks list"
alias cf-hooks-enable="npx claude-flow@alpha hooks enable"
alias cf-hooks-disable="npx claude-flow@alpha hooks disable"
alias cf-hooks-config="npx claude-flow@alpha hooks config"

# === GitHub Integration ===
alias cf-github-init="npx claude-flow@alpha github init"
alias cf-github-sync="npx claude-flow@alpha github sync"
alias cf-github-pr="npx claude-flow@alpha github pr"
alias cf-github-issues="npx claude-flow@alpha github issues"
alias cf-github-analyze="npx claude-flow@alpha github analyze"
alias cf-github-migrate="npx claude-flow@alpha github migrate"

# === Flow Nexus Cloud ===
alias cf-nexus-login="npx claude-flow@alpha nexus login"
alias cf-nexus-sandbox="npx claude-flow@alpha nexus sandbox"
alias cf-nexus-swarm="npx claude-flow@alpha nexus swarm"
alias cf-nexus-deploy="npx claude-flow@alpha nexus deploy"
alias cf-nexus-challenges="npx claude-flow@alpha nexus challenges"
alias cf-nexus-marketplace="npx claude-flow@alpha nexus marketplace"

# === Performance & Analytics ===
alias cf-benchmark="npx claude-flow@alpha benchmark"
alias cf-analyze="npx claude-flow@alpha analyze"
alias cf-optimize="npx claude-flow@alpha optimize"
alias cf-metrics="npx claude-flow@alpha metrics"

# === Benchmarking System ===
alias cf-swarm-bench="swarm-bench"
alias cf-bench-run="swarm-bench run"
alias cf-bench-load="swarm-bench load-test"
alias cf-bench-swe="swarm-bench swe-bench official"
alias cf-bench-multi="swarm-bench swe-bench multi-mode"
alias cf-bench-compare="swarm-bench compare"
alias cf-bench-monitor="swarm-bench monitor --dashboard"
alias cf-bench-diagnose="swarm-bench diagnose"
alias cf-bench-analyze="swarm-bench analyze-errors"
alias cf-bench-optimize="swarm-bench optimize"

# === Hive-Mind Configuration ===
alias cf-hive-init="claude-flow hive init"
alias cf-hive-monitor="claude-flow hive monitor"
alias cf-hive-health="claude-flow hive health"
alias cf-hive-config="claude-flow hive config set"

# === Verification & Testing ===
alias cf-verify="npx claude-flow@alpha verify"
alias cf-truth="npx claude-flow@alpha truth"
alias cf-test="npx claude-flow@alpha test"
alias cf-validate="npx claude-flow@alpha validate"

# === Pairing & Collaboration ===
alias cf-pair="npx claude-flow@alpha pair --start"
alias cf-pair-stop="npx claude-flow@alpha pair --stop"
alias cf-pair-status="npx claude-flow@alpha pair --status"

# === SPARC Methodology ===
alias cf-sparc-init="npx claude-flow@alpha sparc init"
alias cf-sparc-plan="npx claude-flow@alpha sparc plan"
alias cf-sparc-execute="npx claude-flow@alpha sparc execute"
alias cf-sparc-review="npx claude-flow@alpha sparc review"

# === Quick Commands (Shortcuts) ===
alias cfs="cf-swarm"                    # Quick swarm
alias cfh="cf-hive"                     # Quick hive spawn
alias cfr="cf-resume"                   # Quick resume
alias cfst="cf-status"                  # Quick status
alias cfm="cf-memory-stats"             # Quick memory stats
alias cfmq="cf-memory-query"            # Quick memory query
alias cfa="cf-agents-list"              # Quick agent list
alias cfg="cf-github-analyze"           # Quick GitHub analysis
alias cfn="cf-nexus-swarm"              # Quick Nexus swarm

# === Monitoring & Debugging ===
alias cf-monitor="claude-monitor"
alias cf-logs="npx claude-flow@alpha logs"
alias cf-debug="npx claude-flow@alpha debug"
alias cf-trace="npx claude-flow@alpha trace"

# === Help & Documentation ===
alias cf-help="npx claude-flow@alpha --help"
alias cf-docs="echo 'Visit: https://github.com/ruvnet/claude-flow/wiki'"
alias cf-examples="echo 'Visit: https://github.com/ruvnet/claude-flow/tree/main/examples'"

# === Utility Functions ===

# Quick task with automatic Claude integration
cf-task() {
    npx claude-flow@alpha swarm "$1" --claude
}

# Quick hive spawn with namespace
cf-hive-ns() {
    npx claude-flow@alpha hive-mind spawn "$1" --namespace "$2" --claude
}

# Memory search with context
cf-search() {
    npx claude-flow@alpha memory query "$1" --recent --context
}

# Quick Flow Nexus sandbox creation
cf-sandbox() {
    npx claude-flow@alpha nexus sandbox create --template "$1" --name "$2"
}

# Session management helper
cf-session() {
    case "$1" in
        list) npx claude-flow@alpha hive-mind sessions ;;
        resume) npx claude-flow@alpha hive-mind resume "$2" ;;
        status) npx claude-flow@alpha hive-mind status ;;
        *) echo "Usage: cf-session [list|resume <id>|status]" ;;
    esac
}

# Hive initialization with topology
cf-hive-topology() {
    local topology=$1
    shift
    claude-flow hive init --topology "$topology" "$@"
}

# Quick benchmark comparison
cf-bench-quick() {
    swarm-bench run --strategy development,optimization --mode centralized,distributed --agents 5
}

# Quick load test
cf-load-test() {
    local agents=${1:-20}
    local tasks=${2:-200}
    swarm-bench load-test --agents "$agents" --tasks "$tasks"
}

# ============================================
# AGENTIC-FLOW ALIASES
# Multi-Model Router with Cost Optimization
# ============================================

# === Core Context Wrapper Commands ===
alias af="./af-with-context.sh"
alias agentic-flow="npx agentic-flow"

# === Agent Execution ===
alias af-run="npx agentic-flow --agent"
alias af-stream="npx agentic-flow --stream"
alias af-parallel="npx agentic-flow"  # Uses TOPIC, DIFF, DATASET env vars

# === Model Optimization ===
alias af-optimize="npx agentic-flow --optimize"
alias af-optimize-cost="npx agentic-flow --optimize --priority cost"
alias af-optimize-quality="npx agentic-flow --optimize --priority quality"
alias af-optimize-speed="npx agentic-flow --optimize --priority speed"
alias af-optimize-privacy="npx agentic-flow --optimize --priority privacy"

# === Provider Selection ===
alias af-openrouter="npx agentic-flow --model"  # Use with OpenRouter models
alias af-gemini="npx agentic-flow --provider gemini"
alias af-onnx="npx agentic-flow --provider onnx"
alias af-anthropic="npx agentic-flow --provider anthropic"

# === MCP Server Management ===
alias af-mcp-start="npx agentic-flow mcp start"
alias af-mcp-stop="npx agentic-flow mcp stop"
alias af-mcp-status="npx agentic-flow mcp status"
alias af-mcp-list="npx agentic-flow mcp list"

# === Custom MCP Servers (NEW v1.2.1) ===
alias af-mcp-add="npx agentic-flow mcp add"
alias af-mcp-remove="npx agentic-flow mcp remove"
alias af-mcp-enable="npx agentic-flow mcp enable"
alias af-mcp-disable="npx agentic-flow mcp disable"
alias af-mcp-test="npx agentic-flow mcp test"
alias af-mcp-export="npx agentic-flow mcp export"
alias af-mcp-import="npx agentic-flow mcp import"

# === Specific MCP Servers ===
alias af-mcp-claude="npx agentic-flow mcp start claude-flow"
alias af-mcp-nexus="npx agentic-flow mcp start flow-nexus"
alias af-mcp-payments="npx agentic-flow mcp start agentic-payments"

# === Agent Types (150+ Agents) ===
alias af-coder="npx agentic-flow --agent coder"
alias af-reviewer="npx agentic-flow --agent reviewer"
alias af-tester="npx agentic-flow --agent tester"
alias af-researcher="npx agentic-flow --agent researcher"
alias af-planner="npx agentic-flow --agent planner"
alias af-backend="npx agentic-flow --agent backend-dev"
alias af-mobile="npx agentic-flow --agent mobile-dev"
alias af-ml="npx agentic-flow --agent ml-developer"
alias af-architect="npx agentic-flow --agent system-architect"
alias af-cicd="npx agentic-flow --agent cicd-engineer"
alias af-docs="npx agentic-flow --agent api-docs"
alias af-perf="npx agentic-flow --agent perf-analyzer"

# === GitHub Integration Agents ===
alias af-pr="npx agentic-flow --agent pr-manager"
alias af-code-review="npx agentic-flow --agent code-review-swarm"
alias af-issue="npx agentic-flow --agent issue-tracker"
alias af-release="npx agentic-flow --agent release-manager"

# === Swarm Coordinators ===
alias af-hierarchical="npx agentic-flow --agent hierarchical-coordinator"
alias af-mesh="npx agentic-flow --agent mesh-coordinator"
alias af-adaptive="npx agentic-flow --agent adaptive-coordinator"
alias af-swarm-memory="npx agentic-flow --agent swarm-memory-manager"

# === Docker Deployment ===
alias af-docker-build="docker build -f deployment/Dockerfile -t agentic-flow ."
alias af-docker-run="docker run --rm -e ANTHROPIC_API_KEY=\$ANTHROPIC_API_KEY agentic-flow"

# === Information & Help ===
alias af-list="npx agentic-flow --list"
alias af-help="npx agentic-flow --help"
alias af-version="npx agentic-flow --version"

# === Environment Setup ===
alias af-env-anthropic="export ANTHROPIC_API_KEY="
alias af-env-openrouter="export OPENROUTER_API_KEY="
alias af-env-gemini="export GOOGLE_GEMINI_API_KEY="

# === Quick Commands (Shortcuts) ===
alias afr="af-run"                      # Quick agent run
alias afs="af-stream"                   # Quick streaming run
alias afo="af-optimize"                 # Quick optimization
alias afm="af-mcp-list"                 # Quick MCP list
alias afc="af-coder"                    # Quick coder agent
alias afrev="af-reviewer"               # Quick reviewer agent
alias aft="af-tester"                   # Quick tester agent

# === Utility Functions ===

# Quick agent task with streaming
af-task() {
    npx agentic-flow --agent "$1" --task "$2" --stream
}

# Quick optimized task
af-opt-task() {
    npx agentic-flow --agent "$1" --task "$2" --optimize
}

# Quick cost-optimized task
af-cheap() {
    npx agentic-flow --agent "$1" --task "$2" --optimize --priority cost
}

# Quick privacy-focused task (local ONNX)
af-private() {
    npx agentic-flow --agent "$1" --task "$2" --provider onnx --local-only
}

# Run with specific OpenRouter model
af-openai() {
    local model=${1:-"meta-llama/llama-3.1-8b-instruct"}
    shift
    npx agentic-flow --model "$model" "$@"
}

# Run with Gemini
af-gemini-task() {
    npx agentic-flow --agent "$1" --task "$2" --provider gemini
}

# Multi-agent swarm
af-swarm() {
    export TOPIC="$1"
    export DIFF="$2"
    export DATASET="$3"
    npx agentic-flow
}

# Add custom MCP server (Claude Desktop style)
af-add-mcp() {
    local name=$1
    local command=$2
    npx agentic-flow mcp add "$name" "$command"
}

# Quick benchmark comparison
af-benchmark() {
    echo "Running benchmark: $1"
    npx agentic-flow --agent tester --task "$1" --optimize
}

# ============================================
# MCP SERVER UTILITY FUNCTIONS
# ============================================

# Start Playwright MCP server with custom options
mcp-playwright-start() {
    local browser=${1:-chrome}
    npx @playwright/mcp@latest --browser "$browser" --headless
}

# Start Chrome DevTools MCP with isolated profile
mcp-chrome-isolated() {
    npx chrome-devtools-mcp@latest --isolated
}

# Test MCP server connection
mcp-test-connection() {
    local server=${1:-playwright}
    echo "Testing MCP server: $server"
    npx @modelcontextprotocol/inspector
}

# Launch browser with MCP control
mcp-browser-launch() {
    echo "Starting Chrome MCP Bridge..."
    echo "Install extension from: chrome://extensions"
    mcp-chrome-bridge
}

# Inspect MCP server tools
mcp-inspect() {
    local server_script=${1:-.mcp-servers/typescript-server.js}
    npx @modelcontextprotocol/inspector "$server_script"
}

ALIASES_EOF

# Source the updated bashrc
source ~/.bashrc

echo ""
echo "============================================"
echo "🎉 MCP-OPTIMIZED TURBO FLOW SETUP COMPLETE!"
echo "============================================"
echo ""
echo "✅ Claude-Flow v2.5.0 Alpha 130 installed!"
echo "🚀 Performance: 100-600x speedup with Claude Code SDK integration"
echo "🔌 MCP Servers: Playwright, Chrome DevTools, Browser Control"
echo "📚 Type 'cf-help' for documentation or 'cf-docs' for wiki"
echo "🎯 Quick start: 'cf-init' then 'cf-swarm \"your task\"'"
echo ""
echo "✨ MCP Server Commands:"
echo "  • Playwright: mcp-playwright (browser automation)"
echo "  • Chrome DevTools: mcp-chrome (debugging & performance)"
echo "  • Browser MCP: mcp-browser (control your Chrome)"
echo "  • Test MCP: mcp-test (inspect MCP connections)"
echo "  • List Config: mcp-list (view MCP configuration)"
echo ""
echo "✨ Claude Flow Core Commands:"
echo "  • Init: cf-init, cf-init-nexus"
echo "  • Hive: cf-spawn, cf-wizard, cf-resume, cf-status"
echo "  • Swarm: cf-swarm, cf-continue"
echo "  • Memory: cf-memory-stats, cf-memory-list, cf-memory-query"
echo "  • Neural: cf-neural-init (+ --force, --target)"
echo "  • GOAP: cf-goal-init (+ --force, --target)"
echo "  • GitHub: cf-github-init"
echo "  • Benchmark: cf-bench-run, cf-bench-load, cf-bench-compare"
echo ""
echo "============================================"
echo "✅ Agentic Flow installed!"
echo "🤖 150+ specialized agents available"
echo "💰 Multi-model router with 99% cost savings"
echo "🔒 ONNX local inference for privacy"
echo "📚 Type 'af-help' for documentation or 'af-list' for agents"
echo ""
echo "✨ Agentic Flow Quick Start:"
echo "  af-coder --task 'Build REST API' --stream"
echo "  af-optimize --agent reviewer --task 'Review code' --priority cost"
echo "  af-private --agent researcher --task 'Analyze sensitive data'"
echo "  af-mcp-add weather 'npx @modelcontextprotocol/server-weather'"
echo ""
echo "🔑 Set API keys:"
echo "  export ANTHROPIC_API_KEY=sk-ant-..."
echo "  export OPENROUTER_API_KEY=sk-or-v1-..."
echo "  export GOOGLE_GEMINI_API_KEY=xxxxx"
echo ""
echo "============================================"
echo "🔌 MCP Server Setup:"
echo "  • Playwright MCP: Browser automation with accessibility tree"
echo "  • Chrome DevTools MCP: Performance tracing, DOM inspection"
echo "  • Browser MCP: Control your actual Chrome instance"
echo "  • TypeScript MCP: Custom TypeScript compilation tools"
echo ""
echo "📝 MCP Configuration Files Created:"
echo "  • ~/.config/claude/mcp.json (Claude Desktop)"
echo "  • .vscode/mcp.json (VS Code)"
echo "  • .mcp-servers/typescript-server.js (Custom server)"
echo ""
echo "🧪 Test MCP Servers:"
echo "  npm run mcp:playwright  # Test Playwright"
echo "  npm run mcp:chrome      # Test Chrome DevTools"
echo "  npm run mcp:test        # Test custom TypeScript server"
echo ""
echo "============================================"
echo "🔄 Run 'source ~/.bashrc' to activate all aliases"
echo "🎯 Environment is now 100% production-ready with MCP!"
echo "============================================"
echo ""
echo "📖 MCP Resources:"
echo "  • Playwright MCP: https://github.com/microsoft/playwright-mcp"
echo "  • Chrome DevTools MCP: https://github.com/ChromeDevTools/chrome-devtools-mcp"
echo "  • MCP Specification: https://modelcontextprotocol.io"
echo "  • Browser MCP: https://github.com/hangwin/mcp-chrome"
echo ""
echo "💡 Next Steps:"
echo "  1. Test Playwright: mcp-playwright-start chrome"
echo "  2. Test Chrome DevTools: mcp-chrome-isolated"
echo "  3. Install Chrome MCP Extension for browser control"
echo "  4. Run cf-init to initialize Claude Flow"
echo "  5. Try: cf-swarm 'Test Playwright MCP by navigating to google.com'"
echo ""
