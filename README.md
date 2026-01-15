# 🚀 Turbo-Flow Claude v1.0.6 Alpha

**Lean Agentic Development Environment — Powered by RuvVector**  
*DevPods • GitHub Codespaces • Google Cloud Shell*

[![DevPod](https://img.shields.io/badge/DevPod-Ready-blue)](https://devpod.sh)
[![Claude Flow v3](https://img.shields.io/badge/Claude%20Flow-v3%20RuvVector-purple)](https://github.com/ruvnet/claude-flow)
[![Lean Stack](https://img.shields.io/badge/Stack-Lean%2060%25%20Smaller-green)](https://github.com/marcuspat/turbo-flow-claude)
[![HeroUI](https://img.shields.io/badge/Frontend-HeroUI%20%2B%20Tailwind-cyan)](https://heroui.com)

---

## What's New in v1.0.6

### 🧠 **RuvVector Neural Engine**
- ✅ **Claude Flow v3** - Complete rewrite with self-learning neural capabilities
- ✅ **HNSW Vector Memory** - 150x faster pattern retrieval
- ✅ **SONA Self-Learning** - Adapts in <0.05ms, learns from every task
- ✅ **EWC++ Memory** - Prevents catastrophic forgetting
- ✅ **54+ Native Agents** - No more external agent libraries needed
- ✅ **Native Multi-Provider** - OpenAI, Google, Ollama built-in (no claudish/PAL needed)

### 🎯 **Lean Stack (60% Smaller)**
- ❌ **Removed**: claudish, PAL MCP, agtrace, n8n-mcp, chrome-devtools-mcp, @playwright/mcp
- ✅ **Single MCP**: Claude Flow v3 handles everything internally
- ✅ **4 npm packages** instead of 12
- ✅ **2 MCP registrations** instead of 5

### 🎨 **New Frontend Stack**
- ✅ **Playwriter** - AI generates Playwright tests from natural language
- ✅ **Dev-Browser** - Visual AI-powered development environment
- ✅ **HeroUI + Tailwind** - Modern, accessible component library
- ✅ **Security Analyzer** - Vulnerability scanning MCP

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    TURBO FLOW v1.0.6                            │
├─────────────────────────────────────────────────────────────────┤
│  INTERFACE LAYER                                                │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│  │ Claude Code │  │ Dev-Browser │  │   HeroUI    │             │
│  │    (CLI)    │  │  (Visual)   │  │ (Components)│             │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘             │
├─────────┴────────────────┴────────────────┴─────────────────────┤
│  ORCHESTRATION: Claude Flow v3 (RuvVector Neural Engine)        │
│  ┌────────────────────────────────────────────────────────────┐│
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐          ││
│  │  │  SONA   │ │  HNSW   │ │   MoE   │ │  EWC++ │          ││
│  │  │Learning │ │ Memory  │ │ Routing │ │No-Forget│          ││
│  │  └─────────┘ └─────────┘ └─────────┘ └─────────┘          ││
│  │  54+ Native Agents │ Native Multi-Provider Routing         ││
│  │  Single Unified MCP │ Background Workers (12 auto-trigger) ││
│  └────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────┤
│  TESTING LAYER                                                  │
│  ┌───────────────────────┐  ┌───────────────────────┐          │
│  │      Agentic QE       │  │      Playwriter       │          │
│  │ (19 agents, 11 TDD)   │  │ (AI test generation)  │          │
│  └───────────────────────┘  └───────────────────────┘          │
├─────────────────────────────────────────────────────────────────┤
│  SECURITY LAYER                                                 │
│  ┌───────────────────────┐  ┌───────────────────────┐          │
│  │  Security Analyzer    │  │    v3 AIDefence       │          │
│  │  (MCP scanning)       │  │  (runtime threats)    │          │
│  └───────────────────────┘  └───────────────────────┘          │
├─────────────────────────────────────────────────────────────────┤
│  SPEC LAYER                                                     │
│  ┌───────────────────────┐  ┌───────────────────────┐          │
│  │       Spec-Kit        │  │       OpenSpec        │          │
│  └───────────────────────┘  └───────────────────────┘          │
└─────────────────────────────────────────────────────────────────┘
```

---

## ⚡ Quick Start

### DevPod (Recommended)

```bash
# Install DevPod
# macOS: brew install loft-sh/devpod/devpod 
# Windows: choco install devpod
# Linux: curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" && sudo install devpod /usr/local/bin

# Launch workspace
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

### GitHub Codespaces

```bash
# Click "Code" → "Codespaces" → "Create codespace on main"
# Or use CLI:
gh codespace create -r marcuspat/turbo-flow-claude
```

### Manual Installation

```bash
git clone https://github.com/marcuspat/turbo-flow-claude
cd turbo-flow-claude
./devpods/setup.sh
source ~/.bashrc
```

---

## 🛠️ What Gets Installed

### Core Stack (Lean)

| Tool | Alias | Description |
|------|-------|-------------|
| Claude Code | `claude`, `dsp` | Anthropic's AI coding CLI |
| Claude Flow v3 | `cf`, `cf-swarm`, `cf-train` | RuvVector-powered orchestration (54+ agents, HNSW memory) |
| Agentic QE | `aqe`, `aqe-generate` | Best-in-class testing pipeline (19 agents, 11 TDD subagents) |
| AI Agent Skills | `skills-list` | 38+ installable skills for Claude Code |

### Frontend Stack

| Tool | Alias | Description |
|------|-------|-------------|
| Playwriter | `pw-test` | AI generates Playwright tests from natural language |
| Dev-Browser | `dev-browser` | Visual AI-powered development environment |
| HeroUI | (npm) | Modern React component library with Tailwind |
| Security Analyzer | `sec-audit` | Vulnerability scanning and security audits |

### Spec-Driven Development

| Tool | Alias | Description |
|------|-------|-------------|
| Spec-Kit | `sk`, `sk-here` | GitHub's spec-driven development |
| OpenSpec | `os`, `os-init` | Fission AI's spec workflow |

### MCP Configuration (Minimal)

Only **2 MCP servers** instead of 5:

```json
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@v3alpha", "mcp", "start"]
    },
    "agentic-qe": {
      "command": "npx",
      "args": ["-y", "aqe-mcp"]
    }
  }
}
```

Claude Flow v3's unified MCP handles Playwright, browser automation, and 170+ tools internally.

---

## 🎯 Workflows

### Claude Flow v3 (RuvVector)

```bash
# Initialize a swarm with hierarchical topology
cf-swarm

# Run specific agents
cf-agent coder --task "Implement user authentication"
cf-agent tester --task "Write tests for auth module"
cf-agent security-architect --task "Audit for vulnerabilities"

# Neural pattern training
cf-train                              # Train from codebase
cf-pretrain --model-type moe          # Bootstrap MoE routing

# Intelligent task routing (learns over time)
cf-route "optimize database queries"  # Routes to best agent

# Check v3 implementation status
cf-progress --detailed
```

### AI Test Generation (Playwriter)

```bash
# Generate Playwright test from description
pw-test "test that login fails with wrong password"

# Output: Full Playwright test file generated automatically

# Combine with Agentic QE
aqe-generate                          # Generate test suite
aqe-gate                              # Quality gate check
aqe-flaky                             # Hunt flaky tests
```

### Visual Development (Dev-Browser)

```bash
# Launch visual AI development environment
dev-browser

# Opens browser-based IDE with:
# - Live preview
# - AI assistance
# - HeroUI component library
```

### Security Workflow

```bash
# Full vulnerability scan
security-scan

# Claude Flow v3 integrated audit
sec-audit

# v3's AIDefence handles runtime threats automatically
```

### Spec-Driven Development

```bash
# Initialize specs
sk-here                               # Spec-Kit
os-init                               # OpenSpec

# Follow workflow
/speckit.constitution                 # Define principles
/speckit.specify                      # Write specs
/speckit.plan                         # Plan implementation
/speckit.implement                    # Build it
```

---

## 📋 All Aliases

### Claude Flow v3 (RuvVector)

```bash
# Core
cf                        # Base command
cf-init                   # Initialize workspace
cf-mcp                    # Start MCP server
cf-status                 # System status
cf-progress               # V3 implementation progress

# Swarm & Agents
cf-swarm                  # Init hierarchical swarm
cf-mesh                   # Init mesh topology
cf-agent <type>           # Run specific agent
cf-coder                  # Coder agent
cf-reviewer               # Code review agent
cf-tester                 # Testing agent
cf-security               # Security architect
cf-list                   # List all 54+ agents

# Neural (RuvVector)
cf-neural                 # Neural subsystem
cf-train                  # Train patterns
cf-patterns               # View learned patterns
cf-pretrain               # Bootstrap intelligence
cf-route "task"           # Intelligent routing
cf-memory                 # Search vector memory

# Workers & Hooks
cf-hooks                  # Hook system
cf-worker                 # Dispatch background worker
cf-daemon                 # Start background daemon

# Quick function
cf-task coder "implement X"  # Quick agent task
```

### Testing

```bash
# Agentic QE
aqe                       # Base command
aqe-init                  # Initialize
aqe-generate              # Generate tests
aqe-flaky                 # Hunt flaky tests
aqe-gate                  # Quality gate

# Playwriter
playwriter                # Interactive mode
pw-test "description"     # Generate test from description
```

### Frontend

```bash
dev-browser               # Launch visual dev
devb                      # Short alias
security-scan             # Vulnerability scan
sec-audit                 # Security audit
```

### Specs

```bash
# Spec-Kit
sk                        # Specify CLI
sk-here                   # Init in current dir
sk-check                  # Check installation

# OpenSpec
os                        # OpenSpec CLI
os-init                   # Initialize
os-list                   # List changes
os-validate               # Validate change
```

### Skills

```bash
skills                    # Base command
skills-list               # List 38+ skills
skills-install <name>     # Install skill
```

### Helper Functions

```bash
turbo-init                # Initialize full workspace
turbo-help                # Quick reference
turbo-status              # Check all tools
```

---

## 📁 Project Structure

```
/workspaces/turbo-flow-claude/
├── src/                    # Source code
├── tests/                  # Test files  
├── docs/                   # Documentation
├── scripts/                # Utility scripts
├── config/                 # Configuration
├── devpods/                # DevPod setup
│   └── setup.sh            # Main setup script (v10)
├── .claude-flow/           # Claude Flow v3 config
├── .specify/               # Spec-kit specs
├── openspec/               # OpenSpec specs
├── package.json            # Node.js (ES modules)
├── tsconfig.json           # TypeScript config
├── tailwind.config.js      # Tailwind CSS config
└── CLAUDE.md               # Generated project context
```

---

## 🔄 Migration from v1.0.5

### Removed (No Action Needed)

These were removed for leaner stack - Claude Flow v3 handles them internally:

| Removed | Replacement |
|---------|-------------|
| `claudish` | v3 native multi-provider routing |
| `pal-mcp-server` | v3 native multi-provider routing |
| `agtrace` | v3 statusline + metrics |
| `n8n-mcp` | v3 MCP integration |
| `@playwright/mcp` | v3 native browser automation |
| `chrome-devtools-mcp` | v3 native browser automation |
| `610ClaudeSubagents` | v3 has 54+ native agents |

### Updated Commands

| v1.0.5 | v1.0.6 |
|--------|--------|
| `cf-hive` | `cf-swarm` |
| `cf-spawn` | `cf-agent <type>` |
| `claudish --model X` | Built into v3 routing |
| `agt-watch` | `cf-progress` |

### New Commands

```bash
cf-train                  # Neural pattern training
cf-route "task"           # Intelligent routing
cf-pretrain               # Bootstrap intelligence
pw-test "description"     # AI test generation
dev-browser               # Visual development
sec-audit                 # Security audit
```

---

## 📊 v1.0.5 vs v1.0.6 Comparison

| Metric | v1.0.5 | v1.0.6 | Change |
|--------|--------|--------|--------|
| npm global packages | 12 | 4 | **-67%** |
| MCP registrations | 5 | 2 | **-60%** |
| Git clones | 2 | 3 | +50% (better tools) |
| Bash aliases | 50+ | 35 | **-30%** |
| Setup time | ~120s | ~80s | **-33%** |
| Native agents | 0 | 54+ | **+54** |
| Vector memory | None | HNSW 150x | **New** |
| Self-learning | None | SONA <0.05ms | **New** |

---

## 🔧 Troubleshooting

### Verify Installation

```bash
turbo-status              # Check all tools
```

### Claude Flow v3 Issues

```bash
# Re-initialize
cf-init

# Check progress
cf-progress --detailed

# Retrain neural patterns
cf-pretrain
```

### Playwriter Issues

```bash
# Reinstall
rm -rf ~/.playwriter
git clone https://github.com/remorses/playwriter ~/.playwriter
cd ~/.playwriter && npm install
```

### Dev-Browser Issues

```bash
# Reinstall
rm -rf ~/.dev-browser
git clone https://github.com/SawyerHood/dev-browser ~/.dev-browser
cd ~/.dev-browser && npm install
```

### Node.js < 20

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs
```

---

## 📚 Resources

### Core
- [Claude Flow v3](https://github.com/ruvnet/claude-flow) - RuvVector neural engine
- [Agentic QE](https://www.npmjs.com/package/agentic-qe) - Testing pipeline

### Frontend
- [Playwriter](https://github.com/remorses/playwriter) - AI test generation
- [Dev-Browser](https://github.com/SawyerHood/dev-browser) - Visual development
- [HeroUI](https://heroui.com) - Component library

### Security
- [Security Analyzer](https://github.com/Cornjebus/security-analyzer) - Vulnerability scanning

### Specs
- [Spec-Kit](https://github.com/github/spec-kit) - GitHub's spec-driven development
- [OpenSpec](https://github.com/Fission-AI/OpenSpec) - Fission AI's spec workflow

### Skills
- [AI Agent Skills](https://github.com/skillcreatorai/Ai-Agent-Skills) - Universal skill repository

---

## 📦 Installation Summary

| Category | Count |
|----------|-------|
| npm global packages | 4 |
| Git-cloned tools | 3 |
| Python tools (via uv) | 1 |
| MCP registrations | 2 |
| Bash aliases | 35 |
| Frontend packages | 4 |

### Complete Package List

**npm global:**
- @anthropic-ai/claude-code
- agentic-qe
- ai-agent-skills
- @fission-ai/openspec

**Git cloned:**
- playwriter (~/.playwriter)
- dev-browser (~/.dev-browser)
- security-analyzer (~/.security-analyzer)

**Python (via uv):**
- specify-cli (spec-kit)

**Frontend (local):**
- @heroui/react
- framer-motion
- tailwindcss
- autoprefixer

---

## Ready to start?

```bash
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

Then:

```bash
source ~/.bashrc
turbo-help
claude
```

---

<p align="center">
  <b>Turbo Flow v1.0.6</b> — Lean, Fast, Intelligent<br>
  Powered by RuvVector Neural Engine
</p>
