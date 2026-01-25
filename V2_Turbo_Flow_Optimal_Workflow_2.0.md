# V2 Turbo Flow Optimal Workflow

**Version:** 2.0.2
**Last Updated:** 2026-01-22
**Purpose:** Complete development workflow using Claude Flow V3 + RuVector Neural Engine + Agent Browser + Security Analyzer + UI Pro Max + HeroUI

---

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Installation (15-Step Setup)](#installation-15-step-setup)
3. [Quick Start](#quick-start)
4. [Command Reference](#command-reference)
5. [Workflow Phases](#workflow-phases)
6. [Tool Deep Dives](#tool-deep-dives)
7. [prd2build Command](#prd2build-command)
8. [Helper Functions](#helper-functions)
9. [Project Structure](#project-structure)
10. [Configuration Files](#configuration-files)
11. [Integration Patterns](#integration-patterns)
12. [Best Practices](#best-practices)
13. [Troubleshooting](#troubleshooting)

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                          TURBO FLOW v2.0.2 STACK                                │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                 │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐            │
│  │  CLAUDE CODE    │    │  CLAUDE FLOW V3 │    │   RUV VECTOR     │            │
│  │  (AI Agent)     │────│  (Orchestration)│────│  (Neural Engine) │            │
│  │  60+ Agents     │    │  175+ MCP Tools │    │  SONA + HNSW     │            │
│  └─────────────────┘    └─────────────────┘    └─────────────────┘            │
│           │                       │                       │                     │
│           └───────────────────────┴───────────────────────┘                   │
│                                   │                                             │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                          MCP SERVER LAYER                               │   │
│  │  claude-flow  │  agentic-qe  │  agent-browser  │  security-analyzer     │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                   │                                             │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                        SKILLS & TOOLS                                   │   │
│  │  Spec-Kit  │  OpenSpec  │  Agentic QE  │  UI Pro Max  │  Agent Browser   │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                   │                                             │
│  ┌─────────────────────────────────────────────────────────────────────────┐   │
│  │                       FRONTEND STACK                                    │   │
│  │     HeroUI Components  │  Tailwind CSS  │  Framer Motion                │   │
│  └─────────────────────────────────────────────────────────────────────────┘   │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

### Technology Stack Matrix

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Orchestration** | Claude Flow V3 | 175+ MCP tools, 54+ agents |
| **Neural Engine** | RuVector + SONA | Self-learning, HNSW vector search |
| **AI Coding** | Claude Code | Anthropic's AI coding CLI |
| **Testing** | Agentic QE | 19 testing agents |
| **Browser Automation** | Agent Browser | Chromium automation |
| **Security** | Security Analyzer | CVE scanning, vulnerability detection |
| **UI Generation** | UI Pro Max + HeroUI | Component generation |
| **Requirements** | Spec-Kit | Requirements management |
| **API Specs** | OpenSpec | OpenAPI 3.0 generation |

---

## Installation (15-Step Setup)

Run the setup script from `devpods/setup.sh`:

```bash
bash devpods/setup.sh
```

### Step-by-Step Breakdown

#### System Foundation (Steps 1-3)

| Step | Components | Command |
|------|------------|---------|
| 1 | build-essential, python3, git, curl | `apt-get install build-essential python3 git curl` |
| 2 | Node.js 20 LTS | `n 20` |
| 3 | npm cache cleanup | `npm cache clean --force` |

#### Neural Engine (Step 4)

```bash
# RuVector Core
npm install -g ruvector

# SONA (Self-Optimizing Neural Architecture)
npm install -g @ruvector/sona

# RuVector CLI (hooks & intelligence)
npm install -g @ruvector/cli

# Initialize hooks
npx @ruvector/cli hooks init
```

**Capabilities:**
- Vector DB with GNN (Graph Neural Network)
- Self-learning neural engine (<0.05ms adaptation)
- HNSW indexing (150x-12,500x faster search)
- SONA trajectory tracking

#### Orchestration (Step 5)

```bash
npx -y claude-flow@v3alpha init --force
```

**Creates:** `.claude-flow/config.json`

**Capabilities:**
- 175+ MCP tools
- 54+ specialized agents
- Swarm coordination (hierarchical, mesh, hybrid)
- Hive-Mind consensus
- Memory coordination

#### Core Packages (Step 6)

```bash
npm install -g @anthropic-ai/claude-code
npm install -g agentic-qe
npm install -g @fission-ai/openspec
npm install -g uipro-cli
npm install -g agent-browser
npm install -g @claude-flow/browser
npm install -g @ruvector/ruvllm
```

#### Skills Installation (Steps 7-8, 12)

| Skill | Source | Location |
|-------|--------|----------|
| Agent Browser | npm global + GitHub fallback | `~/.claude/skills/agent-browser/` |
| Security Analyzer | github.com/Cornjebus/security-analyzer | `~/.claude/skills/security-analyzer/` |
| UI UX Pro Max | uipro-cli --offline | `~/.claude/skills/ui-ux-pro-max/` |

**Step 7 includes Chromium installation:**
```bash
agent-browser install --with-deps
```

#### Python Tools (Step 9)

```bash
# Install uv (fast Python package manager)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Spec-Kit
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

#### Configuration (Steps 10-11, 13-14)

**MCP Servers** (`~/.config/claude/mcp.json`):
```json
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@v3alpha", "mcp", "start"]
    },
    "agentic-qe": {
      "command": "npx",
      "args": ["-y", "aqe-mcp"]
    }
  }
}
```

**prd2build Command** (`~/.claude/commands/prd2build.md`):
- PRD to complete documentation workflow

**Codex Config** (`~/.codex/instructions.md`):
- Claude profile for OpenAI Codex

**AGENTS.md** (project root):
- Codex/Claude collaboration protocol

#### Workspace Setup (Step 11)

```
project/
├── package.json          # type: "module"
├── tsconfig.json         # ES2022, ESNext modules, JSX
├── tailwind.config.js    # HeroUI plugin configured
├── postcss.config.js     # Tailwind processing
├── src/
│   └── index.css         # Tailwind directives
├── tests/
├── docs/
├── scripts/
├── config/
└── plans/
```

**Dependencies installed:**
```bash
npm install @heroui/react framer-motion
npm install -D tailwindcss postcss autoprefixer
```

#### Bash Aliases (Step 15)

40+ aliases added to `~/.bashrc` (see [Command Reference](#command-reference))

---

## Quick Start

After running `devpods/setup.sh`:

```bash
# 1. Reload shell
source ~/.bashrc

# 2. Check installation status
turbo-status

# 3. View available commands
turbo-help

# 4. Start Claude Code
claude
```

### Expected turbo-status Output

```
📊 Turbo Flow v2.0.2 Status
───────────────────────────
Node.js:       v20.x.x
RuVector:      ✅
Claude Flow:   ✅
prd2build:     ✅
Agent-Browser: ✅
Security:      ✅
UI Pro Max:    ✅
HeroUI:        ✅
```

---

## Command Reference

### RuVector (Neural Engine)

| Alias | Command | Description |
|-------|---------|-------------|
| `ruv` | `npx ruvector` | Start RuVector |
| `ruv-stats` | `npx @ruvector/cli hooks stats` | Show learning statistics |
| `ruv-route` | `npx @ruvector/cli hooks route` | Route task to best agent |
| `ruv-remember` | `npx @ruvector/cli hooks remember` | Store in semantic memory |
| `ruv-recall` | `npx @ruvector/cli hooks recall` | Search semantic memory |
| `ruv-learn` | `npx @ruvector/cli hooks learn` | Trigger learning cycle |
| `ruv-init` | `npx @ruvector/cli hooks init` | Initialize hooks |
| `ruvector-status` | `npx ruvector --version && npx @ruvector/cli hooks stats` | Full status check |

### Claude Code

| Alias | Command | Description |
|-------|---------|-------------|
| `claude` | `claude` | Start Claude Code |
| `dsp` | `claude --dangerously-skip-permissions` | Skip permissions mode |

### Claude Flow V3

| Alias | Command | Description |
|-------|---------|-------------|
| `cf` | `npx -y claude-flow@v3alpha` | Main CLI |
| `cf-init` | `npx -y claude-flow@v3alpha init --force` | Initialize workspace |
| `cf-swarm` | `npx -y claude-flow@v3alpha swarm init --topology hierarchical` | Hierarchical swarm |
| `cf-mesh` | `npx -y claude-flow@v3alpha swarm init --topology mesh` | Mesh topology |
| `cf-swarm-start` | `npx -y claude-flow@v3alpha swarm start --max-agents 15` | Start swarm with 15 agents |
| `cf-swarm-status` | `npx -y claude-flow@v3alpha swarm status` | Check swarm status |
| `cf-agent` | `npx -y claude-flow@v3alpha --agent` | Run specific agent |
| `cf-coder` | `npx -y claude-flow@v3alpha --agent coder` | Coder agent |
| `cf-reviewer` | `npx -y claude-flow@v3alpha --agent reviewer` | Reviewer agent |
| `cf-tester` | `npx -y claude-flow@v3alpha --agent tester` | Tester agent |
| `cf-security` | `npx -y claude-flow@v3alpha --agent security-architect` | Security architect |
| `cf-architect` | `npx -y claude-flow@v3alpha --agent architect` | Architect agent |
| `cf-list` | `npx -y claude-flow@v3alpha --list` | List all 54+ agents |
| `cf-daemon` | `npx -y claude-flow@v3alpha daemon start` | Start background daemon |
| `cf-memory` | `npx -y claude-flow@v3alpha memory` | Memory operations |
| `cf-memory-status` | `npx -y claude-flow@v3alpha memory status` | Memory status |
| `cf-mcp` | `npx -y claude-flow@v3alpha mcp start` | Start MCP server |
| `cf-security-audit` | `npx -y claude-flow@v3alpha security audit` | Security audit |

### Hive-Mind (Queen Coordination)

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-hive` | `npx -y claude-flow@v3alpha hive-mind spawn` | Spawn hive workers |
| `cf-hive-wizard` | `npx -y claude-flow@v3alpha hive-mind wizard` | Hive setup wizard |
| `cf-hive-status` | `npx -y claude-flow@v3alpha hive-mind status` | Hive status |
| `cf-queen` | `npx -y claude-flow@v3alpha queen command` | Queen command |
| `cf-queen-monitor` | `npx -y claude-flow@v3alpha queen monitor` | Monitor queen |

### Neural & Learning

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-neural` | `npx -y claude-flow@v3alpha neural` | Neural operations |
| `cf-train` | `npx -y claude-flow@v3alpha neural train` | Train patterns |
| `cf-patterns` | `npx -y claude-flow@v3alpha neural patterns` | View learned patterns |
| `cf-pretrain` | `npx -y claude-flow@v3alpha hooks pretrain` | Bootstrap intelligence |

### Agentic QE (Testing)

| Alias | Command | Description |
|-------|---------|-------------|
| `aqe` | `npx -y agentic-qe` | Main CLI |
| `aqe-init` | `npx -y agentic-qe init` | Initialize |
| `aqe-generate` | `npx -y agentic-qe generate` | Generate tests |
| `aqe-run` | `npx -y agentic-qe run --analyze` | Run with analysis |
| `aqe-flaky` | `npx -y agentic-qe flaky-hunt` | Hunt flaky tests |
| `aqe-gate` | `npx -y agentic-qe quality-gate` | Quality gate check |
| `aqe-coverage` | `npx -y agentic-qe coverage` | Coverage report |
| `aqe-mcp` | `npx -y aqe-mcp` | MCP server |

### Agent Browser

| Alias | Command | Description |
|-------|---------|-------------|
| `ab` | `agent-browser` | Main CLI |
| `ab-open` | `agent-browser open` | Open URL |
| `ab-snap` | `agent-browser snapshot -i` | Get accessibility snapshot |
| `ab-click` | `agent-browser click` | Click element by ref |
| `ab-fill` | `agent-browser fill` | Fill input by ref |
| `ab-close` | `agent-browser close` | Close browser |

### Spec-Kit (Requirements)

| Alias | Command | Description |
|-------|---------|-------------|
| `sk` | `specify` | Main CLI |
| `sk-init` | `specify init` | Initialize |
| `sk-check` | `specify check` | Check specs |
| `sk-here` | `specify init . --ai claude` | Init in current dir |
| `sk-const` | `specify constitution` | Constitution |
| `sk-spec` | `specify spec` | Spec |
| `sk-plan` | `specify plan` | Plan |
| `sk-tasks` | `specify tasks` | Tasks |
| `sk-impl` | `specify implement` | Implement |

### OpenSpec (API Specs)

| Alias | Command | Description |
|-------|---------|-------------|
| `os` | `openspec` | Main CLI |
| `os-init` | `openspec init` | Initialize |
| `os-list` | `openspec list` | List specs |
| `os-view` | `openspec view` | View spec |
| `os-show` | `openspec show` | Show spec |
| `os-validate` | `openspec validate` | Validate spec |
| `os-archive` | `openspec archive` | Archive spec |
| `os-update` | `openspec update` | Update spec |

### Codex

| Alias | Command | Description |
|-------|---------|-------------|
| `codex-login` | `codex login` | Login to Codex |
| `codex-run` | `codex exec -p claude` | Run with Claude |
| `codex-check` | (function) | Check Codex setup |

### Helper Functions

| Alias | Description |
|-------|-------------|
| `turbo-status` | Check all tools status |
| `turbo-help` | Quick reference guide |
| `turbo-init` | Initialize full workspace |
| `cf-task <agent> "task"` | Quick agent task |
| `cf-do` | Quick swarm task |

### Tmux

| Alias | Command | Description |
|-------|---------|-------------|
| `t` | `tmux` | Main CLI |
| `tn` | `tmux new` | New session |
| `tns` | `tmux new-session -s` | New named session |
| `ta` | `tmux attach-session` | Attach session |
| `tat` | `tmux attach-session -t` | Attach named session |
| `tl` | `tmux ls` | List sessions |
| `tls` | `tmux list-sessions` | List sessions |
| `tks` | `tmux kill-session -t` | Kill session |
| `tksa` | `tmux kill-session -a` | Kill all sessions |
| `tsh` | `tmux split-window -h` | Split horizontal |
| `tsv` | `tmux split-window -v` | Split vertical |
| `tswap` | `tmux swap-window -s` | Swap window |
| `tsync` | `tmux setw synchronize-panes` | Sync panes |

---

## Workflow Phases

The Turbo Flow workflow consists of 7 phases:

| Phase | Duration | Output | Tools Used |
|-------|----------|--------|------------|
| **Phase 0** | 15 min | Tools installed | setup.sh |
| **Phase 1** | 60-90 min | ADR + DDD design | RuVector, Claude Flow, Spec-Kit, OpenSpec |
| **Phase 2** | 5 min | New branch + status | Git, Claude Flow hooks |
| **Phase 3** | 2-4 hrs | Working code | Claude Flow swarms, HeroUI, Tailwind |
| **Phase 4** | 60-90 min | Test suite | Agentic QE, Security Analyzer |
| **Phase 5** | 30-60 min | Optimized code | RuVector SONA, Claude Flow |
| **Phase 6** | 30 min | Complete docs | prd2build, OpenSpec |
| **Phase 7** | 30-45 min | Browser tests | Agent Browser |

### Phase 0: Environment Setup (One-Time)

**Prompt:**
```
Run devpods/setup.sh to set up my complete development environment.
```

**Verify Installation:**
```bash
source ~/.bashrc
turbo-status
turbo-help
```

### Phase 1: Research & Architecture

**Main Prompt:**
```
Review the PR in "/plans/research" and create a detailed ADR/DDD implementation using all the
various capabilities of claude flow, self learning, security, hooks, helpers, skills, agents, and other
optimizations. Spawn swarm, do not implement yet. - lets call this project "[PROJECT NAME]"
```

**Supporting Commands:**

Initialize Spec-Kit:
```bash
sk-here
```

Then in Claude Code:
```
Use Spec-Kit to extract requirements from the research and add them to the database
with acceptance criteria and priorities.
```

Initialize OpenSpec:
```bash
os-init
```

Then in Claude Code:
```
Use OpenSpec to generate OpenAPI 3.0 specifications for the endpoints based on
the requirements in Spec-Kit.
```

Start RuVector learning:
```bash
ruv-init
```

Then in Claude Code:
```
Start a SONA learning trajectory for: ADR/DDD architecture design
```

**Artifacts Generated:**
- `docs/adr/ADR-001.md` through `ADR-010.md`
- `docs/adr/ADR-SEC-001.md` through `ADR-SEC-005.md`
- `docs/ddd/bounded-contexts.md`
- `docs/ddd/aggregates.md`
- `docs/ddd/entities.md`
- `.specify/` database
- `openspec.yaml`

### Phase 2: Branch & Statusline

**Main Prompt:**
```
create new branch "[PROJECT NAME]" and commit - update the statusline to match the
DDD we just outlined using the ADRs and available hooks and helpers
```

**Helper Paths (for statusline):**
```
.claude/helpers/guidance-hooks.sh
.claude/helpers/auto-commit.sh
.claude/helpers/ddd-tracker.sh
.claude/helpers/swarm-hooks.sh
.claude/helpers/learning-hooks.sh
.claude/helpers/security-scanner.sh
.claude/helpers/worker-manager.sh
.claude/helpers/pattern-consolidator.sh
.claude/helpers/perf-worker.sh
.claude/helpers/checkpoint-manager.sh
.claude/helpers/v3.sh
.claude/helpers/swarm-monitor.sh
.claude/helpers/swarm-comms.sh
```

### Phase 3: Swarm Implementation

**Main Prompt:**
```
spawn the swarm implement completely,
test, validate, benchmark, optimize, document, continue until complete
```

**Supporting Commands:**
```bash
# Hierarchical swarm
cf-swarm

# Mesh swarm (for complex interdependent tasks)
cf-mesh

# List available agents
cf-list
```

**Key Agents:**
- `architect` - Design structure
- `coder` - Write code
- `tester` - Write tests
- `reviewer` - Code review
- `security-architect` - Security design
- `code-analyzer` - Analyze code
- `documenter` - Documentation
- `optimizer` - Performance

**Frontend Implementation (HeroUI + Tailwind):**
```
Create HeroUI components for the frontend using Button, Card, Input, Modal, etc.
Style with Tailwind CSS utility classes. Use Framer Motion for animations.
```

**Available HeroUI Components:**
```jsx
import { Button, Card, Input, Modal, Dropdown, Avatar, Badge, Chip,
         Progress, Spinner, Table, Tabs, Tooltip } from "@heroui/react";
```

### Phase 4: Testing & Validation

**Main Prompt:**
```
initialize Agentic QE fleet - run comprehensive testing, validate, benchmark,
and continue until complete
```

**Supporting Commands:**
```bash
# Generate tests
aqe-generate

# Run quality gate
aqe-gate

# Security scan
cf-security
```

**Quality Targets:**
- Test coverage: 80%+
- Critical vulnerabilities: 0
- All quality gates: PASS

### Phase 5: Benchmark & Optimize

**Main Prompt:**
```
benchmark, test, optimize - store patterns for future use in RuVector ReasoningBank
```

**Supporting Commands:**
```bash
# Check learning stats
ruv-stats

# Store successful patterns
ruv-remember -t optimization "Pattern description"

# Search for similar past optimizations
ruv-recall "performance optimization"
```

### Phase 6: Documentation

**Main Prompt:**
```
document - use prd2build to generate complete documentation with INDEX.md showing
traceability: Requirements -> ADR -> Code -> Tests
```

**In Claude Code:**
```
/prd2build prd.md
```

**Artifacts Generated:**
- `docs/implementation/INDEX.md` (traceability matrix)
- `docs/specification/requirements.md`
- `docs/specification/user-stories.md`
- `docs/specification/api-contracts.md`
- API documentation from OpenSpec

### Phase 7: E2E Testing

**Main Prompt:**
```
go create me an end to end test using agent-browser - optimize - and be very specific about the
size of the window you are evaluating on claude
```

**Supporting Commands:**
```bash
ab-open "http://localhost:3000"    # Open URL
ab-snap                             # Get accessibility snapshot
ab-click @ref                       # Click element
ab-fill @ref "text"                 # Fill input
ab-close                            # Close browser
```

**Test viewport sizes:** 1920x1080, 1366x768, 375x667

---

## Tool Deep Dives

### Claude Flow V3

**54+ Agents Available:**

#### Core Development (5)
- `coder` - Write production code
- `reviewer` - Code review
- `tester` - Write tests
- `planner` - Plan tasks
- `researcher` - Research codebase

#### V3 Specialized (4)
- `security-architect` - Security design
- `security-auditor` - Security audit
- `memory-specialist` - Memory management
- `performance-engineer` - Performance optimization

#### Swarm Coordination (5)
- `hierarchical-coordinator` - Hierarchical swarm
- `mesh-coordinator` - Mesh swarm
- `adaptive-coordinator` - Adaptive topology
- `collective-intelligence-coordinator` - Collective IQ
- `swarm-memory-manager` - Shared memory

#### Consensus & Distributed (7)
- `byzantine-coordinator` - Byzantine fault tolerance
- `raft-manager` - Raft consensus
- `gossip-coordinator` - Gossip protocol
- `consensus-builder` - Build consensus
- `crdt-synchronizer` - CRDT sync
- `quorum-manager` - Quorum management
- `security-manager` - Security coordination

#### Performance & Optimization (5)
- `perf-analyzer` - Analyze performance
- `performance-benchmarker` - Run benchmarks
- `task-orchestrator` - Orchestrate tasks
- `memory-coordinator` - Coordinate memory
- `smart-agent` - Intelligent agent

#### GitHub & Repository (9)
- `github-modes` - GitHub modes
- `pr-manager` - PR management
- `code-review-swarm` - Code review swarm
- `issue-tracker` - Issue tracking
- `release-manager` - Release management
- `workflow-automation` - Workflow automation
- `project-board-sync` - Project board sync
- `repo-architect` - Repository architecture
- `multi-repo-swarm` - Multi-repo coordination

#### SPARC Methodology (6)
- `sparc-coord` - SPARC coordinator
- `sparc-coder` - SPARC coder
- `specification` - Specification
- `pseudocode` - Pseudocode
- `architecture` - Architecture
- `refinement` - Refinement

#### Specialized Development (8)
- `backend-dev` - Backend development
- `mobile-dev` - Mobile development
- `ml-developer` - ML development
- `cicd-engineer` - CI/CD engineering
- `api-docs` - API documentation
- `system-architect` - System architecture
- `code-analyzer` - Code analysis
- `base-template-generator` - Template generation

#### Testing & Validation (2)
- `tdd-london-swarm` - TDD London school
- `production-validator` - Production validation

**Swarm Topologies:**

| Topology | Description | Best For |
|----------|-------------|----------|
| `hierarchical` | Queen controls workers directly | Anti-drift, tight control |
| `mesh` | Fully connected peer network | Distributed tasks |
| `hierarchical-mesh` | V3 hybrid (recommended) | 10+ agents |
| `ring` | Circular communication | Sequential workflows |
| `star` | Central coordinator | Simple coordination |
| `adaptive` | Dynamic based on load | Variable workloads |

**175+ MCP Tools:**

Core commands:
- `init` - Project initialization
- `agent` - Agent lifecycle (spawn, list, status, stop)
- `swarm` - Multi-agent coordination
- `memory` - AgentDB with HNSW search
- `mcp` - MCP server management
- `task` - Task assignment
- `session` - Session persistence
- `config` - Configuration
- `status` - System monitoring
- `workflow` - Workflow templates
- `hooks` - Self-learning hooks
- `hive-mind` - Consensus coordination

### RuVector (Neural Engine)

**Components:**
- **SONA** - Self-Optimizing Neural Architecture (<0.05ms adaptation)
- **MoE** - Mixture of Experts routing
- **HNSW** - 150x-12,500x faster search
- **EWC++** - Elastic Weight Consolidation (prevents forgetting)
- **Flash Attention** - 2.49x-7.47x speedup
- **Int8 Quantization** - 3.92x memory reduction

**4-Step Intelligence Pipeline:**
1. **RETRIEVE** - HNSW pattern search
2. **JUDGE** - Success/failure verdicts
3. **DISTILL** - LoRA learning extraction
4. **CONSOLIDATE** - EWC++ preservation

**Memory Commands:**
```bash
# Store pattern
npx @claude-flow/cli@latest memory store --key "name" --value "data" --namespace patterns

# Semantic search
npx @claude-flow/cli@latest memory search --query "authentication"

# List entries
npx @claude-flow/cli@latest memory list --namespace patterns

# Initialize database
npx @claude-flow/cli@latest memory init --force
```

### Spec-Kit

**Purpose:** Requirements management and specification

**Commands:**
```bash
sk-init              # Initialize
sk-check             # Check specs
sk-here              # Init in current directory
sk-const             # Constitution
sk-spec              # Spec
sk-plan              # Plan
sk-tasks             # Tasks
sk-impl              # Implement
```

**Database Location:** `.specify/`

### OpenSpec

**Purpose:** OpenAPI 3.0 specification generation

**Commands:**
```bash
os-init              # Initialize
os-list              # List specs
os-view              # View spec
os-show              # Show spec
os-validate          # Validate spec
os-archive           # Archive spec
os-update            # Update spec
```

**Output:** `openspec.yaml`

### Agentic QE

**19 Testing Agents:**
- Unit test generators
- Integration test specialists
- E2E test automators
- Flaky test hunters
- Coverage analyzers
- Performance testers
- Security testers
- Accessibility validators

**Commands:**
```bash
aqe-init             # Initialize
aqe-generate         # Generate tests
aqe-run              # Run tests
aqe-flaky            # Hunt flaky tests
aqe-gate             # Quality gate
aqe-coverage         # Coverage report
```

### Agent Browser

**Purpose:** Chromium browser automation for testing

**Commands:**
```bash
ab-open <url>        # Open URL
ab-snap              # Get accessibility snapshot
ab-click @ref        # Click element
ab-fill @ref "text"  # Fill input
ab-close             # Close browser
```

**Skill Location:** `~/.claude/skills/agent-browser/`

### Security Analyzer

**Purpose:** CVE scanning and vulnerability detection

**Skill Location:** `~/.claude/skills/security-analyzer/`

**Commands:**
```bash
sec-audit            # Security audit
security-scan        # Full vulnerability scan
```

**Scans for:**
- OWASP Top 10 vulnerabilities
- CVE dependencies
- Input validation issues
- Authentication/authorization flaws
- XSS, SQL injection, CSRF

### UI UX Pro Max

**Purpose:** UI generation with 67 styles, 96 palettes, 56 font pairings

**Skill Location:** `~/.claude/skills/ui-ux-pro-max/`

**Features:**
- Component generation
- Style application
- Palette selection
- Font pairing
- Responsive design
- Accessibility support

### HeroUI + Tailwind

**HeroUI Components:**
```jsx
import {
  Button, Card, Input, Modal, Dropdown, Avatar, Badge, Chip,
  Progress, Spinner, Table, Tabs, Tooltip, Navbar, Sidebar,
  Select, Checkbox, Radio, Switch, Slider, DatePicker,
  TimeInput, Pagination, Breadcrumb, Divider, Link,
  Image, Video, Accordion, Collapse,Popover, Menu, Notification
} from "@heroui/react";
```

**Tailwind Config:**
```javascript
const { heroui } = require("@heroui/react");
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
    "./node_modules/@heroui/theme/dist/**/*.{js,ts,jsx,tsx}"
  ],
  theme: { extend: {} },
  darkMode: "class",
  plugins: [heroui()],
};
```

---

## prd2build Command

**Location:** `~/.claude/commands/prd2build.md`

**Purpose:** Transform PRD into complete documentation with traceability

**Usage in Claude Code:**
```
/prd2build prd.md
```

**Generated Documentation:**
- `docs/implementation/INDEX.md` - Traceability matrix
- `docs/specification/requirements.md` - Requirements
- `docs/specification/user-stories.md` - User stories
- `docs/specification/api-contracts.md` - API contracts
- Architecture diagrams
- Implementation guide
- Test documentation

**Traceability:**
```
Requirements -> ADR -> Code -> Tests
```

---

## Helper Functions

### turbo-status

Check all tools installation status:

```bash
turbo-status
```

**Output:**
```
📊 Turbo Flow v2.0.2 Status
───────────────────────────
Node.js:       v20.x.x
RuVector:      ✅
Claude Flow:   ✅
Codex:         ✅/not installed
prd2build:     ✅
Agent-Browser: ✅
Security:      ✅
UI Pro Max:    ✅
HeroUI:        ✅
```

### turbo-help

Quick reference for all commands:

```bash
turbo-help
```

**Output:**
```
🚀 Turbo Flow v2.0.2 Quick Reference
────────────────────────────────────

RUVECTOR (Neural Engine)
  ruv                  Start RuVector
  ruv-stats            Show learning statistics
  ruv-route 'task'     Route task to best agent
  ruv-remember         Store in semantic memory
  ruv-recall 'query'   Search semantic memory

CLAUDE FLOW V3
  cf-swarm             Hierarchical swarm
  cf-mesh              Mesh swarm
  cf-agent TYPE TASK   Run agent
  cf-daemon            Background daemon

AGENT-BROWSER
  ab-open <url>        Open URL in browser
  ab-snap              Get accessibility snapshot
  ab-click @ref        Click element by ref
  ab-fill @ref 'text'  Fill input by ref
  ab-close             Close browser

TESTING
  aqe-generate         Generate tests
  aqe-gate             Quality gate

STATUS
  turbo-status         Check all tools
  codex-check          Check Codex setup
```

### turbo-init

Initialize full workspace:

```bash
turbo-init
```

**Actions:**
1. Initialize Spec-Kit
2. Initialize Claude Flow V3
3. Bootstrap neural patterns
4. Initialize embeddings

### cf-task

Quick agent task:

```bash
cf-task <agent> "task description"
```

**Example:**
```bash
cf-task coder "Implement user authentication"
```

### cf-do

Quick swarm task:

```bash
cf-do <task> [options]
```

### codex-check

Check Codex setup:

```bash
codex-check
```

---

## Project Structure

```
project/
├── src/                          # Source code
│   ├── index.css                 # Tailwind directives
│   ├── components/               # React components
│   ├── pages/                    # Page components
│   └── ...
├── tests/                        # Test files
├── docs/                         # Documentation
│   ├── adr/                      # Architecture Decision Records
│   │   ├── ADR-001.md
│   │   └── ...
│   ├── ddd/                      # Domain-Driven Design
│   │   ├── bounded-contexts.md
│   │   ├── aggregates.md
│   │   └── entities.md
│   ├── implementation/           # Implementation docs
│   │   └── INDEX.md
│   └── specification/            # Specifications
│       ├── requirements.md
│       ├── user-stories.md
│       └── api-contracts.md
├── scripts/                      # Utility scripts
├── config/                       # Configuration files
├── plans/                        # Research & PRD files
│   └── research/
├── .claude/                      # Claude Code configuration
│   ├── skills/                   # Custom skills
│   ├── commands/                 # Custom commands
│   └── helpers/                  # Helper scripts
├── .claude-flow/                 # Claude Flow V3 configuration
│   ├── config.json               # Main config
│   ├── data/                     # Memory storage
│   ├── logs/                     # Operation logs
│   └── sessions/                 # Session state
├── .specify/                     # Spec-Kit database
├── node_modules/                 # Dependencies
├── package.json                  # type: "module"
├── tsconfig.json                 # TypeScript config
├── tailwind.config.js            # Tailwind + HeroUI
├── postcss.config.js             # PostCSS config
├── AGENTS.md                     # Codex/Claude protocol
└── CLAUDE.md                     # Claude instructions
```

---

## Configuration Files

### ~/.config/claude/mcp.json

MCP server configuration:

```json
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@v3alpha", "mcp", "start"],
      "env": {
        "CLAUDE_FLOW_MODE": "v3",
        "CLAUDE_FLOW_HOOKS_ENABLED": "true",
        "CLAUDE_FLOW_TOPOLOGY": "hierarchical-mesh",
        "CLAUDE_FLOW_MAX_AGENTS": "15",
        "CLAUDE_FLOW_MEMORY_BACKEND": "hybrid"
      }
    },
    "agentic-qe": {
      "command": "npx",
      "args": ["-y", "aqe-mcp"],
      "env": {}
    }
  }
}
```

### ~/.claude/commands/prd2build.md

Slash command for PRD to documentation transformation.

### ~/.codex/instructions.md

Claude profile for OpenAI Codex.

### .claude-flow/config.json

Claude Flow V3 configuration.

### tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "jsx": "react-jsx"
  },
  "include": ["src/**/*", "tests/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

### tailwind.config.js

```javascript
const { heroui } = require("@heroui/react");
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
    "./node_modules/@heroui/theme/dist/**/*.{js,ts,jsx,tsx}"
  ],
  theme: { extend: {} },
  darkMode: "class",
  plugins: [heroui()],
};
```

### postcss.config.js

```javascript
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {}
  }
};
```

---

## Integration Patterns

### Tool → Phase Matrix

| Tool | Phase 0 | Phase 1 | Phase 2 | Phase 3 | Phase 4 | Phase 5 | Phase 6 | Phase 7 |
|------|---------|---------|---------|---------|---------|---------|---------|---------|
| **RuVector** | Install | | | | | | | |
| **@ruvector/sona** | Install | | | | | | | |
| **@ruvector/cli** | Install | | | | | | | |
| **Claude Flow V3** | Install | | | | | | | |
| **Spec-Kit** | Install | | | | | | | |
| **OpenSpec** | Install | | | | | | | |
| **Agentic QE** | Install | | | | | | | |
| **Agent Browser** | Install | | | | | | | |
| **Security Analyzer** | Install | | | | | | | |
| **HeroUI** | Install | | | | | | | |
| **Tailwind CSS** | Install | | | | | | | |
| **prd2build** | Install | | | | | | | |
| **Claude Code** | Install | | | | | | | | |

### Typical Workflow Integration

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          TYPICAL WORKFLOW                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  1. Research/PRD ─────────────────────────────────────────────────────┐     │
│       │                                                              │     │
│       └──► Spec-Kit (requirements)                                     │     │
│       └──► OpenSpec (API specs)                                        │     │
│       └──► RuVector (store patterns)                                   │     │
│                                                                      │     │
│  2. Architecture ───────────────────────────────────────────────────┤     │
│       │                                                              │     │
│       └──► Claude Flow V3 (swarm design)                              │     │
│       └──► ADR/DDD documents                                          │     │
│       └──► Branch + Statusline                                        │     │
│                                                                      │     │
│  3. Implementation ─────────────────────────────────────────────────┤     │
│       │                                                              │     │
│       └──► cf-swarm (spawn agents)                                    │     │
│       │   ├── architect (design)                                      │     │
│       │   ├── coder (implement)                                       │     │
│       │   ├── tester (tests)                                          │     │
│       │   └── reviewer (review)                                       │     │
│       └──► HeroUI + Tailwind (UI)                                     │     │
│                                                                      │     │
│  4. Testing ────────────────────────────────────────────────────────┤     │
│       │                                                              │     │
│       └──► Agentic QE (test suite)                                    │     │
│       └──► Security Analyzer (security scan)                          │     │
│       └──► aqe-gate (quality gate)                                    │     │
│                                                                      │     │
│  5. Optimization ───────────────────────────────────────────────────┤     │
│       │                                                              │     │
│       └──► RuVector SONA (learning)                                   │     │
│       └──► cf-patterns (store patterns)                               │     │
│                                                                      │     │
│  6. Documentation ──────────────────────────────────────────────────┤     │
│       │                                                              │     │
│       └──► prd2build (complete docs)                                  │     │
│       └──► OpenSpec (API docs)                                        │     │
│                                                                      │     │
│  7. E2E Testing ────────────────────────────────────────────────────┤     │
│       │                                                              │     │
│       └──► Agent Browser (browser automation)                         │     │
│       └──► Screenshots + Visual regression                            │     │
│                                                                      │     │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Best Practices

### Development Patterns

1. **Always start with architecture (Phase 1)**
   - Create ADRs for major decisions
   - Define DDD bounded contexts
   - Use Spec-Kit for requirements
   - Use OpenSpec for API contracts

2. **Use appropriate swarm topology**
   - `hierarchical` - Tight control, anti-drift (6-8 agents)
   - `mesh` - Distributed tasks
   - `hierarchical-mesh` - Large teams (10+ agents)

3. **Store patterns for reuse**
   - Use `ruv-remember` after successful implementations
   - Use `ruv-recall` to find similar past solutions
   - Let SONA learn from trajectories

4. **Test continuously**
   - Use Agentic QE for comprehensive testing
   - Run security scans before committing
   - Use quality gates before merging

5. **Document as you go**
   - Use prd2build for complete documentation
   - Keep ADRs up to date
   - Generate API docs with OpenSpec

### Code Quality

1. **HeroUI + Tailwind**
   - Use HeroUI components for consistency
   - Apply Tailwind utility classes
   - Use Framer Motion for animations

2. **TypeScript**
   - Use strict mode
   - Define proper types
   - Use ES2022+ features

3. **Testing**
   - Aim for 80%+ coverage
   - Write unit, integration, and E2E tests
   - Use Agent Browser for visual testing

### Security

1. **Scan regularly**
   - Run `cf-security` before commits
   - Check dependencies for CVEs
   - Validate input handling

2. **Follow OWASP guidelines**
   - Sanitize inputs
   - Use parameterized queries
   - Implement proper auth

---

## Troubleshooting

### Common Issues

#### Node.js Version Issues

**Problem:** Node.js version < 20

**Solution:**
```bash
n 20
hash -r
node -v  # Should show v20.x.x
```

#### Claude Flow Not Initialized

**Problem:** `.claude-flow` directory missing

**Solution:**
```bash
cf-init
```

#### MCP Servers Not Starting

**Problem:** MCP tools unavailable

**Solution:**
```bash
# Check MCP config
cat ~/.config/claude/mcp.json

