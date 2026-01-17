## 🚀 Turbo Flow v2.0.0 Workflow Guide

**Operational Playbook for Spec-Driven Development & Agentic Orchestration**

---

## 📋 Table of Contents

1.  **Workflow 1:** 📝 The Spec-First Approach (Spec-Kit + OpenSpec)
2.  **Workflow 2:** 🧠 Architecture & DDD with Claude Flow V3
3.  **Workflow 3:** 🤖 The Agentic Build (`prd2build`)
4.  **Workflow 4:** 🧠 Intelligent Routing & Pattern Learning (RuVector + SONA)
5.  **Workflow 5:** 🐝 Swarm Coordination (Mesh vs Hierarchical)
6.  **Workflow 6:** 🔒 Security & Compliance
7.  **Workflow 7:** 🌐 Browser Automation (Playwriter + Dev-Browser)
8.  **Workflow 8:** 🎨 Frontend Development (HeroUI + Tailwind)
9.  **Workflow 9:** 🤝 Multi-Agent Collaboration (Codex Integration)

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

# Start Claude Code
claude

# Check installation status
turbo-status

# View quick reference
turbo-help
```

---

## 📝 Workflow 1: The Spec-First Approach

**Goal:** Define requirements and specifications *before* writing code, ensuring implementation drift is prevented.

**Tools Used:** `Spec-Kit` (`sk`), `OpenSpec` (`os`).

### Step 1: Initialize Specs

Initialize the specification tracking for your current directory.

```bash
# Initialize Spec-Kit (Specify CLI)
sk-here

# Initialize OpenSpec
os-init
```

**What happens:**
*   `sk-here`: Creates `.specify/` folder and a local database to track requirements.
*   `os-init`: Creates an `openspec.yaml` file to manage API specifications.

### Step 2: Define Requirements

Create a requirement using Spec-Kit.

```bash
# Add a requirement (interactive)
sk-add

# Add a requirement (direct)
sk-add "User must be able to login with email" --tag auth --priority high
```

### Step 3: Validate Specifications

Ensure your specs are valid before generating code.

```bash
# Check status of Spec-Kit
sk-check

# List all requirements
sk-list

# Visualize OpenSpec tree
os-tree
```

**Output Example:**
```text
[REQ-001] User must be able to login with email
  ├─ Priority: High
  ├─ Status: Draft
  └─ Tag: auth
```

---

## 🧠 Workflow 2: Architecture & DDD with Claude Flow V3

**Goal:** Use Claude Flow V3's "Hive Mind" to manage ADRs (Architecture Decision Records) and DDD (Domain-Driven Design).

**Tools Used:** `claude-flow@v3alpha` (alias `cf`).

### Step 1: Initialize Claude Flow V3

```bash
cf-init
```

**What happens:**
*   Initializes the Hive Mind (Queen-led coordination).
*   Sets up local ReasoningBank (pattern memory).
*   Prepares ADR tracking.
*   Creates `.claude-flow/` configuration directory.

### Step 2: Create Architecture Decisions (ADRs)

Use the Architect agent to draft an ADR.

```bash
# Spawn architect agent
cf-agent architect "Create an ADR for authentication using JWT vs Sessions"
```

**Inside Claude Code:**
> "Draft ADR-001: Authentication Strategy. Context: High security required. Options: 1. JWT, 2. Server Sessions. Decision: JWT..."

### Step 3: Domain-Driven Design (DDD) Modeling

Generate Bounded Contexts and Aggregates.

```bash
# Spawn Code Analyzer for DDD
cf-agent code-analyzer "Model the User and Payment bounded contexts"
```

**Artifacts Generated:**
1.  `docs/ddd/bounded-contexts.md`
2.  `docs/ddd/aggregates.md`
3.  `docs/ddd/entities.md`

### Step 4: Memory & Pattern Storage

Store successful architectural decisions in the ReasoningBank so the system "learns."

```bash
# Check memory status
cf-memory status

# Search for similar past decisions (HNSW - 150x faster)
cf-memory search "authentication pattern"
```

### Step 5: List Available Agents

Claude Flow V3 provides 54+ native agents.

```bash
# List all available agents
cf-list
```

---

## 🤖 Workflow 3: The Agentic Build (`prd2build`)

**Goal:** Transform Specs + ADRs into a complete codebase using the "Swarm."

**Tools Used:** `prd2build` (Slash Command), Claude Flow Swarm.

### Step 1: Prepare the PRD

Ensure your Product Requirements Document is ready.

```bash
# You can create a simple PRD.md if you don't have one
cat << 'EOF' > prd.md
# Project: My SaaS App

## Requirements
- User Authentication
- Payment Processing
- Admin Dashboard
EOF
```

### Step 2: Run the Generator

Execute the `prd2build` command inside Claude Code.

```bash
# Start Claude Code
claude

