# Turbo Flow v3.1.0 - Complete Technology Stack

## What's Configured & Enabled by Default

After running `install-v3.1.0.sh`, here's what's **ready to use immediately** vs what needs manual initialization:

---

## ✅ CONFIGURED & ENABLED BY DEFAULT

### Installed & Ready (No Init Required)

| Component | What's Done | Location |
|-----------|-------------|----------|
| **Bash Aliases** | 50+ aliases added to ~/.bashrc | `~/.bashrc` |
| **PATH Updated** | ~/.claude/bin, ~/.local/bin, ~/.cargo/bin | `~/.bashrc` |
| **Statusline Script** | 15-component cyberpunk statusline created | `~/.claude/turbo-flow-statusline.sh` |
| **Statusline Config** | TOML config with color palette | `~/.claude/statusline-pro/config.toml` |
| **settings.json** | Statusline configured in Claude settings | `~/.claude/settings.json` |
| **ccusage** | Cost tracking for statusline | npm global |

### Skills Installed (Auto-Used by Claude)

| Skill | Location | Auto-Triggers When |
|-------|----------|-------------------|
| **prd2build** | `~/.claude/commands/prd2build.md` | User runs `/prd2build` |
| **agent-browser** | `~/.claude/skills/agent-browser/` | Claude needs browser |
| **security-analyzer** | `~/.claude/skills/security-analyzer/` | Claude analyzes security |
| **ui-ux-pro-max** | `~/.claude/skills/ui-ux-pro-max/` | Claude works on UI |
| **worktree-manager** | `~/.claude/skills/worktree-manager/` | User asks for worktrees |
| **vercel-deploy** | `~/.claude/skills/vercel-deploy/` | User asks to deploy |
| **rUv_helpers** | `~/.claude/skills/rUv_helpers/` | Visualization dashboard |

### NPM Packages Installed Globally

| Package | Purpose | Status |
|---------|---------|--------|
| **claude-flow@alpha** | Multi-agent orchestration | ✅ Installed |
| **agent-browser** | Headless browser CLI | ✅ Installed |
| **@ruvector/ruvllm** | RuVector LLM integration | ✅ Installed |
| **agentic-qe** | Test generation | ✅ Installed |
| **@fission-ai/openspec** | API specs | ✅ Installed |
| **uipro-cli** | UI Pro Max installer | ✅ Installed |
| **ccusage** | Cost tracking | ✅ Installed |

### Project Files Created

| File | Location | Purpose |
|------|----------|---------|
| **tsconfig.json** | `$WORKSPACE/` | TypeScript strict config |
| **tailwind.config.js** | `$WORKSPACE/` | Tailwind + HeroUI + dark mode |
| **postcss.config.js** | `$WORKSPACE/` | PostCSS config |
| **src/index.css** | `$WORKSPACE/src/` | Tailwind base imports |
| **AGENTS.md** | `$WORKSPACE/` | Codex task protocol |

### NPM Packages Installed Locally (per project)

| Package | Purpose |
|---------|---------|
| **@heroui/react** | React component library |
| **framer-motion** | Animation library |
| **tailwindcss** | Utility CSS (dev) |
| **postcss** | CSS transform (dev) |
| **autoprefixer** | Vendor prefixes (dev) |

### Directories Created

```
$WORKSPACE/
├── src/
├── tests/
├── docs/
├── scripts/
├── config/
└── plans/
```

---

## ⚡ REQUIRES MANUAL INITIALIZATION

### Claude Flow (run once per project)

| Command | What It Does | When to Run |
|---------|--------------|-------------|
| `cf-init` | Creates `.claude-flow/` directory, initializes config | Start of project |
| `cf-daemon` | Starts background processing daemon | After cf-init |
| `cf-mcp` | Starts MCP server (59 browser tools) | When using cfb-* commands |

### RuVector (run once per project)

| Command | What It Does | When to Run |
|---------|--------------|-------------|
| `ruv-init` | Initializes memory hooks | Start of project |

