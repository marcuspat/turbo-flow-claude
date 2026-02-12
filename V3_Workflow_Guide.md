# Turbo Flow v3.1.0 — Workflow Guide

## What's Installed

| Layer | Components |
|-------|------------|
| **Orchestration** | Claude Code, Claude Flow V3 (daemon, swarm, MCP, SPARC, browser) |
| **Memory** | Claude Flow SQLite memory, AgentDB vector DB (HNSW), sql.js |
| **Intelligence** | RuVector neural engine, hooks intelligence, neural operations |
| **Skills** | prd2build, Security Analyzer, UI UX Pro Max, Worktree Manager, Vercel Deploy |
| **Quality** | Agentic QE (test gen + quality gates) |
| **Ecosystem** | OpenSpec (API design), RuVector RUVLLM, RuV Helpers 3D Visualization |
| **Monitoring** | Statusline Pro (15 components), ccusage (on-demand) |
| **Collaboration** | Codex integration, AGENTS.md protocol |

---

## Boot Sequence

This is the correct startup order. Each step depends on the one before it.

### Step 1 — Initialize Claude Flow

This creates the `.claude-flow/` workspace config and `.swarm/` directory.

```bash
cf-init
```

> "Initialize Claude Flow in this workspace with default settings"

> "Run the Claude Flow wizard to configure topology, memory, and agent preferences interactively"

Use `cf-wizard` for guided setup, or `cf-init` for defaults.

### Step 2 — Verify Environment

```bash
cf-doctor
```

> "Run Claude Flow doctor to check that everything is healthy — node version, npm globals, MCP connectivity, memory status"

Fix any issues before proceeding.

### Step 3 — Initialize Memory

Claude Flow's memory is SQLite-based at `.swarm/memory.db`. It doesn't exist until you initialize it.

```bash
npx -y claude-flow@alpha memory init
```

Configure retention and limits:

```bash
npx -y claude-flow@alpha config set memory.retention 30d
npx -y claude-flow@alpha config set memory.maxSize 1GB
```

> "Initialize the Claude Flow memory system and set retention to 30 days"

### Step 4 — Register MCP Servers

Claude Flow and AgentDB each run as separate MCP servers. Claude Code can't use their tools until they're registered.

**Claude Flow MCP** (gives Claude Code access to swarm, memory, browser, hooks, neural tools):

```bash
claude mcp add claude-flow -- npx -y claude-flow@alpha mcp start
```

**AgentDB MCP** (gives Claude Code semantic vector search via HNSW):

```bash
claude mcp add agentdb -- npx -y agentdb mcp
```

Verify both are running:

```bash
claude mcp list
```

> "Register Claude Flow and AgentDB as MCP servers, then verify both are connected"

### Step 5 — Activate RuVector Hooks

RuVector is the neural learning engine. It hooks into Claude Flow to learn from your edits, route tasks intelligently, and remember successful patterns. It doesn't activate until you initialize the hooks.

```bash
ruv-init
```

For existing projects, pretrain from the codebase so RuVector already knows your patterns:

```bash
hooks-train
```

> "Initialize RuVector hooks and pretrain the intelligence from the existing codebase"

### Step 6 — Start the Daemon

The daemon runs background workers for monitoring, session persistence, and security auditing.

```bash
cf-daemon
```

> "Start the Claude Flow daemon for background processing"

### Step 7 — Verify Everything

```bash
turbo-status
mem-stats
hooks-intel
claude mcp list
```

> "Show me the full system status — installed components, memory statistics, hooks intelligence status, and active MCP servers"

**You're now fully booted.** Memory is live, RuVector is learning, both MCP servers are registered, daemon is running.

---

## Boot Sequence (Quick Copy-Paste)

```bash
source ~/.bashrc
cf-init
cf-doctor
npx -y claude-flow@alpha memory init
npx -y claude-flow@alpha config set memory.retention 30d
claude mcp add claude-flow -- npx -y claude-flow@alpha mcp start
claude mcp add agentdb -- npx -y agentdb mcp
ruv-init
hooks-train
cf-daemon
turbo-status
```

---

## Three Memory Systems

You have three distinct memory layers. They serve different purposes.

| System | What it does | How to use |
|--------|-------------|------------|
| **Claude Flow Memory** (mem-*) | Key-value + vector search in SQLite. Stores project config, agent state, task context. Built into Claude Flow. | `mem-store`, `mem-search`, `mem-vsearch` |
| **RuVector** (ruv-*) | Neural pattern learning. Watches your edits, learns what works, routes tasks to best agents. Hooks into Claude Flow. | `ruv-remember`, `ruv-recall`, `ruv-route` |
| **AgentDB** (agentdb-*) | Standalone HNSW vector database. Semantic search across documents and embeddings. Runs as its own MCP server. | `agentdb-store`, `agentdb-query` via MCP |

