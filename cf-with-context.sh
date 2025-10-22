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
