# Complete Workflow - Claude Flow V3.0

**Research-Driven ADR/DDD Architecture with Full-Stack Implementation**

---

## Overview

This is the complete workflow that transforms research into production-ready software using the Turbo Flow v2.0.1 stack.

**One-time setup via `devpods/setup.sh`, then use prompts for each phase.**

---

## What Gets Installed (setup.sh)

The setup script runs 15 automated steps to install and configure the complete stack:

### System Foundation (Steps 1-3)
| Step | Components Installed |
|------|---------------------|
| 1 | `build-essential` (gcc, g++, make), `python3`, `git`, `curl` |
| 2 | Node.js 20 LTS (via `n` version manager) |
| 3 | npm cache cleanup |

### Neural Engine (Step 4)
| Package | npm Name | Purpose |
|---------|----------|---------|
| RuVector Core | `ruvector` | Vector DB + GNN + self-learning neural engine |
| SONA | `@ruvector/sona` | Self-Optimizing Neural Architecture (<0.05ms) |
| RuVector CLI | `@ruvector/cli` | Hooks & intelligence for Claude Code |

*Post-install: Initializes hooks via `npx @ruvector/cli hooks init`*

### Orchestration (Step 5)
| Package | npm Name | Features |
|---------|----------|----------|
| Claude Flow V3 | `claude-flow@v3alpha` | 175+ MCP tools, 54+ agents |

*Post-install: Creates `.claude-flow/config.json`*

### Core Packages (Step 6)
| Package | npm Name | Purpose |
|---------|----------|---------|
| Claude Code | `@anthropic-ai/claude-code` | Anthropic's AI coding CLI |
| Agentic QE | `agentic-qe` | Testing pipeline (19 agents) |
| OpenSpec | `@fission-ai/openspec` | API specification workflow |
| UI Pro CLI | `uipro-cli` | UI generation command line |
| Agent Browser | `agent-browser` | Chromium browser automation |
| CF Browser | `@claude-flow/browser` | Browser integration |

### Skills Installation (Steps 7-8, 12)
| Skill | Source | Location |
|-------|--------|----------|
| Agent Browser | npm global + GitHub fallback | `~/.claude/skills/agent-browser/` |
| Security Analyzer | `github.com/Cornjebus/security-analyzer` | `~/.claude/skills/security-analyzer/` |
| UI UX Pro Max | `uipro-cli` | `~/.claude/skills/ui-ux-pro-max/` |

*Step 7 also installs Chromium via `agent-browser install --with-deps`*

### Python Tools (Step 9)
| Tool | Install Method | Purpose |
|------|----------------|---------|
| uv | `astral.sh/uv/install.sh` | Fast Python package manager |
| Spec-Kit | `uv tool install specify-cli` | Requirements management |

*Source: `git+https://github.com/github/spec-kit.git`*

### Configuration (Steps 10-11, 13-14)
| Config | Location | Contents |
|--------|----------|----------|
| MCP Servers | `~/.config/claude/mcp.json` | claude-flow, agentic-qe servers |
| prd2build | `~/.claude/commands/prd2build.md` | PRD → Code slash command |
| Codex Config | `~/.codex/instructions.md` | Claude profile for Codex |
| AGENTS.md | `./AGENTS.md` | Codex/Claude collaboration protocol |

### Workspace Setup (Step 11)
| Component | File/Directory | Purpose |
|-----------|----------------|---------|
| Package | `package.json` | `type: "module"` |
| TypeScript | `tsconfig.json` | ES2022, ESNext modules, JSX |
| Directories | `src/`, `tests/`, `docs/`, `scripts/`, `config/`, `plans/` | Project structure |
| HeroUI | `@heroui/react`, `framer-motion` | UI components |
| Tailwind | `tailwindcss`, `postcss`, `autoprefixer` | CSS framework |
| Tailwind Config | `tailwind.config.js` | HeroUI plugin configured |
| PostCSS Config | `postcss.config.js` | Tailwind processing |
| CSS Entry | `src/index.css` | Tailwind directives |

