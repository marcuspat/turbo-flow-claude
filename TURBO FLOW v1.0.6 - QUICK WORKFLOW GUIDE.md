# TURBO FLOW v1.0.6 - QUICK WORKFLOW GUIDE

**RuV's Enterprise Development Workflow**

*Based on the January 2026 Claude Flow v3 Demo*

---

## Overview

This guide walks through RuV's recommended workflow for enterprise-grade AI-assisted development using Claude Flow v3 with RuvVector neural intelligence. The key principle: **Just ask it. If something isn't working, ask "why is this not working, can you fix it?"**

---

## Phase 1: Research & Planning

### Step 1: Create Research Directory Structure

```bash
# Create the plans/research directory
mkdir -p plans/research

# Create your research file with findings
cat > plans/research/intro.md << 'EOF'
# Research: [Your Topic]

## Overview
[Paste your research findings here - from ChatGPT, papers, existing implementations, etc.]

## Key Concepts
- Concept 1
- Concept 2

## Technical Requirements
- Requirement 1
- Requirement 2

## Reference Materials
- [Link 1]
- [Link 2]

## Notes
[Additional observations and insights]
EOF
```

### Step 2: Add Your Research Content

```bash
# Edit the intro.md with your actual research
# Example: GOAP (Goal-Oriented Action Planning) research
nano plans/research/intro.md

# Or use Claude to help gather research
claude
> "Research [your topic] and create a comprehensive intro.md in plans/research/"
```

---

## Phase 2: ADR/DDD Architecture (Don't Implement Yet!)

### Step 3: Generate Architecture from Research

**The Critical Prompt:**

```
Review the "/plans/research" directory and create a detailed ADR/DDD implementation 
using all the various capabilities of Claude Flow v3:
- Self-learning (SONA neural patterns)
- Security (AIDefence, vulnerability scanning)
- Hooks (pre/post operations, trajectory learning)
- Memory (AgentDB, HNSW vector search)
- Workers (background processing)
- All other optimizations

Spawn swarm, do NOT implement yet. Just plan.
```

**Run it:**

```bash
# Initialize Claude Flow v3 first
cf-init

# Start Claude and give the prompt
claude
> "[paste the prompt above]"
```

### What This Generates:

```
plans/
├── research/
│   └── intro.md              # Your research
├── architecture/
│   ├── ADR-001-core.md       # Architecture Decision Records
│   ├── ADR-002-memory.md
│   ├── ADR-003-security.md
│   └── ...
├── ddd/
│   ├── domains/              # Domain-Driven Design
│   ├── bounded-contexts/
│   └── aggregates/
└── implementation/
    └── plan.md               # Implementation roadmap
```

---

## Phase 3: Project Setup & Version Control

### Step 4: Name Your Project & Create Branch

```bash
# Ask Claude to suggest a name
claude
> "Based on the ADR/DDD we just outlined, what's a good project name? 
   Let's call it [suggested name]"

# Create and switch to new branch
git checkout -b feature/[project-name]

# Or let Claude do it
claude
> "Create new branch '[project-name]' and commit the architecture files"
```

---

## Phase 4: Configure Status Line & Hooks

### Step 5: Update Status Line to Match DDD

First, understand what helpers are available:

```bash
# Ask Claude about the helpers
claude
> "Tell me about the various helpers and what they do in these paths. Be brief:
   - .claude-flow/hooks/
   - .claude-flow/helpers/
   - .claude-flow/workers/
   - .claude-flow/statusline/"
```

Then configure:

```bash
claude
> "Update the statusline to match the DDD we just outlined using the ADRs 
   and available hooks and helpers.
   
   Helpers available:
   [paste the helper paths from the helper directory]"
```

### Step 6: Configure Hooks for Your Domains

```bash
claude
> "Configure the hooks system to:
   1. Track trajectory learning for each bounded context
   2. Auto-trigger security scans on sensitive domains
   3. Store successful patterns in AgentDB
   4. Update statusline on domain state changes"
```

---

## Phase 5: Implementation (Spawn the Swarm!)

### Step 7: Full Implementation with Swarm

**The Implementation Prompt:**

