#!/bin/bash

# --- Function to safely get user input ---
get_input() {
    local prompt=$1
    local var_name=$2
    # Use 'read -r' for safer input reading
    read -r -p "$prompt: " "$var_name"
}

# --- Main Script Execution ---

echo "--- 💡 Structured Project Plan Prompt Generator ---"
echo "This script will collect your project details and generate a highly structured LLM prompt."
echo ""

# Get user variables
get_input "1. Enter the NEW Project Name (e.g., 'Decentralized Energy Trader')" PROJECT_NAME
get_input "2. Enter the NEW Core Technology Stack (e.g., 'TensorFlow, Reinforcement Learning, Kubernetes')" CORE_TECH
get_input "3. Enter the NEW System Domain/Goal (e.g., 'Decentralized Energy Trading Platform')" SYSTEM_GOAL
get_input "4. Enter the Primary Programming Language (e.g., 'Python' or 'TypeScript' or 'Go')" LANG
get_input "5. Enter the Total Project Timeline (e.g., '8 Weeks')" TIMELINE

# Sanitize/prepare variables for the final prompt
# Creates a slug (e.g., decentralized-energy-trader) for the file delimiter
PROJECT_SLUG=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr -c '[:alnum:]\n' '-' | sed 's/-*$//' | sed 's/^-*//')

# Determine file extension for code snippets
LANG_LOWER=$(echo "$LANG" | tr '[:upper:]' '[:lower:]')
case "$LANG_LOWER" in
    python) LANG_EXTENSION="py";;
    go) LANG_EXTENSION="go";;
    typescript) LANG_EXTENSION="ts";;
    javascript) LANG_EXTENSION="js";;
    *) LANG_EXTENSION="code";; # Default
esac

# Construct the LLM Prompt using a heredoc
LLM_PROMPT=$(cat <<EOM
**GOAL:** You are an expert Software Architect and Technical Planner. Your task is to generate a comprehensive set of project planning documents for a new system called **"$PROJECT_NAME"** with the goal of **$SYSTEM_GOAL**.

**FORMAT AND STYLE:**
The plans MUST be formatted in **Markdown** and adhere strictly to the structure, style, and content sections of the 'Renewal Trader' system plans (e.g., clear headers, checklists, code snippets, success metrics).

**NEW PROJECT PARAMETERS:**
* **Project Name:** $PROJECT_NAME
* **System Goal:** $SYSTEM_GOAL
* **Core Technology Stack:** $CORE_TECH
* **Primary Language:** $LANG (Extension: .$LANG_EXTENSION)
* **Total Timeline:** $TIMELINE

**MANDATORY OUTPUT FILES (10 Files):**
The output must be a single response containing the content of all 10 files, clearly separated by a custom file delimiter string. You MUST use the structure and naming conventions of the original plans, adapting the content to the new project parameters.

1.  **00-MASTER-PLAN.md:** (Master Plan) - Must list all other files, the core technologies ($CORE_TECH), and a 'Next Steps' guide.
2.  **01-ARCHITECTURE.md:** (Architecture Plan) - Must include a **layered architecture diagram** similar to the original, tailored for the $SYSTEM_GOAL.
3.  **02-CORE-SYSTEM.md:** (Core Engine) - Detail the main execution/processing component, including a sample **$LANG** class snippet and success metrics.
4.  **03-AGENTS.md OR 03-MODULES.md:** (Intelligent Component) - Detail the primary intelligent/autonomous components, replacing GOAP/SAFLA with concepts relevant to $CORE_TECH. Include a **$LANG** class snippet.
5.  **04-DATA-FEEDS.md OR 04-DATA-SOURCES.md:** (Data Integration) - Detail the required data sources (e.g., market data, sensors, public APIs) and the real-time processing/streaming component. Include a **$LANG** class snippet.
6.  **05-STRATEGIES.md OR 05-LOGIC.md:** (Decision Logic) - Detail the main decision-making strategies or logic algorithms. Include a **$LANG** base class snippet.
7.  **06-COORDINATION.md OR 06-ORCHESTRATION.md:** (Distributed Control) - Detail the multi-component coordination, swarm, or orchestration mechanism (e.g., Kubernetes, Message Queue, RPC). Must include a diagram or a relevant CLI/code snippet.
8.  **07-TESTING.md:** (New File) - A plan for testing, backtesting, and quality assurance.
9.  **08-DEPLOYMENT.md:** (New File) - A plan for CI/CD and deployment (e.g., cloud platform, cloud vendor, serverless architecture).
10. **09-MODIFICATION-GUIDE.md:** (Customization Guide) - A guide on how to extend the system (e.g., add new strategies, agents, or data feeds).

**STRUCTURE FOR EACH FILE (Mandatory Template Usage):**
Each file MUST include these sections, in order, adapting the titles and content to the specific file:
\`\`\`markdown
# [Title] - [Phase Name]
## 🎯 Overview
**Timeline**: [...]
**Dependencies**: [...]
**Deliverables**: [...]

## 📋 Implementation Checklist
- [ ] Task 1
- [ ] Task 2

## 🏗️ Core Components
### 1. [Main Component Name]
**File**: \`src/[path]/[FileName].$LANG_EXTENSION\`
\`\`\`$LANG
// [A realistic, short code snippet in $LANG]
\`\`\`

## 🚀 [Integration/Usage/Testing/Deployment Section]

## 📊 Success Metrics
- [ ] Metric 1
- [ ] Metric 2

## 🔗 Next Steps / 📚 Resources
\`\`\`

**DELIMITER:** Use the string **---END\_OF\_FILE:$PROJECT\_SLUG:FILENAME---** to separate the contents of each file.
For example, the content of **00-MASTER-PLAN.md** must be followed by: **---END\_OF\_FILE:$PROJECT\_SLUG:00-MASTER-PLAN.md---**
EOM
)

# Output the final LLM prompt clearly
echo ""
echo "------------------------------"
echo "--- ✅ Generated LLM Prompt ---"
echo "------------------------------"
echo ""
echo "$LLM_PROMPT"
echo ""
echo "------------------------------"
echo "--- End of Generated Prompt ---"
echo "------------------------------"

exit 0
