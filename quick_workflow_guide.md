# TURBO FLOW v1.0.6 - QUICK WORKFLOW

**Prompts for Claude | RuvVector-Powered Development**

---

## THE GOLDEN RULE

**Just ask Claude.** If something isn't working, ask: *"Why is this not working? Can you fix it?"*

---

## 1. SETUP & RESEARCH

### Initialize Workspace

```bash
turbo-init
source ~/.bashrc
ruv-init
```

### Create Research Directory

> Create a plans/research directory and place an intro.md file with research on [YOUR TOPIC] including key concepts, technical requirements, and reference materials

*Example: "Create plans/research/intro.md with research on ChatGPT and GOAP (Goal-Oriented Action Planning)"*

---

## 2. ARCHITECTURE & ADR

> Review /plans/research and create a detailed ADR/DDD implementation using all the various capabilities of Claude Flow: SONA self-learning, Security AIDefence, Hooks, AgentDB memory, ReasoningBank, and other optimizations. Define bounded contexts using DDD principles. Spawn swarm, do NOT implement yet.

---

## 3. SPEC-KIT + OPENSPEC (Choose One or Both)

**Spec-Kit** and **OpenSpec** are specification tools that complement Claude Flow's ADR/DDD architecture. Use them to formalize and track your specifications.

### How They Work Together

```
┌─────────────────────────────────────────────────────────────────┐
│  plans/research/intro.md        (Your research)                 │
│         ↓                                                       │
│  Claude Flow ADR/DDD            (Architecture decisions)        │
│         ↓                                                       │
│  ┌─────────────┐    ┌─────────────┐                            │
│  │  SPEC-KIT   │ OR │  OPENSPEC   │  (Formalize specs)         │
│  │  .specify/  │    │  openspec/  │                            │
│  └─────────────┘    └─────────────┘                            │
│         ↓                                                       │
│  Claude Flow Swarm              (Implementation)                │
└─────────────────────────────────────────────────────────────────┘
```

| Tool | Best For | Output |
|------|----------|--------|
| **Spec-Kit** | Constitution-driven development, coding standards, task planning | `.specify/` directory |
| **OpenSpec** | Change proposals, versioned specs, validation | `openspec/` directory |
| **Both** | Full traceability from research → specs → implementation | Both directories |

---

### Option A: Spec-Kit Only

```bash
sk-here
```

> /speckit.constitution - Define project rules, coding standards, and architectural principles based on the ADR/DDD from plans/architecture/

> /speckit.specify - Create detailed specifications for each bounded context defined in the ADR

> /speckit.plan - Generate implementation tasks that map to the DDD domains

---

### Option B: OpenSpec Only

```bash
os-init
```

> /openspec:proposal "[PROJECT NAME]" - Create a change proposal that captures the ADR decisions and bounded contexts as formal specs

> /openspec:validate - Ensure specs align with the architecture

---

### Option C: Both Together (Recommended for Large Projects)

```bash
sk-here
os-init
```

**Workflow:**
1. Use **Spec-Kit** for the constitution (coding standards, testing requirements)
2. Use **OpenSpec** for change proposals (track architectural changes over time)

> /speckit.constitution - Define the project constitution based on ADR principles

> /openspec:proposal "Initial Architecture" - Formalize the DDD bounded contexts as a versioned proposal

> /speckit.specify - Create specs that reference the OpenSpec proposal

> /openspec:validate - Validate everything is consistent

---

## 4. TRAIN RUVVECTOR

```bash
cf-train --pattern_type architecture
cf-patterns list
cf-pretrain --model-type moe
```

---

## 5. BRANCH & COMMIT

> Create new branch "[PROJECT NAME]" and commit the architecture files from plans/, .specify/, and openspec/

---

## 6. CUSTOMIZE STATUS LINE

> Update the statusline to match the DDD we just outlined using the ADRs and available hooks and helpers

**Helpers paths for reference:**

| Helper | Path |
|--------|------|
| Security | `@claude-flow/security/` |
| Memory | `@claude-flow/memory/` |
| Integration | `@claude-flow/integration/` |
| Performance | `@claude-flow/performance/` |
| Swarm | `@claude-flow/swarm/` |
| CLI | `@claude-flow/cli/` |
| Neural | `@claude-flow/neural/` |
| Hooks | `@claude-flow/hooks/` |
| Testing | `@claude-flow/testing/` |
| Deployment | `@claude-flow/deployment/` |
| Plugins | `@claude-flow/plugins/` |
| Shared | `@claude-flow/shared/` |

---

## 7. LEARN THE HELPERS