### Swarms (run when needed)

| Command | What It Does | When to Run |
|---------|--------------|-------------|
| `cf-swarm` | Spawns hierarchical agent swarm | Complex tasks |
| `cf-mesh` | Spawns mesh topology swarm | Collaborative tasks |

---

## 🔧 REQUIRES MANUAL START

### Visualization Dashboard

| Command | What It Does | URL |
|---------|--------------|-----|
| `ruv-viz` | Starts 3D WebGL dashboard | http://localhost:3333 |
| `ruv-viz-stop` | Stops dashboard | - |

### MCP Server (for Claude Flow Browser)

| Command | What It Does |
|---------|--------------|
| `cf-mcp` | Starts MCP server for 59 browser tools |

After starting, these commands work:
- `cfb-open`, `cfb-snap`, `cfb-click`, `cfb-fill`
- `cfb-trajectory`, `cfb-learn`

---

## ❌ NOT INSTALLED (Optional)

| Component | Install Command | Purpose |
|-----------|-----------------|---------|
| **Codex** | `npm install -g @openai/codex` | OpenAI code generation |
| **GitHub CLI** | `apt install gh` | GitHub integration |
| **RuVector CLI** | Installed via claude-flow | Neural routing (bundled) |

---

## ⚠️ MISSING FROM CURRENT INSTALL (Should Add)

Based on Claude Flow v3 documentation, these components are available but **not currently installed** by Turbo Flow:

### AgentDB (High Priority)
| Component | What It Does | Install |
|-----------|--------------|---------|
| **agentdb** | SQLite-powered vector database with HNSW (150x-12,500x faster) | `npm install -g agentdb` |
| **AgentDB MCP** | 32 MCP tools for memory operations | `claude mcp add agentdb npx agentdb@latest mcp` |
| **6 Cognitive Patterns** | Reflexion, Skills, Causal Memory, Explainable Recall, Utility Ranking, Nightly Learner | Built into agentdb |

**AgentDB Features:**
- 150x faster vector search with HNSW indexing
- 6 cognitive memory patterns (Reflexion, Skills, Causal, etc.)
- 9 RL algorithms (Q-Learning, SARSA, PPO, DQN, Decision Transformer)
- 97.9% self-healing with Model Predictive Control
- Graph Neural Networks with 8-head attention

### RuVector PostgreSQL (Enterprise)
| Component | What It Does | Install |
|-----------|--------------|---------|
| **ruvector-postgres** | 77+ SQL functions for AI operations | `docker run -d -p 5432:5432 ruvnet/ruvector-postgres` |
| **Hyperbolic Embeddings** | Poincaré ball model for hierarchical data | Built into ruvector |
| **39 Attention Mechanisms** | Multi-head, Flash, Sparse, Linear, Graph | SQL functions |
| **15 GNN Layer Types** | GCN, GAT, GraphSAGE, MPNN, Transformer | SQL functions |

### Hooks Intelligence (Missing Commands)
| Command | What It Does | Current Status |
|---------|--------------|----------------|
| `hooks pre-edit` | Pattern learning before edits | ❌ Not aliased |
| `hooks post-edit --train-patterns` | Learn from successful edits | ❌ Not aliased |
| `hooks pretrain --depth deep` | Bootstrap from codebase | ❌ Not aliased |
| `hooks intelligence --status` | Check RuVector intelligence | ❌ Not aliased |

### Claude Flow Plugins (Optional)
| Plugin | Purpose | Install |
|--------|---------|---------|
| **@claude-flow/plugin-agentic-qe** | 58 QE agents, TDD, coverage | `npm install @claude-flow/plugin-agentic-qe` |
| **@claude-flow/plugin-prime-radiant** | AI interpretability (6 engines) | `npm install @claude-flow/plugin-prime-radiant` |
| **@claude-flow/plugin-gastown-bridge** | WASM acceleration (352x faster) | `npx claude-flow plugins install -n @claude-flow/plugin-gastown-bridge` |

