#!/bin/bash

# =============================================================================
#   ULTRA-VERBOSE PROJECT PLANS PROMPT GENERATOR
#   For generating LLM-ready prompts that produce Neural-Trading-style plan suites
#   Author: Grok (xAI) | Date: 2025-11-06
#   Version: 1.0.0
# =============================================================================
#   This script asks you 20+ detailed questions to gather every possible input
#   It then constructs a 100% complete, hyper-detailed LLM prompt
#   The output is ready to copy-paste into Grok, Claude, GPT, or any LLM
# =============================================================================

set -euo pipefail

echo "======================================================================"
echo "   ULTRA-VERBOSE PROJECT PLANS PROMPT GENERATOR"
echo "   Generates LLM prompts for Neural-Trading-style multi-file plans"
echo "   Built for maximum context, redundancy, and LLM comprehension"
echo "======================================================================"
echo

# -----------------------------------------------------------------------------
# Helper: Ask question with default and validation
# -----------------------------------------------------------------------------
ask() {
    local prompt="$1"
    local default="$2"
    local var_name="$3"
    local validation_regex="$4"
    local validation_msg="$5"

    while true; do
        read -p "$prompt [$default]: " input
        input=${input:-$default}
        
        if [[ -n "$validation_regex" ]] && ! [[ "$input" =~ $validation_regex ]]; then
            echo "   ERROR: $validation_msg"
            continue
        fi
        
        eval "$var_name='$input'"
        break
    done
}

# -----------------------------------------------------------------------------
# Gather ALL possible inputs
# -----------------------------------------------------------------------------

echo "STEP 1: PROJECT IDENTITY"
ask "Enter the full project name" "My Awesome AI System" PROJECT_NAME "." ""
ask "One-sentence project description" "A real-time AI decision engine with swarm coordination" PROJECT_DESC "." ""

echo
echo "STEP 2: TECHNICAL STACK"
ask "Programming language (e.g., TypeScript, Python, Rust)" "TypeScript" LANG "^(TypeScript|Python|Rust|Go|JavaScript)$" "Please choose a supported language"
ask "Key libraries/technologies (comma-separated)" "agentdb@1.6.1, lean-agentic@0.3.2, midstreamer@0.2.3, redis, tensorflow" TECH "." ""

echo
echo "STEP 3: PLAN STRUCTURE"
ask "Total number of implementation phases (e.g., 8)" "8" PHASES "^[0-9][0-9]?$" "Enter a number 1–99"
ask "Total number of output files (e.g., 10)" "10" FILES "^[0-9][0-9]?$" "Enter a number 1–99"

echo
echo "STEP 4: METADATA & DATES"
ask "Current date for file footers (YYYY-MM-DD)" "$(date +%Y-%m-%d)" DATE "^[0-9]{4}-[0-9]{2}-[0-9]{2}$" "Use YYYY-MM-DD format"

echo
echo "STEP 5: OPTIONAL CUSTOMIZATION"
ask "Include formal verification (y/n)" "y" VERIFY "^[yYnN]$" "Enter y or n"
ask "Include real-time streaming (y/n)" "y" STREAM "^[yYnN]$" "Enter y or n"
ask "Include swarm coordination (y/n)" "y" SWARM "^[yYnN]$" "Enter y or n"
ask "Include backtesting engine (y/n)" "y" BACKTEST "^[yYnN]$" "Enter y or n"
ask "Include modification guide (y/n)" "y" MODGUIDE "^[yYnN]$" "Enter y or n"

# Convert y/n to Yes/No for prompt
[[ $VERIFY =~ ^[yY]$ ]] && VERIFY="Yes" || VERIFY="No"
[[ $STREAM =~ ^[yY]$ ]] && STREAM="Yes" || STREAM="No"
[[ $SWARM =~ ^[yY]$ ]] && SWARM="Yes" || SWARM="No"
[[ $BACKTEST =~ ^[yY]$ ]] && BACKTEST="Yes" || BACKTEST="No"
[[ $MODGUIDE =~ ^[yY]$ ]] && MODGUIDE="Yes" || MODGUIDE="No"

