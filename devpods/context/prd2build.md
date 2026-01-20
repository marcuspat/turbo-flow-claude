---
name: prd2build
description: PRD → Complete Documentation (Single Command)
version: 3.0.0-simplified
arguments:
  - name: prd_input
    description: Path to PRD file or inline PRD content
    required: false
  - name: build
    description: Execute FULL build (all 4 milestones) after documentation is complete
    required: false
    switch: --build
    guidance: "Full build through all milestones (not just foundation). Continues automatically until M3 complete."
  - name: build_only
    description: Execute build using existing documentation (skip doc generation)
    required: false
    switch: --build-only
    guidance: "Requires existing docs/ folder with complete documentation. Skips doc generation phase."
  - name: max_agents
    description: Maximum number of agents to spawn concurrently (controls API rate limits)
    required: false
    switch: --max-agents
    default: "8"
    guidance: "Controls parallel agent execution to prevent API exhaustion. Default: 8. Lower values reduce API load but increase total time."
---

# PRD to Complete Documentation - Simplified

**One command. Complete documentation. No complexity.**

---

## What This Does

You provide a PRD. You get:

1. **Specification docs** - Requirements, user stories, API contracts, security model
2. **Domain model (DDD)** - Bounded contexts, aggregates, entities, events, database schema
3. **Architecture (ADR)** - All architectural decisions with rationale
4. **Implementation plan** - Milestones, epics, tasks with dependencies
5. **Unified INDEX.md** - Single entry point that ties everything together

### With --build flag, executes ALL milestones:

**Build Milestones:**
- **M0 (Foundation)**: Project structure, entities, middleware, database setup
- **M1 (MVP)**: Data access, repositories, migrations, core business logic
- **M2 (Release)**: API layer, routes, validation, error handling
- **M3 (Enhanced)**: UI integration, external services, polish

**Terminology:**
- **Milestones (M0-M3)** = Both planning documents AND build execution stages
- Each milestone has defined deliverables and completion criteria

**CRITICAL**: The build is NOT complete until ALL milestones finish. Agents continue automatically between milestones.


---

## Usage

```bash
# Generate documentation only
/prd2build /path/to/your-prd.md

# Generate documentation AND execute build
/prd2build /path/to/your-prd.md --build

# Execute build only (using existing docs)
/prd2build --build-only
```

**Documentation only**: Wait 5-10 minutes. All documentation generated in `docs/`.

**With --build**: Documentation generates first, then hierarchical swarm executes the complete build following all ADRs and DDD artifacts.

**With --build-only**: Skips documentation generation. Requires existing `docs/` folder with complete ADRs, DDD artifacts, and INDEX.md. Launches build swarm immediately.

---

## Input PRD

$ARGUMENTS

---

## Execution (Single Batch)

**CRITICAL**: This runs as ONE concurrent batch. All agents spawn together, work in parallel, report when done.

```javascript
// Initialize system (REQUIRED FIRST)
Bash("mkdir -p docs/{specification,ddd,adr,sparc,implementation/{milestones,epics,tasks},testing,design/mockups}")
Bash("npx @claude-flow/cli@latest init --no-color 2>/dev/null || true")
Bash("npx @claude-flow/cli@latest memory init --force --no-color 2>/dev/null || true")

// Check execution mode
const buildOnly = "$ARGUMENTS".includes("--build-only")
const docAndBuild = "$ARGUMENTS".includes("--build")

// Parse max-agents from arguments (default: 8)
const maxAgentsMatch = "$ARGUMENTS".match(/--max-agents[= ](\d+)/)
const maxAgents = maxAgentsMatch ? parseInt(maxAgentsMatch[1]) : 8

// If --build-only, validate docs exist
if (buildOnly) {
  Bash(`
    if [ ! -d docs/adr ] || [ ! -d docs/ddd ] || [ ! -f docs/implementation/INDEX.md ] || [ ! -f start-env.sh ]; then
      echo "❌ ERROR: Incomplete documentation. Required:"
      echo "  - docs/adr/ (ADRs)"
      echo "  - docs/ddd/ (Domain model)"
      echo "  - docs/implementation/INDEX.md"
      echo "  - start-env.sh (environment setup script)"
      echo ""
      echo "Run without --build-only first to generate docs."
      exit 1
    fi
    echo "✅ Documentation verified. Proceeding to build phase..."
  `)
}

// DOCUMENTATION PHASE (skip if --build-only)
if (!buildOnly) {
  // Spawn ALL documentation agents in PARALLEL (foreground mode)
  // They all run concurrently and block until ALL complete

Task("researcher", `
Read PRD from arguments above.

Generate docs/specification/:
- requirements.md (REQ-XXX IDs, functional requirements)
- non-functional.md (performance, security, scalability targets)
- user-stories.md (As a [role], I want [goal], so that [benefit])
- user-journeys.md (actor definitions, user flows, use cases)
- api-contracts.md (OpenAPI-style endpoint specs)
- security-model.md (threat model, auth/authz, data classification)
- edge-cases.md (boundary conditions)
- constraints.md (technical and business limits)
- glossary.md (domain terminology)

Extract:
- All requirements with unique IDs
- All actors and their goals
- All API endpoints
- Security requirements (auth methods, encryption, compliance)

MINIMUM QUALITY BARS:
- 8+ specification files
- 15+ user stories (for any real project)
- 10+ API endpoints (if API-based)
- Security model >50 lines (substantial, not just headers)

