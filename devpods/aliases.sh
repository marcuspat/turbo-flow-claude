# ============================================
# CLAUDE-FLOW v2.5.0 ALPHA 130 ALIASES
# Performance: 100-600x speedup with SDK integration
# ============================================

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
# RESEARCH SWARM v1.2.2 ALIASES
# Local AI Research Agent with Anti-Hallucination
# ============================================

# === Core Research Commands ===
alias rs="research-swarm"
alias rs-research="research-swarm research"
alias rs-researcher="research-swarm research researcher"
alias rs-analyst="research-swarm research analyst"
alias rs-critic="research-swarm research critic"

# === Job Management ===
alias rs-list="research-swarm list"
alias rs-view="research-swarm view"
alias rs-init="research-swarm init"

# === Swarm Operations ===
alias rs-swarm="research-swarm swarm"
alias rs-parallel="research-swarm swarm"

# === GOALIE Goal-Oriented Research ===
alias rs-goal="research-swarm goal-research"
alias rs-goal-plan="research-swarm goal-plan"
alias rs-goal-decompose="research-swarm goal-decompose"

# === AgentDB Learning & Memory ===
alias rs-learn="research-swarm learn"
alias rs-stats="research-swarm stats"
alias rs-benchmark="research-swarm benchmark"

# === HNSW Vector Search ===
alias rs-hnsw-init="research-swarm hnsw:init"
alias rs-hnsw-build="research-swarm hnsw:build"
alias rs-hnsw-search="research-swarm hnsw:search"
alias rs-hnsw-stats="research-swarm hnsw:stats"

# === MCP Server ===
alias rs-mcp="research-swarm mcp"
alias rs-mcp-start="research-swarm mcp start"

# === Quick Commands (Shortcuts) ===
alias rsr="rs-researcher"                    # Quick researcher
alias rsa="rs-analyst"                       # Quick analyst
alias rsc="rs-critic"                        # Quick critic
alias rsl="rs-list"                          # Quick list jobs
alias rsg="rs-goal"                          # Quick goal research
alias rsv="rs-hnsw-search"                   # Quick vector search

# === Utility Functions ===

# Quick research task
rs-task() {
    research-swarm research researcher "$1"
}

# Research with specific depth
rs-deep() {
    local depth=${2:-8}
    RESEARCH_DEPTH=$depth research-swarm research researcher "$1"
}

# Research with anti-hallucination enabled
rs-verify() {
    ANTI_HALLUCINATION_LEVEL=high CITATION_REQUIRED=true research-swarm research researcher "$1"
}

# Parallel research swarm
rs-multi() {
    research-swarm swarm "$@"
}

# Goal-oriented deep research
rs-goal-task() {
    research-swarm goal-research "$1" --max-iterations 10
}

# Quick vector similarity search
rs-search() {
    research-swarm hnsw:search "$1" -k 10
}

# Source the updated bashrc
source ~/.bashrc

echo ""
echo "============================================"
echo "🎉 TURBO FLOW SETUP COMPLETE!"
echo "============================================"
echo ""
echo "✅ Claude-Flow v2.5.0 Alpha 130 installed!"
echo "🚀 Performance: 100-600x speedup with Claude Code SDK integration"
echo "📚 Type 'cf-help' for documentation or 'cf-docs' for wiki"
echo "🎯 Quick start: 'cf-init' then 'cf-swarm \"your task\"'"
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
echo "✅ Research Swarm v1.2.2 installed!"
echo "🔬 Local AI research with anti-hallucination controls"
echo "📊 SQLite-based with AgentDB self-learning"
echo "📚 Type 'rs --help' for documentation"
echo ""
echo "✨ Research Swarm Quick Start:"
echo "  rs-researcher 'Analyze quantum computing trends'"
echo "  rs-verify 'Research with citations and verification'"
echo "  rs-goal 'Build comprehensive market analysis'"
echo "  rs-swarm 'task 1' 'task 2' 'task 3'  # Parallel research"
echo ""
echo "🎯 Research Depth Levels:"
echo "  rs-deep 'your query' 8  # Depth 1-10 (default: 5)"
echo ""
echo "🔑 Environment Variables:"
echo "  RESEARCH_DEPTH=8"
echo "  ANTI_HALLUCINATION_LEVEL=high"
echo "  CITATION_REQUIRED=true"
echo "  ENABLE_REASONINGBANK=true"
echo ""
echo "============================================"
echo "🔄 Run 'source ~/.bashrc' to activate all aliases"
echo "🎯 Environment is now 100% production-ready!"
echo "============================================"