### When to use which:

- **Storing project configuration or task state** → Claude Flow memory (`mem-store`)
- **Remembering a coding pattern that worked** → RuVector (`ruv-remember`)
- **Storing documents for semantic RAG search** → AgentDB (via MCP tools)
- **Finding which agent is best for a task** → RuVector routing (`ruv-route`)
- **Searching memory by keyword** → Claude Flow (`mem-search`)
- **Searching memory by meaning** → AgentDB (`agentdb_query` MCP tool) or Claude Flow (`mem-vsearch`)

---

## Workflow 1: New Builds

*Greenfield project from PRD to deployment.*

### 1. Boot (do this once per session)

Follow the Boot Sequence above, or if already booted:

> "Check system status and make sure daemon is running and MCP servers are connected"

### 2. Spec & Plan

> "Run /prd2build against this PRD and break it into architecture decisions, bounded contexts, and an ordered task list"

> "Use OpenSpec to define the REST API contract before we write any code"

> "Store the project architecture decisions in memory so agents can reference them throughout the build"

### 3. Design

> "Spawn a hierarchical swarm with a system architect, task planner, and tech researcher to design the architecture"

> "Design a modern dashboard interface for this application" *(auto-triggers UI UX Pro Max — 57 styles, 95 palettes, 56 font pairings)*

> "Search the design database for a color palette and typography that fits a SaaS fintech product"

> "Generate a persistent design system so every page stays visually consistent"

### 4. Build

> "Create a development swarm with 3 coders, 2 testers, and a reviewer using hierarchical topology"

> "Orchestrate building the user authentication system with adaptive task routing"

> "Route the database schema task to the agent best suited based on learned patterns"

> "Remember this OAuth implementation as a reusable pattern for future projects"

### 5. Test & Secure

> "Generate comprehensive tests for src/services/ targeting 95% coverage"

> "Run the full quality pipeline: test generation, coverage analysis, security scan, and quality gate at 90% threshold"

> "Scan the codebase for security vulnerabilities and OWASP compliance" *(auto-triggers Security Analyzer)*

> "Use the Claude Flow browser to open localhost:3000, take a snapshot, fill in the login form with test credentials, and verify it works"

### 6. Deploy

> "Deploy this to Vercel and give me the preview URL" *(triggers Vercel Deploy skill)*

> "Generate API documentation for the project"

### 7. Learn & Save

> "Consolidate everything RuVector learned during this build session"

> "Store the full project architecture in AgentDB for semantic search in future sessions"

> "Show me what patterns were captured and learning statistics"

```bash
ruv-learn
ruv-stats
mem-stats
```

---

## Workflow 2: Continued Builds

*Adding features to an existing project.*

### 1. Recover Context

> "Recall what RuVector knows about this project from previous sessions"

> "Search AgentDB for the architecture decisions we stored last time"

> "What patterns have been learned for this codebase? Show me the statistics"

```bash
cf-doctor
ruv-recall "project-name"
ruv-stats
```

### 2. Plan the Feature

> "Analyze the impact of adding payment processing — what modules are affected, what might break?"

> "Spawn a tactical hive-mind to evaluate Stripe vs PayPal integration and reach consensus"

> "Use OpenSpec to extend the API contract with payment endpoints"

> "Route this feature to the right workflow based on learned patterns"

### 3. Build

> "Create a feature swarm with 2 backend devs, 1 frontend dev, and a tester for Stripe integration"

> "Orchestrate the payment processing implementation using a fork-join task pattern"

> "Store the integration approach in memory so the swarm agents stay aligned"

### 4. Test

> "Run incremental tests scoped to src/services/payment/"

> "Use the Claude Flow browser to walk through the checkout flow — open the page, fill card details, submit, and verify success"

> "Start a trajectory recording on the checkout flow and save it as a reusable test pattern"

> "Run the quality gate at 95% threshold with a merge recommendation"

### 5. Secure & Ship

> "Audit the payment implementation for PCI compliance" *(triggers Security Analyzer)*

> "Deploy the preview to Vercel so stakeholders can review"

> "Remember the Stripe integration pattern and payment form validation approach"

---

## Workflow 3: Refactor Builds

*Improving code quality without changing behavior.*

### 1. Baseline

> "Recall any refactor patterns RuVector has stored from previous sessions"

> "Generate characterization tests that capture current behavior before we change anything"

> "Spawn a mesh analysis swarm to review the entire codebase — complexity, dead code, performance hotspots, dependency issues"

> "Run a comprehensive security audit: CVEs, insecure dependencies, hardcoded credentials, OWASP Top 10"

### 2. Plan

> "Create architecture decision records for migrating to TypeScript strict mode and modernizing the API layer"

> "Plan the refactoring sequence based on dependency chains, risk levels, and available test coverage"

