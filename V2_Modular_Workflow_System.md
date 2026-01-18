#Complete Workflow - Claude Flow V3.0

**Research-Driven ADR/DDD Architecture with Full-Stack Implementation**

---

## Overview

This is RUV's complete workflow that transforms research into production-ready software.

**One-time setup via `devpods/setup.sh`, then use prompts for each phase.**

---

## Workflow Phases

| Phase | Duration | Output | Status |
|-------|----------|--------|--------|
| **Phase 0: Environment Setup** | 15 min | Tools installed | One-time |
| **Phase 1: Research & Architecture** | 60-90 min | ADR + DDD design | Pending |
| **Phase 2: Branch & Statusline** | 5 min | New branch + status | Pending |
| **Phase 3: Swarm Implementation** | 2-4 hrs | Working code | Pending |
| **Phase 4: Testing & Validation** | 60-90 min | Test suite | Pending |
| **Phase 5: Benchmark & Optimize** | 30-60 min | Optimized code | Pending |
| **Phase 6: Documentation** | 30 min | Complete docs | Pending |
| **Phase 7: E2E Testing** | 30-45 min | Playwright tests | Pending |

---

## Phase 0: Environment Setup (One-Time)

**Prompt:**
```
Run devpods/setup.sh to set up my complete development environment.
```

**What gets installed:**
- Node.js 20, RuVector, Claude Flow V3, Spec-Kit, OpenSpec
- Agentic QE, playwriter, Dev-Browser, Security Analyzer
- HeroUI, Tailwind, prd2build, MCP servers, bash aliases
- Workspace directories (src, tests, docs, scripts, config, plans)

---

## Phase 1: Research & Architecture

**Main Prompt:**
```
Review the "/plans/research" and create a detailed ADR/DDD implementation using all the
various capabilities of claude flow, self learning, security, hooks, helpers, skills, agents, and other
optimizations. Spawn swarm, do not implement yet. - lets call this project "[PROJECT NAME]"
```

**Additional prompts during this phase:**

**Spec-Kit - Extract requirements:**
```
Use Spec-Kit to extract requirements from the research and add them to the database
with acceptance criteria and priorities.
```

**OpenSpec - Generate API specs:**
```
Use OpenSpec to generate OpenAPI 3.0 specifications for the endpoints based on
the requirements in Spec-Kit.
```

**RuVector - Start learning trajectory:**
```
Start a SONA learning trajectory for: ADR/DDD architecture design
```

**RuVector - Store patterns:**
```
Store the architectural patterns in RuVector ReasoningBank with HNSW indexing
for fast retrieval.
```

---

## Phase 2: Branch & Statusline

**Main Prompt:**
```
create new branch "[PROJECT NAME]" and commit - update the statusline to match the
DDD we just outlined using the ADRs and available hooks and helpers
(paste helpers paths from helper directory just in case)
```

**Helper paths (paste in statusline):**
- `.claude/helpers/guidance-hooks.sh`
- `.claude/helpers/auto-commit.sh`
- `.claude/helpers/ddd-tracker.sh`
- `.claude/helpers/swarm-hooks.sh`
- `.claude/helpers/learning-hooks.sh`
- `.claude/helpers/security-scanner.sh`
- `.claude/helpers/worker-manager.sh`
- `.claude/helpers/pattern-consolidator.sh`
- `.claude/helpers/perf-worker.sh`
- `.claude/helpers/checkpoint-manager.sh`
- `.claude/helpers/v3.sh`
- `.claude/helpers/swarm-monitor.sh`
- `.claude/helpers/swarm-comms.sh`

---

## Phase 3: Swarm Implementation

**Main Prompt:**
```
spawn the swarm in one window, then interrogate in another - implement completely,
test, validate, benchmark, optimize, document, continue until complete
```

**Additional prompts during this phase:**

**Claude Flow V3 - Spawn swarm:**
```
Spawn hierarchical-mesh swarm with 15 agents for implementation.
Use intelligent routing (haiku for simple tasks, sonnet/opus for complex).
```

**HeroUI - Create components:**
```
Create HeroUI components for the frontend using Button, Card, Input, etc.
Style with Tailwind CSS.
```

**Tailwind - Apply styling:**
```
Apply Tailwind CSS classes to all components for responsive design.
```

---

## Phase 4: Testing & Validation