### Memory Commands (Missing)
| Command | What It Does | Current Status |
|---------|--------------|----------------|
| `memory vector-search` | Semantic search with HNSW | ❌ Not aliased |
| `memory store-vector` | Store with embeddings | ❌ Not aliased |
| `memory agentdb-info` | AgentDB integration status | ❌ Not aliased |
| `memory --build-hnsw` | Build HNSW index | ❌ Not aliased |

### Neural Commands (Missing)
| Command | What It Does | Current Status |
|---------|--------------|----------------|
| `neural train` | Train patterns | ❌ Not aliased |
| `neural status` | Check neural status | ❌ Not aliased |
| `neural patterns` | View learned patterns | ❌ Not aliased |
| `neural predict` | Predict from patterns | ❌ Not aliased |

---

## 📋 RECOMMENDED ADDITIONS TO INSTALL SCRIPT

### Priority 1: AgentDB Integration
```bash
# Install AgentDB globally
npm install -g agentdb

# Add MCP server
claude mcp add agentdb npx agentdb@latest mcp

# Initialize database
npx agentdb init ./agents.db --dimension 768
```

### Priority 2: Missing Aliases
```bash
# Hooks Intelligence
alias hooks-pre="npx claude-flow@alpha hooks pre-edit"
alias hooks-post="npx claude-flow@alpha hooks post-edit"
alias hooks-train="npx claude-flow@alpha hooks pretrain --depth deep"
alias hooks-intel="npx claude-flow@alpha hooks intelligence --status"

# Memory Vector Operations
alias mem-vsearch="npx claude-flow@alpha memory vector-search"
alias mem-vstore="npx claude-flow@alpha memory store-vector"
alias mem-hnsw="npx claude-flow@alpha memory search --build-hnsw"
alias mem-agentdb="npx claude-flow@alpha memory agentdb-info"

# Neural Operations
alias neural-train="npx claude-flow@alpha neural train"
alias neural-status="npx claude-flow@alpha neural status"
alias neural-patterns="npx claude-flow@alpha neural patterns"
```

### Priority 3: Enhanced Learning Loop
```bash
# Pre/post edit with pattern learning
npx claude-flow@alpha hooks pre-edit ./src/file.ts
# ... make edits ...
npx claude-flow@alpha hooks post-edit ./src/file.ts --success true --train-patterns

# Route with explanation
npx claude-flow@alpha hooks route "refactor auth" --include-explanation

# Bootstrap intelligence from codebase
npx claude-flow@alpha hooks pretrain --depth deep --model-type moe
```

---

## 🔑 REQUIRES API KEYS

| Key | Purpose | How to Set |
|-----|---------|------------|
| **ANTHROPIC_API_KEY** | Claude API access | `export ANTHROPIC_API_KEY="sk-ant-..."` |
| **OPENAI_API_KEY** | Codex (if installed) | `export OPENAI_API_KEY="sk-..."` |

---

## Quick Start Sequence

```bash
# 1. Reload shell (aliases become available)
source ~/.bashrc

# 2. Verify installation
turbo-status

# 3. Set API key
export ANTHROPIC_API_KEY="sk-ant-..."

# 4. Initialize Claude Flow + RuVector (once per project)
cf-init
ruv-init

# 5. Start daemon (optional, for background processing)
cf-daemon

# 6. Start visualization (optional)
ruv-viz

# 7. Start working
claude "/prd2build"
```

---

## Summary: What Works Immediately

| Category | Works Immediately | Needs Init |
|----------|-------------------|------------|
| **Statusline** | ✅ Yes | - |
| **Bash Aliases** | ✅ Yes (after source) | - |
| **Skills** | ✅ Yes (auto-used) | - |
| **Agent Browser CLI** | ✅ Yes (`ab-*`) | - |
| **HeroUI/Tailwind** | ✅ Yes | - |
| **TypeScript** | ✅ Yes | - |
| **Claude Flow** | ❌ | `cf-init` |
| **RuVector Memory** | ❌ | `ruv-init` |
| **Claude Flow Browser** | ❌ | `cf-mcp` |
| **3D Visualization** | ❌ | `ruv-viz` |
| **Swarms** | ❌ | `cf-swarm` |