> "Store the refactor plan in memory so all swarm agents reference the same priorities"

### 3. Refactor

> "Use SPARC test-driven development to refactor the user service to a repository pattern"

> "Spin up a mesh swarm with 4 coders and 2 reviewers for parallel refactoring"

> "Route the class-to-hooks migration to agents with React experience"

> "Modernize these legacy components with accessibility, dark mode, and proper design patterns" *(triggers UI UX Pro Max)*

### 4. Validate

> "Run the characterization tests against the baseline to detect any behavioral changes"

> "Use the Claude Flow browser to snapshot every major page before and after for visual regression"

> "Compare performance benchmarks — page load, bundle size, memory usage — against the pre-refactor baseline"

> "Run the final quality gate: full regression, security compliance, performance comparison, 90%+ coverage"

### 5. Learn

> "Remember the TypeScript strict migration pattern, the component modernization approach, and the repository pattern for future refactors"

> "Consolidate all learnings from this refactor session"

```bash
ruv-learn
ruv-stats
```

---

## Workflow 4: UI Development

*Frontend work leveraging the design intelligence database.*

UI UX Pro Max activates automatically when your prompt mentions design, UI, dashboard, components, styling, or similar terms. It searches 57 styles, 95 color palettes, 56 font pairings, 98 UX guidelines, and 24 chart types — then feeds Claude the relevant design context before generating code.

### Design

> "Design a SaaS dashboard with a professional color palette, typography, and responsive layout"

> "What UI style works best for a healthcare app? Give me the full design system"

> "Search the design database for glassmorphism with dark mode"

> "Generate a persistent design system for this project with master rules and per-page overrides"

### Build

> "Build a data table component with sorting, filtering, and pagination following our design system"

> "Create a responsive navigation with mobile hamburger, following the UX accessibility guidelines"

> "Implement smooth page transitions and micro-interactions"

### Test

> "Use the Claude Flow browser to snapshot every major page at desktop and mobile viewports"

> "Start a trajectory recording, walk through the entire signup flow, and save it for regression testing"

> "Audit the frontend for WCAG 2.1 AA compliance and fix any violations"

### Deploy

> "Deploy to Vercel and run a visual check on the deployed preview"

---

## Tool Reference

### Swarm Topologies

| Topology | Command | When to use |
|----------|---------|-------------|
| Hierarchical | `cf-swarm` | Feature builds — lead delegates to specialists |
| Mesh | `cf-mesh` | Refactoring — parallel peer-to-peer work |
| Byzantine | via NLP | Research — consensus when agents disagree |
| Star | via NLP | Full app builds — central coordinator |
| Single agent | `dsp` | Quick fixes — no orchestration overhead |

> "Spawn a hierarchical swarm with 3 coders and 2 testers"

> "Create a mesh swarm for parallel refactoring across 4 modules"

> "Use byzantine consensus to evaluate three competing architecture approaches"

### Claude Flow Browser (59 MCP Tools)

Browser automation without Chromium — runs through Claude Flow's MCP.

| Command | What it does |
|---------|-------------|
| `cfb-open <url>` | Open a page |
| `cfb-snap` | Take a snapshot |
| `cfb-click <ref>` | Click element (@e1, @e2...) |
| `cfb-fill <ref> <val>` | Fill an input |
| `cfb-trajectory` | Start recording a user flow |
| `cfb-learn` | Save the recording to RuVector |

> "Open localhost:3000, snapshot the homepage, then fill the search box and click submit"

> "Record a trajectory of the entire onboarding flow and save it as a regression test"

### Memory Operations

**Claude Flow Memory** (SQLite, built-in):

| Command | What it does |
|---------|-------------|
| `mem-store "key" "value"` | Store a key-value pair |
| `mem-search "query"` | Keyword search |
| `mem-vsearch "query"` | Semantic vector search |
| `mem-stats` | Database statistics |
| `mem-hnsw` | Build/rebuild HNSW index |

**RuVector** (Neural learning):

| Command | What it does |
|---------|-------------|
| `ruv-init` | Activate hooks |
| `ruv-remember "name"` | Save a successful pattern |
| `ruv-recall "query"` | Retrieve matching patterns |
| `ruv-route "task"` | Route task to best agent |
| `ruv-learn` | Consolidate session learnings |
| `ruv-stats` | Learning statistics |

**AgentDB** (HNSW vector DB, separate MCP):

| Command | What it does |
|---------|-------------|
| `agentdb-init` | Initialize database |
| `agentdb-mcp` | Start as MCP server |
| `agentdb-stats` | Database statistics |

Once AgentDB is registered as MCP, Claude Code gains these tools: `agentdb_query` (semantic search), `agentdb_store` (store with embeddings), `agentdb_stats`.

### Hooks Intelligence