> Tell me about the various helpers and what they do at @claude-flow/*, be brief

---

## 8. IMPLEMENTATION (Hierarchical-Mesh Swarm)

### Swarm Architecture

```
                    ┌─────────────────────┐
                    │  QUEEN COORDINATOR  │
                    │     (Agent #1)      │
                    └──────────┬──────────┘
                               │
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
        ▼                      ▼                      ▼
┌───────────────┐    ┌───────────────┐    ┌───────────────┐
│   ARCHITECT   │    │    CODER      │    │   TESTER      │
└───────────────┘    └───────────────┘    └───────────────┘
```

### Anti-Drift Configuration (Recommended)

```bash
# Use hierarchical topology to prevent goal drift
npx claude-flow@v3alpha swarm init \
  --topology hierarchical \
  --maxAgents 8 \
  --strategy specialized
```

| Setting | Value | Why |
|---------|-------|-----|
| `topology` | hierarchical | Coordinator validates each output against goal |
| `maxAgents` | 6-8 | Fewer agents = less drift surface |
| `strategy` | specialized | Clear roles, no overlap |

### Agent Routing by Task Type

| Task | Agents to Spawn |
|------|-----------------|
| Bug Fix | coordinator, researcher, coder, tester |
| Feature | coordinator, architect, coder, tester, reviewer |
| Refactor | coordinator, architect, coder, reviewer |
| Performance | coordinator, perf-engineer, coder |
| Security | coordinator, security-architect, auditor |

### Two-Terminal Workflow

**Terminal 1 (Swarm):**
```bash
cf-swarm
```

**Terminal 2 (Interrogate):**

> Spawn swarm, implement completely, test, validate, benchmark, optimize, document, continue until complete

> What's the status?

> Why is [X] not working? Can you fix it?

### Auto-Swarm Detection

**Claude will AUTO-INVOKE swarm when task involves:**
- Multiple files (3+)
- New feature implementation
- Refactoring across modules
- API changes with tests
- Security-related changes
- Performance optimization

**Claude will SKIP swarm for:**
- Single file edits
- Simple bug fixes (1-2 lines)
- Documentation updates
- Configuration changes

---

## 9. EXPORT/IMPORT MODEL

> Tell me how I can export my Claude Flow v3 model and import into another Claude Flow environment

```bash
# Export
npx claude-flow@v3alpha neural export --output ./model-export/
npx claude-flow@v3alpha memory export --output ./memory-export/
npx claude-flow@v3alpha backup create --include neural,memory,config

# Import
npx claude-flow@v3alpha neural import --input ./model-export/
npx claude-flow@v3alpha memory import --input ./memory-export/
npx claude-flow@v3alpha backup restore --from ./backup/
```

---

## 10. TESTING & QA

> Claude, go create me a Playwright end-to-end test and optimize it

> When you are doing front end development, be very specific about the size of the window you are evaluating on - use 1920x1080 desktop viewport

```bash
aqe-generate
aqe-gate
pw-test "complete user journey"
sec-audit
```

**Testing Tools:**
- **Playwright** - E2E browser testing (RuV's choice)
- **Vitest** - Unit tests (newer, not as mature, but faster)
- **Agentic QE** - AI-powered test generation

---

## 11. DEPLOYMENT

> Claude, can you deploy yourself on [PLATFORM]? Here is the API key: [KEY]

**Agentic Flow** for long-running agents:
- Cloud Functions
- Cloud Run
- Rackspace

---

## 12. TOKEN & COST ANALYSIS

> Go customize the status line, go figure out how much tokens I am using and what are my savings

---

## 13. RESEARCH DELEGATION

> Delegate any questioning or research to Claude Code or preferred LLM and point it at the different resources and code sources to find the answer, then point to you where it is referencing the answer

---

## 14. ASSETS & SCREENSHOTS

> Create folder called assets, paste in screenshots etc

Use for visual context when working with Claude on frontend development.

---

## RUVVECTOR INTELLIGENCE SYSTEM

RuvVector powers the neural engine with a 4-step intelligence pipeline:

```
1. RETRIEVE  →  Fetch relevant patterns via HNSW (150x faster)
2. JUDGE     →  Evaluate with verdicts (success/failure)
3. DISTILL   →  Extract key learnings via LoRA
4. CONSOLIDATE → Prevent forgetting via EWC++
```

### Performance Specs

| Feature | Performance |
|---------|-------------|
| SONA | <0.05ms adaptation |
| EWC++ | 95%+ retention |
| MoE | 8 expert routing |
| HNSW | 150x-12,500x faster search |
| Flash Attention | 2.49x-7.47x speedup |
| Memory Reduction | 50-75% with quantization |

### 3-Tier Model Routing

| Tier | Handler | Latency | Cost | Use Cases |
|------|---------|---------|------|-----------|
| **1** | Agent Booster (WASM) | <1ms | $0 | Simple transforms (var→const, add types) |
| **2** | Haiku | ~500ms | $0.0002 | Simple tasks, low complexity |
| **3** | Sonnet/Opus | 2-5s | $0.003+ | Complex reasoning, architecture |

---

## COMPLETE WORKFLOW

```bash
# 1. Setup
turbo-init && source ~/.bashrc && ruv-init

# 2. Research
mkdir -p plans/research
# Create plans/research/intro.md

# 3. In Claude: ADR/DDD prompt
# "Review /plans/research and create ADR/DDD implementation..."

# 4. Specs (choose one or both)
sk-here && os-init

# 5. Train
cf-train --pattern_type architecture
cf-pretrain --model-type moe

# 6. Branch
git checkout -b my-project
git add plans/ .specify/ openspec/
git commit -m "Initial architecture"

# 7. Implement (two terminals)
# Terminal 1: Initialize swarm with anti-drift config
npx claude-flow@v3alpha swarm init --topology hierarchical --maxAgents 8 --strategy specialized

# Terminal 2: Interrogate
# "Spawn swarm, implement completely..."

# 8. Test
pw-test "user journey"
aqe-gate
sec-audit

# 9. Export
npx claude-flow@v3alpha backup create --include neural,memory,config
```

---

**Just ask it. Just do it. RuvVector handles the rest.**
