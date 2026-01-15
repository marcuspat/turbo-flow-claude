#!/bin/bash
# TURBO FLOW ALIASES v1.0.6
# Lean Stack Edition - Powered by RuvVector Neural Engine
# Source this file or add to your shell profile: source aliases.sh

# ═══════════════════════════════════════════════════════════════
# CLAUDE CODE
# ═══════════════════════════════════════════════════════════════
alias claude-hierarchical="claude --dangerously-skip-permissions"
alias dsp="claude --dangerously-skip-permissions"

# ═══════════════════════════════════════════════════════════════
# CLAUDE FLOW v3 (RuvVector Neural Engine)
# ═══════════════════════════════════════════════════════════════

# Core
alias cf="npx -y claude-flow@v3alpha"
alias cf-init="npx -y claude-flow@v3alpha init --force"
alias cf-mcp="npx -y claude-flow@v3alpha mcp start"
alias cf-status="npx -y claude-flow@v3alpha status"
alias cf-progress="npx -y claude-flow@v3alpha progress --detailed"
alias cf-help="npx -y claude-flow@v3alpha --help"
alias cf-version="npx -y claude-flow@v3alpha --version"

# Swarm & Agents
alias cf-swarm="npx -y claude-flow@v3alpha swarm init --topology hierarchical"
alias cf-mesh="npx -y claude-flow@v3alpha swarm init --topology mesh"
alias cf-swarm-start="npx -y claude-flow@v3alpha swarm start --max-agents 15"
alias cf-swarm-status="npx -y claude-flow@v3alpha swarm status"
alias cf-agent="npx -y claude-flow@v3alpha --agent"
alias cf-coder="npx -y claude-flow@v3alpha --agent coder"
alias cf-reviewer="npx -y claude-flow@v3alpha --agent reviewer"
alias cf-tester="npx -y claude-flow@v3alpha --agent tester"
alias cf-security="npx -y claude-flow@v3alpha --agent security-architect"
alias cf-architect="npx -y claude-flow@v3alpha --agent architect"
alias cf-list="npx -y claude-flow@v3alpha --list"

# Hive-Mind
alias cf-hive="npx -y claude-flow@v3alpha hive-mind spawn"
alias cf-hive-wizard="npx -y claude-flow@v3alpha hive-mind wizard"
alias cf-hive-status="npx -y claude-flow@v3alpha hive-mind status"
alias cf-queen="npx -y claude-flow@v3alpha queen command"
alias cf-queen-monitor="npx -y claude-flow@v3alpha queen monitor"

# Neural & Learning (RuvVector)
alias cf-neural="npx -y claude-flow@v3alpha neural"
alias cf-train="npx -y claude-flow@v3alpha neural train"
alias cf-patterns="npx -y claude-flow@v3alpha neural patterns"
alias cf-pretrain="npx -y claude-flow@v3alpha hooks pretrain"
alias cf-route="npx -y claude-flow@v3alpha hooks route"

# Memory (AgentDB + HNSW)
alias cf-memory="npx -y claude-flow@v3alpha memory search"
alias cf-memory-status="npx -y claude-flow@v3alpha memory status"
alias cf-memory-store="npx -y claude-flow@v3alpha memory store"
alias cf-memory-vector="npx -y claude-flow@v3alpha memory vector-search"
alias cf-embeddings="npx -y claude-flow@v3alpha embeddings init"

# Hooks & Workers
alias cf-hooks="npx -y claude-flow@v3alpha hooks"
alias cf-hooks-list="npx -y claude-flow@v3alpha hooks list"
alias cf-worker="npx -y claude-flow@v3alpha worker dispatch"
alias cf-worker-status="npx -y claude-flow@v3alpha worker status"
alias cf-daemon="npx -y claude-flow@v3alpha daemon start"

# SPARC Methodology
alias cf-sparc="npx -y claude-flow@v3alpha sparc"
alias cf-sparc-tdd="npx -y claude-flow@v3alpha sparc tdd"
alias cf-sparc-modes="npx -y claude-flow@v3alpha sparc modes"

# GitHub Integration
alias cf-github="npx -y claude-flow@v3alpha github"
alias cf-github-init="npx -y claude-flow@v3alpha github init"
alias cf-github-review="npx -y claude-flow@v3alpha github review"

# Security
alias cf-security-audit="npx -y claude-flow@v3alpha security audit"

# Quick task function
cf-task() {
    local agent="${1:-coder}"
    local task="$2"
    if [ -z "$task" ]; then
        echo "Usage: cf-task <agent> \"task description\""
        echo "Agents: coder, tester, reviewer, architect, security-architect"
        return 1
    fi
    npx -y claude-flow@v3alpha --agent "$agent" --task "$task"
}

# Quick swarm task
cf-do() {
    npx -y claude-flow@v3alpha swarm "$@" --mode parallel
}