---

## 1. AI Agent Orchestration

### Claude Flow V3
| Component | What It Does |
|-----------|--------------|
| **Multi-Agent Swarms** | Spawn hierarchical/mesh agent topologies |
| **Task Orchestration** | Distribute work across specialized agents |
| **SPARC Methodology** | Specification→Pseudocode→Architecture→Refinement→Completion |
| **Daemon Mode** | Background processing and monitoring |
| **Memory System** | HNSW-indexed vector database for context |

**Commands:** `cf-init`, `cf-swarm`, `cf-mesh`, `cf-agent`, `cf-daemon`, `cf-doctor`

### RuVector Neural Engine
| Component | What It Does |
|-----------|--------------|
| **Neural Routing** | Routes tasks to best-performing agents |
| **Pattern Memory** | Remembers successful code patterns |
| **Learning Hooks** | Learns from code review feedback |
| **SONA Compression** | Compresses patterns into clusters |
| **@ruvector/ruvllm** | LLM integration layer |

**Commands:** `ruv-init`, `ruv-stats`, `ruv-route`, `ruv-remember`, `ruv-recall`, `ruv-learn`

---

## 2. Browser Automation

### Agent Browser (CLI)
| Feature | Description |
|---------|-------------|
| **Headless Chromium** | Runs without visible browser |
| **50+ Commands** | Full browser control API |
| **Element Refs** | Use @e1, @e2 instead of CSS selectors |
| **Screenshots** | Capture snapshots for testing |

**Commands:** `ab-open`, `ab-snap`, `ab-click`, `ab-fill`, `ab-close`

### Claude Flow Browser (MCP - 59 Tools)
| Feature | Description |
|---------|-------------|
| **Trajectory Learning** | Records interaction patterns |
| **Security Scanning** | URL and PII validation |
| **RuVector Integration** | Saves patterns to memory |
| **MCP Protocol** | 59 tools via Model Context Protocol |

**Commands:** `cfb-open`, `cfb-snap`, `cfb-click`, `cfb-fill`, `cfb-trajectory`, `cfb-learn`

---

## 3. Testing & Quality

### Agentic QE
| Feature | Description |
|---------|-------------|
| **Test Generation** | AI-generated unit/integration tests |
| **Quality Gates** | Automated pass/fail thresholds |
| **Coverage Analysis** | Track code coverage metrics |
| **Queen Coordinator** | Orchestrates testing pipeline |

**Commands:** `aqe-generate`, `aqe-gate`

---

## 4. Specifications & Documentation

### OpenSpec (@fission-ai/openspec)
| Feature | Description |
|---------|-------------|
| **API-First Design** | OpenAPI spec generation |
| **Schema Validation** | Validate API contracts |

**Commands:** `os-init`

### Spec-Kit (specify-cli)
| Feature | Description |
|---------|-------------|
| **Project Specs** | GitHub's specification toolkit |
| **Requirement Docs** | Structure project requirements |

**Commands:** `sk-here`

### prd2build Command
| Feature | Description |
|---------|-------------|
| **PRD Parsing** | Converts requirements to tasks |
| **ADR Generation** | Architecture Decision Records |
| **DDD Contexts** | Domain-driven design boundaries |
| **Task Breakdown** | Multi-agent task allocation |

**Command:** `claude "/prd2build"`

---

## 5. UI Development

### UI UX Pro Max Skill
| Feature | Description |
|---------|-------------|
| **Design Systems** | Color, typography, spacing guidance |
| **Component Patterns** | Best practices for React components |
| **Accessibility** | WCAG 2.1 AA compliance guidance |
| **Animation Design** | Motion and interaction patterns |

**Usage:** Automatically used when Claude works on UI

