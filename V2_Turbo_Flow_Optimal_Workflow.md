# V2 Turbo Flow Optimal Workflow

**Comprehensive Guide to Turbo Flow v2.0.1 Development Workflow**

---

## Table of Contents

1. [Overview](#overview)
2. [Environment Setup](#environment-setup)
3. [Workflow Phases](#workflow-phases)
4. [Command Reference](#command-reference)
5. [Best Practices](#best-practices)
6. [Troubleshooting](#troubleshooting)

---

## Overview

The V2 Turbo Flow workflow is a comprehensive development pipeline that combines:
- **Spec-First Development** - Requirements before code
- **Architecture-Driven Design (ADR)** - Documented decisions
- **Domain-Driven Design (DDD)** - Bounded contexts and aggregates
- **Agentic Orchestration** - Multi-agent parallel execution
- **Neural Learning** - Pattern storage and retrieval
- **Comprehensive Testing** - Quality gates and security scanning

**Version:** v2.0.1
**Last Updated:** 2026-01-22

---

## Environment Setup

### Prerequisites

- DevPod for environment provisioning
- Git repository initialized
- SSH access to development environment

### Installation Steps

The `setup.sh` script automates **15 steps** of installation:

#### System & Runtime (Steps 1-3)

| Step | Component | Purpose |
|------|-----------|---------|
| 1 | `build-essential`, `gcc`, `g++`, `make`, `python3`, `git`, `curl` | Build tools and utilities |
| 2 | Node.js 20 LTS | Runtime environment |
| 3 | npm cache cleanup | Clean installation |

#### Neural Engine (Step 4)

| Package | Installation | Purpose |
|---------|--------------|---------|
| RuVector Core | `npm install -g ruvector` | Vector DB + GNN |
| SONA | `npm install -g @ruvector/sona` | Self-learning architecture |
| RuVector CLI | `npm install -g @ruvector/cli` | Hooks integration |

#### Orchestration (Step 5)

```bash
npm install -g claude-flow@v3alpha
```

Provides 175+ MCP tools and 54+ specialized agents.

#### Core Packages (Step 6)

| Package | Purpose |
|---------|---------|
| `@anthropic-ai/claude-code` | AI coding CLI |
| `agentic-qe` | Testing pipeline (19 agents) |
| `@fission-ai/openspec` | API specification workflow |
| `uipro-cli` | UI generation |
| `agent-browser` | Browser automation |
| `@claude-flow/browser` | Browser integration |

#### Skills Installation (Steps 7-8, 12)

```bash
# Agent Browser
agent-browser install --with-deps

# Security Analyzer
git clone https://github.com/Cornjebus/security-analyzer ~/.claude/skills/security-analyzer

# UI UX Pro Max
uipro-cli install
```

#### Python Tools (Step 9)

```bash
# Install uv package manager
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Spec-Kit
uv tool install specify-cli --git https://github.com/github/spec-kit.git
```

#### Configuration (Steps 10-11, 13-14)

Creates the following configuration:

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

**Workspace** creates:
- `package.json` with `type: "module"`
- `tsconfig.json` with ES2022 target
- `tailwind.config.js` with HeroUI plugin
- `postcss.config.js`
- `src/`, `tests/`, `docs/` directories

**Frontend Stack**:
```bash
npm install @heroui/react framer-motion tailwindcss postcss autoprefixer
```

#### Bash Aliases (Step 15)

40+ aliases installed in `~/.bashrc`:

| Category | Aliases |
|----------|---------|
| RuVector | `ruv`, `ruv-init`, `ruv-stats`, `ruv-route`, `ruv-remember`, `ruv-recall`, `ruv-learn` |
| Claude Flow | `cf`, `cf-init`, `cf-swarm`, `cf-mesh`, `cf-agent`, `cf-list`, `cf-daemon`, `cf-memory`, `cf-security` |
| Testing | `aqe`, `aqe-generate`, `aqe-gate` |
| Browser | `ab`, `ab-open`, `ab-snap`, `ab-click`, `ab-fill`, `ab-close` |
| Utilities | `turbo-status`, `turbo-help` |

---

## Workflow Phases

### Phase 0: Environment Setup (One-Time, 15 min)

```bash
# Run setup script
./devpods/setup.sh

# Reload shell
source ~/.bashrc

# Verify installation
turbo-status
```

**Expected Output:**
```
Turbo Flow v2.0.1 Status
──────────────────────────
Node.js:       v20.x.x    ✅
RuVector:      ✅
Claude Flow:   ✅
prd2build:     ✅
Agent-Browser: ✅
Security:      ✅
UI Pro Max:    ✅
HeroUI:        ✅
```

---

### Phase 1: Research & Architecture (60-90 min)

**Goal:** Define requirements and create architecture decisions.

#### Step 1: Initialize Specification Tools

```bash
# Initialize Spec-Kit (requirements database)
sk-here

# Initialize OpenSpec (API specifications)
os-init

# Initialize RuVector hooks
ruv-init
```

#### Step 2: Analyze Research Materials

In Claude Code:
```
Review the PR in "/plans/research" and extract requirements for Spec-Kit.
```

#### Step 3: Create ADRs and DDD Models

In Claude Code:
```
Create detailed ADR/DDD implementation using:
- Architecture Decision Records (ADRs)
- Security ADRs (ADR-SEC)
- Domain-Driven Design (bounded contexts, aggregates)
- Store patterns in RuVector ReasoningBank
```

**Artifacts Generated:**
- `docs/adr/ADR-001.md` through `ADR-010.md`
- `docs/adr/ADR-SEC-001.md` through `ADR-SEC-005.md`
- `docs/ddd/bounded-contexts.md`
- `docs/ddd/aggregates.md`
- `docs/ddd/entities.md`

#### Step 4: Extract Requirements to Spec-Kit

```bash
specify add "User must be able to login with email" --tag auth --priority high
specify list
specify check
```

#### Step 5: Generate OpenAPI Specifications

```
Use OpenSpec to generate OpenAPI 3.0 specifications for endpoints.
```

---

### Phase 2: Branch & Statusline (5 min)

**Goal:** Create development branch with proper tracking.

```bash
# Create feature branch
git checkout -b feature/project-name

# Update statusline with DDD context
```

In Claude Code:
```
Update the statusline to match the DDD we outlined using ADRs and hooks.
Include helper paths: .claude/helpers/guidance-hooks.sh, auto-commit.sh, ddd-tracker.sh
```

---

### Phase 3: Swarm Implementation (2-4 hrs)

**Goal:** Implement the solution using multi-agent coordination.

#### Step 1: Choose Swarm Topology

```bash
# Hierarchical (boss/workers) - for structured tasks
cf-swarm

# Mesh (peer-to-peer) - for complex interdependencies
cf-mesh
```

#### Step 2: Spawn Swarm

In Claude Code:
```
Spawn the swarm and implement completely using hierarchical topology.
Use specialized agents: architect, coder, tester, reviewer, security-architect.
```

**Agent Roles:**
| Agent | Responsibility |
|-------|----------------|
| Architect | System design guidance |
| Coder | Implementation |
| Tester | Test generation |
| Reviewer | Code review |
| Security-Architect | Security patterns |
| Documenter | Documentation |

#### Step 3: Frontend Implementation

In Claude Code:
```
Create HeroUI components for the frontend using Button, Card, Input, Modal.
Style with Tailwind CSS utility classes.
Use Framer Motion for animations.
```

**Available Components:**
```jsx
import { Button, Card, Input, Modal, Dropdown, Avatar, Badge, Chip,
         Progress, Spinner, Table, Tabs, Tooltip } from "@heroui/react";
```

---

### Phase 4: Testing & Validation (60-90 min)

**Goal:** Comprehensive testing and security validation.

#### Step 1: Generate Tests

```bash
# Generate tests with Agentic QE
aqe-generate

# Generate with coverage target
npx -y agentic-qe generate --coverage 80
```

#### Step 2: Run Quality Gate

```bash
# Run quality gate
aqe-gate

# Full pipeline with report
npx -y agentic-qe gate --report
```

**Quality Targets:**
| Metric | Target |
|--------|--------|
| Test Coverage | ≥80% |
| Critical Vulnerabilities | 0 |
| Type Errors | 0 |
| Build Success | Required |

#### Step 3: Security Scan

```bash
# Via Claude Flow
cf-security
```

**Checks Performed:**
- CVE Scanning
- OWASP Top 10 vulnerabilities
- Secrets detection
- Dependency audit
- Code analysis

---

### Phase 5: Benchmark & Optimize (30-60 min)

**Goal:** Performance optimization and pattern learning.

#### Step 1: Check Learning Stats

```bash
ruv-stats
```

**Output Example:**
```
RuVector Learning Stats
────────────────────────
Patterns learned: 156
Success rate: 87%
Top agents: coder, tester, reviewer
Memory entries: 42
SONA adaptations: 2,341
```

#### Step 2: Store Successful Patterns

```bash
ruv-remember -t optimization "Refactored with dependency injection"
ruv-remember -t architecture "JWT with refresh token rotation pattern"
```

#### Step 3: Search Past Patterns

```bash
ruv-recall "performance optimization"
ruv-recall "authentication patterns"
```

---

### Phase 6: Documentation (30 min)

**Goal:** Complete documentation with traceability.

#### Step 1: Generate Documentation

In Claude Code:
```bash
/prd2build prd.md
```

#### Step 2: Verify Traceability

The `docs/implementation/INDEX.md` provides:
```
Requirement → ADR → Code File → Test File
```

#### Step 3: API Documentation

```
Use OpenSpec to generate API documentation for all endpoints.
```

**Artifacts Generated:**
- `docs/implementation/INDEX.md`
- `docs/specification/requirements.md`
- `docs/specification/user-stories.md`
- `docs/specification/api-contracts.md`

---

### Phase 7: E2E Testing (30-45 min)

**Goal:** Browser-based end-to-end testing.

#### Step 1: Agent Browser Testing

```bash
# Open URL
ab-open "http://localhost:3000"

# Get accessibility snapshot
ab-snap

# Interact with elements
ab-fill @email "test@example.com"
ab-fill @password "password123"
ab-click @submit

# Close browser
ab-close
```

#### Step 2: Visual Regression Testing

In Claude Code:
```
Use Agent Browser to take screenshots of key pages at viewport sizes:
- 1920x1080 (desktop)
- 1366x768 (laptop)
- 375x667 (mobile)
```

---

## Command Reference

### Spec Management

| Command | Description |
|---------|-------------|
| `sk-here` | Initialize Spec-Kit in current directory |
| `specify list` | List all requirements |
| `specify add "req"` | Add a requirement |
| `specify check` | Validate specifications |
| `os-init` | Initialize OpenSpec |
| `openspec tree` | Visualize spec tree |

### Claude Flow V3

| Command | Description |
|---------|-------------|
| `cf-init` | Initialize workspace |
| `cf-swarm` | Start hierarchical swarm |
| `cf-mesh` | Start mesh swarm |
| `cf-agent <type> "task"` | Run specific agent |
| `cf-list` | List available agents (54+) |
| `cf-daemon` | Start background daemon |
| `cf-memory status` | Check memory system |
| `cf-memory search "query"` | Search patterns |
| `cf-security` | Run security scan |
| `cf-mcp` | Start MCP server |

### RuVector Neural Engine

| Command | Description |
|---------|-------------|
| `ruv-init` | Initialize hooks |
| `ruv-stats` | Show learning statistics |
| `ruv-route "task"` | Route task to best agent |
| `ruv-remember -t <type> "desc"` | Store in semantic memory |
| `ruv-recall "query"` | Search semantic memory |
| `ruv-learn` | Record learning trajectory |
| `ruvector-status` | Check full status |

### Testing

| Command | Description |
|---------|-------------|
| `aqe-generate` | Generate tests |
| `aqe-gate` | Run quality gate |

### Browser Automation

| Command | Description |
|---------|-------------|
| `ab-open <url>` | Open URL in browser |
| `ab-snap` | Get accessibility snapshot |
| `ab-click @ref` | Click element by reference |
| `ab-fill @ref "text"` | Fill input field |
| `ab-close` | Close browser |

### Claude Code

| Command | Description |
|---------|-------------|
| `claude` | Start Claude Code |
| `dsp` | Start with --dangerously-skip-permissions |

**Slash Commands (inside Claude Code):**
| Command | Description |
|---------|-------------|
| `/prd2build prd.md` | Generate docs from PRD |
| `/prd2build prd.md --build` | Generate + build |

---

## Best Practices

### Spec-First Development

1. **Always define requirements before code**
   - Use Spec-Kit to track requirements
   - Tag and prioritize requirements
   - Validate specs before implementation

2. **Document architectural decisions**
   - Create ADRs for significant decisions
   - Include context, options, and rationale
   - Store security decisions separately (ADR-SEC)

3. **Use DDD for domain modeling**
   - Define bounded contexts clearly
   - Identify aggregates and entities
   - Map relationships between domains

### Swarm Orchestration

1. **Choose appropriate topology**
   - Hierarchical for structured tasks (8-12 agents)
   - Mesh for complex interdependencies (6-8 agents)
   - Ring for sequential pipelines (4-6 agents)

2. **Use specialized agents**
   - architect for design
   - coder for implementation
   - tester for quality assurance
   - security-architect for security

3. **Monitor swarm progress**
   ```bash
   cf-memory status
   ```

### Neural Learning

1. **Store successful patterns**
   ```bash
   ruv-remember -t edit "Refactored user service with DI"
   ruv-remember -t architecture "JWT with refresh token rotation"
   ```

2. **Search before implementing**
   ```bash
   ruv-recall "authentication patterns"
   ```

3. **Let the system learn**
   - Routes improve over time
   - Success rates increase
   - Cost optimization occurs

### Testing Strategy

1. **Generate tests early**
   ```bash
   aqe-generate --coverage 80
   ```

2. **Run quality gates**
   ```bash
   aqe-gate --report
   ```

3. **Security scanning**
   ```bash
   cf-security
   ```

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Commands not found | `source ~/.bashrc` |
| MCP not working | Check `~/.config/claude/mcp.json` |
| RuVector errors | `ruv-init` to reinitialize |
| Claude Flow issues | `cf-init` to reinitialize |
| Agent Browser fails | `agent-browser install --with-deps` |
| Low test coverage | `aqe-generate --coverage 80` |
| Security vulnerabilities | `cf-security` then review ADR-SEC |

---

## Project Structure

```
project/
+-- src/                      # Source code
|   +-- index.css             # Tailwind imports
+-- tests/                    # Test files
+-- docs/
|   +-- specification/        # Requirements, user stories, API
|   +-- ddd/                  # Bounded contexts, aggregates
|   +-- adr/                  # Architecture decisions
|   +-- implementation/       # INDEX.md (traceability)
+-- plans/                    # Research plans
+-- scripts/                  # Utility scripts
+-- config/                   # Configuration
+-- .claude-flow/             # Claude Flow V3 config
+-- .specify/                 # Spec-Kit database
+-- .ruvector/                # RuVector hooks data
+-- AGENTS.md                 # Codex/Claude protocol
+-- CLAUDE.md                 # Project context
+-- openspec.yaml             # API specifications
+-- tailwind.config.js        # Tailwind + HeroUI
+-- postcss.config.js         # PostCSS config
+-- tsconfig.json             # TypeScript config
+-- package.json              # Dependencies (type: "module")
```

---

## Resources

| Resource | URL |
|----------|-----|
| RuVector | github.com/ruvnet/ruvector |
| Claude Flow V3 | github.com/ruvnet/claude-flow |
| Turbo Flow | github.com/marcuspat/turbo-flow-claude |
| Agentic QE | npmjs.com/package/agentic-qe |
| HeroUI | heroui.com |
| Tailwind CSS | tailwindcss.com |
| Security Analyzer | github.com/Cornjebus/security-analyzer |
| Spec-Kit | github.com/github/spec-kit |

---

**Version:** 2.0.1
**Generated:** 2026-01-22