# Run the slash command (docs only)
/prd2build prd.md

# Run with build execution
/prd2build prd.md --build
```

**What Happens (The "Magic"):**

```diff
+ 1. RESEARCHER Agent reads PRD.
+    → Extracts 8+ requirements.
+    → Extracts user stories.
+
+ 2. ARCHITECT Agent generates ADRs.
+    → Creates 27+ Architecture Decision Records.
+    → Aligns with Claude Flow V3 patterns.
+
+ 3. UI DESIGNER creates style guide.
+    → Uses OpenSpec definitions.
+
+ 4. CODE ANALYZER defines DDD.
+    → Bounded Contexts.
+    → Aggregates.
+
+ 5. BUILD SWARM executes code.
+    → Backend Dev (API) using ADR-001.
+    → Frontend Dev (UI) using ADR-017.
+    → Tester (Tests) using Test Strategy.
```

### Step 3: Review the Implementation Index

The generator creates a `docs/implementation/INDEX.md`.

```bash
cat docs/implementation/INDEX.md
```

This file acts as the **Single Source of Truth**, linking every Requirement → ADR → Code File.

---

## 🧠 Workflow 4: Intelligent Routing & Pattern Learning (RuVector + SONA)

**Goal:** Let the system learn which agents are best for specific tasks using the RuVector Neural Engine.

**Tools Used:** RuVector, @ruvector/sona, @ruvector/cli, Claude Flow V3 Hooks.

### Understanding the Neural Engine

RuVector provides several key capabilities:

| Component | Description | Performance |
|-----------|-------------|-------------|
| **SONA** | Self-Optimizing Neural Architecture | <0.05ms adaptation |
| **HNSW** | Hierarchical Navigable Small World graphs | 150x faster search |
| **MoE** | Mixture of Experts routing | 8 expert models |
| **EWC++** | Elastic Weight Consolidation | 95% knowledge retention |
| **GNN** | Graph Neural Network layers | Pattern recognition |

### Step 1: Initialize RuVector Hooks

```bash
# Initialize hooks (done automatically during setup)
ruv-init

# Check RuVector status
ruvector-status
```

### Step 2: Route a Task

Ask the system who should do the work based on history.

```bash
# Ask for routing recommendation
ruv-route "Refactor the user service"

# Alternative via claude-flow
claude-flow hooks route "Refactor the user service"
```

**Output:**
```text
Recommendation: backend-dev
Confidence: 92%
Reason: High historical success rate on refactoring tasks.
Cost Saving: 15% (using Haiku vs Opus)
```

### Step 3: Semantic Memory Operations

```bash
# Store in semantic memory
ruv-remember -t edit "Refactored user service with SOLID principles"

# Search semantic memory
ruv-recall "user service patterns"

# Record learning trajectory
ruv-learn
```

### Step 4: Learning from Trajectories

The system automatically tracks outcomes. View what it has learned.

```bash
# View learning stats
ruv-stats

# View neural patterns
claude-flow neural patterns

# View hook metrics
claude-flow hooks metrics
```

**SONA (Self-Optimizing Neural Architecture):**
*   Adapts routing in <0.05ms.
*   Prevents catastrophic forgetting (EWC++).
*   Improves accuracy over time.

### Step 5: Pattern Consolidation

Consolidate learned patterns to optimize memory.

```bash
# Trigger consolidation
claude-flow hooks worker dispatch --trigger consolidate
```

---

## 🐝 Workflow 5: Swarm Coordination

**Goal:** Orchestrate multiple agents working in parallel using different topologies.

**Tools Used:** `cf-swarm`, `cf-mesh`.

### Scenario A: Hierarchical Swarm (Boss/Workers)
Best for: Structured tasks with clear authority.

```bash
# Initialize Hierarchy
cf-swarm

# Define objective in Claude Code
"Implement the Authentication feature using Hierarchical Swarm"
```

**Structure:**
```text
      [Queen Coordinator]
             |
    +----+----+----+
    |    |    |    |
 [Coder] [Tester] [Architect]
```

### Scenario B: Mesh Swarm (Peer-to-Peer)
Best for: Complex problem solving where agents need to talk to each other directly.

```bash
# Initialize Mesh
cf-mesh
```

**Structure:**
```text
[Coder] <-------> [Tester] <-------> [Architect]
    ^              ^              ^
    |______________|______________|
