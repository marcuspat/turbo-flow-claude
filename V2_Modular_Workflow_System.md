# RUV's Complete Workflow - Claude Flow V3.0

**Research-Driven ADR/DDD Architecture with Full-Stack Implementation**

---

## Overview

This is RUV's complete workflow that transforms research into production-ready software. Simply tell Claude what you want, and it handles everything.

**No npx commands needed - just prompts!**

---

## Workflow Phases

| Phase | Duration | Output | Status |
|-------|----------|--------|--------|
| **Phase 1: Research & Architecture** | 60-90 min | ADR + DDD design | Pending |
| **Phase 2: Branch & Statusline** | 5 min | New branch + status | Pending |
| **Phase 3: Swarm Implementation** | 2-4 hrs | Working code | Pending |
| **Phase 4: Testing & Validation** | 60-90 min | Test suite | Pending |
| **Phase 5: Benchmark & Optimize** | 30-60 min | Optimized code | Pending |
| **Phase 6: Documentation** | 30 min | Complete docs | Pending |
| **Phase 7: E2E Testing** | 30-45 min | Playwright tests | Pending |

---

## Phase 1: Research & Architecture (ADR/DDD Creation)

**Prompt to Claude:**

```
Review the /plans/research directory and create a detailed ADR/DDD implementation
using all the various capabilities of Claude Flow V3: self-learning, security,
hooks, neural memory (HNSW indexing), and other optimizations.

Spawn a swarm to analyze the research and create architecture. DO NOT IMPLEMENT YET.
```

**What Claude does:**

1. **Initializes swarm coordination** (hierarchical-mesh topology, 15 agents, Raft consensus)

2. **Spawns research agents in background:**
   - Research Agent: Reads all markdown files in `/plans/research/`
   - System Architect: Designs DDD bounded contexts and aggregates
   - Security Architect: Creates STRIDE threat model and OWASP compliance ADRs
   - Integration Architect: Designs agentic-flow@alpha integration patterns
   - Memory Specialist: Initializes HNSW indexing and ReasoningBank
   - Performance Engineer: Defines metrics and optimization strategies
   - Specification Agent: Extracts requirements and creates OpenAPI specs

3. **Enables SONA learning trajectory** for the architecture phase

4. **Creates ADR roadmap:**
   - ADR-001: Project Name & Scope
   - ADR-002: Technology Stack
   - ADR-003: Architecture Pattern
   - ADR-004: Database Design
   - ADR-005: Authentication Strategy
   - ADR-006: API Design
   - ADR-007: Caching Strategy
   - ADR-008: Message Queue
   - ADR-009: Frontend Framework
   - ADR-010: Deployment Strategy
   - ADR-SEC-001 through ADR-SEC-005: Security ADRs (STRIDE, OWASP, SLSA)

5. **Designs DDD architecture:**
   - Bounded Contexts (User, Core, Infrastructure, API)
   - Aggregates (User, Session, Configuration)
   - Entities and Value Objects
   - Context Maps
   - Domain Events

6. **Stores patterns in ReasoningBank** with HNSW indexing

7. **Completes SONA trajectory** and stores learnings

---

## Phase 2: Branch & Statusline Setup

**Prompt to Claude:**

```
Create a new branch for this project and commit the architecture.

Then update the statusline to match the DDD we just outlined, including the ADRs
and available hooks and helpers.
```

**What Claude does:**

1. **Creates feature branch** named after the project from ADR-001

2. **Creates statusline config** at `.claude/statusline.json`:
   - Project name and branch
   - DDD contexts and aggregates
   - Active ADRs
   - V3 configuration (topology, agents, consensus)
   - Helper scripts reference

3. **Commits architecture:**
   - All ADRs (ADR-001 through ADR-010)
   - Security ADRs (ADR-SEC-001 through ADR-SEC-005)
   - DDD documentation
   - Threat model
   - SONA trajectory data

---

## Phase 3: Swarm Implementation

**Prompt to Claude:**

```
Spawn the swarm and implement the project completely based on the ADR/DDD
architecture we created. Test everything, validate, benchmark, optimize,
and document. Continue until complete.
```

**What Claude does:**

1. **Gets intelligent routing recommendation** for optimal model selection

2. **Spawns implementation swarm in background:**
   - Backend Dev: Implements bounded contexts and aggregates
   - Coder (Haiku): Simple entities, DTOs, utilities
   - Integration Architect: agentic-flow@alpha integration
   - API Docs: OpenAPI specs and documentation
   - Frontend Coder: HeroUI components with Tailwind
   - Test Generator: Unit and integration tests
   - Security Auditor: Validates security implementation

3. **Monitors swarm progress** (in separate terminal if needed)

4. **Stores implementation patterns** after each major component

5. **Triggers background workers:**
   - Optimization worker
   - Security audit worker
   - Test gap analysis worker
   - Codebase mapping worker

---

## Phase 4: Testing & Validation

**Prompt to Claude:**

```
Run comprehensive testing with Agentic QE. Generate all tests, run quality gates,
and ensure 80%+ coverage with zero critical vulnerabilities.
```

**What Claude does:**

1. **Initializes QE fleet** with hierarchical topology

2. **Spawns QE agents:**
   - Test Generator: Creates unit, integration, and E2E tests
   - Coverage Analyzer: Identifies coverage gaps
   - Quality Gate: Enforces standards
   - Security Scanner: OWASP validation
   - Performance Tester: Load testing

3. **Executes test suites** in parallel

4. **Runs quality gate** and generates reports

---

## Phase 5: Benchmark & Optimize

**Prompt to Claude:**