### Bash Aliases (Step 15)
Installs 40+ aliases in `~/.bashrc`:
- RuVector: `ruv`, `ruv-stats`, `ruv-route`, `ruv-remember`, `ruv-recall`, `ruv-learn`, `ruv-init`
- Claude Flow: `cf`, `cf-init`, `cf-swarm`, `cf-mesh`, `cf-agent`, `cf-list`, `cf-daemon`, `cf-memory`, `cf-security`, `cf-mcp`
- Testing: `aqe`, `aqe-generate`, `aqe-gate`
- Browser: `ab`, `ab-open`, `ab-snap`, `ab-click`, `ab-fill`, `ab-close`
- Specs: `sk`, `sk-here`, `os`, `os-init`
- Codex: `codex-login`, `codex-run`, `codex-check`
- Utilities: `turbo-status`, `turbo-help`

---

## Workflow Phases

| Phase | Duration | Output | Tools Used |
|-------|----------|--------|------------|
| **Phase 0: Environment Setup** | 15 min | Tools installed | setup.sh |
| **Phase 1: Research & Architecture** | 60-90 min | ADR + DDD design | RuVector, Claude Flow, Spec-Kit, OpenSpec |
| **Phase 2: Branch & Statusline** | 5 min | New branch + status | Git, Claude Flow hooks |
| **Phase 3: Swarm Implementation** | 2-4 hrs | Working code | Claude Flow swarms, HeroUI, Tailwind |
| **Phase 4: Testing & Validation** | 60-90 min | Test suite | Agentic QE, Security Analyzer |
| **Phase 5: Benchmark & Optimize** | 30-60 min | Optimized code | RuVector SONA, Claude Flow |
| **Phase 6: Documentation** | 30 min | Complete docs | prd2build, OpenSpec |
| **Phase 7: E2E Testing** | 30-45 min | Browser tests | Agent Browser |

---

## Phase 0: Environment Setup (One-Time)

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

**Expected Output:**
```
📊 Turbo Flow v2.0.1 Status
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

## Phase 1: Research & Architecture

### Main Prompt:
```
Review the PR in "/plans/research" and create a detailed ADR/DDD implementation using all the
various capabilities of claude flow, self learning, security, hooks, helpers, skills, agents, and other
optimizations. Spawn swarm, do not implement yet. - lets call this project "[PROJECT NAME]"
```

### Supporting Commands:

**Initialize Spec-Kit (extract requirements):**
```bash
sk-here
```

Then in Claude Code:
```
Use Spec-Kit to extract requirements from the research and add them to the database
with acceptance criteria and priorities.
```

**Initialize OpenSpec (generate API specs):**
```bash
os-init
```

Then in Claude Code:
```
Use OpenSpec to generate OpenAPI 3.0 specifications for the endpoints based on
the requirements in Spec-Kit.
```

**Start RuVector learning trajectory:**
```bash
ruv-init
```

Then in Claude Code:
```
Start a SONA learning trajectory for: ADR/DDD architecture design
```

**Store patterns in RuVector:**
```
Store the architectural patterns in RuVector ReasoningBank with HNSW indexing
for fast retrieval.
```

### Artifacts Generated:
- `docs/adr/ADR-001.md` through `ADR-010.md`
- `docs/adr/ADR-SEC-001.md` through `ADR-SEC-005.md`
- `docs/ddd/bounded-contexts.md`
- `docs/ddd/aggregates.md`
- `docs/ddd/entities.md`
- `.specify/` database
- `openspec.yaml`

---

## Phase 2: Branch & Statusline

### Main Prompt:
```
create new branch "[PROJECT NAME]" and commit - update the statusline to match the
DDD we just outlined using the ADRs and available hooks and helpers
```

### Helper Paths (paste in statusline):
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

---

## Phase 3: Swarm Implementation

### Main Prompt:
```
spawn the swarm implement completely,
test, validate, benchmark, optimize, document, continue until complete
```

### Supporting Commands:

**Spawn hierarchical swarm:**
```bash
cf-swarm
```

**Or spawn mesh swarm (for complex interdependent tasks):**
```bash
cf-mesh
```

**Claude Flow Agent Types Available:**
```bash
cf-list
```

Key agents: `architect`, `coder`, `tester`, `reviewer`, `security-architect`, `code-analyzer`, `documenter`, `optimizer`

### Frontend Implementation (HeroUI + Tailwind):

In Claude Code:
```
Create HeroUI components for the frontend using Button, Card, Input, Modal, etc.
Style with Tailwind CSS utility classes. Use Framer Motion for animations.
```

**Available HeroUI Components:**
```jsx
import { Button, Card, Input, Modal, Dropdown, Avatar, Badge, Chip, 
         Progress, Spinner, Table, Tabs, Tooltip } from "@heroui/react";
