# Turbo Flow v2.0.1 Quick Reference

---

## Getting Started

### 1. Install via DevPod

```bash
# macOS
brew install loft-sh/devpod/devpod

# Windows
choco install devpod

# Linux
curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64"
sudo install devpod /usr/local/bin

# Launch
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

### 2. Post-Install

```bash
source ~/.bashrc       # Load aliases
turbo-status           # Verify installation
turbo-help             # Show command reference
```

### 3. First Run

```bash
claude                 # Start Claude Code
cf-init                # Initialize Claude Flow V3
sk-here                # Initialize Spec-Kit
ruv-init               # Initialize RuVector hooks
```

### 4. Quick Build

Create `prd.md`, then in Claude Code:
```
/prd2build prd.md --build
```

---

## What Gets Installed (15 Steps)

### System & Runtime (Steps 1-3)
| Component | Package/Tool |
|-----------|--------------|
| Build Tools | `build-essential`, `gcc`, `g++`, `make` |
| Python | `python3` |
| Utilities | `git`, `curl` |
| Node.js | v20 LTS (via `n` version manager) |
| Cache | npm cache cleared for clean install |

### Neural Engine (Step 4)
| Package | npm Name | Purpose |
|---------|----------|---------|
| RuVector Core | `ruvector` | Vector DB + GNN + self-learning |
| SONA | `@ruvector/sona` | Self-Optimizing Neural Architecture |
| RuVector CLI | `@ruvector/cli` | Hooks & intelligence for Claude Code |

### Orchestration (Step 5)
| Package | npm Name | Purpose |
|---------|----------|---------|
| Claude Flow V3 | `claude-flow@v3alpha` | 175+ MCP tools, 54+ agents |

### Core Packages (Step 6)
| Package | npm Name | Purpose |
|---------|----------|---------|
| Claude Code | `@anthropic-ai/claude-code` | AI coding CLI |
| Agentic QE | `agentic-qe` | 19 testing agents |
| OpenSpec | `@fission-ai/openspec` | API spec workflow |
| UI Pro CLI | `uipro-cli` | UI generation CLI |
| Agent Browser | `agent-browser` | Browser automation |
| CF Browser | `@claude-flow/browser` | Browser integration |

### Skills & Tools (Steps 7-9, 12-13)
| Skill/Tool | Location | Purpose |
|------------|----------|---------|
| Agent Browser | `~/.claude/skills/agent-browser/` | Chromium automation |
| Security Analyzer | `~/.claude/skills/security-analyzer/` | OWASP scanning |
| UI UX Pro Max | `~/.claude/skills/ui-ux-pro-max/` | Advanced UI gen |
| prd2build | `~/.claude/commands/prd2build.md` | PRD → Code workflow |
| uv | `~/.local/bin/uv` | Fast Python package manager |
| Spec-Kit | `specify` CLI | Requirements management |

### Configuration (Steps 10-11, 14)
| Config | Location | Purpose |
|--------|----------|---------|
| MCP Servers | `~/.config/claude/mcp.json` | claude-flow, agentic-qe |
| Codex Profile | `~/.codex/instructions.md` | Codex Claude instructions |
| AGENTS.md | `./AGENTS.md` | Codex/Claude protocol |
| TypeScript | `./tsconfig.json` | ES2022, ESNext modules |
| Tailwind | `./tailwind.config.js` | HeroUI plugin configured |
| PostCSS | `./postcss.config.js` | Tailwind processing |

### Frontend Stack (Step 11)
| Package | Purpose |
|---------|---------|
| `@heroui/react` | UI component library |
| `framer-motion` | Animation library |
| `tailwindcss` | Utility CSS framework |
| `postcss` | CSS processing |
| `autoprefixer` | CSS vendor prefixes |

### Bash Aliases (Step 15)
All aliases installed in `~/.bashrc` — see Command Reference below.

---

## Status Check

```bash
turbo-status          # Check all installations
turbo-help            # Show this reference
ruvector-status       # Check RuVector + hooks
codex-check           # Check Codex setup (optional)
```

---

## Command Reference

### Claude Code

```bash
claude                # Start Claude Code
dsp                   # Start with skip permissions
```

**Slash commands (inside Claude Code):**
```
/prd2build prd.md           # Generate docs from PRD
/prd2build prd.md --build   # Generate docs + execute build
```

### Claude Flow V3

```bash
# Setup
cf-init               # Initialize workspace
cf-list               # List 54+ available agents
cf-daemon             # Start background daemon

# Agents
cf-agent architect "Create ADR for authentication"
cf-agent coder "Implement user service"
cf-agent tester "Generate unit tests"
cf-agent security-architect "Review security patterns"
cf-agent code-analyzer "Model bounded contexts"

# Swarms
cf-swarm              # Hierarchical (boss/workers)
cf-mesh               # Mesh (peer-to-peer)

# Memory
cf-memory status      # Check memory system
cf-memory search "query"  # Search patterns

# Security
cf-security           # Run security scan

# MCP
cf-mcp                # Start MCP server
```

### RuVector (Neural Engine)

```bash
# Setup
ruv                   # Start RuVector
ruv-init              # Initialize hooks
ruvector-status       # Full status check

# Learning Stats
ruv-stats             # View learning statistics

# Task Routing
ruv-route "task"      # Get agent recommendation