| Command | What it does |
|---------|-------------|
| `hooks-train` | Pretrain from codebase |
| `hooks-pre "file"` | Look up patterns before editing |
| `hooks-post "file"` | Learn patterns after editing |
| `hooks-intel` | Intelligence status |
| `hooks-route "task"` | Route to best agent |

> "Pretrain hooks intelligence from the codebase so it knows our patterns"

> "What does hooks intelligence recommend for this database migration?"

### Neural Operations

| Command | What it does |
|---------|-------------|
| `neural-train` | Train on accumulated patterns |
| `neural-status` | Engine status |
| `neural-patterns` | View learned patterns |
| `neural-predict "input"` | Predict from patterns |

> "Train the neural engine on everything we've done today, then show me the learned patterns"

### Testing & Quality

| Command | What it does |
|---------|-------------|
| `aqe-generate` | Generate tests |
| `aqe-gate` | Run quality gate |

> "Generate tests for the auth module with 95% coverage target"

> "Run the quality gate — coverage, security, performance — and tell me if it's safe to merge"

### OpenSpec (API Design)

| Command | What it does |
|---------|-------------|
| `os "command"` | Run OpenSpec |
| `os-init` | Initialize spec structure |

> "Initialize OpenSpec and define the REST API contract for the user service"

> "Validate the API spec and show any violations"

### Security Analyzer

Activates automatically on security-related prompts.

> "Scan for vulnerabilities and check dependencies for CVEs"

> "Audit API endpoints against OWASP Top 10"

> "Review authentication flows for security weaknesses"

### Worktree Manager

| Command | What it does |
|---------|-------------|
| `wt-create` | Create a new worktree branch |
| `wt-status` | Check all worktrees |
| `wt-clean` | Remove merged worktrees |

> "Create a worktree for the payment-feature branch"

> "Clean up worktrees for branches that have been merged"

### Deployment

| Command | What it does |
|---------|-------------|
| `deploy` | Deploy to Vercel |
| `deploy-preview` | Deploy and return preview URL |

> "Deploy to Vercel and give me the preview URL"

### Visualization

```bash
ruv-viz          # Start 3D dashboard at localhost:3333
ruv-viz-stop     # Stop the server
```

> "Start the RuVector 3D visualization so I can see pattern clusters and agent routing"

### Codex Collaboration

Turbo Flow configures Claude Code and Codex for split responsibilities via AGENTS.md:

| Task | Codex | Claude Code |
|------|-------|-------------|
| Code changes, tests, refactors | ✅ | |
| PRs, secrets, multi-repo coordination | | ✅ |

```bash
codex-login       # Authenticate
codex-run         # Run with Claude provider
```

### Monitoring

**Statusline Pro** displays automatically in your terminal:

```
LINE 1: 📁 Project │ 🤖 Model │ 🌿 Branch │ 📟 Version │ 🎨 Style │ 🔗 Session
LINE 2: 📊 Tokens │ 🧠 Context │ 💾 Cache │ 💰 Cost │ 🔥 Burn Rate │ ⏱️ Duration
LINE 3: ➕ Added │ ➖ Removed │ 📂 Git │ 🌳 Worktree │ 🔌 MCP │ ✅ Status
```

```bash
turbo-status      # Full component check
cf-doctor         # Claude Flow diagnostics
npx -y ccusage    # On-demand cost analysis
```

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Commands not found | `source ~/.bashrc` |
| MCP servers not connected | `claude mcp list` — re-register any missing |
| Memory empty after restart | `npx -y claude-flow@alpha memory init` again |
| RuVector not learning | `ruv-init` then `hooks-train` |
| AgentDB not responding | `claude mcp add agentdb -- npx -y agentdb mcp` |
| Swarm stuck | `npx -y claude-flow@alpha swarm status` |
| Slow first tool run | Normal — npx downloads on first use, cached after |
| Skill not activating | `ls ~/.claude/skills/` — needs SKILL.md present |
| Daemon died | `cf-daemon` to restart |

---

## Quick Reference

```
BOOT:     cf-init → memory init → mcp add → ruv-init → hooks-train → cf-daemon
PLAN:     /prd2build → os-init → cf-swarm
BUILD:    ruv-route → swarm orchestrate → ruv-remember
TEST:     aqe-generate → aqe-gate → cfb-open → cfb-snap
SECURE:   "scan for vulnerabilities" (auto-triggers)
UI:       "design a dashboard" (auto-triggers UI Pro Max)
MEMORY:   mem-store → mem-search → mem-vsearch → mem-hnsw
LEARN:    ruv-remember → ruv-learn → ruv-stats
NEURAL:   neural-train → neural-patterns → neural-predict
DEPLOY:   deploy-preview
MONITOR:  turbo-status → cf-doctor → ccusage
```