```

---

## Phase 4: Testing & Validation

### Main Prompt:
```
initialize Agentic QE fleet - run comprehensive testing, validate, benchmark,
and continue until complete
```

### Supporting Commands:

**Generate tests:**
```bash
aqe-generate
```

**Run quality gate:**
```bash
aqe-gate
```

**Run security scan:**
```bash
cf-security
```

Or in Claude Code:
```
Run security scan on the codebase to check for OWASP Top 10 vulnerabilities
and any security issues using the Security Analyzer skill.
```

### Quality Targets:
- Test coverage: 80%+
- Critical vulnerabilities: 0
- All quality gates: PASS

---

## Phase 5: Benchmark & Optimize

### Main Prompt:
```
benchmark, test, optimize - store patterns for future use in RuVector ReasoningBank
```

### Supporting Commands:

**Check learning stats:**
```bash
ruv-stats
```

**Store successful patterns:**
```bash
ruv-remember -t optimization "Pattern description"
```

**Search for similar past optimizations:**
```bash
ruv-recall "performance optimization"
```

**Trigger pattern consolidation:**
```bash
cf-memory status
```

---

## Phase 6: Documentation

### Main Prompt:
```
document - use prd2build to generate complete documentation with INDEX.md showing
traceability: Requirements → ADR → Code → Tests
```

### In Claude Code:
```
/prd2build prd.md
```

### Supporting Commands:

**Generate API documentation:**
```
Use OpenSpec to generate API documentation for all endpoints.
```

### Artifacts Generated:
- `docs/implementation/INDEX.md` (traceability matrix)
- `docs/specification/requirements.md`
- `docs/specification/user-stories.md`
- `docs/specification/api-contracts.md`
- API documentation from OpenSpec

---

## Phase 7: E2E Testing

### Main Prompt:
```
go create me an end to end test using agent-browser - optimize - and be very specific about the
size of the window you are evaluating on claude
```

### Supporting Commands:

**Agent Browser operations:**
```bash
ab-open "http://localhost:3000"    # Open URL
ab-snap                             # Get accessibility snapshot
ab-click @ref                       # Click element
ab-fill @ref "text"                 # Fill input
ab-close                            # Close browser
```

### In Claude Code:
```
Use Agent Browser to navigate to the application and take screenshots of key pages
for visual regression testing. Test viewport sizes: 1920x1080, 1366x768, 375x667.
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

## Tool → Phase Matrix

| Tool | Phase 0 | Phase 1 | Phase 2 | Phase 3 | Phase 4 | Phase 5 | Phase 6 | Phase 7 |
|------|---------|---------|---------|---------|---------|---------|---------|---------|
| **RuVector** | Install | ✅ | | ✅ | | ✅ | | |
| **@ruvector/sona** | Install | ✅ | | | | ✅ | | |
| **@ruvector/cli** | Install | ✅ | ✅ | ✅ | | ✅ | | |
| **Claude Flow V3** | Install | ✅ | ✅ | ✅ | ✅ | ✅ | | |
| **Spec-Kit** | Install | ✅ | | | | | ✅ | |
| **OpenSpec** | Install | ✅ | | | | | ✅ | |
| **Agentic QE** | Install | | | | ✅ | | | |
| **Agent Browser** | Install | | | | | | | ✅ |
| **Security Analyzer** | Install | | | | ✅ | | | |
| **HeroUI** | Install | | | ✅ | | | | |
| **Tailwind CSS** | Install | | | ✅ | | | | |
| **prd2build** | Install | | | | | | ✅ | |
| **Claude Code** | Install | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

---

**Version:** 3.0.1 (Updated for Turbo Flow v2.0.1)
**Last Updated:** 2026-01-21
