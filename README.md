# Turbo Flow Claude v2.0.1

**Agentic Development Environment — Claude Flow V3 + RuVector**

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    TURBO FLOW v2.0.1                            │
├─────────────────────────────────────────────────────────────────┤
│  INTERFACE: Claude Code (CLI) │ Dev-Browser │ HeroUI            │
├─────────────────────────────────────────────────────────────────┤
│  NEURAL ENGINE: RuVector                                        │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐   │
│  │  SONA   │ │  HNSW   │ │   MoE   │ │  EWC++ │ │   GNN   │   │
│  │<0.05ms  │ │  150x   │ │8 experts│ │95% keep│ │ layers  │   │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘   │
├─────────────────────────────────────────────────────────────────┤
│  ORCHESTRATION: Claude Flow V3                                  │
│  54+ Native Agents │ Unified MCP │ Background Workers           │
├─────────────────────────────────────────────────────────────────┤
│  TESTING: Agentic QE (19 agents) │ Playwriter (AI tests)        │
├─────────────────────────────────────────────────────────────────┤
│  SECURITY: Security Analyzer │ Codex Integration                │
├─────────────────────────────────────────────────────────────────┤
│  SPECS: Spec-Kit │ OpenSpec                                     │
└─────────────────────────────────────────────────────────────────┘
```

---

## Quick Start

### DevPod

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

---

## What Gets Installed

The `setup.sh` script installs and configures the complete Turbo Flow stack in 15 automated steps:

### Step 1: Build Tools
| Package | Purpose |
|---------|---------|
| `build-essential` | C/C++ compiler toolchain (gcc, g++, make) |
| `python3` | Python runtime for scripts |
| `git` | Version control |
| `curl` | HTTP client for downloads |

### Step 2: Node.js Runtime
| Package | Version | Purpose |
|---------|---------|---------|
| `Node.js` | 20 LTS | JavaScript runtime |
| `n` | latest | Node version manager (for upgrades) |

### Step 3: Cache Cleanup
- Clears npm lock files and npx cache
- Ensures clean installation state

### Step 4: RuVector Neural Engine
| Package | npm Name | Purpose |
|---------|----------|---------|
| RuVector Core | `ruvector` | Vector DB + GNN + self-learning neural engine |
| SONA | `@ruvector/sona` | Self-Optimizing Neural Architecture (<0.05ms adaptation) |
| RuVector CLI | `@ruvector/cli` | Hooks and intelligence integration for Claude Code |

**Post-install:** Initializes RuVector hooks via `npx @ruvector/cli hooks init`

### Step 5: Claude Flow V3
| Package | npm Name | Purpose |
|---------|----------|---------|
| Claude Flow | `claude-flow@v3alpha` | Agent orchestration (175+ MCP tools, 54+ agents) |

**Post-install:** Creates `.claude-flow/` directory with `config.json`

### Step 6: Core npm Packages
| Package | npm Name | Purpose |
|---------|----------|---------|
| Claude Code | `@anthropic-ai/claude-code` | Anthropic's AI coding CLI |
| Agentic QE | `agentic-qe` | Testing pipeline (19 agents) |
| OpenSpec | `@fission-ai/openspec` | API specification workflow |
| UI Pro CLI | `uipro-cli` | UI generation command line tool |
| Agent Browser | `agent-browser` | Chromium automation for testing |
| Claude Flow Browser | `@claude-flow/browser` | Browser integration for Claude Flow |

### Step 7: Agent Browser Setup
| Component | Purpose |
|-----------|---------|
| Chromium | Headless browser for automation |
| Agent Browser Skill | Claude skill for browser automation |

**Skill Location:** `~/.claude/skills/agent-browser/`

### Step 8: Security Analyzer Skill
| Component | Source | Purpose |
|-----------|--------|---------|
| Security Analyzer | `github.com/Cornjebus/security-analyzer` | OWASP Top 10 vulnerability scanning |

**Skill Location:** `~/.claude/skills/security-analyzer/`

### Step 9: uv & Spec-Kit
| Package | Purpose |
|---------|---------|
| `uv` | Fast Python package manager (Astral) |
| `specify-cli` | Spec-Kit requirements management |

**Install Source:** `git+https://github.com/github/spec-kit.git`