# Restart Claude Code
exit
claude
```

#### HeroUI Not Found

**Problem:** `@heroui/react` not installed

**Solution:**
```bash
npm install @heroui/react framer-motion
npm install -D tailwindcss postcss autoprefixer
```

#### Agent Browser Chromium Issues

**Problem:** Chromium not installed

**Solution:**
```bash
agent-browser install --with-deps
```

#### UI Pro Max Skill Empty

**Problem:** Skill directory exists but is empty

**Solution:**
```bash
# Remove empty directory
rm -rf ~/.claude/skills/ui-ux-pro-max

# Reinstall with offline flag
uipro init --ai claude --offline
```

#### Spec-Kit Not Found

**Problem:** `specify` command not found

**Solution:**
```bash
# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.cargo/env

# Install Spec-Kit
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

#### Aliases Not Working

**Problem:** Bash aliases not loaded

**Solution:**
```bash
source ~/.bashrc
```

If still not working, check `~/.bashrc` contains Turbo Flow aliases:
```bash
grep "TURBO FLOW" ~/.bashrc
```

#### Memory Issues

**Problem:** Out of memory during large swarms

**Solution:**
```bash
# Reduce max agents
cf-swarm-start --max-agents 8

# Or use hierarchical topology
cf-swarm
```

#### Pattern Search Not Working

