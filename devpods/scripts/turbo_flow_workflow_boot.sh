#!/bin/bash

# Turbo Flow v3.1.0 — Ultimate Companion Script
# Simplified automation for complex agentic workflows.

set -x

# --- Styles ---
BOLD=$(tput bold)
CYAN=$(tput setaf 6)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
MAGENTA=$(tput setaf 5)
RESET=$(tput sgr0)

header() {
    clear
    echo "${BOLD}${CYAN}=============================================="
    echo "       TURBO FLOW v3.1.0 COMMAND CENTER       "
    echo "==============================================${RESET}\n"
}

# --- Workflow Modules ---

run_boot() {
    header
    echo "${YELLOW}▶ Initializing Full Stack...${RESET}"
    cf-init
    cf-doctor
    npx -y claude-flow@alpha memory init
    claude mcp add claude-flow -- npx -y claude-flow@alpha mcp start
    claude mcp add agentdb -- npx -y agentdb mcp
    ruv-init && hooks-train
    cf-daemon
    echo "\n${GREEN}✔ System is Live.${RESET}"
    sleep 2
}

run_dev_swarm() {
    header
    echo "${MAGENTA}▶ Launching Development Swarm${RESET}"
    read -p "Briefly describe the task: " TASK
    read -p "Number of coders (default 2): " CODERS
    CODERS=${CODERS:-2}
    
    echo "\n${YELLOW}Routing task through RuVector...${RESET}"
    ruv-route "$TASK"
    
    echo "${YELLOW}Spawning hierarchical swarm...${RESET}"
    cf-swarm "Create a swarm with $CODERS coders and 1 tester to: $TASK"
}

run_memory_ops() {
    header
    echo "${YELLOW}Memory Management Options:${RESET}"
    echo "1) V-Search (Semantic search in Claude Flow)"
    echo "2) AgentDB Query (HNSW Vector search)"
    echo "3) Consolidate Learnings (Sync RuVector)"
    echo "4) Rebuild HNSW Index"
    read -p "Selection: " MEM_CHOICE

    case $MEM_CHOICE in
        1) read -p "Query: " Q; mem-vsearch "$Q" ;;
        2) read -p "Query: " Q; agentdb-query "$Q" ;;
        3) ruv-learn && ruv-stats ;;
        4) mem-hnsw ;;
    esac
    read -p "Press enter to return..."
}

run_ui_ux() {
    header
    echo "${GREEN}▶ UI/UX Pro Max Mode${RESET}"
    read -p "Describe the UI component/page: " UI_TASK
    echo "${YELLOW}Injecting design intelligence...${RESET}"
    # This feeds the context for the next Claude Code prompt
    mem-store "current_ui_focus" "$UI_TASK"
    echo "System: 'Design a $UI_TASK using professional SaaS palettes and accessibility guidelines'"
}

# --- Main Interaction Loop ---
while true; do
    header
    echo "${BOLD}Select your active workflow:${RESET}"
    echo "${CYAN}1) [BOOT]${RESET}    Full System Startup"
    echo "${CYAN}2) [BUILD]${RESET}   New Feature Swarm (Hierarchical)"
    echo "${CYAN}3) [FIX]${RESET}     Refactor/Bug Mesh (Parallel)"
    echo "${CYAN}4) [UI/UX]${RESET}   Design System & Frontend Build"
    echo "${CYAN}5) [MEMORY]${RESET}  Search, Sync, or Indexing"
    echo "${CYAN}6) [STATUS]${RESET}  Check Health (Turbo Status)"
    echo "${CYAN}q) [EXIT]${RESET}"
    echo "----------------------------------------------"
    read -p "Action: " MAIN_CHOICE

    case $MAIN_CHOICE in
        1) run_boot ;;
        2) run_dev_swarm ;;
        3) cf-mesh "Analyze and refactor the current directory" ;;
        4) run_ui_ux ;;
        5) run_memory_ops ;;
        6) turbo-status; read -p "Press enter..." ;;
        q) exit 0 ;;
        *) echo "Invalid choice." ; sleep 1 ;;
    esac
done