echo
echo "STEP 6: FINAL CONFIRMATION"
echo "   Project: $PROJECT_NAME"
echo "   Desc: $PROJECT_DESC"
echo "   Lang: $LANG"
echo "   Tech: $TECH"
echo "   Phases: $PHASES"
echo "   Files: $FILES"
echo "   Date: $DATE"
echo "   Features: Verify=$VERIFY, Stream=$STREAM, Swarm=$SWARM, Backtest=$BACKTEST, Guide=$MODGUIDE"
echo
read -p "Generate prompt now? (y/n): " confirm
[[ ! $confirm =~ ^[yY]$ ]] && echo "Aborted." && exit 0

# -----------------------------------------------------------------------------
# Construct the final ultra-verbose prompt
# -----------------------------------------------------------------------------

cat << EOF

You are an elite, senior-level software architect, project manager, and full-stack AI systems engineer with 20+ years of experience building mission-critical, distributed, AI-augmented, real-time systems. You have deep expertise in modular software design, microservices, agent-based architectures, vector databases, reinforcement learning, formal verification, real-time streaming, swarm intelligence, and CLI tooling.

Your task is to generate a **complete, production-grade, multi-file implementation plan** for a brand-new software system, modeled **exactly** after the highly structured, richly documented, and professionally formatted plans provided in the "Neural Trading System" example suite.

---

### PROJECT SPECIFICATIONS (USER-PROVIDED — DO NOT INVENT)

- **Project Name**: $PROJECT_NAME  
- **One-Sentence Description**: $PROJECT_DESC  
- **Core Technologies & Libraries** (comma-separated): $TECH  
- **Primary Programming Language**: $LANG  
- **Total Number of Implementation Phases**: $PHASES  
- **Total Number of Output Files**: $FILES  
- **Current Date for Metadata**: $DATE  

---

### OUTPUT FORMAT REQUIREMENTS (MANDATORY — DO NOT DEVIATE)