**Main Prompt:**
```
initialize Agentic QE fleet - run comprehensive testing, validate, benchmark,
and continue until complete
```

**Additional prompts during this phase:**

**Agentic QE - Generate tests:**
```
Use Agentic QE to generate comprehensive unit and integration tests.
Target 80%+ coverage.
```

**Agentic QE - Run quality gate:**
```
Run Agentic QE quality gate to ensure all tests pass, coverage is 80%+,
and zero critical vulnerabilities.
```

**Security Analyzer - Security scan:**
```
Run security scan on the codebase to check for OWASP Top 10 vulnerabilities
and any security issues.
```

---

## Phase 5: Benchmark & Optimize

**Main Prompt:**
```
benchmark, test, optimize - store patterns for future use in RuVector ReasoningBank
```

---

## Phase 6: Documentation

**Main Prompt:**
```
document - use prd2build to generate complete documentation with INDEX.md showing
traceability: Requirements → ADR → Code → Tests
```

**Additional prompts during this phase:**

**OpenSpec - Generate API documentation:**
```
Use OpenSpec to generate API documentation for all endpoints.
```

---

## Phase 7: E2E Testing

**Main Prompt:**
```
go create me a playwright end to end test - optimize - and be very specific about the
size of the window you are evaluating on claude
```

**Additional prompts during this phase:**

**playwriter - Create E2E test:**
```
Create playwriter E2E test for: [scenario]. Include specific viewport sizes
and save screenshots to assets/screenshots/.
```

**playwriter - Run tests:**
```
Run all playwriter E2E tests and generate a report with screenshots for each viewport.
```

**Dev-Browser - Visual testing:**
```
Use Dev-Browser to navigate to the application and take screenshots of key pages
for visual regression testing.
```

---

## Completion Checklist

### Environment Setup (Phase 0 - One-Time)
- [ ] Ran devpods/setup.sh
- [ ] All tools installed (turbo-status)
- [ ] Workspace directories created

### Architecture Phase (Phase 1)
- [ ] Research analyzed from `/plans/research`
- [ ] ADR-001 through ADR-010 created
- [ ] ADR-SEC-001 through ADR-SEC-005 created
- [ ] DDD bounded contexts defined
- [ ] Spec-Kit requirements extracted
- [ ] OpenAPI specs generated with OpenSpec
- [ ] Patterns stored in RuVector ReasoningBank
- [ ] SONA trajectory completed
- [ ] Project named

### Branch & Statusline (Phase 2)
- [ ] Feature branch created
- [ ] Statusline configured with DDD context
- [ ] Helper paths included in statusline
- [ ] Architecture committed

### Implementation (Phase 3)
- [ ] Swarm spawned in one window
- [ ] Interrogate in another window
- [ ] HeroUI components created
- [ ] Tailwind CSS applied
- [ ] Code implemented following DDD architecture

### Testing (Phase 4)
- [ ] Agentic QE fleet initialized
- [ ] Tests generated
-- [ ] Validated
- [ ] Benchmarked
- [ ] Quality gate passed
- [ ] 80%+ coverage achieved
- [ ] Security scan passed (zero critical)

### Optimization (Phase 5)
- [ ] Performance benchmarks run
- [ ] Bottlenecks resolved
- [ ] Optimization patterns stored in ReasoningBank

### Documentation (Phase 6)
- [ ] Documentation generated with prd2build
- [ ] INDEX.md traceability verified
- [ ] API docs generated with OpenSpec

### E2E Testing (Phase 7)
- [ ] playwriter E2E tests created
- [ ] Optimized
- [ ] Window sizes specified
- [ ] Screenshots saved to assets/screenshots/
- [ ] Tests passing

---

## Installed Tools (via setup.sh)

| Tool | Used In Phase |
|------|---------------|
| **RuVector** | 1, 3, 5 |
| **Claude Flow V3** | 1, 3 |
| **Spec-Kit** | 1, 6 |
| **OpenSpec** | 1, 6 |
| **Agentic QE** | 4 |
| **playwriter** | 7 |
| **Dev-Browser** | 7 |
| **Security Analyzer** | 4 |
| **HeroUI** | 3 |
| **Tailwind CSS** | 3 |
| **prd2build** | 6 |
| **Claude Code** | 3 |

---

**Version:** 3.0.0 (RUV's Prompt-Driven Workflow)
**Last Updated:** 2026-01-18