```
Spawn swarm, implement completely:
- Test all components
- Validate against ADRs
- Benchmark performance
- Optimize bottlenecks
- Document everything
- Continue until complete
```

**Run in Split Terminal (Critical!):**

```bash
# Terminal 1: Spawn the swarm
cf-swarm
npx claude-flow@v3alpha swarm "implement the [project-name] system completely" \
  --topology hierarchical-mesh \
  --max-agents 15

# Terminal 2: Interrogate/Monitor (in new tmux pane)
tsh  # Split horizontal
claude
> "What's the current status of the implementation?"
> "Which agents are working on what?"
> "Are there any blockers?"
```

### Step 8: Monitor & Debug

```bash
# Check progress
cf-progress --detailed

# Check swarm status
cf-swarm-status

# Query what's been learned
cf-memory "implementation patterns"

# If something isn't working:
claude
> "Why is [component] not working? Can you fix it?"
```

---

## Phase 6: RuvVector Neural Optimization

### Step 9: Train Neural Patterns

```bash
# Train RuvVector on successful implementation patterns
cf-train --pattern_type implementation \
  --training_data "successful patterns from [project-name]"

# Enable intelligent routing for future tasks
cf-route "optimize [specific component]"

# Store learned patterns
npx claude-flow@v3alpha hooks intelligence pattern-store \
  --pattern "[project-name]-patterns"
```

### Step 10: Export/Import Model (For Sharing)

**Export your trained model:**

```bash
claude
> "Tell me how I can export my Claude Flow v3 model and import into another 
   Claude Flow environment"

# The export process:
npx claude-flow@v3alpha memory export --namespace [project-name] \
  --output ./exports/[project-name]-model.json

npx claude-flow@v3alpha neural export \
  --patterns ./exports/[project-name]-patterns.json
```

**Import in another environment:**

```bash
# On the target environment
cf-init

npx claude-flow@v3alpha memory import \
  --input ./exports/[project-name]-model.json

npx claude-flow@v3alpha neural import \
  --patterns ./exports/[project-name]-patterns.json
```

---

## Phase 7: Testing & Validation

### Step 11: Generate Playwright E2E Tests

```bash
# Use Playwriter for AI-generated tests
pw-test "complete end-to-end test for [project-name] user flows"

# Or ask Claude directly
claude
> "Go create me a Playwright end-to-end test for [component] and optimize"

# Run the tests
npx playwright test
```

### Step 12: Quality Gate

```bash
# Run Agentic QE pipeline
aqe init
aqe-generate
aqe-run
aqe-gate --coverage 90

# Security validation
sec-audit
security-scan
```

---

## Phase 8: Deployment & Cloud Integration

### Step 13: Deploy with Agentic Flow

For long-running agents in cloud environments:

```bash
claude
> "Claude, can you deploy yourself on [platform]? Here is the API key: [key]
   
   Target platforms:
   - Cloud Functions
   - Cloud Run  
   - Rackspace Spot
   
   Configure for long-running agent execution with Agentic Flow."
```

### Step 14: Monitor Token Usage & Savings

```bash
claude
> "Go customize the status line to show:
   - How much tokens I am using
   - What is my cost savings from intelligent routing
   - Current swarm efficiency metrics"
```

---

## Phase 9: Documentation & Assets

### Step 15: Create Assets Directory

```bash
# Create assets folder for screenshots, diagrams, etc.
mkdir -p assets/screenshots
mkdir -p assets/diagrams

# Take screenshots of your UI at specific sizes
# IMPORTANT: Be very specific about window dimensions!
claude
> "When evaluating the frontend, use window size 1920x1080 for desktop 
   and 375x812 for mobile (iPhone X)"
```

### Step 16: Generate Documentation

```bash
claude
> "Generate comprehensive documentation for [project-name]:
   - API documentation
   - Architecture diagrams
   - User guides
   - Deployment instructions
   
   Save to docs/ directory"
```

---

## Phase 10: Delegation & Research

### Step 17: Delegate Research Tasks

```bash
claude
> "Delegate any questioning or research about [topic] to Claude Code.
   Point it at these resources and code sources to find the answer:
   - [resource 1]
   - [code path 1]
   - [documentation link]
   
   Then tell me where it's referencing the answer."
```