**Problem:** `ruv-recall` returns no results

**Solution:**
```bash
# Initialize memory
ruv-init

# Store some patterns
ruv-remember -t testing "Unit test pattern with Jest"

# Try recall again
ruv-recall "testing"
```

---

## Completion Checklist

### Environment Setup (Phase 0 - One-Time)
- [ ] Ran devpods/setup.sh
- [ ] All tools installed (`turbo-status` shows all ✅)
- [ ] Shell aliases loaded (`source ~/.bashrc`)

### Architecture Phase (Phase 1)
- [ ] Research analyzed from `/plans/research`
- [ ] Spec-Kit initialized (`sk-here`)
- [ ] OpenSpec initialized (`os-init`)
- [ ] ADR-001 through ADR-010 created
- [ ] ADR-SEC-001 through ADR-SEC-005 created
- [ ] DDD bounded contexts defined
- [ ] Requirements extracted to Spec-Kit
- [ ] OpenAPI specs generated
- [ ] RuVector hooks initialized (`ruv-init`)
- [ ] Patterns stored in RuVector ReasoningBank
- [ ] SONA trajectory started
- [ ] Project named

### Branch & Statusline (Phase 2)
- [ ] Feature branch created
- [ ] Statusline configured with DDD context
- [ ] Helper paths included
- [ ] Architecture committed