### Step 10: MCP Configuration
Creates `~/.config/claude/mcp.json` with:
| Server | Command | Purpose |
|--------|---------|---------|
| `claude-flow` | `npx -y claude-flow@v3alpha mcp start` | Orchestration tools |
| `agentic-qe` | `npx -y aqe-mcp` | Testing tools |

### Step 11: Workspace Setup
| Component | Purpose |
|-----------|---------|
| `package.json` | Initialized with `type: "module"` |
| Directory structure | `src/`, `tests/`, `docs/`, `scripts/`, `config/`, `plans/` |
| `tsconfig.json` | TypeScript configuration (ES2022, ESNext modules) |
| HeroUI | `@heroui/react`, `framer-motion` |
| Tailwind CSS | `tailwindcss`, `postcss`, `autoprefixer` |
| `tailwind.config.js` | Pre-configured with HeroUI plugin |
| `postcss.config.js` | PostCSS configuration |
| `src/index.css` | Tailwind directives |

### Step 12: UI UX Pro Max Skill
| Component | Purpose |
|-----------|---------|
| UI UX Pro Max | Advanced UI generation skill for Claude |

**Skill Location:** `~/.claude/skills/ui-ux-pro-max/` or `.claude/skills/ui-ux-pro-max/`

### Step 13: prd2build Command
| Component | Purpose |
|-----------|---------|
| `prd2build.md` | Slash command for PRD → Implementation workflow |

**Command Location:** `~/.claude/commands/prd2build.md`

### Step 14: Codex Configuration (Optional)
| Component | Purpose |
|-----------|---------|
| `~/.codex/` | Codex configuration directory |
| `~/.codex/instructions.md` | Claude profile for Codex |
| `AGENTS.md` | Codex/Claude collaboration protocol |

**Note:** Codex itself (`@openai/codex`) requires manual installation

### Step 15: Bash Aliases
Installs comprehensive aliases in `~/.bashrc`:

**RuVector Aliases:**
| Alias | Command | Purpose |
|-------|---------|---------|
| `ruv` | `npx ruvector` | Start RuVector |
| `ruv-stats` | `npx @ruvector/cli hooks stats` | Show learning statistics |
| `ruv-route` | `npx @ruvector/cli hooks route` | Route task to best agent |
| `ruv-remember` | `npx @ruvector/cli hooks remember` | Store in semantic memory |
| `ruv-recall` | `npx @ruvector/cli hooks recall` | Search semantic memory |
| `ruv-learn` | `npx @ruvector/cli hooks learn` | Record learning trajectory |
| `ruv-init` | `npx @ruvector/cli hooks init` | Initialize hooks |
| `ruvector-status` | Combined status check | Full RuVector status |

**Claude Code Aliases:**
| Alias | Command | Purpose |
|-------|---------|---------|
| `dsp` | `claude --dangerously-skip-permissions` | Skip permissions mode |

**Claude Flow V3 Aliases:**
| Alias | Command | Purpose |
|-------|---------|---------|
| `cf` | `npx -y claude-flow@v3alpha` | Base command |
| `cf-init` | `... init --force` | Initialize workspace |
| `cf-swarm` | `... swarm init --topology hierarchical` | Hierarchical swarm |
| `cf-mesh` | `... swarm init --topology mesh` | Mesh swarm |
| `cf-agent` | `... --agent` | Run specific agent |
| `cf-list` | `... --list` | List agents |
| `cf-daemon` | `... daemon start` | Start background daemon |
| `cf-memory` | `... memory` | Memory operations |
| `cf-memory-status` | `... memory status` | Check memory system |
| `cf-security` | `... security scan` | Run security scan |
| `cf-mcp` | `... mcp start` | Start MCP server |

**Testing Aliases:**
| Alias | Command | Purpose |
|-------|---------|---------|
| `aqe` | `npx -y agentic-qe` | Agentic QE base |
| `aqe-generate` | `... generate` | Generate tests |
| `aqe-gate` | `... gate` | Quality gate |

**Agent Browser Aliases:**
| Alias | Command | Purpose |
|-------|---------|---------|
| `ab` | `agent-browser` | Base command |
| `ab-open` | `agent-browser open` | Open URL |
| `ab-snap` | `agent-browser snapshot -i` | Accessibility snapshot |
| `ab-click` | `agent-browser click` | Click element |
| `ab-fill` | `agent-browser fill` | Fill input |
| `ab-close` | `agent-browser close` | Close browser |