# ═══════════════════════════════════════════════════════════════
# AGENTIC QE (Testing Pipeline)
# ═══════════════════════════════════════════════════════════════
alias aqe="npx -y agentic-qe"
alias aqe-init="npx -y agentic-qe init"
alias aqe-generate="npx -y agentic-qe generate"
alias aqe-run="npx -y agentic-qe run --analyze"
alias aqe-flaky="npx -y agentic-qe flaky-hunt"
alias aqe-gate="npx -y agentic-qe quality-gate"
alias aqe-coverage="npx -y agentic-qe coverage"
alias aqe-mcp="npx -y aqe-mcp"

# ═══════════════════════════════════════════════════════════════
# PLAYWRITER (AI Test Generation)
# ═══════════════════════════════════════════════════════════════
alias playwriter="cd ~/.playwriter && npm start"
alias pw-generate="cd ~/.playwriter && npm run generate"

pw-test() {
    if [ -z "$1" ]; then
        echo "Usage: pw-test \"test description\""
        echo "Example: pw-test \"user can login with valid credentials\""
        return 1
    fi
    cd ~/.playwriter
    echo "$1" | npm run generate
    cd - >/dev/null
}

# ═══════════════════════════════════════════════════════════════
# DEV-BROWSER (Visual Development)
# ═══════════════════════════════════════════════════════════════
alias dev-browser="cd ~/.dev-browser && npm run dev"
alias devb="cd ~/.dev-browser && npm run dev"

# ═══════════════════════════════════════════════════════════════
# SECURITY ANALYZER
# ═══════════════════════════════════════════════════════════════
alias security-scan="cd ~/.security-analyzer && npm run scan"
alias sec-audit="npx -y claude-flow@v3alpha security audit"
alias sec-linux="npx @claude-flow/security@latest audit --platform linux"
alias sec-mac="npx @claude-flow/security@latest audit --platform darwin"
alias sec-win="npx @claude-flow/security@latest audit --platform windows"

# ═══════════════════════════════════════════════════════════════
# SPEC-KIT
# ═══════════════════════════════════════════════════════════════
alias sk="specify"
alias sk-init="specify init"
alias sk-check="specify check"
alias sk-here="specify init . --ai claude"
alias sk-const="specify constitution"
alias sk-spec="specify spec"
alias sk-plan="specify plan"
alias sk-tasks="specify tasks"
alias sk-impl="specify implement"

# ═══════════════════════════════════════════════════════════════
# OPENSPEC (Fission-AI)
# ═══════════════════════════════════════════════════════════════
alias os="openspec"
alias os-init="openspec init"
alias os-list="openspec list"
alias os-view="openspec view"
alias os-show="openspec show"
alias os-validate="openspec validate"
alias os-archive="openspec archive"
alias os-update="openspec update"

# ═══════════════════════════════════════════════════════════════
# AI AGENT SKILLS
# ═══════════════════════════════════════════════════════════════
alias skills="npx ai-agent-skills"
alias skills-list="npx ai-agent-skills list"
alias skills-search="npx ai-agent-skills search"
alias skills-install="npx ai-agent-skills install"
alias skills-info="npx ai-agent-skills info"

# ═══════════════════════════════════════════════════════════════
# TMUX - SESSIONS
# ═══════════════════════════════════════════════════════════════
alias t="tmux"
alias tn="tmux new"
alias tns="tmux new-session -s"
alias ta="tmux attach-session"
alias tat="tmux attach-session -t"
alias tl="tmux ls"
alias tls="tmux list-sessions"
alias tks="tmux kill-session -t"
alias tksa="tmux kill-session -a"

# ═══════════════════════════════════════════════════════════════
# TMUX - PANES & WINDOWS
# ═══════════════════════════════════════════════════════════════
alias tsh="tmux split-window -h"
alias tsv="tmux split-window -v"
alias tswap="tmux swap-window -s"
alias tsync="tmux setw synchronize-panes"
alias tmouse="tmux set mouse on"
alias tnomouse="tmux set mouse off"

# ═══════════════════════════════════════════════════════════════
# HELPER FUNCTIONS
# ═══════════════════════════════════════════════════════════════

# Initialize full Turbo Flow workspace
turbo-init() {
    echo "🚀 Initializing Turbo Flow v1.0.6 workspace..."
    echo ""
    
    # Spec-Kit
    echo "📋 Initializing Spec-Kit..."
    specify init . --ai claude 2>/dev/null || echo "  ⚠️ spec-kit skipped"
    
    # Claude Flow v3
    echo "🧠 Initializing Claude Flow v3..."
    npx -y claude-flow@v3alpha init --force 2>/dev/null || echo "  ⚠️ claude-flow skipped"
    
    # Bootstrap neural intelligence
    echo "⚡ Bootstrapping RuvVector neural patterns..."
    npx -y claude-flow@v3alpha hooks pretrain --model-type moe 2>/dev/null || true
    npx -y claude-flow@v3alpha embeddings init 2>/dev/null || true
    
    echo ""
    echo "✅ Workspace ready!"
    echo "   Run: claude"
}

