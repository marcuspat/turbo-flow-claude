# Turbo Flow V2 - Comprehensive Workflow Guide

**Version:** 2.0.3
**Last Updated:** 2026-01-28
**Purpose:** Complete installation, initialization, and development workflow for Claude Flow V3 + RuVector + AgentDB + Swarm Coordination

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Installation & Setup](#installation--setup)
3. [Initialization Workflow](#initialization-workflow)
4. [Development Workflows](#development-workflows)
   - [New Feature Development](#new-feature-development)
   - [Refactoring Development](#refactoring-development)
   - [UI/Frontend Development](#uifrontend-development)
   - [Backend Development](#backend-development)
   - [Security Audits](#security-audits)
   - [RuVector & Intelligence](#ruvector--intelligence)
5. [Command Reference](#command-reference)
6. [AgentDB vs RuVector](#agentdb-vs-ruvector)
7. [Project Structure](#project-structure)
8. [Best Practices](#best-practices)
9. [Troubleshooting](#troubleshooting)

---

## Quick Start

### One-Line Setup

```bash
# Run the complete setup
bash devpods/setup.sh && bash devpods/post-setup.sh && source ~/.bashrc
```

### Verify Installation

```bash
turbo-status          # Check all tools
npx @claude-flow/cli@latest doctor  # Full diagnostics
```

---

## Installation & Setup

### Step 1: Run Setup Script (15 Automated Steps)

```bash
bash devpods/setup.sh
```

**What Gets Installed:**

| Step | Category | Components |
|------|----------|------------|
| **1-3** | System | build-essential, python3, git, curl, Node.js 20 LTS |
| **4** | Neural Engine | `ruvector`, `@ruvector/sona`, `@ruvector/cli` + hooks init |
| **5** | Orchestration | `claude-flow@v3alpha` (175+ MCP tools, 54+ agents) |
| **6** | Core Packages | `@anthropic-ai/claude-code`, `agentic-qe`, `@fission-ai/openspec`, `uipro-cli`, `agent-browser` |
| **7-8** | Skills | agent-browser, security-analyzer (Chromium included) |
| **9** | Python Tools | `uv` package manager + `specify-cli` (Spec-Kit) |
| **10** | MCP Config | `~/.config/claude/mcp.json` |
| **11** | Workspace | Directories, package.json, tsconfig.json, HeroUI, Tailwind CSS |
| **12** | UI Skill | ui-ux-pro-max skill |
| **13** | Commands | `~/.claude/commands/prd2build.md` |
| **14** | Codex Config | `~/.codex/instructions.md` + `AGENTS.md` |
| **15** | Bash Aliases | 40+ aliases in `~/.bashrc` |

### Step 2: Run Post-Setup

```bash
bash devpods/post-setup.sh
```

**Verifies and starts:**
- Daemon with background workers
- Memory with HNSW indexing
- Swarm with hierarchical topology
- MCP server configuration

### Step 3: Reload Shell

```bash
source ~/.bashrc
```

### Step 4: Verify

```bash
turbo-status
```

**Expected Output:**
```
📊 Turbo Flow v2.0.3 Status
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

## Initialization Workflow

### Complete Initialization Prompts

After setup, use these prompts in Claude Code to initialize everything:

#### 1. Restart MCP Connection
```
Please restart the MCP server connection to detect the claude-flow MCP server.
```

#### 2. Verify Complete Status
```
Run Claude Flow doctor and show me the complete status including MCP tools, skills, daemon, memory, swarm, and intelligence features.
```

#### 3. Initialize Memory System
```
Initialize Claude Flow memory with HNSW indexing for semantic search. Create the memory database with vector embeddings support.
```

#### 4. Initialize Swarm Coordination
```
Initialize Claude Flow swarm with hierarchical topology, specialized strategy, and max-agents 8 for optimal anti-drift performance.
```

#### 5. Enable RuVector Neural Substrate
```
Initialize the RuVector neural substrate integration with AgentDB for enhanced embeddings and neural operations.
```

#### 6. Enable SONA Learning
```
Enable SONA (Self-Optimizing Neural Architecture) learning for adaptive agent behavior with EWC++ memory consolidation.
```

#### 7. Enable MoE Routing
```
Enable MoE (Mixture of Experts) routing for intelligent model selection and specialized task handling.
```

#### 8. Initialize Embeddings System
```
Initialize the ONNX embedding subsystem with hyperbolic (Poincaré) embeddings support for semantic vector operations.
```

#### 9. Verify Intelligence System
```
Show me the RuVector intelligence system status including neural patterns, SONA learning, MoE routing, and HNSW search capabilities.
```

#### 10. Store Initial Patterns
```
Store some initial successful patterns in memory to bootstrap the intelligence system for future pattern matching.
```

### Bash Commands for Initialization

```bash
# 1. Reload shell
source ~/.bashrc

# 2. Full diagnostics
npx @claude-flow/cli@latest doctor

# 3. Initialize memory
npx @claude-flow/cli@latest memory init --force

# 4. Initialize swarm
npx @claude-flow/cli@latest swarm init --topology hierarchical --max-agents 8 --strategy specialized

# 5. Start daemon
npx @claude-flow/cli@latest daemon start

# 6. Enable RuVector neural substrate
npx @claude-flow/cli@latest embeddings neural --action init

# 7. Initialize embeddings
npx @claude-flow/cli@latest embeddings init --model all-MiniLM-L6-v2 --hyperbolic true

# 8. Enable intelligence features
npx @claude-flow/cli@latest hooks intelligence --enableSona true --enableMoe true --enableHnsw true --showStatus

# 9. Store test pattern
npx @claude-flow/cli@latest memory store --key "test-pattern" --value "Claude Flow V2 initialized!" --namespace patterns

# 10. Test search
npx @claude-flow/cli@latest memory search --query "test" --namespace patterns
```

---

## Development Workflows

### New Feature Development

**Phase 1: Architecture & Research**

```
Review the requirements and create a detailed ADR/DDD implementation using:
- Claude Flow V3 swarm coordination
- RuVector self-learning
- Security analysis
- Hooks and helpers
- All available optimizations

Spawn swarm for architecture design, do not implement yet. Let's call this project "[PROJECT NAME]"
```

**Supporting Commands:**
```bash
# Initialize Spec-Kit for requirements
sk-here

# Initialize OpenSpec for API specs
os-init

# Start RuVector learning trajectory
ruv-init
```

**In Claude Code after the above:**
```
Use Spec-Kit to extract requirements and add acceptance criteria with priorities.
Use OpenSpec to generate OpenAPI 3.0 specifications based on requirements.
Start a SONA learning trajectory for ADR/DDD architecture design.
Store the architectural patterns in RuVector ReasoningBank with HNSW indexing.
```

**Artifacts Generated:**
- `docs/adr/ADR-001.md` through `ADR-010.md`
- `docs/adr/ADR-SEC-001.md` through `ADR-SEC-005.md`
- `docs/ddd/bounded-contexts.md`
- `docs/ddd/aggregates.md`
- `.specify/` database
- `openspec.yaml`

**Phase 2: Branch & Statusline**

```
Create new branch "[PROJECT NAME]" and commit - update the statusline to match the DDD we outlined using the ADRs and available hooks and helpers.
```

**Helper Paths for statusline:**
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

**Phase 3: Swarm Implementation**

```
Spawn the swarm and implement completely:
- Write code following DDD architecture
- Create HeroUI components with Tailwind CSS
- Test everything
- Validate all functionality
- Benchmark performance
- Optimize bottlenecks
- Generate documentation
Continue until complete
```

**Supporting Commands:**
```bash
# Hierarchical swarm (recommended)
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

**Phase 4: Testing & Validation**

```
Initialize Agentic QE fleet - run comprehensive testing, validate, benchmark, and continue until complete.
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

**Phase 5: Optimization**

```
Benchmark, test, optimize - store patterns for future use in RuVector ReasoningBank.
```

**Supporting Commands:**
```bash
# Check learning stats
ruv-stats

# Store successful patterns
ruv-remember -t optimization "Pattern description"

# Search for similar optimizations
ruv-recall "performance optimization"
```

**Phase 6: Documentation**

```
Document everything - use prd2build to generate complete documentation with INDEX.md showing traceability: Requirements → ADR → Code → Tests
```

**In Claude Code:**
```bash
/prd2build prd.md
```

**Artifacts Generated:**
- `docs/implementation/INDEX.md` (traceability matrix)
- `docs/specification/requirements.md`
- `docs/specification/user-stories.md`
- `docs/specification/api-contracts.md`

**Phase 7: E2E Testing**

```
Create an end-to-end test using agent-browser - optimize and be very specific about the viewport sizes: 1920x1080, 1366x768, 375x667.
```

**Supporting Commands:**
```bash
ab-open "http://localhost:3000"    # Open URL
ab-snap                             # Get accessibility snapshot
ab-click @ref                       # Click element
ab-fill @ref "text"                 # Fill input
ab-close                            # Close browser
```

---

### Refactoring Development

**Prompt:**
```
Analyze the current codebase and create a refactoring plan:

1. Use RuVector to analyze code structure and detect boundaries
2. Create ADRs for refactoring decisions
3. Define new bounded contexts using DDD
4. Store patterns in ReasoningBank
5. Spawn swarm to implement refactoring
6. Run tests and validation
7. Optimize and document
```

**Supporting Commands:**
```bash
# AST analysis
npx @claude-flow/cli@latest analyze ast src/ --complexity

# Detect module boundaries
npx @claude-flow/cli@latest analyze boundaries src/ --algorithm louvain

# Analyze diff risk
npx @claude-flow/cli@latest analyze diff --risk

# Find circular dependencies
npx @claude-flow/cli@latest analyze circular src/

# Route refactoring task
npx @claude-flow/cli@latest hooks route --task "Refactor user service"
```

---

### UI/Frontend Development

**Prompt:**
```
Create a modern, responsive UI using HeroUI components and Tailwind CSS:

1. Design component hierarchy
2. Implement with HeroUI components
3. Apply Tailwind utility classes
4. Add Framer Motion animations
5. Ensure accessibility (ARIA labels)
6. Test with agent-browser at multiple viewports
7. Optimize performance
```

**Available HeroUI Components:**
```jsx
import {
  // Layout
  Card, Divider, Spacer, Navbar, Sidebar,

  // Inputs
  Button, Input, Checkbox, Radio, Select, Slider, Switch, Textarea,

  // Data Display
  Avatar, Badge, Chip, Table, User, Image, Code,

  // Feedback
  Alert, CircularProgress, Progress, Skeleton, Spinner,

  // Navigation
  Breadcrumbs, Dropdown, Link, Pagination, Tabs,

  // Overlay
  Modal, Popover, Tooltip,

  // Other
  Accordion, Collapse, DatePicker, TimeInput, Notification, Menu
} from "@heroui/react";

import { motion } from "framer-motion";
```

**Example Component:**
```jsx
import { Button, Card, Input, Modal } from "@heroui/react";
import { motion } from "framer-motion";

function LoginForm() {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.3 }}
    >
      <Card className="p-6 max-w-md mx-auto">
        <h2 className="text-2xl font-bold mb-4">Login</h2>
        <div className="space-y-4">
          <Input
            label="Email"
            type="email"
            placeholder="you@example.com"
            variant="bordered"
          />
          <Input
            label="Password"
            type="password"
            placeholder="••••••••"
            variant="bordered"
          />
          <Button color="primary" className="w-full">
            Sign In
          </Button>
        </div>
      </Card>
    </motion.div>
  );
}
```

**Supporting Commands:**
```bash
# UI UX Pro Max skill
uipro init --ai claude

# Generate UI
uipro generate --component Dashboard --style modern

# Test UI with agent browser
ab-open "http://localhost:3000"
ab-snap
```

---

### Backend Development

**Prompt:**
```
Develop the backend API following DDD architecture:

1. Define bounded contexts and aggregates
2. Create API specifications with OpenSpec
3. Implement endpoints following ADRs
4. Add input validation (Zod)
5. Implement error handling
6. Add authentication/authorization
7. Write comprehensive tests
8. Run security scan
```

**Supporting Commands:**
```bash
# Initialize Spec-Kit
sk-here

# Add requirements
specify add "User must be able to authenticate with JWT" --tag auth --priority high

# Initialize OpenSpec
os-init

# Generate API specs
openspec generate

# Validate specs
openspec validate

# Route task to backend agent
cf-agent backend-dev "Implement user authentication API"
```

**Backend Stack:**
- Node.js + Express / Fastify
- TypeScript (ES2022)
- Zod for validation
- JWT authentication
- PostgreSQL / MongoDB
- OpenAPI 3.0 specifications

---

### Security Audits

**Prompt:**
```
Run a comprehensive security audit of the codebase:

1. Scan for OWASP Top 10 vulnerabilities
2. Check for hardcoded secrets/API keys
3. Validate input handling
4. Review authentication/authorization
5. Check dependency CVEs
6. Analyze code for injection vulnerabilities
7. Generate security ADRs for any issues found
8. Store security patterns in ReasoningBank
```

**Supporting Commands:**
```bash
# Security scan via Claude Flow
cf-security

# Or via security analyzer skill
security-scan

# Full audit
npx @claude-flow/cli@latest security audit --depth full

# Check specific file
npx @claude-flow/cli@latest security scan --path src/auth/

# Generate report
npx @claude-flow/cli@latest security report --format markdown
```

**Security Checks Performed:**
- CVE Scanning (Common Vulnerabilities and Exposures)
- OWASP Top 10 (Injection, XSS, CSRF, etc.)
- Secrets Detection (Hardcoded API keys, passwords)
- Dependency Audit (Vulnerable packages)
- Code Analysis (SQL injection, XSS patterns)

**If Vulnerabilities Found:**
```
Create ADR to mitigate [vulnerability type] following security best practices.
Implement the fix and run security scan again to verify.
```

---

### RuVector & Intelligence

**Prompt:**
```
Enable and configure RuVector intelligence features:

1. Initialize neural substrate
2. Enable SONA learning
3. Enable MoE routing
4. Initialize embeddings with hyperbolic support
5. Store patterns in ReasoningBank
6. Train on successful trajectories
7. Verify intelligence system is working
```

**Supporting Commands:**
```bash
# Initialize RuVector hooks
ruv-init

# Check status
ruvector-status

# View learning stats
ruv-stats

# Route task with ML
ruv-route "Implement authentication feature"

# Store pattern
ruv-remember -t architecture "JWT with refresh token rotation"

# Search memory
ruv-recall "authentication patterns"

# Record trajectory
ruv-learn

# Enable SONA
npx @claude-flow/cli@latest hooks intelligence trajectory-start --task "auth impl"

# Record step
npx @claude-flow/cli@latest hooks intelligence trajectory-step --action "wrote tests" --quality 0.9

# End trajectory
npx @claude-flow/cli@latest hooks intelligence trajectory-end --success true

# Search patterns
npx @claude-flow/cli@latest hooks intelligence pattern-search --query "auth" --topK 5

# View stats
npx @claude-flow/cli@latest hooks intelligence_stats --detailed
```

**RuVector Components:**
- **SONA** - Self-Optimizing Neural Architecture (<0.05ms adaptation)
- **MoE** - Mixture of Experts routing
- **HNSW** - 150x-12,500x faster search
- **EWC++** - Elastic Weight Consolidation (prevents forgetting)
- **Flash Attention** - 2.49x-7.47x speedup
- **LoRA** - 128x memory compression

---

## Command Reference

### Bash Aliases (40+ Installed)

#### Claude Flow V3
```bash
cf                    # Main CLI
cf-init               # Initialize workspace
cf-swarm              # Hierarchical swarm
cf-mesh               # Mesh topology
cf-agent <type> TASK  # Run specific agent
cf-list               # List 54+ agents
cf-daemon             # Background daemon
cf-memory status       # Memory status
cf-security           # Security scan
cf-mcp                # MCP server
```

#### RuVector
```bash
ruv                   # Start RuVector
ruv-stats             # Learning statistics
ruv-route "task"       # Route to best agent
ruv-remember -t TYPE   # Store in memory
ruv-recall "query"     # Search memory
ruv-learn             # Record trajectory
ruv-init              # Initialize hooks
```

#### Testing
```bash
aqe-generate          # Generate tests
aqe-gate              # Quality gate
aqe-coverage          # Coverage report
```

#### Agent Browser
```bash
ab-open <url>         # Open URL
ab-snap               # Snapshot
ab-click @ref         # Click element
ab-fill @ref TEXT     # Fill input
ab-close              # Close browser
```

#### Spec-Kit
```bash
sk-here               # Init in current dir
sk-check              # Check specs
specify add "req"     # Add requirement
specify list          # List requirements
```

#### OpenSpec
```bash
os-init               # Initialize
openspec tree         # Visualize specs
openspec validate     # Validate spec
```

#### Utilities
```bash
turbo-status          # Check all tools
turbo-help            # Quick reference
turbo-init            # Initialize workspace
dsp                   # Claude with skip permissions
```

### Direct CLI Commands

#### Memory Operations
```bash
# Initialize
npx @claude-flow/cli@latest memory init --force

# Store
npx @claude-flow/cli@latest memory store --key "name" --value "data" --namespace patterns

# Search (HNSW indexed)
npx @claude-flow/cli@latest memory search --query "pattern"

# List
npx @claude-flow/cli@latest memory list --namespace patterns

# Stats
npx @claude-flow/cli@latest memory stats
```

#### Swarm Operations
```bash
# Initialize
npx @claude-flow/cli@latest swarm init --topology hierarchical --max-agents 8

# Status
npx @claude-flow/cli@latest swarm status

# Health
npx @claude-flow/cli@latest swarm_health
```

#### Intelligence Operations
```bash
# Route
npx @claude-flow/cli@latest hooks route --task "description"

# Enable features
npx @claude-flow/cli@latest hooks intelligence --enableSona true --enableMoe true

# Trajectory
npx @claude-flow/cli@latest hooks intelligence trajectory-start --task "task"
npx @claude-flow/cli@latest hooks intelligence trajectory-step --action "action" --quality 0.9
npx @claude-flow/cli@latest hooks intelligence trajectory-end --success true

# Patterns
npx @claude-flow/cli@latest hooks intelligence pattern-search --query "pattern"

# Stats
npx @claude-flow/cli@latest hooks intelligence_stats --detailed
```

#### Embeddings Operations
```bash
# Initialize
npx @claude-flow/cli@latest embeddings init --model all-MiniLM-L6-v2 --hyperbolic true

# Neural substrate
npx @claude-flow/cli@latest embeddings neural --action init

# Generate
npx @claude-flow/cli@latest embeddings generate --text "sample text"

# Compare
npx @claude-flow/cli@latest embeddings compare --text1 "text1" --text2 "text2"

# Search
npx @claude-flow/cli@latest embeddings search --query "search term" --topK 5
```

#### Background Workers
```bash
# Dispatch
npx @claude-flow/cli@latest hooks worker dispatch --trigger audit

# Status
npx @claude-flow/cli@latest hooks worker status

# List
npx @claude-flow/cli@latest hooks worker list
```

---

## AgentDB vs RuVector

### Quick Decision Matrix

| Your Need | Use This | Why |
|-----------|----------|-----|
| **Vector memory storage** | AgentDB | Built-in, persistent HNSW indexing |
| **Code intelligence (routing, AST, diff)** | RuVector | ML-based agent routing, code analysis |
| **Distributed swarms (100+ agents)** | RuVector Postgres | Centralized coordination |
| **Local development (1-15 agents)** | AgentDB | Simpler, already installed |
| **Advanced neural (LoRA, EWC++, Flash Attention)** | RuVector | Native Rust performance |
| **Simple semantic search** | AgentDB | Good enough for most cases |

### AgentDB (Built-in)

**What It Is:**
- Vector database component of `@claude-flow/memory`
- JavaScript/TypeScript with WASM SQLite backend
- Automatically installed with Claude Flow V3

**Capabilities:**
- Pattern storage and retrieval
- Semantic search via HNSW indexing (150x-12,500x faster)
- Cross-agent memory sharing
- Session persistence

**When to Use:**
- Memory & pattern storage
- Semantic search
- RAG systems
- Local development (1-15 agents)

**Commands:**
```bash
npx @claude-flow/cli@latest memory init
npx @claude-flow/cli@latest memory store --key "k" --value "v"
npx @claude-flow/cli@latest memory search --query "q"
npx @claude-flow/cli@latest memory stats
```

### RuVector (Optional)

**What It Is:**
- Separate npm package for advanced features
- High-performance Rust/WASM library
- Optional dependency

**Capabilities:**
- Q-Learning agent routing (learns from outcomes)
- AST analysis and code structure parsing
- Diff classification and risk scoring
- Coverage-aware task routing
- Graph-based boundary detection
- Advanced neural features (Flash Attention, SONA, LoRA, EWC++)

**When to Use:**
- Code analysis & intelligence
- ML-based routing
- Advanced neural computing
- Large-scale production (100+ agents)
- Performance-critical applications

**Installation:**
```bash
npm install -g ruvector
```

**Commands:**
```bash
# Q-Learning routing
npx @claude-flow/cli@latest hooks route --task "Fix bug" --q-learning

# AST analysis
npx @claude-flow/cli@latest analyze ast src/ --complexity

# Diff analysis
npx @claude-flow/cli@latest analyze diff --risk

# Coverage routing
npx @claude-flow/cli@latest hooks route --task "Add tests" --coverage-aware

# Graph analysis
npx @claude-flow/cli@latest analyze boundaries src/ --algorithm louvain
```

### How They Work Together

```
┌─────────────────────────────────────────────┐
│              Claude Flow V3                  │
├─────────────────────────────────────────────┤
│                                               │
│  AgentDB (Core Memory Layer)                  │
│  • Vector storage with HNSW                   │
│  • Semantic search                            │
│  • Pattern persistence                        │
│  • Cross-agent sharing                        │
│                                               │
│  RuVector (Intelligence Layer) - Optional     │
│  • Q-Learning routing                         │
│  • AST analysis                               │
│  • Diff classification                        │
│  • SONA learning                              │
│  • Flash Attention                            │
└─────────────────────────────────────────────┘
```

**Example Workflow:**
```bash
# 1. RuVector routes task (ML-based)
npx @claude-flow/cli@latest hooks route --task "Implement auth"
# Returns: security-architect (92% confidence)

# 2. Agent executes, stores in AgentDB
npx @claude-flow/cli@latest memory store --key "auth-impl" --value "JWT success"

# 3. RuVector learns from outcome
npx @claude-flow/cli@latest hooks intelligence trajectory-end --success true

# 4. Next similar task benefits from learning
npx @claude-flow/cli@latest hooks route --task "Add OAuth2"
# Returns: security-architect (95% - improved!)
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
│   │   ├── ADR-SEC-001.md
│   │   └── ...
│   ├── ddd/                      # Domain-Driven Design
│   │   ├── bounded-contexts.md
│   │   ├── aggregates.md
│   │   └── entities.md
│   ├── implementation/           # Implementation docs
│   │   └── INDEX.md              # Traceability matrix
│   └── specification/            # Specifications
│       ├── requirements.md
│       ├── user-stories.md
│       └── api-contracts.md
├── scripts/                      # Utility scripts
├── config/                       # Configuration files
├── plans/                        # Research & PRD files
│   └── research/
├── .claude/                      # Claude Code config
│   ├── skills/                   # Custom skills
│   ├── commands/                 # Custom commands
│   └── helpers/                  # Helper scripts
├── .claude-flow/                 # Claude Flow V3 config
│   ├── config.json
│   ├── data/                     # Memory storage
│   └── sessions/                 # Session state
├── .specify/                     # Spec-Kit database
├── .ruvector/                    # RuVector hooks data
├── package.json                  # type: "module"
├── tsconfig.json                 # ES2022, ESNext, JSX
├── tailwind.config.js            # Tailwind + HeroUI
├── postcss.config.js             # PostCSS config
├── AGENTS.md                     # Codex/Claude protocol
└── CLAUDE.md                     # Claude instructions
```

---

## Best Practices

### Development Patterns

1. **Always start with architecture**
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

## Verification & Status Commands

### Quick Status Check
```bash
turbo-status                # All tools status
npx @claude-flow/cli@latest doctor  # Full diagnostics
```

### Memory System
```bash
npx @claude-flow/cli@latest memory stats
npx @claude-flow/cli@latest memory list
npx @claude-flow/cli@latest memory search --query "test"
```

### Swarm Coordination
```bash
npx @claude-flow/cli@latest swarm status
npx @claude-flow/cli@latest daemon status
npx @claude-flow/cli@latest swarm_health
```

### Intelligence System
```bash
npx @claude-flow/cli@latest hooks intelligence --showStatus
npx @claude-flow/cli@latest hooks intelligence_stats --detailed
npx @claude-flow/cli@latest hooks route --task "test"
```

### System Health
```bash
npx @claude-flow/cli@latest system_health --deep
npx @claude-flow/cli@latest system_metrics --category all
```

---

## Troubleshooting

### Common Issues

#### Node.js Version Issues
```bash
n 20
hash -r
node -v  # Should show v20.x.x
```

#### Claude Flow Not Initialized
```bash
cf-init
```

#### MCP Servers Not Starting
```bash
cat ~/.config/claude/mcp.json
exit
claude  # Restart Claude Code
```

#### Aliases Not Working
```bash
source ~/.bashrc
grep "TURBO FLOW" ~/.bashrc
```

#### Memory Issues
```bash
# Reduce max agents
cf-swarm-start --max-agents 8
```

### Getting Help

```bash
turbo-help            # Quick reference
cf-doctor             # Claude Flow diagnostics
ruvector-status       # RuVector status
```

---

## Workflow Summary

### Complete Development Pipeline

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    TURBO FLOW V2 COMPLETE WORKFLOW                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  1. SETUP (One-Time)                                                        │
│     ├─ Run: bash devpods/setup.sh && bash devpods/post-setup.sh            │
│     ├─ Source: source ~/.bashrc                                            │
│     └─ Verify: turbo-status                                                │
│                                                                             │
│  2. ARCHITECTURE                                                            │
│     ├─ Spec-Kit: Requirements management                                    │
│     ├─ OpenSpec: API specifications                                        │
│     ├─ ADR/DDD: Architecture decisions                                      │
│     └─ RuVector: Store patterns                                            │
│                                                                             │
│  3. BRANCH & STATUSLINE                                                     │
│     ├─ Create feature branch                                               │
│     ├─ Update statusline with DDD context                                  │
│     └─ Commit architecture                                                 │
│                                                                             │
│  4. IMPLEMENTATION                                                          │
│     ├─ Spawn: cf-swarm (hierarchical)                                     │
│     ├─ Agents: architect → coder → tester → reviewer                      │
│     ├─ Frontend: HeroUI + Tailwind                                         │
│     └─ Backend: DDD bounded contexts                                       │
│                                                                             │
│  5. TESTING                                                                │
│     ├─ Agentic QE: Test suite                                             │
│     ├─ Security: OWASP scan                                                │
│     └─ Quality Gate: 80%+ coverage, 0 critical CVEs                       │
│                                                                             │
│  6. OPTIMIZATION                                                            │
│     ├─ RuVector SONA: Learning from outcomes                              │
│     ├─ Pattern storage: ruv-remember                                       │
│     └─ Performance: Benchmark and optimize                                 │
│                                                                             │
│  7. DOCUMENTATION                                                           │
│     ├─ prd2build: Complete docs with traceability                          │
│     ├─ INDEX.md: Requirements → ADR → Code → Tests                        │
│     └─ OpenSpec: API documentation                                         │
│                                                                             │
│  8. E2E TESTING                                                             │
│     ├─ Agent Browser: Browser automation                                    │
│     ├─ Viewports: 1920x1080, 1366x768, 375x667                           │
│     └─ Visual regression: Screenshots                                      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Enabled Features Summary

| Feature | Status |
|---------|--------|
| AgentDB (sql.js backend) | ✅ |
| HNSW Vector Search (150x-12,500x faster) | ✅ |
| RuVector Neural Substrate | ✅ |
| SONA Learning (Self-Optimizing) | ✅ |
| MoE Routing (Mixture of Experts) | ✅ |
| Hyperbolic Embeddings (Poincaré ball) | ✅ |
| Flash Attention (2.49x-7.47x speedup) | ✅ |
| EWC++ Memory Consolidation | ✅ |
| Hierarchical Swarm (8 agents) | ✅ |
| MCP Server Integration | ✅ |
| Background Daemon + Workers | ✅ |
| Agent Browser (Chromium) | ✅ |
| Security Analyzer | ✅ |
| HeroUI + Tailwind CSS | ✅ |
| Spec-Kit + OpenSpec | ✅ |
| Agentic QE (19 testing agents) | ✅ |

---

**Version:** 2.0.3
**Turbo Flow V2 - Claude Flow V3 + RuVector Neural Engine**
**Last Updated:** 2026-01-28