### HeroUI + React
| Package | Purpose |
|---------|---------|
| **@heroui/react** | Modern React component library |
| **framer-motion** | Animation library |
| **tailwindcss** | Utility-first CSS |
| **postcss** | CSS transformation |
| **autoprefixer** | Vendor prefixing |

### TypeScript
| File | Purpose |
|------|---------|
| **tsconfig.json** | Strict TypeScript configuration |

---

## 6. Security

### Security Analyzer Skill
| Feature | Description |
|---------|-------------|
| **Vulnerability Scanning** | Code security analysis |
| **OWASP Compliance** | Top 10 vulnerability checks |
| **Dependency Audit** | Check for vulnerable packages |
| **Credential Detection** | Find hardcoded secrets |

**Usage:** Automatically used when Claude analyzes security

---

## 7. Parallel Development (v3.1.0 NEW)

### Worktree Manager Skill
| Feature | Description |
|---------|-------------|
| **Git Worktrees** | Multiple branches checked out |
| **Port Allocation** | Ports 8100-8199 auto-assigned |
| **Auto Setup** | Copies .env, installs deps |
| **Agent Spawning** | Each worktree gets Claude agent |
| **Terminal Support** | ghostty, iterm2, tmux, wezterm, kitty |

**Commands:** `wt-status`, `wt-create`, `wt-clean`

---

## 8. Deployment (v3.1.0 NEW)

### Vercel Deploy Skill
| Feature | Description |
|---------|-------------|
| **Zero Auth** | Deploy without login |
| **Auto-Detection** | Detects 40+ frameworks |
| **Preview URLs** | Instant preview links |
| **Claim URLs** | Transfer ownership later |

**Commands:** `deploy`, `deploy-preview`

---

## 9. Visualization (v3.1.0 NEW)

### RuV Helpers (3D Dashboard)
| Panel | Description |
|-------|-------------|
| **System Health** | Overall system status |
| **Memory** | RuVector pattern storage |
| **Learning** | Pattern success rates |
| **SONA** | Compressed pattern clusters |
| **Agent Swarm** | Real-time agent monitoring |

**Features:**
- Three.js WebGL force graph
- 20+ REST API endpoints
- Real-time metrics from intelligence.db

**Commands:** `ruv-viz` (localhost:3333), `ruv-viz-stop`

---

## 10. Terminal UI (v3.1.0 NEW)

### Ultimate Cyberpunk Statusline
15 components across 3 lines:

| Line | Components |
|------|------------|
| **1** | 📁 Project │ 🤖 Model │ 🌿 Branch │ 📟 Version │ 🎨 Style │ 🔗 Session |
| **2** | 📊 Tokens │ 🧠 Context Bar │ 💾 Cache │ 💰 Cost │ 🔥 Burn Rate │ ⏱️ Duration |
| **3** | ➕ Added │ ➖ Removed │ 📂 Git Details │ 🌳 Worktree │ 🔌 MCP │ ✅ Status |

**Dependencies:** jq, ccusage (cost tracking)

---

## 11. Optional Components

### Codex (OpenAI)
| Feature | Description |
|---------|-------------|
| **Code Generation** | OpenAI Codex CLI |
| **AGENTS.md** | Task allocation protocol |

**Install:** `npm install -g @openai/codex`

---

## Complete Package List

### NPM Global Packages
```
claude-flow@alpha       # Multi-agent orchestration
ruvector               # Neural routing (via claude-flow)
@ruvector/ruvllm       # RuVector LLM integration
agent-browser          # Headless browser automation
agentic-qe             # Test generation & quality gates
@fission-ai/openspec   # API specification tooling
uipro-cli              # UI UX Pro Max installer
ccusage                # Cost tracking for statusline
```

### NPM Local Packages (per project)
```
@heroui/react          # React component library
framer-motion          # Animation library
tailwindcss            # Utility CSS (dev)
postcss                # CSS transform (dev)
autoprefixer           # Vendor prefixes (dev)
```

### Python/UV Tools
```
specify-cli            # GitHub Spec-Kit
uv                     # Fast Python package manager
```

