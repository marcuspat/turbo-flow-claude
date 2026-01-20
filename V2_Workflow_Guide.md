# 🚀 Turbo Flow v2.0.1 Workflow Guide

**Operational Playbook for Spec-Driven Development & Agentic Orchestration**

---

## 📋 Table of Contents

1. [Quick Start](#-quick-start)
2. [Workflow 1: Spec-First Approach](#-workflow-1-the-spec-first-approach)
3. [Workflow 2: Architecture & DDD](#-workflow-2-architecture--ddd-with-claude-flow-v3)
4. [Workflow 3: Agentic Build](#-workflow-3-the-agentic-build-prd2build)
5. [Workflow 4: Neural Learning](#-workflow-4-intelligent-routing--pattern-learning)
6. [Workflow 5: Swarm Coordination](#-workflow-5-swarm-coordination)
7. [Workflow 6: Security & Compliance](#-workflow-6-security--compliance)
8. [Workflow 7: Browser Automation](#-workflow-7-browser-automation-agent-browser)
9. [Workflow 8: Frontend Development](#-workflow-8-frontend-development-heroui--tailwind)
10. [Workflow 9: Multi-Agent Collaboration](#-workflow-9-multi-agent-collaboration-codex-integration)
11. [Command Reference](#-turbo-command-reference)

---

## 🚀 Quick Start

### DevPod Setup

```bash
# macOS
brew install loft-sh/devpod/devpod

# Windows
choco install devpod

# Linux
curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64"
sudo install devpod /usr/local/bin

# Launch Turbo Flow
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

### Post-Setup Commands

```bash
# Reload shell aliases
source ~/.bashrc

# Check installation status
turbo-status

# View quick reference
turbo-help

# Start Claude Code
claude
```

### What Gets Installed

| Category | Components |
|----------|------------|
| **Runtime** | Node.js 20 LTS, build-essential, python3, uv |
| **Neural Engine** | ruvector, @ruvector/sona, @ruvector/cli |
| **Orchestration** | claude-flow@v3alpha (175+ MCP tools) |
| **AI Agents** | @anthropic-ai/claude-code |
| **Specifications** | specify-cli (Spec-Kit), @fission-ai/openspec |
| **Testing** | agentic-qe (19 testing agents) |
| **Browser** | agent-browser + Chromium |
| **Security** | security-analyzer skill |
| **UI/UX** | uipro-cli, ui-ux-pro-max skill |
| **Frontend** | @heroui/react, tailwindcss, framer-motion |
| **Commands** | prd2build |
| **Optional** | @openai/codex |

---

## 📝 Workflow 1: The Spec-First Approach

**Goal:** Define requirements and specifications *before* writing code.

**Tools Used:** Spec-Kit (`sk`), OpenSpec (`os`)

### Step 1: Initialize Specs

```bash
# Initialize Spec-Kit in current directory
sk-here

# Initialize OpenSpec
os-init
```

**What happens:**
- `sk-here`: Creates `.specify/` folder with local database for requirements
- `os-init`: Creates `openspec.yaml` for API specifications

### Step 2: Define Requirements

```bash
# Add a requirement (interactive)
specify add

# Add a requirement (direct)
specify add "User must be able to login with email" --tag auth --priority high

# List all requirements
specify list
```

### Step 3: Validate Specifications

```bash
# Check Spec-Kit status
specify check

# List requirements with filters
specify list --tag auth --status draft

# Visualize OpenSpec tree
openspec tree
```

**Output Example:**
```
[REQ-001] User must be able to login with email
  ├─ Priority: High
  ├─ Status: Draft
  └─ Tag: auth
```

### Step 4: Generate from Specs

In Claude Code:
```
Generate API endpoints based on the requirements in Spec-Kit.
Use OpenSpec to create OpenAPI 3.0 specifications.
```

---

## 🧠 Workflow 2: Architecture & DDD with Claude Flow V3

**Goal:** Use Claude Flow V3 to manage ADRs and Domain-Driven Design.

**Tools Used:** claude-flow@v3alpha (`cf`)

### Step 1: Initialize Claude Flow V3

```bash
cf-init
```

**What happens:**
- Initializes the coordination system
- Sets up local ReasoningBank (pattern memory)
- Prepares ADR tracking
- Creates `.claude-flow/` configuration

### Step 2: Create Architecture Decisions (ADRs)

```bash
# Spawn architect agent
cf-agent architect "Create an ADR for authentication using JWT vs Sessions"
```

**In Claude Code:**
```
Draft ADR-001: Authentication Strategy.
Context: High security required for financial data.
Options: 1. JWT tokens, 2. Server sessions, 3. Hybrid approach.
Evaluate trade-offs and recommend.
```

### Step 3: Domain-Driven Design (DDD) Modeling

```bash
# Spawn code analyzer for DDD
cf-agent code-analyzer "Model the User and Payment bounded contexts"
```

**Artifacts Generated:**
- `docs/ddd/bounded-contexts.md`
- `docs/ddd/aggregates.md`
- `docs/ddd/entities.md`
- `docs/ddd/value-objects.md`

### Step 4: Memory & Pattern Storage

```bash
# Check memory status
cf-memory status

# Search for similar past decisions (HNSW - 150x faster)
cf-memory search "authentication pattern"

# Store a successful pattern
ruv-remember -t architecture "JWT with refresh token rotation pattern"
```

### Step 5: List Available Agents

```bash
# List all 54+ available agents
cf-list
```

**Key Agent Types:**
| Agent | Use Case |
|-------|----------|
| `architect` | System design, ADRs |
| `coder` | Implementation |
| `tester` | Test generation |
| `reviewer` | Code review |
| `security-architect` | Security patterns |
| `code-analyzer` | DDD, refactoring |
| `documenter` | Documentation |
| `optimizer` | Performance tuning |

---

## 🤖 Workflow 3: The Agentic Build (`prd2build`)

**Goal:** Transform Specs + ADRs into a complete codebase using swarms.

**Tools Used:** prd2build (slash command), Claude Flow swarms

### Step 1: Prepare the PRD

```bash
cat << 'EOF' > prd.md
# Project: My SaaS App

## Requirements
- User Authentication (JWT)
- Payment Processing (Stripe)
- Admin Dashboard
- API Rate Limiting

## Tech Stack
- Backend: Node.js + Express
- Frontend: React + HeroUI
- Database: PostgreSQL
EOF
```

### Step 2: Run the Generator

In Claude Code:
```bash
# Generate documentation only
/prd2build prd.md

# Generate documentation + execute build
/prd2build prd.md --build
```

**What Happens (The Swarm Process):**

```
1. RESEARCHER Agent reads PRD
   → Extracts requirements
   → Identifies user stories

2. ARCHITECT Agent generates ADRs
   → Creates Architecture Decision Records
   → Aligns with Claude Flow V3 patterns

3. UI DESIGNER creates style guide
   → Uses HeroUI component library
   → Applies Tailwind CSS patterns

4. CODE ANALYZER defines DDD
   → Bounded Contexts
   → Aggregates and Entities

5. BUILD SWARM executes code
   → Backend Dev (API)
   → Frontend Dev (UI)
   → Tester (Tests)
```

### Step 3: Review the Implementation Index

```bash
cat docs/implementation/INDEX.md
```

This file is the **Single Source of Truth**, linking:
```
Requirement → ADR → Code File → Test File
```

---

## 🧠 Workflow 4: Intelligent Routing & Pattern Learning

**Goal:** Let the system learn which agents are best for specific tasks.

**Tools Used:** RuVector, @ruvector/sona, @ruvector/cli

### Understanding the Neural Engine

| Component | Description | Performance |
|-----------|-------------|-------------|
| **RuVector** | Vector database with HNSW indexing | 150x faster search |
| **SONA** | Self-Optimizing Neural Architecture | <0.05ms adaptation |
| **EWC++** | Elastic Weight Consolidation | 95% knowledge retention |
| **GNN** | Graph Neural Network layers | Pattern recognition |
| **Hooks** | Claude Code integration | Real-time learning |

### Step 1: Initialize RuVector Hooks

```bash
# Initialize hooks (done automatically during setup)
ruv-init

# Check RuVector status
ruvector-status
```

### Step 2: Route a Task

```bash
# Ask for routing recommendation
ruv-route "Refactor the user service with SOLID principles"
```

**Output:**
```
🤖 Recommendation: coder
   Confidence: 92%
   Reason: High historical success rate on refactoring tasks
   Cost Saving: 15% (routing to optimal model)
```

### Step 3: Semantic Memory Operations

```bash
# Store in semantic memory
ruv-remember -t edit "Refactored user service with dependency injection"

# Search semantic memory
ruv-recall "user service patterns"

# Record learning trajectory
ruv-learn
```

### Step 4: View Learning Progress

```bash
# View learning statistics
ruv-stats
```

**Output:**
```
📊 RuVector Learning Stats
─────────────────────────
Patterns learned: 156
Success rate: 87%
Top agents: coder, tester, reviewer
Memory entries: 42
SONA adaptations: 2,341
```

### Step 5: Pattern Consolidation

```bash
# Check memory status
cf-memory status

# Trigger pattern consolidation
cf-memory search "consolidate"
```

---

## 🐝 Workflow 5: Swarm Coordination

**Goal:** Orchestrate multiple agents working in parallel.

**Tools Used:** cf-swarm, cf-mesh

### Scenario A: Hierarchical Swarm (Boss/Workers)

Best for: Structured tasks with clear authority.

```bash
cf-swarm
```

**Structure:**
```
      [Coordinator]
           │
    ┌──────┼──────┐
    │      │      │
[Coder] [Tester] [Reviewer]
```

**Use in Claude Code:**
```
Implement the Authentication feature using Hierarchical Swarm.
Coordinator assigns tasks to specialized agents.
```

### Scenario B: Mesh Swarm (Peer-to-Peer)

Best for: Complex problem solving with interdependencies.

```bash
cf-mesh
```

**Structure:**
```
[Coder] ←──────→ [Tester]
    ↑               ↑
    │               │
    └─────→ [Architect] ←─────┘
```

**Use in Claude Code:**
```
Design the microservices architecture using Mesh Swarm.
Agents collaborate directly to resolve dependencies.
```

### Scenario C: Background Daemon

Run persistent agent coordination:

```bash
# Start background daemon
cf-daemon

# Check daemon status
cf-memory status
```

### Swarm Best Practices

| Topology | Best For | Max Agents |
|----------|----------|------------|
| Hierarchical | Structured builds, clear ownership | 8-12 |
| Mesh | Complex design, many interdependencies | 6-8 |
| Ring | Sequential pipelines | 4-6 |
| Star | Central coordinator, independent tasks | 10-15 |

---

## 🔒 Workflow 6: Security & Compliance

**Goal:** Ensure code security using built-in scanning tools.

**Tools Used:** Security Analyzer skill, cf-security

### Step 1: Run Security Scan

```bash
# Via Claude Flow
cf-security
```

**Or in Claude Code:**
```
Run a full security scan on the auth module using the Security Analyzer skill.
Check for OWASP Top 10 vulnerabilities.
```

### Checks Performed

| Check | Description |
|-------|-------------|
| CVE Scanning | Common Vulnerabilities and Exposures |
| OWASP Top 10 | Injection, XSS, CSRF, etc. |
| Secrets Detection | Hardcoded API keys, passwords |
| Dependency Audit | Vulnerable packages |
| Code Analysis | SQL injection, XSS patterns |

### Step 2: Generate Security ADR

If a vulnerability is found:

```bash
cf-agent security-architect "Draft ADR to mitigate SQL injection vulnerability"
```

**Result:** Creates `docs/adr/ADR-SEC-XXX.md`

### Step 3: Continuous Security

In Claude Code:
```
Add security scan to the pre-commit hook.
Fail builds if critical vulnerabilities are found.
```

---

## 🌐 Workflow 7: Browser Automation (Agent Browser)

**Goal:** Automate browser testing and visual development.

**Tools Used:** agent-browser (`ab`)

### Agent Browser Commands

```bash
# Open a URL
ab-open "http://localhost:3000"

# Get accessibility snapshot (element references)
ab-snap

# Click an element by reference
ab-click @ref

# Fill an input field
ab-fill @ref "test@example.com"

# Close the browser
ab-close
```

### E2E Testing Example

In Claude Code:
```
Use Agent Browser to test the login flow:
1. Open http://localhost:3000/login
2. Fill email field with "test@example.com"
3. Fill password field with "password123"
4. Click the login button
5. Verify redirect to /dashboard
6. Take screenshot at 1920x1080, 1366x768, and 375x667 viewports
```

### Visual Regression Testing

```
Use Agent Browser to:
1. Navigate to each page in the application
2. Take screenshots at desktop and mobile viewports
3. Save to assets/screenshots/ for baseline comparison
```

---

## 🎨 Workflow 8: Frontend Development (HeroUI + Tailwind)

**Goal:** Build modern, responsive UIs with pre-configured components.

**Tools Used:** @heroui/react, tailwindcss, framer-motion

### Configuration (Auto-Generated)

**tailwind.config.js:**
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

### Available HeroUI Components

```jsx
import {
  // Layout
  Card, Divider, Spacer,
  // Inputs
  Button, Input, Checkbox, Radio, Select, Slider, Switch, Textarea,
  // Data Display
  Avatar, Badge, Chip, Code, Image, Table, User,
  // Feedback
  Alert, CircularProgress, Progress, Skeleton, Spinner,
  // Navigation
  Breadcrumbs, Dropdown, Link, Navbar, Pagination, Tabs,
  // Overlay
  Modal, Popover, Tooltip,
} from "@heroui/react";
```

### Example: Login Form

```jsx
import { Button, Card, Input } from "@heroui/react";
import { motion } from "framer-motion";

function LoginForm() {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
    >
      <Card className="p-6 max-w-md mx-auto">
        <h2 className="text-2xl font-bold mb-4">Login</h2>
        <div className="space-y-4">
          <Input 
            label="Email" 
            type="email" 
            placeholder="you@example.com"
          />
          <Input 
            label="Password" 
            type="password" 
            placeholder="••••••••"
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

### UI UX Pro Max Skill

The UI UX Pro Max skill provides advanced UI generation:

```
Create a dashboard layout using HeroUI with:
- Sidebar navigation
- Stats cards with animations
- Data table with sorting and filtering
- Dark mode support
```

---

## 🤝 Workflow 9: Multi-Agent Collaboration (Codex Integration)

**Goal:** Coordinate between Claude Code and OpenAI Codex.

**Tools Used:** @openai/codex, AGENTS.md protocol

### Codex Setup (Optional)

```bash
# Install Codex
npm install -g @openai/codex

# Login to Codex
codex login

# Check setup
codex-check
```

### Task Allocation Protocol (AGENTS.md)

| Task Type | Codex | Claude Code |
|-----------|-------|-------------|
| Code changes, tests, refactors | ✅ | ❌ |
| Build, lint, format, migrate | ✅ | ❌ |
| GitHub PRs, CI/CD admin | ❌ | ✅ |
| Secrets, tokens, vault | ❌ | ✅ |
| Multi-repo coordination | ❌ | ✅ |
| Architecture decisions | ❌ | ✅ |
| Security scanning | ❌ | ✅ |

### Running Codex

```bash
# Run Codex with Claude profile
codex-run "Implement the user registration endpoint"

# Or directly
codex exec -p claude "Add unit tests for UserService"
```

### Coordination Example

1. **Claude Code** creates the architecture and ADRs
2. **Codex** implements the code based on ADRs
3. **Claude Code** reviews and manages deployment
4. **Both** share context via AGENTS.md

---

## 🧪 Testing Workflows

**Goal:** Comprehensive testing using Agentic QE.

**Tools Used:** agentic-qe (19 testing agents)

### Generate Tests

```bash
# Generate tests for codebase
aqe-generate

# Generate with coverage target
npx -y agentic-qe generate --coverage 80
```

### Quality Gate

```bash
# Run quality gate
aqe-gate

# Full pipeline with report
npx -y agentic-qe gate --report
```

### Quality Gate Checks

| Check | Threshold |
|-------|-----------|
| Test Coverage | ≥80% |
| Critical Vulnerabilities | 0 |
| Type Errors | 0 |
| Lint Errors | 0 |
| Build Success | Required |

---

## 🚀 Turbo Command Reference

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
| `cf-list` | List available agents |
| `cf-daemon` | Start background daemon |
| `cf-memory status` | Check memory system |
| `cf-memory search "query"` | Search patterns |
| `cf-security` | Run security scan |
| `cf-mcp` | Start MCP server |

### RuVector Neural Engine

| Command | Description |
|---------|-------------|
| `ruv` | Start RuVector |
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

### Codex (Optional)

| Command | Description |
|---------|-------------|
| `codex-login` | Login to Codex |
| `codex-run "task"` | Run with Claude profile |
| `codex-check` | Check setup status |

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

### Utilities

| Command | Description |
|---------|-------------|
| `turbo-status` | Check all installations |
| `turbo-help` | Quick reference guide |

---

## 📁 Project Structure

```
project/
├── src/                      # Source code
│   └── index.css             # Tailwind imports
├── tests/                    # Test files
├── docs/
│   ├── specification/        # Requirements, user stories, API contracts
│   ├── ddd/                  # Bounded contexts, aggregates, entities
│   ├── adr/                  # Architecture Decision Records
│   └── implementation/       # INDEX.md (traceability matrix)
├── plans/                    # Research and architecture plans
├── scripts/                  # Utility scripts
├── config/                   # Configuration files
├── .claude-flow/             # Claude Flow V3 config
├── .specify/                 # Spec-Kit database
├── .ruvector/                # RuVector hooks data
├── AGENTS.md                 # Codex/Claude collaboration protocol
├── CLAUDE.md                 # Project context
├── openspec.yaml             # OpenSpec configuration
├── tailwind.config.js        # Tailwind + HeroUI config
├── postcss.config.js         # PostCSS configuration
├── tsconfig.json             # TypeScript configuration
└── package.json              # Dependencies (type: "module")
```

---

## 🔧 Key Configuration Files

### MCP Servers (~/.config/claude/mcp.json)

```json
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@v3alpha", "mcp", "start"],
      "env": {}
    },
    "agentic-qe": {
      "command": "npx",
      "args": ["-y", "aqe-mcp"],
      "env": {}
    }
  }
}
```

### Skills Directory (~/.claude/skills/)

| Skill | Path |
|-------|------|
| Agent Browser | `~/.claude/skills/agent-browser/` |
| Security Analyzer | `~/.claude/skills/security-analyzer/` |
| UI UX Pro Max | `~/.claude/skills/ui-ux-pro-max/` |

### Commands Directory (~/.claude/commands/)

| Command | Path |
|---------|------|
| prd2build | `~/.claude/commands/prd2build.md` |

---

## 📚 Resources

| Resource | URL |
|----------|-----|
| RuVector | github.com/ruvnet/ruvector |
| Claude Flow V3 | github.com/ruvnet/claude-flow |
| Turbo Flow Claude | github.com/marcuspat/turbo-flow-claude |
| Agentic QE | npmjs.com/package/agentic-qe |
| HeroUI | heroui.com |
| Tailwind CSS | tailwindcss.com |

---

**Version:** 2.0.1
**Last Updated:** 2026-01-20
