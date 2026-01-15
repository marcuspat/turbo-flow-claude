# Turbo Flow Claude v1.0.6

**Lean Agentic Development Environment — Powered by RuvVector**

DevPods • GitHub Codespaces • Google Cloud Shell

---

## What's New in v1.0.6

**RuvVector Neural Engine** — Self-learning vector database with GNN layers. Features SONA (<0.05ms adaptation), EWC++ (95%+ retention), HNSW (150x faster search), MoE (8 expert routing), and 39 attention mechanisms. Install: `npm install ruvector`

**RuvVector Intelligence Hooks** — Q-learning agent routing, semantic memory, error pattern learning, file sequence prediction, and swarm coordination. Integrates directly with Claude Code hooks.

**Lean Stack (60% Smaller)** — Removed redundant MCPs. Claude Flow v3 + RuvVector handles everything internally with only 7 npm packages and 2 MCP registrations.

**New Frontend Stack** — Playwriter (AI test generation), Dev-Browser (visual development), HeroUI + Tailwind, Security Analyzer.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    TURBO FLOW v1.0.6                            │
├─────────────────────────────────────────────────────────────────┤
│  INTERFACE: Claude Code (CLI) │ Dev-Browser │ HeroUI            │
├─────────────────────────────────────────────────────────────────┤
│  NEURAL ENGINE: RuvVector                                       │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐  │
│  │  SONA   │ │  HNSW   │ │   MoE   │ │  EWC++ │ │   GNN   │  │
│  │<0.05ms  │ │  150x   │ │8 experts│ │95% keep│ │ layers  │  │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘  │
├─────────────────────────────────────────────────────────────────┤
│  ORCHESTRATION: Claude Flow v3                                  │
│  54+ Native Agents │ Unified MCP │ Background Workers           │
├─────────────────────────────────────────────────────────────────┤
│  TESTING: Agentic QE (19 agents) │ Playwriter (AI tests)        │
├─────────────────────────────────────────────────────────────────┤
│  SECURITY: Security Analyzer │ v3 AIDefence                     │
├─────────────────────────────────────────────────────────────────┤
│  SPECS: Spec-Kit │ OpenSpec                                     │
└─────────────────────────────────────────────────────────────────┘
```

---

## Quick Start

### DevPod (Recommended)

```bash
# macOS
brew install loft-sh/devpod/devpod

# Windows
choco install devpod

# Linux
curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64"
sudo install devpod /usr/local/bin

# Launch workspace
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

### GitHub Codespaces

```bash
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

## Core Stack

| Tool | Alias | Description |
|------|-------|-------------|
| **RuvVector** | `ruv`, `ruv-*` | Vector DB + GNN + Self-learning neural engine |
| @ruvector/sona | (via ruv) | SONA self-learning (<0.05ms adaptation) |
| @ruvector/cli | `ruv-hooks` | Intelligence hooks for Claude Code |
| Claude Code | `claude`, `dsp` | Anthropic's AI coding CLI |
| Claude Flow v3 | `cf`, `cf-swarm` | Agent orchestration (54+ agents) |
| Agentic QE | `aqe`, `aqe-generate` | Testing pipeline (19 agents) |
| Playwriter | `pw-test` | AI generates Playwright tests |
| Dev-Browser | `dev-browser` | Visual AI development |
| Security Analyzer | `sec-audit` | Vulnerability scanning |
| Spec-Kit | `sk`, `sk-here` | Spec-driven development |
| OpenSpec | `os`, `os-init` | Fission AI's spec workflow |

---

## npm Packages Installed

```bash
# RuvVector Neural Engine
ruvector                  # Vector DB + GNN + everything
@ruvector/sona            # SONA self-learning
@ruvector/cli             # Hooks & intelligence

# Claude Code & Tools
@anthropic-ai/claude-code
agentic-qe
ai-agent-skills
@fission-ai/openspec
```

---

## MCP Configuration

Only 2 MCP servers (Claude Flow v3 handles 170+ tools internally):

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

---

## Key Aliases

```bash
# RuvVector
ruv                       # Start RuvVector (npx ruvector)
ruv-stats                 # Show learning statistics
ruv-route "task"          # Route task to best agent
ruv-remember -t edit "X"  # Store in semantic memory
ruv-recall "query"        # Search semantic memory
ruv-learn                 # Record learning trajectory
ruvector-status           # Check RuvVector status

# Claude Code
claude                    # Start Claude
dsp                       # Skip permissions mode

# Claude Flow v3 Core
cf-init                   # Initialize workspace
cf-swarm                  # Hierarchical swarm
cf-agent <type> "task"    # Run specific agent
cf-list                   # List 54+ agents

# Neural (via RuvVector)
cf-pretrain               # Bootstrap intelligence
cf-train                  # Train patterns
cf-route "task"           # Intelligent routing
cf-memory "query"         # Vector search

# Testing
aqe-generate              # Generate tests
aqe-gate                  # Quality gate
pw-test "description"     # AI test generation

# Specs
sk-here                   # Init Spec-Kit
os-init                   # Init OpenSpec

# Status
turbo-status              # Check all tools
turbo-help                # Quick reference
```

---

## Project Structure

```
/workspaces/turbo-flow-claude/
├── src/                    # Source code
├── tests/                  # Test files
├── plans/                  # Research and architecture
│   ├── research/           # Research documents
│   └── architecture/       # ADR documents
├── .claude-flow/           # Claude Flow v3 config
├── .ruvector/              # RuvVector hooks data
├── .specify/               # Spec-kit specs
├── openspec/               # OpenSpec specs
└── CLAUDE.md               # Generated project context
```

---

## Troubleshooting

```bash
turbo-status              # Check all tools
ruvector-status           # Check RuvVector
ruv-init                  # Re-initialize RuvVector hooks
cf-init                   # Re-initialize Claude Flow
cf-progress --detailed    # Check v3 progress
cf-pretrain               # Retrain neural patterns
```

---

## Resources

| Resource | URL |
|----------|-----|
| RuvVector | github.com/ruvnet/ruvector |
| RuvVector npm | npmjs.com/package/ruvector |
| Claude Flow v3 | github.com/ruvnet/claude-flow |
| Turbo Flow Claude | github.com/marcuspat/turbo-flow-claude |
| Agentic QE | npmjs.com/package/agentic-qe |
| Playwriter | github.com/remorses/playwriter |
| HeroUI | heroui.com |

---

**Turbo Flow v1.0.6** — Lean, Fast, Intelligent | Powered by RuvVector Neural Engine