### System Packages
```
build-essential        # g++, make
python3                # Python runtime
git                    # Version control
curl                   # HTTP client
jq                     # JSON processor
chromium-browser       # Headless browser
```

### Git-Cloned Skills
```
~/.claude/skills/agent-browser/
~/.claude/skills/security-analyzer/
~/.claude/skills/ui-ux-pro-max/
~/.claude/skills/worktree-manager/
~/.claude/skills/vercel-deploy/
~/.claude/skills/rUv_helpers/
```

### Configuration Files
```
~/.claude/commands/prd2build.md
~/.claude/turbo-flow-statusline.sh
~/.claude/statusline-pro/config.toml
~/.claude/settings.json
~/.codex/instructions.md
$WORKSPACE/AGENTS.md
$WORKSPACE/tsconfig.json
$WORKSPACE/tailwind.config.js
$WORKSPACE/postcss.config.js
```

---

## Technology Integration Map

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         USER REQUEST                                     │
└─────────────────────────────────────────────────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                         CLAUDE CODE                                      │
│  • Interprets request                                                    │
│  • Loads relevant skills (UI Pro Max, Security, etc.)                   │
│  • Uses prd2build for requirements                                       │
└─────────────────────────────────────────────────────────────────────────┘
                                  │
                    ┌─────────────┼─────────────┐
                    ▼             ▼             ▼
          ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
          │ CLAUDE FLOW │ │  RUVECTOR   │ │   BROWSER   │
          │    SWARM    │ │   MEMORY    │ │ AUTOMATION  │
          │             │ │             │ │             │
          │ • Spawn     │ │ • Route     │ │ • ab-* CLI  │
          │   agents    │ │   tasks     │ │ • cfb-* MCP │
          │ • Mesh/     │ │ • Remember  │ │ • Trajectory│
          │   Hierarchy │ │   patterns  │ │   learning  │
          │ • SPARC     │ │ • Learn     │ │ • Snapshots │
          └─────────────┘ └─────────────┘ └─────────────┘
                    │             │             │
                    └─────────────┼─────────────┘
                                  ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                      DEVELOPMENT & TESTING                               │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐        │
│  │  HEROUI    │  │ AGENTIC QE │  │  SECURITY  │  │  WORKTREE  │        │
│  │  + MOTION  │  │            │  │  ANALYZER  │  │  MANAGER   │        │
│  │  + TAILWIND│  │ • Tests    │  │            │  │            │        │
│  │            │  │ • Coverage │  │ • Vuln scan│  │ • Parallel │        │
│  │ Components │  │ • Gates    │  │ • OWASP    │  │ • Ports    │        │
│  └────────────┘  └────────────┘  └────────────┘  └────────────┘        │
└─────────────────────────────────────────────────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                         DEPLOYMENT                                       │
│                    ┌────────────────────┐                                │
│                    │   VERCEL DEPLOY    │                                │
│                    │   • Zero auth      │                                │
│                    │   • Preview URLs   │                                │
│                    └────────────────────┘                                │
└─────────────────────────────────────────────────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                       OBSERVABILITY                                      │
│  ┌────────────────────────┐  ┌────────────────────────────────────┐     │
│  │   CYBERPUNK STATUSLINE │  │      RUV HELPERS 3D DASHBOARD     │     │
│  │   15 components        │  │      localhost:3333               │     │
│  │   3 lines              │  │                                    │     │
│  │   Real-time metrics    │  │      • Memory visualization       │     │
│  │                        │  │      • Agent swarm view           │     │
│  │   Cost, tokens, git,   │  │      • Learning metrics           │     │
│  │   cache, MCP, status   │  │      • SONA clusters              │     │
│  └────────────────────────┘  └────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Quick Start After Install

```bash
# 1. Reload shell
source ~/.bashrc

# 2. Check everything installed
turbo-status

# 3. Initialize in project
cf-init
ruv-init

# 4. Start visualization
ruv-viz

# 5. Begin development
claude "/prd2build"
```