---

## Quick Reference: Key Prompts

### Planning Phase
```
"Review /plans/research and create detailed ADR/DDD implementation using 
Claude Flow v3 capabilities. Spawn swarm, do NOT implement yet."
```

### Implementation Phase
```
"Spawn swarm, implement completely, test, validate, benchmark, optimize, 
document, continue until complete."
```

### Debugging
```
"Why is [this] not working? Can you fix it?"
```

### Export Model
```
"Tell me how I can export my Claude Flow v3 model and import into 
another Claude Flow environment"
```

### Status Line
```
"Go figure out how much tokens I am using and what is my savings. 
Update the statusline."
```

### Testing
```
"Go create me a Playwright end-to-end test for [component] and optimize"
```

### Deployment
```
"Claude, can you deploy yourself on [platform]? Here is the API key."
```

---

## Recommended Terminal Layout

```
┌─────────────────────────────────────────┬─────────────────────────────────────────┐
│                                         │                                         │
│  SWARM EXECUTION                        │  INTERROGATION / MONITORING             │
│                                         │                                         │
│  $ cf-swarm                             │  $ claude                               │
│  $ npx claude-flow@v3alpha swarm        │  > "What's the status?"                 │
│    "implement [project]"                │  > "Any blockers?"                      │
│    --topology hierarchical-mesh         │  > "Why is X not working?"              │
│                                         │                                         │
├─────────────────────────────────────────┼─────────────────────────────────────────┤
│                                         │                                         │
│  PROGRESS & METRICS                     │  TESTING                                │
│                                         │                                         │
│  $ cf-progress --detailed               │  $ npx playwright test                  │
│  $ cf-memory-status                     │  $ aqe-run                              │
│  $ turbo-status                         │  $ sec-audit                            │
│                                         │                                         │
└─────────────────────────────────────────┴─────────────────────────────────────────┘
```

**Tmux Setup:**
```bash
# Create the layout
tmux new-session -s turbo
tsh  # Split horizontal
tsv  # Split vertical in right pane
# Ctrl+b then arrow keys to navigate
```

---

## Technology Selection Guide

| Use Case | Technology | Notes |
|----------|------------|-------|
| **Logic/Planning** | RuvVector | SONA neural intelligence, pattern learning |
| **Long-running Agents** | Agentic Flow | Cloud Functions, Cloud Run, Rackspace |
| **Frontend Testing** | Playwright | Visual testing, E2E, specific window sizes |
| **Fast Prototyping** | Vibium | New, not mature, but faster |
| **Test Generation** | Playwriter | AI writes tests from descriptions |
| **Visual Dev** | Dev-Browser | Browser-based IDE with AI |
| **Security** | Security Analyzer + v3 AIDefence | Dual-layer protection |

---

## Troubleshooting

### Swarm Not Responding
```bash
claude
> "Why is the swarm not responding? Can you fix it?"

# Check status
cf-swarm-status
cf-progress --detailed
```

### Memory Issues
```bash
# Check memory
cf-memory-status

# Clear and reinitialize if needed
npx claude-flow@v3alpha memory clear --namespace all
cf-init
```

### Tests Failing
```bash
claude
> "The [test name] is failing. Can you debug and fix it?"

# Re-run with analysis
aqe-run --analyze
```

---

## Summary: The RuV Workflow

1. **Research** → `plans/research/intro.md`
2. **Architecture** → ADR/DDD (don't implement!)
3. **Branch** → `git checkout -b feature/[name]`
4. **Configure** → Status line, hooks, helpers
5. **Implement** → Spawn swarm in split terminal
6. **Monitor** → Interrogate in second terminal
7. **Test** → Playwright E2E, Agentic QE
8. **Optimize** → RuvVector patterns
9. **Export** → Share trained model
10. **Deploy** → Cloud with Agentic Flow

**The Golden Rule:** Just ask it. If something isn't working, ask "why is this not working, can you fix it?"

---

*Turbo Flow v1.0.6 - Powered by RuvVector Neural Engine*