**Spec Aliases:**
| Alias | Command | Purpose |
|-------|---------|---------|
| `sk` | `specify` | Spec-Kit base |
| `sk-here` | `specify init . --ai claude` | Init in current dir |
| `os` | `openspec` | OpenSpec base |
| `os-init` | `openspec init` | Initialize OpenSpec |

**Codex Aliases:**
| Alias | Command | Purpose |
|-------|---------|---------|
| `codex-login` | `codex login` | Authenticate |
| `codex-run` | `codex exec -p claude` | Run with Claude profile |
| `codex-check` | Function | Check setup status |

**Utility Functions:**
| Function | Purpose |
|----------|---------|
| `turbo-status` | Check all tool installations |
| `turbo-help` | Quick reference guide |

---

## Directory Structure Created

```
~/.claude/
├── skills/
│   ├── agent-browser/      # Browser automation skill
│   ├── security-analyzer/  # Security scanning skill
│   └── ui-ux-pro-max/      # UI generation skill
└── commands/
    └── prd2build.md        # PRD to build command

~/.config/claude/
└── mcp.json                # MCP server configuration

~/.codex/
└── instructions.md         # Codex Claude profile

/workspaces/turbo-flow-claude/
├── src/
│   └── index.css           # Tailwind imports
├── tests/
├── docs/
├── scripts/
├── config/
├── plans/
├── .claude-flow/
│   └── config.json         # Claude Flow config
├── .ruvector/              # RuVector hooks data
├── node_modules/
│   └── @heroui/            # HeroUI components
├── AGENTS.md               # Codex/Claude protocol
├── package.json            # type: "module"
├── tsconfig.json           # TypeScript config
├── tailwind.config.js      # Tailwind + HeroUI
└── postcss.config.js       # PostCSS config
```

---

## Post-Setup Manual Steps

1. **Reload Shell Aliases**
   ```bash
   source ~/.bashrc
   ```

2. **Verify Installation**
   ```bash
   turbo-status
   ```

3. **Playwriter Chrome Extension** (Optional)
   https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe

4. **Codex** (Optional)
   ```bash
   npm install -g @openai/codex
   codex login
   ```

---

## Key Commands

```bash
# Status
turbo-status              # Check all tools
turbo-help                # Quick reference

# RuVector
ruv                       # Start RuVector
ruv-stats                 # Show learning statistics
ruv-route "task"          # Route task to best agent
ruv-remember -t edit "X"  # Store in semantic memory
ruv-recall "query"        # Search semantic memory

# Claude Code
claude                    # Start Claude
dsp                       # Skip permissions mode

# Claude Flow V3
cf-init                   # Initialize workspace
cf-swarm                  # Hierarchical swarm
cf-mesh                   # Mesh swarm
cf-agent <type> "task"    # Run specific agent
cf-list                   # List agents
cf-security               # Security scan

# prd2build (in Claude Code)
/prd2build prd.md         # Generate docs from PRD
/prd2build prd.md --build # Generate docs + build

# Testing
aqe-generate              # Generate tests
aqe-gate                  # Quality gate

# Browser Automation
ab-open <url>             # Open URL
ab-snap                   # Get accessibility snapshot
ab-click @ref             # Click element
ab-fill @ref "text"       # Fill input
ab-close                  # Close browser
```

---

## Resources

| Resource | URL |
|----------|-----|
| RuVector | github.com/ruvnet/ruvector |
| RuVector npm | npmjs.com/package/ruvector |
| Claude Flow V3 | github.com/ruvnet/claude-flow |
| Turbo Flow Claude | github.com/marcuspat/turbo-flow-claude |
| Agentic QE | npmjs.com/package/agentic-qe |
| Playwriter | github.com/remorses/playwriter |
| HeroUI | heroui.com |
| Security Analyzer | github.com/Cornjebus/security-analyzer |
| Spec-Kit | github.com/github/spec-kit |

---

## ⭐ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=marcuspat/turbo-flow-claude&type=Date)](https://star-history.com/#marcuspat/turbo-flow-claude&Date)

---

**Version:** 2.0.1 | **Last Updated:** 2026-01-21
