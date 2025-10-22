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