### Implementation (Phase 3)
- [ ] Swarm topology chosen (hierarchical or mesh)
- [ ] Swarm spawned (`cf-swarm` or `cf-mesh`)
- [ ] HeroUI components created
- [ ] Tailwind CSS applied
- [ ] Code implemented following DDD architecture

### Testing (Phase 4)
- [ ] Agentic QE tests generated (`aqe-generate`)
- [ ] Quality gate passed (`aqe-gate`)
- [ ] 80%+ coverage achieved
- [ ] Security scan passed (`cf-security`)
- [ ] Zero critical vulnerabilities

### Optimization (Phase 5)
- [ ] Performance benchmarks run
- [ ] Bottlenecks resolved
- [ ] Patterns stored in RuVector (`ruv-remember`)
- [ ] Learning stats reviewed (`ruv-stats`)

### Documentation (Phase 6)
- [ ] prd2build executed (`/prd2build prd.md`)
- [ ] INDEX.md traceability verified
- [ ] API docs generated with OpenSpec

### E2E Testing (Phase 7)
- [ ] Agent Browser tests created
- [ ] Multiple viewport sizes tested
- [ ] Screenshots saved
- [ ] All E2E tests passing

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 2.0.2 | 2026-01-22 | Complete workflow documentation |
| 2.0.1 | 2026-01-21 | Updated for Claude Flow V3 |
| 2.0.0 | 2026-01-20 | Initial v2 release with RuVector |

---

**For more information, see:**
- [CAPABILITIES.md](.claude-flow/CAPABILITIES.md) - Complete Claude Flow V3 reference
- [V2_Complete_Workflow_System.md](V2_Complete_Workflow_System.md) - Detailed workflow phases
- [AGENTS.md](AGENTS.md) - Codex/Claude collaboration protocol

---

**Turbo Flow v2.0.2 - Claude Flow V3 + RuVector Neural Engine**