Store key entities in memory for other agents.
`, "researcher")

  // Explicit memory storage: researcher outputs
  Bash(`
    # Extract and store requirements summary
    grep -E '^## |^### |^- REQ-' docs/specification/requirements.md | head -30 | tr '\n' '|' > /tmp/prd_reqs.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key requirements_summary --value "$(cat /tmp/prd_reqs.txt)" 2>/dev/null || true

    # Extract and store API endpoints
    grep -E '(GET|POST|PUT|DELETE|PATCH) /' docs/specification/api-contracts.md | tr '\n' '|' > /tmp/prd_apis.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key api_endpoints --value "$(cat /tmp/prd_apis.txt)" 2>/dev/null || true

    # Extract and store actors
    grep -E '^## |^### |\*\*Actor' docs/specification/user-journeys.md | head -20 | tr '\n' '|' > /tmp/prd_actors.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key actors --value "$(cat /tmp/prd_actors.txt)" 2>/dev/null || true

    # Count and store specification files
    ls docs/specification/*.md 2>/dev/null | wc -l > /tmp/prd_spec_count.txt 2>/dev/null || echo "0" > /tmp/prd_spec_count.txt
    npx @claude-flow/cli@latest memory store --namespace prd2build --key spec_files_count --value "$(cat /tmp/prd_spec_count.txt)" 2>/dev/null || true

    rm -f /tmp/prd_*.txt 2>/dev/null || true
  `)

Task("ui-designer", `
Read PRD and requirements.md.

CRITICAL: Check for existing style guides BEFORE generating:
- If docs/specification/style-guide.md exists → READ and REUSE it, DO NOT overwrite
- If docs/specification/style-guide.html exists → READ and REUSE it, DO NOT overwrite

Generate design artifacts:
1. docs/specification/wireframes.md (ASCII wireframes, all major screens)
2. docs/specification/style-guide.md (colors, typography, spacing) - ONLY if not exists
3. docs/specification/style-guide.html (interactive visual guide) - ONLY if not exists
4. docs/design/mockups/*.html (pixel-perfect mockups with dark/light toggle)

Color selection (3-tier priority):
1. TIER 0: Check existing (tailwind.config.js, design-tokens.css) → USE THOSE
2. TIER 1: PRD mentions (brand colors, competitor refs) → USE THOSE
3. TIER 2: Domain psychology (healthcare=blue, finance=navy, ecommerce=neutral)
4. TIER 3: Generate 3 options with rationale if unclear

Typography: Use Google Fonts appropriate for domain.

Accessibility: WCAG 2.1 AA compliance, keyboard nav, screen reader support.

Store design tokens in memory.
`, "ui-designer")

  // Explicit memory storage: ui-designer outputs
  Bash(`
    # Extract and store color palette
    grep -E 'color|#[0-9a-fA-F]{6}|rgb\(|hsl\(' docs/specification/style-guide.md | head -20 | tr '\n' '|' > /tmp/prd_colors.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key design_colors --value "$(cat /tmp/prd_colors.txt)" 2>/dev/null || true

    # Extract and store typography choices
    grep -E 'font|Font|typography|Typography' docs/specification/style-guide.md | head -10 | tr '\n' '|' > /tmp/prd_fonts.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key design_typography --value "$(cat /tmp/prd_fonts.txt)" 2>/dev/null || true

    # Count mockup files
    ls docs/design/mockups/*.html 2>/dev/null | wc -l > /tmp/prd_mockup_count.txt 2>/dev/null || echo "0" > /tmp/prd_mockup_count.txt
    npx @claude-flow/cli@latest memory store --namespace prd2build --key mockup_count --value "$(cat /tmp/prd_mockup_count.txt)" 2>/dev/null || true

    rm -f /tmp/prd_*.txt 2>/dev/null || true
  `)

Task("Environment Setup", `
Read PRD and extract tech stack information:

Generate start-env.sh script that starts all required services.

Extract from PRD:
- Database type and port (PostgreSQL, MySQL, MongoDB, SQLite, etc.)
- Cache type and port (Redis, Memcached, etc.)
- Backend framework and port (Rust/Loco, Node/Express, Django, Rails, etc.)
- Frontend framework and port (React/Vite, Next.js, Vue, Svelte, etc.)

Default ports if not specified in PRD:
- PostgreSQL: 5432
- MySQL: 3306
- MongoDB: 27017
- Redis: 6379
- Memcached: 11211
- Backend: 5843 (or 3001, 8000, 4000 depending on framework)
- Frontend dev server: 3000 (or 5173 for Vite, 3001 for Next.js)

Generate start-env.sh with:
1. Shebang and header comments
2. Service startup commands for each detected service:
   - Database (PostgreSQL/MySQL start commands)
   - Cache (Redis/Memcached start commands)
   - Backend server (cargo run, npm run dev, python manage.py runserver, etc.)
   - Frontend dev server (npm run dev, next dev, etc.)
3. Health checks for each service
4. Graceful shutdown handler (trap signals)
5. Log output showing which services started
6. Instructions for manual start if auto-detection fails

Example output structure:
\`\`\`bash
#!/bin/bash
# Start all ForgeCMS services
# Auto-generated from PRD tech stack

set -e

echo "🚀 Starting ForgeCMS services..."

# Start PostgreSQL
echo "📊 Starting PostgreSQL on port 5432..."
# Add service-specific start command

# Start Redis
echo "⚡ Starting Redis on port 6379..."
# Add service-specific start command

# Start Backend (Rust + Loco)
echo "🦀 Starting backend on port 5843..."
# Add service-specific start command

# Start Frontend (React + Vite)
echo "⚛️  Starting frontend on port 3000..."
# Add service-specific start command

echo "✅ All services started!"
echo ""
echo "Access your application:"
echo "  - Frontend: http://localhost:3000"
echo "  - Backend API: http://localhost:5843"
echo "  - Database: localhost:5432"
echo "  - Cache: localhost:6379"
\`\`\`

Save to project root: start-env.sh
Make executable: chmod +x start-env.sh

Store tech stack details in memory for other agents.
`, "coder")

  // Explicit memory storage: devops setup outputs
  Bash(`
    # Extract tech stack from start-env.sh
    grep -E 'PostgreSQL|MySQL|MongoDB|Redis|Memcached|Backend|Frontend|port [0-9]+' start-env.sh 2>/dev/null | head -20 | tr '\n' '|' > /tmp/prd_techstack.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key tech_stack --value "$(cat /tmp/prd_techstack.txt)" 2>/dev/null || true

    # Extract database info
    grep -E 'PostgreSQL|MySQL|MongoDB|SQLite|Database|port.*543|port.*330' start-env.sh 2>/dev/null | head -5 | tr '\n' '|' > /tmp/prd_database.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key database_info --value "$(cat /tmp/prd_database.txt)" 2>/dev/null || true

    # Extract cache info
    grep -E 'Redis|Memcached|Cache|port.*637|port.*112' start-env.sh 2>/dev/null | head -5 | tr '\n' '|' > /tmp/prd_cache.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key cache_info --value "$(cat /tmp/prd_cache.txt)" 2>/dev/null || true

    # Extract backend framework info
    grep -E 'Backend|Rust|Node|Django|Rails|Express|Loco|port.*584|port.*300[0-9]|port.*800' start-env.sh 2>/dev/null | head -5 | tr '\n' '|' > /tmp/prd_backend.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key backend_info --value "$(cat /tmp/prd_backend.txt)" 2>/dev/null || true

    # Extract frontend framework info
    grep -E 'Frontend|React|Vue|Svelte|Next|Vite|port.*300|port.*517' start-env.sh 2>/dev/null | head -5 | tr '\n' '|' > /tmp/prd_frontend.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key frontend_info --value "$(cat /tmp/prd_frontend.txt)" 2>/dev/null || true

    rm -f /tmp/prd_*.txt 2>/dev/null || true
  `)

Task("code-analyzer", `
Read PRD and requirements.md from memory.

Generate docs/ddd/:
- domain-model.md (strategic design overview)
- bounded-contexts.md (context boundaries, responsibilities)
- context-map.md (relationships between contexts with diagram)
- ubiquitous-language.md (per-context terminology)
- aggregates.md (aggregate roots, consistency boundaries)
- entities.md (domain entities with identity)
- value-objects.md (immutable value objects)
- domain-events.md (event catalog with triggers)
- sagas.md (long-running processes, compensating transactions)
- repositories.md (repository interfaces)
- services.md (domain and application services)
- database-schema.md (complete schema with migrations)
- migrations/XXX-* (numbered migration files)

MINIMUM DDD ARTIFACTS:
- 3+ bounded contexts (Core + Supporting + Generic)
- 5+ aggregates (1-2 per context)
- 8+ entities (aggregates + children)
- 10+ value objects (Money, Email, Status, etc.)
- 6+ domain events (1 per aggregate transition)
- 5+ repositories (1 per aggregate root)
- 4+ services (domain + application)

Generate SQL migrations from aggregates (1 migration per aggregate).

Store aggregate list in memory.
`, "code-analyzer")

  // Explicit memory storage: code-analyzer (DDD) outputs
  Bash(`
    # Extract and store bounded contexts
    grep -E '^## |^### ' docs/ddd/bounded-contexts.md | sed 's/^## //;s/^### //' | tr '\n' '|' > /tmp/prd_contexts.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key bounded_contexts --value "$(cat /tmp/prd_contexts.txt)" 2>/dev/null || true

    # Extract and store aggregates
    grep -E '^## |^### |\*\*.*Aggregate' docs/ddd/aggregates.md | head -20 | tr '\n' '|' > /tmp/prd_aggregates.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key aggregates_list --value "$(cat /tmp/prd_aggregates.txt)" 2>/dev/null || true

    # Extract and store entities
    grep -E '^## |^### |\*\*.*Entity|\-.*Entity' docs/ddd/entities.md | head -30 | tr '\n' '|' > /tmp/prd_entities.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key entities_list --value "$(cat /tmp/prd_entities.txt)" 2>/dev/null || true

    # Extract and store value objects
    grep -E '^## |^### |\-.*Value' docs/ddd/value-objects.md | head -20 | tr '\n' '|' > /tmp/prd_vos.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key value_objects --value "$(cat /tmp/prd_vos.txt)" 2>/dev/null || true

    # Count migration files
    ls docs/ddd/migrations/* 2>/dev/null | wc -l > /tmp/prd_migration_count.txt 2>/dev/null || echo "0" > /tmp/prd_migration_count.txt
    npx @claude-flow/cli@latest memory store --namespace prd2build --key migration_count --value "$(cat /tmp/prd_migration_count.txt)" 2>/dev/null || true

    rm -f /tmp/prd_*.txt 2>/dev/null || true
  `)

Task("System Architect", `
Read PRD, requirements, DDD artifacts from memory.

Generate docs/adr/:
- index.md (ADR registry with dependency graph)
- ADR-001.md through ADR-027.md MINIMUM (each as SEPARATE file)

REQUIRED ADR TOPICS (1 ADR per topic = 27 minimum):
- Architecture (3): system style, module boundaries, deployment
- Database (3): technology, schema design, multi-tenancy
- API (3): design style (REST/GraphQL), versioning, error handling
- Security (4): authentication, authorization, RLS, secrets
- Infrastructure (2): deployment architecture, CDN/storage
- Integration (3): third-party service providers
- Frontend (3): client framework, state management, component architecture
- Testing (3): strategy, coverage targets, E2E approach
- Observability (3): logging, monitoring, error tracking

PLUS: Additional ADRs for PRD-specific decisions.

Each ADR = separate file. Enhanced template with metadata, alternatives, impact radius.

CRITICAL: DO NOT create just index.md. CREATE ALL INDIVIDUAL ADR FILES.

Before claiming done: ls docs/adr/ADR-*.md | wc -l (must be ≥27)

Store ADR index in memory.
`, "system-architect")

  // Explicit memory storage: system-architect outputs
  Bash(`
    # Count ADR files
    ls docs/adr/ADR-*.md 2>/dev/null | wc -l > /tmp/prd_adr_count.txt 2>/dev/null || echo "0" > /tmp/prd_adr_count.txt
    npx @claude-flow/cli@latest memory store --namespace prd2build --key adr_count --value "$(cat /tmp/prd_adr_count.txt)" 2>/dev/null || true

    # Extract ADR topics from index
    grep -E '^## |^### |^- ADR-' docs/adr/index.md 2>/dev/null | head -40 | tr '\n' '|' > /tmp/prd_adr_topics.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key adr_topics_list --value "$(cat /tmp/prd_adr_topics.txt)" 2>/dev/null || true

    # Extract key architectural decisions
    grep -E 'Decision:|Status: Accepted|Context:' docs/adr/ADR-001*.md docs/adr/ADR-002*.md docs/adr/ADR-003*.md 2>/dev/null | head -30 | tr '\n' '|' > /tmp/prd_arch_decisions.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key key_architectural_decisions --value "$(cat /tmp/prd_arch_decisions.txt)" 2>/dev/null || true

    rm -f /tmp/prd_*.txt 2>/dev/null || true
  `)

Task("SPARC Coordinator", `
Read PRD, requirements, DDD, ADR from memory.

Generate docs/sparc/:
- 01-specification.md (detailed specs with acceptance criteria)
- 02-pseudocode.md (algorithms, logic flows, data structures)
- 03-architecture.md (component diagram, service boundaries, tech stack)
- 04-refinement.md (TDD strategy, refactoring, quality metrics)
- 05-completion.md (integration tests, deployment, CI/CD, handoff)
- traceability-matrix.md (Requirement → Pseudocode → Architecture → Code → Test)

Create end-to-end traceability showing how every requirement flows through design to code.
`, "sparc-coord")

  // Explicit memory storage: sparc-coord outputs
  Bash(`
    # Count SPARC files
    ls docs/sparc/*.md 2>/dev/null | wc -l > /tmp/prd_sparc_count.txt 2>/dev/null || echo "0" > /tmp/prd_sparc_count.txt
    npx @claude-flow/cli@latest memory store --namespace prd2build --key sparc_files_count --value "$(cat /tmp/prd_sparc_count.txt)" 2>/dev/null || true

    # Extract traceability entries from matrix
    grep -E 'REQ-|US-|ADR-|\->' docs/sparc/traceability-matrix.md 2>/dev/null | head -50 | tr '\n' '|' > /tmp/prd_traceability.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key traceability_entries --value "$(cat /tmp/prd_traceability.txt)" 2>/dev/null || true

    # Extract architecture components
    grep -E '^## |^### |\*\*Component|\*\*Service' docs/sparc/03-architecture.md 2>/dev/null | head -30 | tr '\n' '|' > /tmp/prd_components.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key architecture_components --value "$(cat /tmp/prd_components.txt)" 2>/dev/null || true

    rm -f /tmp/prd_*.txt 2>/dev/null || true
  `)

Task("Implementation Planner", `
Read ALL prior documentation from memory.

Generate docs/implementation/:
- roadmap.md (phased delivery plan)
- dependency-graph.md (task dependencies, critical path)
- risks.md (risk register with mitigation)
- definition-of-done.md (DoD templates per task type)

Generate docs/implementation/milestones/:
- M0-foundation.md (infrastructure, database, auth)
- M1-mvp.md (minimum viable product features)
- M2-release.md (full v1.0 release)
- M3-enhanced.md (post-release improvements)

Generate docs/implementation/epics/:
- EPIC-XXX-[name].md (one file per business feature)

Generate docs/implementation/tasks/:
- index.md (task registry with status tracking)
- TASK-XXX-[name].md (one file per atomic technical task)

Each task MUST reference:
- Related requirements (REQ-XXX)
- Related user stories (US-XXX)
- Related ADRs (ADR-XXX)
- Related DDD artifacts (Aggregate, Service, etc.)
- Dependencies (other TASK-XXX)

MINIMUM TASKS: 20+ (real projects need more)

Store task count and relationships in memory.
`, "task-orchestrator")

  // Explicit memory storage: implementation planner outputs
  Bash(`
    # Count milestones
    ls docs/implementation/milestones/*.md 2>/dev/null | wc -l > /tmp/prd_milestone_count.txt 2>/dev/null || echo "0" > /tmp/prd_milestone_count.txt
    npx @claude-flow/cli@latest memory store --namespace prd2build --key milestone_count --value "$(cat /tmp/prd_milestone_count.txt)" 2>/dev/null || true

    # Count epics
    ls docs/implementation/epics/EPIC-*.md 2>/dev/null | wc -l > /tmp/prd_epic_count.txt 2>/dev/null || echo "0" > /tmp/prd_epic_count.txt
    npx @claude-flow/cli@latest memory store --namespace prd2build --key epic_count --value "$(cat /tmp/prd_epic_count.txt)" 2>/dev/null || true

    # Count tasks
    ls docs/implementation/tasks/TASK-*.md 2>/dev/null | wc -l > /tmp/prd_task_count.txt 2>/dev/null || echo "0" > /tmp/prd_task_count.txt
    npx @claude-flow/cli@latest memory store --namespace prd2build --key task_count --value "$(cat /tmp/prd_task_count.txt)" 2>/dev/null || true

    # Extract dependency graph summary
    grep -E 'TASK-.*depends on|Critical Path|Dependency:' docs/implementation/dependency-graph.md 2>/dev/null | head -30 | tr '\n' '|' > /tmp/prd_deps.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key dependency_graph_summary --value "$(cat /tmp/prd_deps.txt)" 2>/dev/null || true

    # Extract roadmap milestones
    grep -E '^## M[0-3]|^### Milestone|^## Milestone' docs/implementation/roadmap.md 2>/dev/null | head -20 | tr '\n' '|' > /tmp/prd_roadmap.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key roadmap_milestones --value "$(cat /tmp/prd_roadmap.txt)" 2>/dev/null || true

    rm -f /tmp/prd_*.txt 2>/dev/null || true
  `)

Task("Test Strategist", `
Read requirements, DDD, and tasks from memory.

Generate docs/testing/:
- test-strategy.md (test pyramid, coverage targets, tools)
- test-cases.md (test specifications per requirement)
- test-data-requirements.md (fixtures, seeds, mocks)
- tdd-approach.md (TDD workflow per bounded context)

Map every requirement to test cases.
Define test data factories for all entities.
`, "tester")

  // Explicit memory storage: test strategist outputs
  Bash(`
    # Extract test strategy summary
    grep -E '^## |^### |Coverage Target|Test Pyramid' docs/testing/test-strategy.md 2>/dev/null | head -30 | tr '\n' '|' > /tmp/prd_test_strategy.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key test_strategy_summary --value "$(cat /tmp/prd_test_strategy.txt)" 2>/dev/null || true

    # Extract coverage targets
    grep -E 'coverage|Coverage|Unit.*%|Integration.*%|E2E.*%' docs/testing/test-strategy.md 2>/dev/null | head -10 | tr '\n' '|' > /tmp/prd_coverage.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key coverage_targets --value "$(cat /tmp/prd_coverage.txt)" 2>/dev/null || true

    # Count test cases
    grep -E '^## Test Case|^### TC-' docs/testing/test-cases.md 2>/dev/null | wc -l > /tmp/prd_testcase_count.txt 2>/dev/null || echo "0" > /tmp/prd_testcase_count.txt
    npx @claude-flow/cli@latest memory store --namespace prd2build --key test_case_count --value "$(cat /tmp/prd_testcase_count.txt)" 2>/dev/null || true

    # Extract TDD approach summary
    grep -E '^## |^### |Red-Green-Refactor|TDD Workflow' docs/testing/tdd-approach.md 2>/dev/null | head -20 | tr '\n' '|' > /tmp/prd_tdd.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key tdd_approach_summary --value "$(cat /tmp/prd_tdd.txt)" 2>/dev/null || true

    rm -f /tmp/prd_*.txt 2>/dev/null || true
  `)

Task("Documentation Integrator", `
CRITICAL: This agent runs LAST and creates the unified index.

Wait for all other agents to complete, then:

1. Read ALL generated documentation:
   - docs/specification/ (all files)
   - docs/ddd/ (all files)
   - docs/adr/ (all ADR files)
   - docs/sparc/ (all files)
   - docs/implementation/ (milestones, epics, tasks)
   - docs/testing/ (all files)

2. Count all artifacts:
   - Total milestones, epics, tasks
   - Total ADRs, bounded contexts, aggregates
   - Total requirements, user stories, API endpoints

3. Extract relationships:
   - Parse "Related ADRs:" from each task
   - Parse "DDD Artifacts:" from each task
   - Parse "Requirements:" from each task
   - Parse "Dependencies:" from each task
   - Build dependency graph

4. Calculate metrics:
   - Total effort (sum task durations)
   - Critical path (longest dependency chain)
   - Complexity distribution

5. Generate docs/implementation/INDEX.md with:
   - Overview & statistics
   - Milestone breakdown (with epic lists)
   - Epic breakdown (with task lists)
   - Task reference tables (by epic, by ADR, by bounded context)
   - Complete traceability matrix (REQ → US → DDD → ADR → Task → Test)
   - Dependency graph (Mermaid)
   - Quick start guide
   - Progress tracking commands

6. Generate docs/README.md:
   - Navigation to all documentation sections
   - Quick links to major documents
   - How to read the docs
   - Glossary of abbreviations

OUTPUT FILES REQUIRED:
- docs/implementation/INDEX.md (THE SINGLE ENTRY POINT)
- docs/README.md (documentation navigator)

VERIFICATION:
- INDEX.md exists and >400 lines
- All milestones appear in INDEX.md
- All epics appear in INDEX.md
- All tasks appear in INDEX.md
- Traceability matrix complete
- README.md has links to all sections

This INDEX.md becomes THE SINGLE SOURCE OF TRUTH for implementation.
`, "planner")

  // Explicit memory storage: documentation integrator outputs
  Bash(`
    # Extract INDEX.md statistics (total artifacts count)
    grep -E 'Total.*:|Milestones:|Epics:|Tasks:|ADRs:|Bounded Contexts:' docs/implementation/INDEX.md 2>/dev/null | head -20 | tr '\n' '|' > /tmp/prd_index_stats.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key index_stats --value "$(cat /tmp/prd_index_stats.txt)" 2>/dev/null || true

    # Count total documentation artifacts across all folders
    total_docs=$(find docs -name '*.md' 2>/dev/null | wc -l)
    echo "$total_docs" > /tmp/prd_total_artifacts.txt 2>/dev/null || echo "0" > /tmp/prd_total_artifacts.txt
    npx @claude-flow/cli@latest memory store --namespace prd2build --key total_artifacts_count --value "$(cat /tmp/prd_total_artifacts.txt)" 2>/dev/null || true

    # Extract critical path from INDEX.md
    grep -E 'Critical Path|critical path|longest.*chain' docs/implementation/INDEX.md 2>/dev/null | head -10 | tr '\n' '|' > /tmp/prd_critical_path.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key critical_path_summary --value "$(cat /tmp/prd_critical_path.txt)" 2>/dev/null || true

    # Extract total effort estimate
    grep -E 'Total.*effort|Total.*duration|Estimated.*time' docs/implementation/INDEX.md 2>/dev/null | head -5 | tr '\n' '|' > /tmp/prd_effort.txt 2>/dev/null || true
    npx @claude-flow/cli@latest memory store --namespace prd2build --key effort_estimate --value "$(cat /tmp/prd_effort.txt)" 2>/dev/null || true

    rm -f /tmp/prd_*.txt 2>/dev/null || true
  `)

  // That's it. All agents spawn together, run in parallel, complete when done.

  // ============================================================
  // DOCUMENTATION COMPLETION VERIFICATION
  // ============================================================
  // CRITICAL: After all documentation agents complete, verify ALL documents are created
  // Spawn reviewer agent to verify completeness and re-spawn agents if gaps found

  Task("Documentation Reviewer", `
    CRITICAL: Verify ALL documentation is complete and meets minimum quality bars.

    1. Count and verify ALL required documentation files:
       - docs/specification/ (8+ files): requirements.md, non-functional.md, user-stories.md, user-journeys.md, api-contracts.md, security-model.md, edge-cases.md, constraints.md, glossary.md
       - docs/ddd/ (11+ files): domain-model.md, bounded-contexts.md, context-map.md, ubiquitous-language.md, aggregates.md, entities.md, value-objects.md, domain-events.md, sagas.md, repositories.md, services.md, database-schema.md, migrations/*
       - docs/adr/ (27+ individual ADR-XXX.md files): ADR-001.md through ADR-027.md minimum
       - docs/sparc/ (6+ files): 01-specification.md, 02-pseudocode.md, 03-architecture.md, 04-refinement.md, 05-completion.md, traceability-matrix.md
       - docs/implementation/ (4+ milestones, N epics, 20+ tasks): milestones/*.md, epics/*.md, tasks/*.md, INDEX.md
       - docs/testing/ (4+ files): test-strategy.md, test-cases.md, test-data-requirements.md, tdd-approach.md
       - docs/design/mockups/ (multiple HTML mockups)

    2. Verify minimum quality bars:
       - 8+ specification files
       - 15+ user stories
       - 10+ API endpoints (if API-based)
       - Security model >50 lines
       - 27+ ADR files (not just index.md)
       - 3+ bounded contexts
       - 5+ aggregates
       - 10+ value objects
       - 6+ domain events
       - 5+ repositories
       - 4+ services
       - 20+ tasks
       - 4+ milestones
       - docs/implementation/INDEX.md exists and >400 lines

    3. Create verification report: docs/.verification-report.md with:
       - Total files found vs required
       - Pass/fail for each quality bar
       - List of any missing or incomplete documents
       - List of any gaps that need to be filled

    4. IF GAPS FOUND:
       - Store gap details in memory for remediation
       - Provide specific remediation instructions
       - DO NOT just report - re-spawn the appropriate agent type to fill gaps

    5. IF ALL VERIFIED:
       - Store "documentation_complete=true" in memory
       - Store completion timestamp in memory
       - Generate final summary of all artifacts

    MINIMUM VERIFICATION STANDARDS:
    - ls docs/adr/ADR-*.md | wc -l MUST be >= 27
    - ls docs/specification/*.md | wc -l MUST be >= 8
    - ls docs/ddd/*.md | wc -l MUST be >= 11
    - ls docs/implementation/tasks/TASK-*.md | wc -l MUST be >= 20
    - grep -c "## " docs/implementation/INDEX.md MUST be >= 100 (sections and entries)

    Report any failures with specific file paths that need to be created.
  `, "reviewer")

  // Store reviewer results and check if respawns needed
  Bash(`
    # Store verification results
    npx @claude-flow/cli@latest memory store --namespace prd2build --key docs_verification_complete --value "$(cat docs/.verification-report.md 2>/dev/null | grep -i 'complete\|pass\|verified' | head -5)" 2>/dev/null || true

    # Check for gaps
    if grep -qi "gap\|missing\|incomplete\|failed" docs/.verification-report.md 2>/dev/null; then
      echo "Documentation gaps detected - remediation needed"
      npx @claude-flow/cli@latest memory store --namespace prd2build --key docs_has_gaps --value "true" 2>/dev/null || true
    else
      echo "Documentation complete - all artifacts verified"
      npx @claude-flow/cli@latest memory store --namespace prd2build --key docs_has_gaps --value "false" 2>/dev/null || true
    fi
  `)

  // If gaps detected, spawn remediation agents (conditional based on memory check)
  // This runs only if documentation reviewer found gaps
} // END DOCUMENTATION PHASE

// ============================================================
// BUILD EXECUTION (Only if --build or --build-only)
// ============================================================
if (buildOnly || docAndBuild) {

  // Step 1: Initialize swarm with hierarchical-mesh topology (V3 recommended for 10+ agents)
  Bash(`npx @claude-flow/cli@latest swarm init --topology hierarchical-mesh --max-agents ${maxAgents} --strategy specialized --no-color 2>/dev/null || true`)

  // Step 1.5: Initialize build state tracking
  Bash("npx @claude-flow/cli@latest memory store --key 'build/milestone' --value 'M0' --namespace build 2>/dev/null || true")
  Bash("npx @claude-flow/cli@latest memory store --key 'build/total_milestones' --value '4' --namespace build 2>/dev/null || true")
  Bash("npx @claude-flow/cli@latest memory store --key 'build/status' --value 'in_progress' --namespace build 2>/dev/null || true")

  // Step 2: Spawn build swarm agents in BACKGROUND (parallel execution)
  // They will execute the build using all ADRs and DDD artifacts as reference

  Task("Build Coordinator", `
    Read ALL documentation:
    - docs/adr/ (all ADRs for architectural decisions)
    - docs/ddd/ (all DDD artifacts for domain understanding)
    - docs/implementation/INDEX.md (task execution order)

    Coordinate the build swarm through ALL milestones:
    1. Parse ALL ADRs to understand architectural constraints
    2. Understand ALL DDD bounded contexts and aggregates
    3. Create COMPLETE execution plan from INDEX.md tasks (all milestones)
    4. Delegate work to specialized agents for EACH milestone
    5. Monitor milestone completion via memory coordination
    6. Trigger next milestone when current milestone completes
    7. DO NOT mark complete until ALL 4 milestones are verified done

    Milestone transitions:
    - When M0 agents finish → Store "m0_complete" in memory, set build/milestone to M1
    - When M1 agents finish → Store "m1_complete" in memory, set build/milestone to M2
    - When M2 agents finish → Store "m2_complete" in memory, set build/milestone to M3
    - When M3 agents finish → Store "m3_complete" in memory, mark build/status as "complete"

    Store build plan and milestone status in memory for other agents.
  `, "hierarchical-coordinator", run_in_background: true)

  Task("Foundation Builder", `
    Read ADR-001 (system architecture), ADR-004 (database), ADR-007 (auth).

    Execute M0 (Foundation) tasks:
    - Project setup and structure (per ADR-001)
    - Database schema and migrations (per ADR-004, DDD aggregates)
    - Authentication system (per ADR-007)

    Verify each task against related ADRs and DDD artifacts.

    When M0 is COMPLETE:
    1. Store completion status in memory: memory store --key "m0/my_status" --value "complete" --namespace build
    2. Check with Build Coordinator if all M0 agents are done
    3. Wait for Build Coordinator to trigger M1
    4. DO NOT mark yourself as "complete" until Build Coordinator confirms ALL milestones done
    5. Continue to M1 when triggered via memory signal
  `, "coder", run_in_background: true)

  Task("Feature Implementer", `
    Read all ADRs, DDD bounded contexts, and implementation tasks.

    Execute M1 (MVP) tasks (Data Access Layer):
    - Repository implementations per DDD repository interfaces
    - Database migrations (per chosen database ADR)
    - Connection pooling and data access configuration
    - Repository integration tests

    Follow INDEX.md task order and dependencies.

    When M1 is COMPLETE:
    1. Store completion status in memory: memory store --key "m1/my_status" --value "complete" --namespace build
    2. Check with Build Coordinator if all M1 agents are done
    3. Wait for Build Coordinator to trigger M2
    4. DO NOT mark yourself as "complete" until Build Coordinator confirms ALL milestones done
    5. Continue to M2 when triggered via memory signal
  `, "backend-dev", run_in_background: true)

  Task("Frontend Builder", `
    Read ADR-017 (client framework), ADR-018 (state management), wireframes, style guide.

    Execute M2 (Release) tasks (API Layer):
    - Route handlers for all API endpoints
    - Request validation and error handling
    - Integration with repository layer
    - API integration tests

    Execute M3 (Enhanced) tasks (Integration):
    - Component library setup (per ADR-017)
    - State management (per ADR-018)
    - UI screens per wireframes and mockups
    - Third-party service integrations

    Match design tokens from style-guide.md.

    When EACH milestone is COMPLETE:
    1. Store completion status in memory for that milestone
    2. Coordinate with Build Coordinator for milestone transitions
    3. DO NOT mark as "complete" until ALL milestones (M0-M3) are verified done
  `, "ui-designer", run_in_background: true)

  Task("Test Implementer", `
    Read test strategy and ADR-022 (testing strategy).

    Execute test implementation across ALL milestones:
    - M0: Unit tests for entities, value objects, domain logic
    - M1: Integration tests for repositories
    - M2: API integration tests
    - M3: E2E tests per user journey

    Achieve coverage targets from test-strategy.md.

    When tests for EACH milestone are COMPLETE:
    1. Store test coverage status in memory
    2. Report any failing tests to Build Coordinator
    3. DO NOT mark as "complete" until ALL milestones have passing tests
  `, "tester", run_in_background: true)

  Task("Quality Verifier", `
    Read all ADRs and verify compliance across ALL milestones:
    - M0: Security per ADR-010 through ADR-013, structure per ADR-001
    - M1: Database compliance per ADR-004, RLS per ADR-005
    - M2: API contracts per ADR-008 through ADR-009
    - M3: Integration compliance per relevant ADRs

    Run linting, type checking, and security scans after EACH milestone.
    Report any ADR violations for remediation.

    DO NOT mark as "complete" until:
    1. All 4 milestones are verified
    2. All ADR violations are resolved
    3. All tests pass
    4. Build Coordinator confirms build is complete
  `, "code-review-swarm", run_in_background: true)

  // ============================================================
  // MILESTONE TRANSITION COORDINATION
  // ============================================================
  // All agents spawned in background - they work in parallel via hierarchical topology
  // Build coordinator orchestrates milestone transitions; agents communicate via memory

  // DO NOT tell user "build swarm launched"
  // INSTEAD: Monitor milestone completion and continue automatically

  // Claude Code (you) must:
  // 1. Monitor memory for milestone completion signals
  // 2. Verify each milestone before allowing next milestone to start
  // 3. Continue WITHOUT user input until M3 is complete
  // 4. Store milestone status in memory
  // 5. Only report completion when Build Coordinator confirms ALL milestones done

  // ============================================================
  // BUILD COMPLETION VERIFICATION
  // ============================================================
  // This verification runs AFTER build agents report completion
  // CRITICAL: Do NOT report build complete until ALL tasks are 100% verified

  Task("Build Completion Reviewer", `
    CRITICAL: Verify ALL tasks from ADRs and DDDs are 100% completed.
    Re-spawn agents if ANY gaps are found. Only report completion when ALL milestones M0-M3 are verified done.

    1. Verify build completion via memory:
       - Bash("npx @claude-flow/cli@latest memory retrieve --key 'build/milestone' --namespace build")
       - Must equal M3 (final milestone)
       - Bash("npx @claude-flow/cli@latest memory retrieve --key 'build/status' --namespace build")
       - Must equal "complete"

    2. Verify all milestone completion signals exist in memory:
       - m0_complete: M0 (Foundation) - Project structure, entities, middleware, database setup
       - m1_complete: M1 (MVP) - Data access, repositories, migrations, core business logic
       - m2_complete: M2 (Release) - API layer, routes, validation, error handling
       - m3_complete: M3 (Enhanced) - UI integration, external services, polish

    3. Cross-reference ALL tasks from docs/implementation/INDEX.md:
       - For EACH TASK-XXX in INDEX.md, verify the corresponding implementation exists
       - Check source code files against task descriptions
       - Verify each task references its related ADRs are implemented correctly
       - Verify each task references its related DDD artifacts are implemented correctly

    4. Verify ADR compliance:
       - Read all ADR files from docs/adr/
       - For each ADR, verify the implementation follows the architectural decision
       - Check security ADRs (ADR-010 through ADR-013) are properly implemented
       - Check database ADR (ADR-004) schema matches migrations
       - Check API ADRs (ADR-008 through ADR-009) contracts are implemented
       - Check frontend ADRs (ADR-017 through ADR-019) components exist

    5. Verify DDD artifact implementation:
       - For each bounded context in docs/ddd/bounded-contexts.md, verify module exists
       - For each aggregate in docs/ddd/aggregates.md, verify implementation exists
       - For each repository interface in docs/ddd/repositories.md, verify implementation exists
       - For each domain event in docs/ddd/domain-events.md, verify emission/handling exists

    6. Create comprehensive build verification report: docs/.build-verification-report.md with:
       - Total tasks in INDEX.md vs completed implementations
       - Pass/fail for each milestone
       - List of ADRs not properly implemented
       - List of DDD artifacts not implemented
       - List of any incomplete tasks with specific file paths

    7. IF GAPS FOUND:
       - DO NOT just report gaps
       - Re-spawn appropriate agent(s) to complete missing work:
         * Foundation gaps → Re-spawn "Foundation Builder" (coder)
         * Data layer gaps → Re-spawn "Feature Implementer" (backend-dev)
         * API gaps → Re-spawn "Feature Implementer" (backend-dev)
         * Frontend gaps → Re-spawn "Frontend Builder" (ui-designer)
         * Test gaps → Re-spawn "Test Implementer" (tester)
       - Store gap details in memory for targeted remediation
       - Continue verification cycles until ALL gaps are filled

    8. IF ALL VERIFIED:
       - Store "build_complete=true" in memory
       - Store completion timestamp in memory
       - Generate final build completion report with all milestone results
       - Only then report completion to user

    MINIMUM BUILD VERIFICATION STANDARDS:
    - All 4 milestones (M0-M3) must have completion signals in memory
    - build/milestone must equal M3
    - build/status must equal "complete"
    - At least 90% of tasks from INDEX.md must have corresponding implementations
    - All critical ADRs (security, database, API) must be verified implemented
    - All core DDD aggregates must have implementations

    Continue monitoring and re-spawning agents until 100% completion.
  `, "reviewer")

  // Store final build verification results
  Bash(`
    # Store build verification results
    npx @claude-flow/cli@latest memory store --namespace build --key verification_complete --value "$(cat docs/.build-verification-report.md 2>/dev/null | grep -i 'complete\|verified' | head -5)" 2>/dev/null || true

    # Check for build gaps
    if grep -qi "gap\|missing\|incomplete\|failed" docs/.build-verification-report.md 2>/dev/null; then
      echo "Build gaps detected - remediation agents spawned"
      npx @claude-flow/cli@latest memory store --namespace build --key has_gaps --value "true" 2>/dev/null || true
    else
      echo "Build complete - all milestones verified 100%"
      npx @claude-flow/cli@latest memory store --namespace build --key has_gaps --value "false" 2>/dev/null || true

      # Generate final completion report
      echo "=== BUILD COMPLETION REPORT ===" > docs/.build-complete.txt
      echo "Timestamp: $(date)" >> docs/.build-complete.txt
      echo "Milestones: M0, M1, M2, M3 - ALL COMPLETE" >> docs/.build-complete.txt
      echo "Tasks Verified: $(grep -c TASK- docs/implementation/INDEX.md || echo 0)" >> docs/.build-complete.txt
      echo "ADRs Verified: $(ls docs/adr/ADR-*.md 2>/dev/null | wc -l)" >> docs/.build-complete.txt
      echo "DDD Artifacts Verified: $(ls docs/ddd/*.md 2>/dev/null | wc -l)" >> docs/.build-complete.txt
    fi
  `)
```

---

## Output Structure

After execution, you get:

```
start-env.sh                            # 🚀 Start all services (executable)

docs/
├── README.md                           # 📖 Start here - Navigation guide
├── implementation/
│   └── INDEX.md                        # 🎯 IMPLEMENTATION START HERE
│
├── specification/
│   ├── requirements.md                 # Functional requirements (REQ-XXX)
│   ├── non-functional.md               # NFRs (performance, security)
│   ├── user-stories.md                 # User stories (US-XXX)
│   ├── user-journeys.md                # Actor flows and use cases
│   ├── wireframes.md                   # UI wireframes (ASCII)
│   ├── style-guide.md                  # Design tokens, colors, typography
│   ├── style-guide.html                # Interactive visual style guide
│   ├── api-contracts.md                # API specifications (OpenAPI-style)
│   ├── security-model.md               # Threat model, auth/authz
│   ├── edge-cases.md                   # Boundary conditions
│   ├── constraints.md                  # Technical/business constraints
│   └── glossary.md                     # Domain terminology
│
├── design/
│   └── mockups/
│       ├── design-tokens.css           # Shared CSS variables
│       └── *.html                      # Mockups with dark/light toggle
│
├── ddd/
│   ├── domain-model.md                 # Strategic design
│   ├── bounded-contexts.md             # Context boundaries
│   ├── context-map.md                  # Context relationships
│   ├── ubiquitous-language.md          # Domain terminology
│   ├── aggregates.md                   # Aggregate roots
│   ├── entities.md                     # Domain entities
│   ├── value-objects.md                # Value objects
│   ├── domain-events.md                # Event catalog
│   ├── sagas.md                        # Process managers
│   ├── repositories.md                 # Repository interfaces
│   ├── services.md                     # Domain/application services
│   ├── database-schema.md              # Complete schema
│   └── migrations/
│       └── *.*                         # Numbered migrations
│
├── adr/
│   ├── index.md                        # ADR registry + dependency graph
│   ├── ADR-001-*.md                    # Architecture decisions
│   ├── ADR-002-*.md                    # (27+ individual files)
│   └── ...
│
├── sparc/
│   ├── 01-specification.md             # Detailed specifications
│   ├── 02-pseudocode.md                # Algorithms and logic
│   ├── 03-architecture.md              # System architecture
│   ├── 04-refinement.md                # TDD strategy
│   ├── 05-completion.md                # Integration & deployment
│   └── traceability-matrix.md          # Req → Implementation mapping
│
├── implementation/
│   ├── INDEX.md                        # 🎯 SINGLE ENTRY POINT
│   ├── roadmap.md                      # Master plan
│   ├── dependency-graph.md             # Task dependencies (DAG)
│   ├── risks.md                        # Risk register
│   ├── definition-of-done.md           # DoD templates
│   ├── milestones/
│   │   ├── M0-foundation.md
│   │   ├── M1-mvp.md
│   │   ├── M2-release.md
│   │   └── M3-enhanced.md
│   ├── epics/
│   │   └── EPIC-XXX-[name].md          # Business features
│   └── tasks/
│       ├── index.md                    # Task registry
│       └── TASK-XXX-[name].md          # Atomic tasks
│
└── testing/
    ├── test-strategy.md                # Test pyramid, coverage
    ├── test-cases.md                   # Test specs per requirement
    ├── test-data-requirements.md       # Fixtures and seeds
    └── tdd-approach.md                 # TDD workflow
```

---

## What You Do Next

1. **Read**: `docs/README.md` - Understand the documentation
2. **Review**: `docs/implementation/INDEX.md` - Your implementation guide
3. **Start Building**: Follow the tasks in order or use your own workflow

**That's it. No complex scripts. No guardian verification for docs. Just clean, complete documentation.**

---

## Quality Guarantees

### Documentation
Each generated document includes:
- ✅ Cross-references to related docs
- ✅ Traceability to PRD requirements
- ✅ No placeholder content (no TODO/TBD)
- ✅ Concrete decisions (no "we'll decide later")
- ✅ Complete coverage (minimums enforced)

**Minimum artifact counts** (auto-validated):
- 8+ specification files
- 27+ ADRs (one per architectural topic)
- 11+ DDD files
- 3+ bounded contexts
- 5+ aggregates
- 20+ tasks

### Build (--build flag only)
**CRITICAL**: Build is NOT complete until ALL 4 milestones finish:

**M0 - Foundation**:
- ✅ Project structure and workspace setup
- ✅ Core entities and value objects
- ✅ Authentication and middleware
- ✅ Database schema defined

**M1 - MVP (Data Access)**:
- ✅ Repository implementations (all aggregates)
- ✅ Database migrations (per ADR database choice)
- ✅ Connection pooling and data access layer
- ✅ Repository integration tests

**M2 - Release (API Layer)**:
- ✅ Route handlers (all endpoints)
- ✅ Request validation and error handling
- ✅ API integration tests
- ✅ ADR compliance verified

**M3 - Enhanced (Integration)**:
- ✅ UI components and screens
- ✅ Third-party service integrations
- ✅ End-to-end tests passing
- ✅ Final ADR compliance verified

**Build Completion Criteria** (ALL must pass):
- ✅ All 4 milestones verified complete
- ✅ All tests passing (unit + integration + E2E)
- ✅ All ADR violations resolved
- ✅ Build Coordinator confirms completion
- ✅ Memory flags: build/milestone=M3, build/status=complete

If PRD is too vague, agents make explicit assumptions and document them.

---

## Execution Details

### Concurrency Model
- All 8 agents spawn in ONE message
- They execute in parallel (foreground mode)
- Task tool blocks until ALL agents complete
- Then INDEX.md is generated from their outputs
- Total time: 5-10 minutes (depends on PRD size)

### No Waves, No Checkpoints
- Simple: Spawn all → Wait → Generate index → Done
- No complex verification between milestones
- No session checkpointing (not needed for docs)
- No retry logic (if agent fails, you see the error)

### Memory Coordination
Agents share via memory:
- Specification agent stores requirements → DDD agent reads
- DDD agent stores aggregates → Implementation planner reads
- All outputs → INDEX generator reads and integrates

---

## INDEX.md Contents

The generated INDEX.md provides:

### 1. Quick Start
```markdown
## How to Implement This

### By Milestone
1. M0: Foundation (8 tasks, 3 days) - Setup, database, auth
2. M1: MVP (24 tasks, 12 days) - Core features
3. M2: Release (28 tasks, 18 days) - Full feature set
4. M3: Enhanced (12 tasks, 8 days) - Polish

### By Epic
- EPIC-001: Project setup (3 tasks)
- EPIC-002: Database schema (5 tasks)
- EPIC-003: Authentication (4 tasks)
...
```

### 2. Complete Traceability
```markdown
## Traceability Matrix

| Requirement | User Story | Bounded Context | Aggregate | ADR | Epic | Tasks | Tests |
|-------------|------------|-----------------|-----------|-----|------|-------|-------|
| REQ-001 | US-001 | Core | Entity | ADR-002, ADR-007 | EPIC-003 | TASK-012, TASK-013 | entity.test |
...
```

### 3. Dependency Graph
```markdown
## Task Dependencies

### Critical Path (23 tasks, 15 days)
TASK-001 → TASK-002 → TASK-005 → TASK-008 → ...

### Dependency Visualization
[Mermaid graph showing all task dependencies]
```

### 4. Reference Tables

**Tasks by Epic**:
Shows all tasks grouped by business feature

**Tasks by ADR**:
Shows which tasks implement each architectural decision

**Tasks by Bounded Context**:
Shows which tasks touch each domain area

### 5. Quick Commands
```markdown
## Development Commands

### Build
[package-manager] run build

### Test
[package-manager] test

### Development
[package-manager] run dev
[container-tool] up -d

### Database
[package-manager] run db:migrate
[package-manager] run db:seed
```

---

## Customization

### Adjust Quality Bars
```bash
# Before running, set your thresholds
export PRD2BUILD_MIN_ADR_COUNT=15      # For MVP (default: 27)
export PRD2BUILD_MIN_AGGREGATES=3      # For simple app (default: 5)
export PRD2BUILD_MIN_TASKS=10          # For prototype (default: 20)

/prd2build my-prd.md
```

### Update Mode
```bash
# Update existing docs when PRD changes
/prd2build my-updated-prd.md --mode=update

# Compares against docs/source-prd.md
# Only regenerates changed sections
# Preserves custom edits
# Generates UPDATE-REPORT.md
```


## Example Execution

```bash
$ /prd2build ~/projects/my-project/prd.md

Initializing system...
✅ Directories created
✅ Memory initialized

Spawning documentation agents (8 parallel)...
→ Specification Analyst (researcher)
→ UX Designer (ui-designer)
→ Environment Setup (coder)
→ DDD Expert (code-analyzer)
→ System Architect (system-architect)
→ SPARC Coordinator (sparc-coord)
→ Implementation Planner (task-orchestrator)
→ Test Strategist (tester)
→ Documentation Integrator (planner)

⏳ Agents working... (this takes 5-10 minutes)

✅ All agents complete!

Generating unified index...
✅ INDEX.md created

Documentation complete! Generated:
- 1 environment startup script (start-env.sh)
- 8 specification files
- 11 DDD files (5 aggregates, 3 bounded contexts)
- 31 ADRs
- 6 SPARC files
- 4 milestones, 12 epics, 67 tasks
- 4 testing files
- 1 unified INDEX.md

🚀 Quick start: ./start-env.sh
📖 Start here: docs/README.md
🎯 Implementation guide: docs/implementation/INDEX.md
```

---

## End Result

You run ONE command. You get COMPLETE documentation. You read INDEX.md to understand how to build it.

**That's the goal. Simple. Effective. No complexity.**

---

**END OF SIMPLIFIED WORKFLOW**