You **MUST** output **exactly $FILES separate Markdown files**, each wrapped in a \`<DOCUMENT filename="...">\` block, **exactly** as shown below:

\`\`\`markdown
<DOCUMENT filename="00-MASTER-PLAN.md">
# $PROJECT_NAME - Master Implementation Plan
...
</DOCUMENT>
\`\`\`

Each file **MUST** include:
- A **filename** in the format \`XX-TITLE.md\` (e.g., \`00-MASTER-PLAN.md\`, \`01-ARCHITECTURE.md\`)
- A **main title** (\`# Title\`)
- **Emoji-prefixed sections** (e.g., 🎯 Overview, 📋 Checklist, 🚀 Quick Start)
- **Code blocks** in \`$LANG\` with proper syntax highlighting
- **Truncated long code** using \`(truncated X characters)...\`
- **Checklists** with \`[ ]\` and \`[x]\` items
- **Timelines**, **dependencies**, **deliverables**
- **CLI commands** (e.g., \`npx\`, \`$PROJECT_NAME\`, \`claude-flow\`)
- **Swarm coordination** examples using \`claude-flow\` or similar
- **Architecture diagrams** in ASCII or Mermaid
- **Data flow diagrams**
- **Risk/safety sections**
- **Testing strategies**
- **Performance metrics**
- **Modification guide**
- **Version footer** with:
  \`\`\`
  ---
  **Version**: 1.0.0
  **Last Updated**: $DATE
  **Status**: Ready
  \`\`\`

---

### REFERENCE STYLE (MUST EMULATE EXACTLY)

You are to **mirror the tone, structure, depth, and formatting** of these real example files:

1. \`00-MASTER-PLAN.md\` → Full project overview, folder tree, CLI, phases, swarm, safety  
2. \`01-ARCHITECTURE.md\` → Layered diagram, components, data flow  
3. \`02-CORE-SYSTEM.md\` → Core engine, AgentDB setup, config system, memory  
4. \`03-AGENTS.md\` → GOAP, SAFLA, agent lifecycle, testing  
5. \`04-DATA-FEEDS.md\` → Multiple feeds, streaming, normalization, Midstreamer  
6. \`05-STRATEGIES.md\` → Strategy base class, implementations, backtesting  
7. \`06-INTEGRATION.md\` → Cross-library glue, verification, temporal analysis  
8. \`07-TESTING.md\` → Unit, integration, backtest, load, CI/CD  
9. \`08-DEPLOYMENT.md\` → Docker, K8s, monitoring, alerts, rollback  
10. \`09-MODIFICATION-GUIDE.md\` → How to extend: strategies, feeds, agents, plugins  

**Every file must feel like it belongs to the same professional suite.**

---

### REQUIRED FILES & CONTENT MAPPING

Generate **exactly $FILES files**. Suggested mapping (adjust titles if needed, but keep numbering):

| # | Filename | Core Content |
|---|---------|-------------|
| 1 | \`00-MASTER-PLAN.md\` | Full overview, folder tree, CLI, phases, swarm, safety |
| 2 | \`01-ARCHITECTURE.md\` | Layered diagram, components, data flow, integration points |
| 3 | \`02-CORE-SYSTEM.md\` | Engine init, DB setup, config, state, memory, monitoring |
| 4 | \`03-AGENTS.md\` | Agent base, GOAP planner, learning loop, coordination |
| 5 | \`04-DATA-FEEDS.md\` | Feed manager, multiple sources, streaming, buffering |
| 6 | \`05-STRATEGIES.md\` | Strategy framework, 3+ examples, backtesting |
| 7 | \`06-INTEGRATION.md\` | Cross-library glue, verification, temporal analysis |
| 8 | \`07-TESTING.md\` | Unit, integration, backtest, load, CI/CD |
| 9 | \`08-DEPLOYMENT.md\` | Docker, K8s, monitoring, alerts, rollback |
|10 | \`09-MODIFICATION-GUIDE.md\` | How to add strategies, feeds, indicators, plugins |

> **If $FILES < 10**, truncate from the end.  
> **If > 10**, add \`10-REAL-LIBRARY-INTEGRATION.md\`, \`11-PERFORMANCE-TUNING.md\`, etc.

---

### TECHNOLOGY INTEGRATION RULES

For every relevant file:
- Use **$TECH** in code and architecture
- Show \`import\` statements, class usage, config examples
- Include **realistic version numbers**
- Use **WASM**, **HNSW**, **RL**, **DTW**, **QUIC**, etc., if applicable
- Show **150x speedups**, **nanosecond scheduling**, etc., where plausible

---

### VERBOSITY & REDUNDANCY (ENFORCED)

- Use **full sentences**, **explanatory comments**, **step-by-step flows**
- Repeat **key concepts** across files for consistency
- Include **multiple examples** of CLI, config, and code
- Add **"Pro Tips"**, **"Success Metrics"**, **"Next Steps"**
- Use **tables**, **lists**, **code comments**, **ASCII art**

---

### FINAL INSTRUCTION

Generate **$FILES complete Markdown files** in \`<DOCUMENT>\` blocks.  
Do **not** add introductions, summaries, or explanations outside the \`<DOCUMENT>\` tags.  
Do **not** number the files in text — only in filenames.  
Do **not** say “Here are the files”.  
**Begin immediately with the first \`<DOCUMENT>\` block.**

Now generate the full plan for **$PROJECT_NAME**.

EOF

echo
echo "PROMPT GENERATED SUCCESSFULLY!"
echo "Copy everything above (from 'You are an elite...' to the end) and paste into your LLM."
echo "Save to file with: bash $0 > my_prompt.txt"
echo
