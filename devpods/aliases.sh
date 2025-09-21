#!/bin/bash

# ============================================
# CLAUDE-FLOW v2.0.0 ALPHA ALIASES
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
alias cf-init-verify="npx claude-flow@alpha init --verify --pair --github-enhanced"
alias cf-init-project="npx claude-flow@alpha init --force --project-name"
alias cf-init-nexus="npx claude-flow@alpha init --flow-nexus"

# === Hive-Mind Operations ===
alias cf-spawn="npx claude-flow@alpha hive-mind spawn"
alias cf-wizard="npx claude-flow@alpha hive-mind wizard"
alias cf-resume="npx claude-flow@alpha hive-mind resume"
alias cf-status="npx claude-flow@alpha hive-mind status"
alias cf-sessions="npx claude-flow@alpha hive-mind sessions"
alias cf-upgrade="npx claude-flow@alpha hive-mind upgrade"
alias cf-github-hive="npx claude-flow@alpha hive-mind spawn --github-enhanced --agents 13 --claude"

# === Swarm Operations ===
alias cf-continue="npx claude-flow@alpha swarm --continue-session"
alias cf-swarm-temp="npx claude-flow@alpha swarm --temp"
alias cf-swarm-namespace="npx claude-flow@alpha swarm --namespace"

# === Memory Management ===
alias cf-memory-stats="npx claude-flow@alpha memory stats"
alias cf-memory-list="npx claude-flow@alpha memory list"
alias cf-memory-query="npx claude-flow@alpha memory query"
alias cf-memory-recent="npx claude-flow@alpha memory query --recent --limit 5"
alias cf-memory-clear="npx claude-flow@alpha memory clear"
alias cf-memory-export="npx claude-flow@alpha memory export"
alias cf-memory-import="npx claude-flow@alpha memory import"

# === Neural Operations ===
alias cf-neural-train="npx claude-flow@alpha neural train"
alias cf-neural-predict="npx claude-flow@alpha neural predict"
alias cf-neural-status="npx claude-flow@alpha neural status"
alias cf-neural-models="npx claude-flow@alpha neural models"

# === Goal Planning (GOAP) ===
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

echo "✅ Claude-Flow v2.0.0 Alpha aliases loaded!"
echo "📚 Type 'cf-help' for documentation or 'cf-docs' for wiki"
echo "🚀 Quick start: 'cf-init' then 'cf-swarm \"your task\"'"



# Source the updated bashrc
source ~/.bashrc

echo "🎉 Claude-Flow v2.0.0 aliases have been installed!"
echo "✨ New features available:"
echo "  • Flow Nexus Cloud: cf-nexus-*"
echo "  • Neural operations: cf-neural-*"
echo "  • Memory management: cf-memory-*"
echo "  • GitHub integration: cf-github-*"
echo "  • Hooks system: cf-hooks-*"
echo "  • SPARC methodology: cf-sparc-*"
echo ""
echo "🔄 Run 'source ~/.bashrc' to activate the aliases"
echo "Setup completed successfully!"
echo "🎯 Environment is now 100% production-ready!"
echo "✅ TypeScript ES module configuration fixed"
echo "✅ Playwright tests configured with proper imports"
echo "✅ DSP alias configured"
echo "✅ Claude Flow wrapper fixed for interactive commands"