```
Run performance benchmarks, analyze bottlenecks, and apply optimizations.
Store optimization patterns for future reference.
```

**What Claude does:**

1. **Runs performance benchmarks** (all suites, 100 iterations)

2. **Analyzes bottlenecks** with deep analysis

3. **Applies optimizations** aggressively

4. **Stores optimization patterns** in ReasoningBank

---

## Phase 6: Documentation

**Prompt to Claude:**

```
Generate complete documentation for the project including specs, DDD docs,
ADRs, implementation INDEX.md, API docs, and user guide.
```

**What Claude does:**

1. **Generates documentation** using prd2build

2. **Creates INDEX.md** as single source of truth with traceability:
   - Requirements → ADR → Code Files
   - User Stories → Implementation → Tests
   - API Specs → Endpoints → Tests

3. **Verifies all documentation** is complete

---

## Phase 7: E2E Testing with Playwright

**Prompt to Claude:**

```
Create an assets folder and generate Playwright end-to-end tests. When doing
frontend development, be very specific about the window size you're evaluating.
Include tests for desktop (1920x1080, 1440x900, 1366x768), tablet (768x1024),
and mobile (390x844, 428x926) sizes. Paste screenshots in the assets folder.
```

**What Claude does:**

1. **Creates assets folder:**
   - `assets/screenshots/`
   - `assets/videos/`
   - `assets/traces/`

2. **Creates Playwright config** with all viewport sizes:
   - Desktop: 1920x1080, 1440x900, 1366x768, 1536x864, 1280x720
   - Tablet: iPad Pro 11 landscape/portrait
   - Mobile: iPhone 14 Pro (390x844), iPhone 14 Pro Max (428x926), Pixel 5

3. **Creates E2E tests:**
   - Complete user flow tests
   - Responsive layout tests
   - Visual regression tests

4. **Runs tests** and captures screenshots

5. **Generates test report** with visual comparisons

---

## Helper Scripts Reference

**Available helpers in `.claude/helpers/`:**

| Helper | Purpose |
|--------|---------|
| `guidance-hooks.sh` | Pre/post task guidance |
| `auto-commit.sh` | Automatic git commits |
| `ddd-tracker.sh` | DDD context tracking |
| `swarm-hooks.sh` | Swarm event hooks |
| `learning-hooks.sh` | SONA learning triggers |
| `security-scanner.sh` | Security scanning automation |
| `worker-manager.sh` | Background worker management |
| `pattern-consolidator.sh` | Memory consolidation |
| `perf-worker.sh` | Performance monitoring |
| `checkpoint-manager.sh` | State checkpointing |
| `v3.sh` | V3 specific commands |
| `swarm-monitor.sh` | Swarm health monitoring |
| `swarm-comms.sh` | Inter-agent communication |

---

## Quick Reference - What to Say to Claude

### Starting a Project
```
Review /plans/research and create ADR/DDD architecture using Claude Flow V3.
Spawn swarm, do not implement yet.
```

### Creating Branch
```
Create branch [project-name] and commit architecture. Update statusline
with DDD context and helpers.
```

### Implementation
```
Spawn swarm and implement completely. Test, validate, benchmark, optimize,
document. Continue until complete.
```

### Testing
```
Run comprehensive testing with Agentic QE. Generate all tests, quality gates,
80%+ coverage, zero critical vulnerabilities.
```

### Optimization
```
Run performance benchmarks, analyze bottlenecks, apply optimizations.
```

### Documentation
```
Generate complete documentation with prd2build.
```

### E2E Testing
```
Create assets folder and Playwright E2E tests. Test all viewport sizes:
desktop (1920x1080, 1440x900, 1366x768), tablet (768x1024), mobile (390x844).
Save screenshots to assets/screenshots/.
```

---

## Completion Checklist

### Architecture Phase (Phase 1)
- [ ] Research analyzed from `/plans/research`
- [ ] ADR-001 through ADR-010 created
- [ ] ADR-SEC-001 through ADR-SEC-005 created
- [ ] DDD bounded contexts defined
- [ ] DDD aggregates documented
- [ ] Patterns stored in ReasoningBank
- [ ] SONA trajectory completed

### Branch & Statusline (Phase 2)
- [ ] Feature branch created
- [ ] Statusline configured with DDD context
- [ ] Initial commit with architecture

### Implementation (Phase 3)
- [ ] Backend bounded contexts implemented
- [ ] Frontend HeroUI components created
- [ ] API endpoints functional
- [ ] Integration with agentic-flow@alpha
- [ ] MCP servers connected
- [ ] Security validations applied

### Testing (Phase 4)
- [ ] Unit tests passing (80%+ coverage)
- [ ] Integration tests passing
- [ ] Quality gate passed
- [ ] Security scan passed (zero critical)

### Optimization (Phase 5)
- [ ] Performance benchmarks met
- [ ] Bottlenecks resolved
- [ ] Optimization patterns stored

### Documentation (Phase 6)
- [ ] INDEX.md traceability complete
- [ ] API documentation generated
- [ ] User guide created

### E2E Testing (Phase 7)
- [ ] Playwright tests passing
- [ ] All viewport sizes tested
- [ ] Screenshots in assets/screenshots/
- [ ] Visual regression passed

---

## Notes

1. **Just tell Claude what you want** - no need for npx commands
2. **Claude spawns agents in background** and waits for results
3. **Monitor progress** in separate terminal if needed
4. **Screenshots go in assets/** folder for visual regression
5. **Viewport sizes are specified** for each frontend test

---

**Version:** 3.0.0 (RUV's Prompt-Driven Workflow)
**Last Updated:** 2026-01-18