# Quick reference
turbo-help() {
    echo "🚀 Turbo Flow v1.0.6 Quick Reference"
    echo "════════════════════════════════════"
    echo ""
    echo "CLAUDE CODE"
    echo "  claude              Start Claude Code"
    echo "  dsp                 Skip permissions mode"
    echo ""
    echo "CLAUDE FLOW v3 (RuvVector)"
    echo "  cf-init             Initialize workspace"
    echo "  cf-swarm            Initialize hierarchical swarm"
    echo "  cf-mesh             Initialize mesh topology"
    echo "  cf-agent <type>     Run specific agent"
    echo "  cf-coder            Coder agent shortcut"
    echo "  cf-list             List all 54+ agents"
    echo ""
    echo "NEURAL LEARNING"
    echo "  cf-pretrain         Bootstrap intelligence"
    echo "  cf-train            Train patterns"
    echo "  cf-route \"task\"     Intelligent routing"
    echo "  cf-patterns         View learned patterns"
    echo ""
    echo "MEMORY"
    echo "  cf-memory \"query\"   Search vector memory"
    echo "  cf-memory-status    Check memory status"
    echo ""
    echo "TESTING"
    echo "  aqe                 Agentic QE pipeline"
    echo "  aqe-generate        Generate tests"
    echo "  aqe-gate            Quality gate check"
    echo "  pw-test \"desc\"      AI test generation"
    echo ""
    echo "FRONTEND"
    echo "  dev-browser         Visual AI development"
    echo "  devb                Short alias"
    echo ""
    echo "SECURITY"
    echo "  sec-audit           Security audit"
    echo "  security-scan       Full vulnerability scan"
    echo ""
    echo "SPECS"
    echo "  sk-here             Init Spec-Kit (current dir)"
    echo "  os-init             Init OpenSpec"
    echo ""
    echo "SKILLS"
    echo "  skills-list         Browse 38+ skills"
    echo "  skills-install X    Install skill"
    echo ""
    echo "HELPERS"
    echo "  turbo-init          Initialize full workspace"
    echo "  turbo-status        Check all tools"
    echo "  cf-task <a> \"t\"     Quick agent task"
}

# Status check
turbo-status() {
    echo "📊 Turbo Flow v1.0.6 Status"
    echo "═══════════════════════════"
    echo ""
    echo "Core Tools:"
    echo "  Node.js:        $(node -v 2>/dev/null || echo '❌ not found')"
    echo "  Claude Code:    $(command -v claude >/dev/null && echo '✅ installed' || echo '❌ not found')"
    echo "  Claude Flow v3: $(npx -y claude-flow@v3alpha --version 2>/dev/null || echo '❌ not found')"
    echo ""
    echo "Testing:"
    echo "  Agentic QE:     $(npx -y agentic-qe --version 2>/dev/null || echo '❌ not found')"
    echo "  Playwriter:     $([ -d ~/.playwriter ] && echo '✅ installed' || echo '❌ not found')"
    echo ""
    echo "Frontend:"
    echo "  Dev-Browser:    $([ -d ~/.dev-browser ] && echo '✅ installed' || echo '❌ not found')"
    echo ""
    echo "Security:"
    echo "  Analyzer:       $([ -d ~/.security-analyzer ] && echo '✅ installed' || echo '❌ not found')"
    echo ""
    echo "Specs:"
    echo "  Spec-Kit:       $(command -v specify >/dev/null && echo '✅ installed' || echo '❌ not found')"
    echo "  OpenSpec:       $(command -v openspec >/dev/null && echo '✅ installed' || echo '❌ not found')"
    echo ""
    echo "Workspace:"
    echo "  Claude Flow:    $([ -d .claude-flow ] && echo '✅ initialized' || echo '⚠️ not initialized')"
    echo "  Spec-Kit:       $([ -d .specify ] && echo '✅ initialized' || echo '⚠️ not initialized')"
    echo "  OpenSpec:       $([ -d openspec ] && echo '✅ initialized' || echo '⚠️ not initialized')"
}

# Generate CLAUDE.md from specs
generate-claude-md() {
    claude "Read the .specify/ directory and generate an optimal CLAUDE.md for this project based on the specs, plan, and constitution."
}

# ═══════════════════════════════════════════════════════════════
# PATH
# ═══════════════════════════════════════════════════════════════
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"

# ═══════════════════════════════════════════════════════════════
# STARTUP MESSAGE
# ═══════════════════════════════════════════════════════════════
echo "✅ Turbo Flow v1.0.6 aliases loaded!"
echo "   Powered by RuvVector Neural Engine"
echo "   Run 'turbo-help' for quick reference"