# Semantic Memory
ruv-remember -t edit "description"   # Store pattern
ruv-recall "query"                   # Search memory
ruv-learn                            # Record trajectory
```

**Memory Types for `ruv-remember`:**
- `-t edit` — Code changes
- `-t architecture` — Design patterns
- `-t decision` — ADR decisions
- `-t reference` — Documentation links
- `-t optimization` — Performance patterns

### Specifications

**Spec-Kit:**
```bash
sk-here               # Init in current directory
specify list          # List requirements
specify add "req"     # Add requirement
specify check         # Validate specs
```

**OpenSpec:**
```bash
os-init               # Initialize
openspec tree         # Visualize spec tree
openspec generate     # Generate from specs
```

### Testing (Agentic QE)

```bash
aqe-generate          # Generate tests
aqe-gate              # Run quality gate
```

**Quality Gate Checks:**
- Test coverage ≥80%
- Critical vulnerabilities = 0
- Type errors = 0
- Build success

### Browser Automation (Agent Browser)

```bash
ab-open <url>         # Open URL in browser
ab-snap               # Get accessibility snapshot
ab-click @ref         # Click element by reference
ab-fill @ref "text"   # Fill input field
ab-close              # Close browser
```

**Example Flow:**
```bash
ab-open "http://localhost:3000/login"
ab-snap
ab-fill @email "test@example.com"
ab-fill @password "password123"
ab-click @submit
ab-snap
ab-close
```

### Frontend (HeroUI + Tailwind)

**Import Components:**
```jsx
import { Button, Card, Input, Modal, Table, Tabs } from "@heroui/react";
import { motion } from "framer-motion";
```

**Quick Example:**
```jsx
<Card className="p-6">
  <Input label="Email" type="email" />
  <Button color="primary">Submit</Button>
</Card>
```

### Codex (Optional)

```bash
# Setup (manual)
npm install -g @openai/codex
codex login

# Commands
codex-check           # Check setup status
codex-run "task"      # Run with Claude profile
```

**Task Allocation (AGENTS.md):**
| Task | Codex | Claude |
|------|-------|--------|
| Code changes | ✅ | ❌ |
| GitHub/CI admin | ❌ | ✅ |
| Secrets/tokens | ❌ | ✅ |

---

## Key Paths

| Path | Contents |
|------|----------|
| `~/.claude/commands/` | Custom slash commands (prd2build) |
| `~/.claude/skills/` | Installed skills (agent-browser, security-analyzer, ui-ux-pro-max) |
| `~/.config/claude/mcp.json` | MCP server config |
| `~/.codex/` | Codex configuration |
| `.claude-flow/` | Project Claude Flow config |
| `.specify/` | Spec-Kit database |
| `.ruvector/` | RuVector hooks data |

---

## Project Structure

```
project/
├── src/                  # Source code
│   └── index.css         # Tailwind imports
├── tests/                # Test files
├── docs/
│   ├── specification/    # Requirements, stories, API
│   ├── ddd/              # Bounded contexts, aggregates
│   ├── adr/              # Architecture decisions
│   └── implementation/   # INDEX.md (traceability)
├── plans/                # Research plans
├── scripts/              # Utility scripts
├── config/               # Configuration
├── .claude-flow/         # Claude Flow V3 config
├── .specify/             # Spec-Kit database
├── .ruvector/            # RuVector hooks data
├── AGENTS.md             # Codex/Claude protocol
├── CLAUDE.md             # Project context
├── openspec.yaml         # API specifications
├── tailwind.config.js    # Tailwind + HeroUI
├── postcss.config.js     # PostCSS config
├── tsconfig.json         # TypeScript config
└── package.json          # Dependencies (type: "module")
```

---

## MCP Servers

Configured in `~/.config/claude/mcp.json`:

| Server | Command | Purpose |
|--------|---------|---------|
| `claude-flow` | `npx -y claude-flow@v3alpha mcp start` | 175+ orchestration tools |
| `agentic-qe` | `npx -y aqe-mcp` | Testing tools |

---

## Typical Workflow

```bash
# 1. Setup (one-time)
source ~/.bashrc
turbo-status

# 2. Initialize project
claude
cf-init
sk-here
ruv-init

# 3. Define specs
# In Claude Code: "Extract requirements from prd.md to Spec-Kit"

# 4. Architecture
cf-agent architect "Create ADRs for the system"
cf-agent code-analyzer "Define DDD bounded contexts"

# 5. Build
/prd2build prd.md --build
# Or: cf-swarm then "Implement the system"

# 6. Test
aqe-generate
aqe-gate
cf-security

# 7. E2E Test
ab-open "http://localhost:3000"
ab-snap
# ... test flow ...
ab-close

# 8. Document
# In Claude Code: "Generate documentation with prd2build"
```

---

## Quick Troubleshooting

| Issue | Fix |
|-------|-----|
| Commands not found | `source ~/.bashrc` |
| MCP not working | Check `~/.config/claude/mcp.json` |
| RuVector errors | `ruv-init` to reinitialize |
| Claude Flow issues | `cf-init` to reinitialize |
| Agent Browser fails | `agent-browser install --with-deps` |

---

## Resources

| Resource | URL |
|----------|-----|
| RuVector | github.com/ruvnet/ruvector |
| Claude Flow | github.com/ruvnet/claude-flow |
| Turbo Flow | github.com/marcuspat/turbo-flow-claude |
| HeroUI | heroui.com |
| Tailwind | tailwindcss.com |
| Security Analyzer | github.com/Cornjebus/security-analyzer |
| Spec-Kit | github.com/github/spec-kit |

---

**Version:** 2.0.1 | **Updated:** 2026-01-21