```

### Scenario C: Byzantine Consensus
Best for: Critical decisions where you need fault tolerance (e.g., Security Audit).

```bash
# Initialize with Byzantine fault tolerance
claude-flow swarm init --topology hierarchical --consensus byzantine
```

**Feature:** Tolerates up to 1/3 of agents failing or returning bad results.

### Background Daemon

Run the Claude Flow daemon for persistent agent coordination.

```bash
# Start background daemon
cf-daemon
```

---

## 🔒 Workflow 6: Security & Compliance

**Goal:** Use the Security Analyzer skill and Claude Flow security tools to ensure code is safe.

**Tools Used:** `Security Analyzer` Skill, `cf-security`.

### Step 1: Run Security Scan

```bash
# Via Claude Flow
cf-security

# Or via Claude Code Skill
claude
"Run a full security scan on the auth module"
```

**Checks Performed:**
*   CVE Scanning (Common Vulnerabilities).
*   OWASP Top 10 compliance.
*   Hardcoded secrets detection.
*   SQL Injection / XSS analysis.

### Step 2: Generate ADR for Security

If a vulnerability is found, create a mandated fix.

```bash
cf-agent security-architect "Draft ADR to mitigate SQL injection vulnerability found in scan"
```

**Result:** A new ADR is created and pushed to `docs/adr/`.

---

## 🌐 Workflow 7: Browser Automation (Playwriter + Dev-Browser)

**Goal:** Automate browser testing and visual development using AI-powered tools.

**Tools Used:** Playwriter MCP, Dev-Browser Skill.

### Playwriter Setup

Playwriter uses AI to generate Playwright tests from natural language.

**Prerequisites:**
1. Install the Chrome extension: [Playwriter MCP Extension](https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe)

```bash
# Verify Playwriter is accessible
playwriter --version

# Use Playwriter in Claude Code
claude
"Generate a Playwright test for the login flow"
```

### Dev-Browser Skill

Visual AI development tool installed as a Claude skill.

```bash
# Start Dev-Browser server
devb-start

# Located at
~/.claude/skills/dev-browser/
```

**Use Cases:**
*   Visual component testing
*   Screenshot-based debugging
*   UI regression detection

---

## 🎨 Workflow 8: Frontend Development (HeroUI + Tailwind)

**Goal:** Build modern, responsive UIs with HeroUI components and Tailwind CSS.

**Tools Used:** HeroUI, Tailwind CSS, Framer Motion.

### Project Setup

The setup script automatically installs:
- `@heroui/react` - Component library
- `framer-motion` - Animation library
- `tailwindcss` - Utility-first CSS
- `postcss` & `autoprefixer` - CSS processing

### Configuration Files

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

**src/index.css:**
```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

### Using HeroUI Components

```jsx
import { Button, Card, Input } from "@heroui/react";

function LoginForm() {
  return (
    <Card className="p-6">
      <Input label="Email" type="email" />
      <Input label="Password" type="password" />
      <Button color="primary">Login</Button>
    </Card>
  );
}
```

### Resources

