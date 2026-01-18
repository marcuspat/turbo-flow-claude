# 🚀 Turbo-Flow Claude v1.0.5 Alpha

**Advanced Agentic Development Environment**  
*DevPods • GitHub Codespaces • Google Cloud Shell*

[![DevPod](https://img.shields.io/badge/DevPod-Ready-blue)](https://devpod.sh)
[![Claude Flow](https://img.shields.io/badge/Claude%20Flow-Alpha-purple)](https://github.com/ruvnet/claude-flow)
[![Agents](https://img.shields.io/badge/Agents-610+-green)](https://github.com/ChrisRoyse/610ClaudeSubagents)
[![Spec-Kit](https://img.shields.io/badge/Spec--Kit-Enabled-orange)](https://github.com/github/spec-kit)

---

## What's New in v1.0.5

- ✅ **Fixed Claude Flow Initialization** - Now initializes in correct workspace directory (v9 script fixes)
- ✅ **agtrace** - AI agent observability with live dashboard and MCP integration
- ✅ **Claudish** - Multi-model proxy supporting 100+ models via OpenRouter
- ✅ **OpenSpec** - Spec-driven development from Fission AI
- ✅ **Enhanced Playwright MCP** - 143+ device emulation, cross-browser testing
- ✅ **Chrome DevTools MCP** - Full DevTools access with performance tracing
- ✅ **Improved Reliability** - Synchronous npm cache clean, preserved npx cache, absolute path checks
- ✅ **Better Status Reporting** - Shows actual initialization status with fix commands if needed
- ✅ **Spec-Kit Integration** - GitHub's spec-driven development workflow (`/speckit.*` commands)
- ✅ **AI Agent Skills** - 38+ installable skills for Claude Code via `ai-agent-skills`
- ✅ **n8n-MCP Server** - Build n8n workflows with AI assistance
- ✅ **PAL MCP Server** - Multi-model AI orchestration (Gemini + GPT + Grok + Ollama)
- ✅ **Skills-Based Architecture** - Claude Code now uses skills; wrapper scripts removed
- ✅ **Dynamic CLAUDE.md** - Generated from specs instead of pre-loaded

---

## ⚡ Quick Start

### DevPod

```bash
# Install DevPod
# macOS: brew install loft-sh/devpod/devpod 
# Windows: choco install devpod
# Linux: curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" && sudo install devpod /usr/local/bin

# Launch workspace
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

### GitHub Codespaces

See [github_codespaces_setup.md](github_codespaces_setup.md)

### Google Cloud Shell

See [google_cloud_shell_setup.md](google_cloud_shell_setup.md)

---

## 🛠️ What Gets Installed

### Core Tools

| Tool | Alias | Description |
|------|-------|-------------|
| Claude Code | `claude`, `dsp` | Anthropic's AI coding CLI |
| Claude Flow | `cf`, `cf-swarm`, `cf-hive` | AI orchestration with SPARC methodology |
| Agentic Flow | `af`, `af-run`, `af-coder` | Self-learning agent workflows (66 agents, 213 MCP tools) |
| Agentic QE | `aqe`, `aqe-mcp` | AI-powered testing (19 agents, 11 TDD subagents) |
| Agentic Jujutsu | `aj` | AI-enhanced version control (23x faster than Git) |
| Claude Usage | `cu`, `claude-usage` | API usage tracking |
| Claudish | `claudish` | Multi-model proxy (100+ models via OpenRouter) |

### New in v1.0.5

| Tool | Alias | Description |
|------|-------|-------------|
| Spec-Kit | `sk`, `sk-here`, `sk-check` | Spec-driven development from GitHub |
| OpenSpec | `os`, `os-init`, `os-list` | Spec-driven development from Fission AI |
| AI Agent Skills | `skills-list`, `skills-install` | 38+ skills for Claude/Cursor/Codex/Amp |
| n8n-MCP | `n8n-mcp` | n8n workflow automation (543 nodes) |
| PAL MCP | `pal`, `pal-setup` | Multi-model AI (Gemini, GPT, Grok, Ollama) |
| agtrace | `agt-watch`, `agt-sessions` | AI agent observability with live TUI dashboard |

### MCP Servers (Auto-Configured)

| Server | Alias | Description |
|--------|-------|-------------|
| Playwright MCP | `mcp-playwright` | Browser automation (143+ devices, cross-browser) |
| Chrome DevTools MCP | `mcp-chrome` | Full DevTools access (24+ tools, performance tracing) |
| n8n-MCP | `n8n-mcp` | Workflow automation (543 nodes, 2,646 examples) |
| PAL MCP | `pal` | Multi-model AI orchestration |
| agtrace MCP | `agt-mcp` | Agent self-reflection and history queries |

### Resources

- **610+ AI Agents** - Specialized subagents for any task (422 non-coding, 188 coding)
- **TypeScript Setup** - Pre-configured with `tsconfig.json`
- **Project Structure** - `src/`, `tests/`, `docs/`, `scripts/`, `examples/`, `config/`

---

## 🎯 Recommended Workflow

### Spec-Driven Development

```bash
# 1. Initialize spec-kit in your project
sk-here                              # or: specify init . --ai claude

# 2. Generate CLAUDE.md (dynamic project context)
./devpods/generate-claude-md.sh      # or: generate-claude-md

# 3. Start Claude Code
claude

# 4. Follow the spec-kit workflow
/speckit.constitution               # Define project principles
/speckit.specify                    # Write specifications  
/speckit.plan                       # Create implementation plan
/speckit.tasks                      # Break down into tasks
/speckit.implement                  # Build it

# 5. Regenerate CLAUDE.md after spec changes
generate-claude-md                   # Updates with latest specs
```

### OpenSpec Workflow

```bash
# 1. Initialize OpenSpec
os-init

# 2. Create a change proposal
claude
> "/openspec:proposal Add OAuth authentication"

# 3. Review and iterate
os-show add-oauth
os-validate add-oauth

# 4. Apply when ready
> "/openspec:apply add-oauth"

# 5. Archive completed change
os-archive add-oauth
```

### Multi-Model AI with PAL

```bash
# Setup PAL (first time only)
pal-setup                           # Installs dependencies

# Edit PAL config with your API keys
nano ~/.pal-mcp-server/.env

# Start PAL server
pal

# Use PAL for multi-model collaboration in Claude:
# "Use pal to analyze this with gemini pro and o3"
# "Get consensus from multiple models on this approach"
```

### Multi-Model with Claudish

```bash
# Set API key
export OPENROUTER_API_KEY='sk-or-v1-...'

# Use different models
claudish --model x-ai/grok-code-fast-1 "fix the bug"
claudish --model google/gemini-2.5-flash "review this code"
claudish --model openai/gpt-5-codex "refactor the API"

# List available models
claudish --models
claudish --top-models
```

### Agent Observability with agtrace

```bash
# Initialize in your project
agtrace init

# Launch live dashboard (in separate terminal)
agtrace watch

# Browse session history
agtrace session list

# Search across sessions
agtrace lab grep "error"

# Let agents query their own history (add MCP)
claude mcp add agtrace -- agtrace mcp serve
```

### Agent Discovery

```bash
# Browse available skills
skills-list

# Install a skill
skills-install frontend-design

# Search for skills
skills-search "code review"

# Get skill details
skills-info frontend-design

# Install for different agents
skills-install frontend-design --agent cursor
skills-install frontend-design --agent vscode
```

---

## 📋 All Available Aliases

### Claude Code

```bash
claude                    # Start Claude Code
claude-hierarchical       # claude --dangerously-skip-permissions
dsp                       # claude --dangerously-skip-permissions (short)
```

### Claude Flow

```bash
cf                        # Claude Flow base command
cf-init                   # Initialize claude-flow (--force)
cf-swarm                  # Run swarm mode
cf-hive                   # Spawn hive-mind agents
cf-spawn                  # Spawn hive-mind (alias)
cf-status                 # Check hive-mind status
cf-help                   # Show help
cf-fix                    # Fix better-sqlite3 dependency
cf-task "task"            # Quick swarm task (function)
```

### Agentic Tools

```bash
af                        # Agentic Flow
af-run                    # Run with agent
af-coder                  # Run coder agent
af-help                   # Agentic Flow help
af-task "agent" "task"    # Quick agentic task (function)
aqe                       # Agentic QE testing
aqe-init                  # Initialize AQE
aqe-generate              # Generate tests
aqe-flaky                 # Hunt flaky tests
aqe-gate                  # Quality gate check
aqe-mcp                   # Agentic QE MCP server
aj                        # Agentic Jujutsu (git)
aj-status                 # Jujutsu status
aj-analyze                # Analyze repository
cu                        # Claude usage stats
claude-usage              # Claude usage stats (full)
```

### Spec-Kit

```bash
sk                        # Specify CLI
sk-init                   # Initialize new project
sk-check                  # Check installed tools
sk-here                   # Init in current directory with Claude
```

### OpenSpec

```bash
os                        # OpenSpec CLI
os-init                   # Initialize OpenSpec
os-list                   # List change proposals
os-show                   # Show specific change
os-validate               # Validate a change
os-archive                # Archive completed change
os-update                 # Update configurations
```

### AI Agent Skills

```bash
skills                    # Base command
skills-list               # List all 38+ skills
skills-search "query"     # Search skills
skills-install <name>     # Install a skill
skills-info <name>        # Get skill details
```

### agtrace (Observability)

```bash
agt                       # agtrace base command
agt-init                  # Initialize workspace
agt-watch                 # Live TUI dashboard
agt-sessions              # List sessions
agt-grep                  # Search across sessions
agt-mcp                   # Start MCP server
```

### MCP Servers

```bash
n8n-mcp                   # n8n workflow MCP
pal                       # Start PAL multi-model MCP server
pal-setup                 # Setup PAL dependencies (uv sync)
mcp-playwright            # Playwright MCP
mcp-chrome                # Chrome DevTools MCP
```

### Claudish (Multi-Model)

```bash
claudish                  # Interactive mode
claudish --models         # List available models
claudish --top-models     # Show recommended models
claudish-grok             # Use Grok model
claudish-gemini           # Use Gemini model
claudish-gpt              # Use GPT model
```

### Tmux

```bash
t                         # tmux
tn / tns                  # new / new-session -s
ta / tat                  # attach / attach -t
tl / tls                  # list sessions
tks                       # kill-session -t
tsh / tsv                 # split horizontal / vertical
```

### Helper Functions

```bash
cf-task "task"            # Quick swarm task
af-task "agent" "task"    # Quick agentic task with streaming
generate-claude-md        # Generate CLAUDE.md from project analysis
turbo-init                # Initialize all tools in new project
turbo-help                # Show quick reference
```

---

## 📁 Project Structure

```
/workspaces/turbo-flow-claude/
├── agents/                 # 610+ AI agent definitions
├── src/                    # Source code
├── tests/                  # Test files
├── docs/                   # Documentation
├── scripts/                # Utility scripts
├── examples/               # Example code
├── config/                 # Configuration files
├── devpods/                # DevPod setup scripts
│   ├── setup.sh            # Main setup script (v9)
│   └── generate-claude-md.sh  # CLAUDE.md generator script
├── openspec/               # OpenSpec specs (after os-init)
│   ├── specs/              # Current truth
│   └── changes/            # Proposed changes
├── .specify/               # Spec-kit specs (after sk-here)
├── .claude-flow/           # Claude Flow config (after cf-init)
├── package.json            # Node.js config (ES modules)
├── tsconfig.json           # TypeScript config
└── CLAUDE.md               # Generated project context for Claude
```

---

## 🔧 Configuration

### PAL MCP (Multi-Model AI)

Edit `~/.pal-mcp-server/.env`:

```bash
GEMINI_API_KEY=your-key      # Google Gemini
OPENAI_API_KEY=your-key      # GPT-4, GPT-5, O3
OPENROUTER_API_KEY=your-key  # 100+ models
XAI_API_KEY=your-key         # Grok
ANTHROPIC_API_KEY=your-key   # Claude (for PAL orchestration)
```

### Claudish

```bash
export OPENROUTER_API_KEY='sk-or-v1-...'
export CLAUDISH_MODEL='x-ai/grok-code-fast-1'  # Optional default
```

### n8n-MCP

```bash
N8N_API_URL=https://your-n8n.com
N8N_API_KEY=your-api-key
```

### MCP Servers

Auto-configured at `~/.config/claude/mcp.json`:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"]
    },
    "chrome-devtools": {
      "command": "npx",
      "args": ["chrome-devtools-mcp@latest"]
    },
    "n8n-mcp": {
      "command": "npx",
      "args": ["-y", "n8n-mcp"]
    },
    "agtrace": {
      "command": "agtrace",
      "args": ["mcp", "serve"]
    }
  }
}
```

---

## 🎛️ DevPod Management

```bash
# Create workspace
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode

# Stop (saves costs)
devpod stop turbo-flow-claude

# Resume
devpod up turbo-flow-claude --ide vscode

# Delete
devpod delete turbo-flow-claude --force

# List workspaces
devpod list
```

---

## 🌍 Cloud Providers

### DigitalOcean (Recommended)

```bash
devpod provider add digitalocean
devpod provider use digitalocean
devpod provider update digitalocean --option DIGITALOCEAN_ACCESS_TOKEN=your_token
devpod provider update digitalocean --option DROPLET_SIZE=s-4vcpu-8gb
```

### AWS

```bash
devpod provider add aws
devpod provider use aws
devpod provider update aws --option AWS_INSTANCE_TYPE=t3.medium
```

### Other Providers

See [devpod_provider_setup_guide.md](devpod_provider_setup_guide.md) for Azure, GCP, Rackspace, and local Docker setup.

---

## 🔧 Troubleshooting

### Verify Installation

```bash
# Check all tools
claude --version
specify check
skills-list
echo "Agents: $(ls -1 agents/*.md 2>/dev/null | wc -l)"

# Check Claude Flow initialization
ls -la .claude-flow/ 2>/dev/null || echo "Claude Flow not initialized"
```

### Claude Flow Not Initialized

If the setup summary shows `❌ not initialized` for Claude Flow:

```bash
source ~/.bashrc
cf-fix
npx -y claude-flow@alpha init --force
```

### Node.js Version < 20

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs
```

### Spec-Kit Not Found

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

### Permission Issues

```bash
sudo chown -R $(whoami):staff ~/.devpod
```

### Reload Aliases

```bash
source ~/.bashrc
```

### npm Lock Issues

```bash
rm -rf ~/.npm/_locks
```

### MCP Server Issues

```bash
# List registered servers
claude mcp list

# Remove and re-add
claude mcp remove n8n-mcp
claude mcp add n8n-mcp npx -y n8n-mcp
```

---

## 📚 Resources

- [Turbo Flow Claude](https://github.com/marcuspat/turbo-flow-claude) - This repository
- [Claude Flow](https://github.com/ruvnet/claude-flow) - AI orchestration
- [610 Claude Subagents](https://github.com/ChrisRoyse/610ClaudeSubagents) - Agent library
- [AI Agent Skills](https://github.com/skillcreatorai/Ai-Agent-Skills) - Universal skill repository
- [Spec-Kit](https://github.com/github/spec-kit) - Spec-driven development
- [OpenSpec](https://github.com/Fission-AI/OpenSpec) - Spec-driven development
- [PAL MCP Server](https://github.com/BeehiveInnovations/pal-mcp-server) - Multi-model AI
- [agtrace](https://github.com/lanegrid/agtrace) - Agent observability
- [Claudish](https://github.com/MadAppGang/claudish) - Multi-model proxy
- [n8n-MCP](https://www.npmjs.com/package/n8n-mcp) - n8n workflow automation
- [DevPod Documentation](https://devpod.sh/docs) - Dev environments as code

---

## 📦 Installation Summary

The setup script installs:

| Category | Count |
|----------|-------|
| npm global packages | 12 |
| npm local dev packages | 2 |
| Python tools | 2 |
| Shell tools | 1 |
| Git-cloned repos | 2 |
| AI skills | 3 |
| Config files created | 4 |
| Directories created | 9 |
| Bash aliases | 50+ |
| Helper functions | 5 |
| MCP registrations | 5 |

### Complete Package List

**npm global:**
- @anthropic-ai/claude-code
- claude-usage-cli
- agentic-qe
- agentic-flow
- agentic-jujutsu
- claudish
- @fission-ai/openspec
- ai-agent-skills
- n8n-mcp
- @playwright/mcp
- chrome-devtools-mcp
- @lanegrid/agtrace

**Python (via uv):**
- uv (package manager)
- specify-cli (spec-kit)

**Shell:**
- direnv

**Git cloned:**
- pal-mcp-server (~/.pal-mcp-server)
- 610ClaudeSubagents (agents/)

**Skills installed:**
- frontend-design
- mcp-builder
- code-review

---

## ⭐ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=marcuspat/turbo-flow-claude&type=Date)](https://star-history.com/#marcuspat/turbo-flow-claude&Date)

---

## Ready to start?

```bash
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```