- [HeroUI Documentation](https://heroui.com)
- [Tailwind CSS](https://tailwindcss.com)

---

## 🤝 Workflow 9: Multi-Agent Collaboration (Codex Integration)

**Goal:** Coordinate between Claude Code and OpenAI Codex for optimal task allocation.

**Tools Used:** Codex CLI, AGENTS.md protocol.

### Codex Setup

```bash
# Install Codex (optional)
npm install -g @openai/codex

# Login to Codex
codex login

# Check Codex setup
codex-check
```

### Task Allocation Protocol (AGENTS.md)

The `AGENTS.md` file defines which agent handles which tasks:

| Task Type | Codex | Claude Code |
|-----------|-------|-------------|
| Code changes, tests, refactors | ✅ | ❌ |
| Build, lint, format, migrate | ✅ | ❌ |
| GitHub PRs, CI/CD admin | ❌ | ✅ |
| Secrets, tokens, vault | ❌ | ✅ |
| Multi-repo coordination | ❌ | ✅ |

### Codex Configuration

Configuration stored in `~/.codex/config.toml`:

```toml
[projects."/workspaces/turbo-flow-claude"]
trust_level = "trusted"

[profiles.claude]
approval_policy = "never"
sandbox_mode = "danger-full-access"
model = "gpt-5"
model_reasoning_effort = "high"
```

### Running Codex

```bash
# Run Codex with Claude profile
codex-run "Implement the user registration endpoint"

# Or directly
codex exec -p claude "task description"
```

---

## 🧪 Testing Workflows

**Goal:** Comprehensive testing using Agentic QE.

**Tools Used:** Agentic QE (19 testing agents).

### Generate Tests

```bash
# Generate tests for your codebase
aqe-generate

# Or via npx
npx -y agentic-qe generate
```

### Quality Gate

Run quality gates before deployment.

```bash
# Run quality gate
aqe-gate

# Full testing pipeline
npx -y agentic-qe gate
```

---

## 🚀 Turbo Command Reference

### Spec Management

| Command | Tool | Description |
|---------|------|-------------|
| `sk-here` | Spec-Kit | Initialize specs in current directory |
| `sk-check` | Spec-Kit | Validate specifications |
| `os-init` | OpenSpec | Initialize OpenSpec |

### Claude Flow V3

| Command | Tool | Description |
|---------|------|-------------|
| `cf-init` | Claude Flow | Initialize workspace |
| `cf-swarm` | Claude Flow | Start hierarchical swarm |
| `cf-mesh` | Claude Flow | Start mesh swarm |
| `cf-agent <type> "task"` | Claude Flow | Run specific agent |
| `cf-list` | Claude Flow | List available agents |
| `cf-daemon` | Claude Flow | Start background daemon |
| `cf-memory status` | Claude Flow | Check memory system |
| `cf-security` | Claude Flow | Run security scan |
| `cf-mcp` | Claude Flow | Start MCP server |

### RuVector Neural Engine

| Command | Tool | Description |
|---------|------|-------------|
| `ruv` | RuVector | Start RuVector |
| `ruv-init` | RuVector CLI | Initialize hooks |
| `ruv-stats` | RuVector CLI | Show learning statistics |
| `ruv-route "task"` | RuVector CLI | Route task to best agent |
| `ruv-remember` | RuVector CLI | Store in semantic memory |
| `ruv-recall "query"` | RuVector CLI | Search semantic memory |
| `ruv-learn` | RuVector CLI | Record learning trajectory |
| `ruvector-status` | RuVector | Check full status |

### Testing

| Command | Tool | Description |
|---------|------|-------------|
| `aqe-generate` | Agentic QE | Generate tests |
| `aqe-gate` | Agentic QE | Run quality gate |

### Browser Automation

| Command | Tool | Description |
|---------|------|-------------|
| `playwriter` | Playwriter | Run Playwriter |
| `devb-start` | Dev-Browser | Start dev-browser server |

### Codex

| Command | Tool | Description |
|---------|------|-------------|
| `codex-login` | Codex | Login to Codex |
| `codex-run "task"` | Codex | Run with Claude profile |
| `codex-check` | Codex | Check setup status |

### Claude Code

| Command | Tool | Description |
|---------|------|-------------|
| `claude` | Claude Code | Start Claude Code |
| `dsp` | Claude Code | Start with --dangerously-skip-permissions |
| `/prd2build prd.md` | prd2build | Generate docs from PRD |
| `/prd2build prd.md --build` | prd2build | Generate + build |

### Utilities

| Command | Description |
|---------|-------------|
| `turbo-status` | Check all tool installations |
| `turbo-help` | Quick reference guide |

---

## 📁 Project Structure

```
/workspaces/turbo-flow-claude/
├── src/                    # Source code
├── tests/                  # Test files
├── docs/                   # Generated documentation
│   ├── specification/      # Requirements, user stories, API contracts
│   ├── ddd/                # Bounded contexts, aggregates, entities
│   ├── adr/                # Architecture Decision Records
│   └── implementation/     # Milestones, epics, tasks, INDEX.md
├── plans/                  # Research and architecture plans
├── scripts/                # Utility scripts
├── config/                 # Configuration files
├── .claude-flow/           # Claude Flow V3 config
├── .ruvector/              # RuVector hooks data
├── AGENTS.md               # Codex/Claude collaboration protocol
├── CLAUDE.md               # Project context
├── tailwind.config.js      # Tailwind configuration
├── postcss.config.js       # PostCSS configuration
└── tsconfig.json           # TypeScript configuration
```

---

## 🔧 MCP Configuration

Located at `~/.config/claude/mcp.json`:

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
    },
    "playwriter": {
      "command": "npx",
      "args": ["-y", "playwriter@latest"],
      "env": {}
    }
  }
}
```

---

## 📚 Resources

| Resource | URL |
|----------|-----|
| RuVector | github.com/ruvnet/ruvector |
| RuVector npm | npmjs.com/package/ruvector |
| Claude Flow V3 | github.com/ruvnet/claude-flow |
| Turbo Flow Claude | github.com/marcuspat/turbo-flow-claude |
| Agentic QE | npmjs.com/package/agentic-qe |
| Playwriter | github.com/remorses/playwriter |
| HeroUI | heroui.com |
| Tailwind CSS | tailwindcss.com |

---

## ⚠️ Manual Steps After Setup

1. **Playwriter Chrome Extension**
   - Install from: [Chrome Web Store](https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe)

2. **Codex Authentication (Optional)**
   ```bash
   npm install -g @openai/codex
   codex login
   ```

3. **Reload Shell Aliases**
   ```bash
   source ~/.bashrc
   ```
