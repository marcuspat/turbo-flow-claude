# 🚀 Turbo-Flow Claude v1.0.4 Alpha

**Advanced Agentic Development Environment**  
*DevPods • GitHub Codespaces • Google Cloud Shell*

[![DevPod](https://img.shields.io/badge/DevPod-Ready-blue)](https://devpod.sh)
[![Claude Flow](https://img.shields.io/badge/Claude%20Flow-Alpha-purple)](https://github.com/anthropics/claude-flow)
[![Agents](https://img.shields.io/badge/Agents-610+-green)](https://github.com/ChrisRoyse/610ClaudeSubagents)
[![Spec-Kit](https://img.shields.io/badge/Spec--Kit-Enabled-orange)](https://github.com/github/spec-kit)

---

## What's New in v1.0.4

- ✅ **Fixed Claude Flow Initialization** - Now initializes in correct workspace directory (v7 script fixes)
- ✅ **Claudish** - Added Claude shell helper utilities
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
| Agentic Flow | `af`, `af-run`, `af-coder` | Agent workflow automation |
| Agentic QE | `aqe`, `aqe-mcp` | AI-powered testing framework |
| Agentic Jujutsu | `aj` | Git operations assistant |
| Claude Usage | `cu`, `claude-usage` | API usage tracking |
| Claudish | - | Claude shell helper utilities |

### New in v1.0.4

| Tool | Alias | Description |
|------|-------|-------------|
| Spec-Kit | `sk`, `sk-init`, `sk-check`, `sk-here` | Spec-driven development from GitHub |
| AI Agent Skills | `skills`, `skills-list`, `skills-search`, `skills-install`, `skills-info` | 38+ skills for Claude/Cursor/Codex |
| n8n-MCP | `n8n-mcp` | n8n workflow automation via MCP |
| PAL MCP | `pal`, `pal-setup` | Multi-model AI (Gemini, GPT, Grok, Ollama) |

### MCP Servers (Auto-Configured)

| Server | Alias | Description |
|--------|-------|-------------|
| Playwright MCP | `mcp-playwright` | Browser automation |
| Chrome DevTools MCP | `mcp-chrome` | Chrome integration |
| n8n-MCP | `n8n-mcp` | Workflow automation |
| PAL MCP | `pal` | Multi-model AI orchestration |

### Resources

- **610+ AI Agents** - Specialized subagents for any task
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

### Dynamic CLAUDE.md Generation

The `generate-claude-md.sh` script creates an optimized `CLAUDE.md` file by analyzing your project:

```bash
# Basic usage - generates CLAUDE.md in current directory
./devpods/generate-claude-md.sh

# Custom output location
./devpods/generate-claude-md.sh -o docs/CLAUDE.md

# Verbose mode - shows preview of generated file
./devpods/generate-claude-md.sh -v

# Show help
./devpods/generate-claude-md.sh -h
```

**What it detects:**
- Spec-kit specifications (`.specify/` directory)
- Project type (Node.js, Python, Rust, Go, etc.)
- Package manager (npm, yarn, pnpm, uv, pip, cargo)
- Frameworks (React, Vue, Next.js, FastAPI, etc.)
- Available scripts from package.json
- Directory structure
- CI/CD configuration
- Container setup (Docker, DevContainer)
- Git repository info

**Generated sections:**
- Project Overview (table with all detected attributes)
- Spec-Kit Specifications (full content from `.specify/`)
- Project Structure (directory tree)
- Available Scripts (from package.json)
- Development Commands (package manager specific)
- Coding Guidelines
- Instructions for Claude
- Available MCP Tools

### Multi-Model AI with PAL

```bash
# Setup PAL (first time only)
pal-setup                           # Installs dependencies

# Edit PAL config with your API keys
nano ~/.pal-mcp-server/.env

# Start PAL server
pal

# Use PAL for multi-model collaboration
# In Claude: "Use pal to analyze this with gemini pro and o3"
# In Claude: "Get consensus from multiple models on this approach"
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
aqe-mcp                   # Agentic QE MCP server
aj                        # Agentic Jujutsu (git)
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

### AI Agent Skills

```bash
skills                    # Base command
skills-list               # List all 38+ skills
skills-search "query"     # Search skills
skills-install <name>     # Install a skill
skills-info <name>        # Get skill details
```

### MCP Servers

```bash
n8n-mcp                   # n8n workflow MCP
pal                       # Start PAL multi-model MCP server
pal-setup                 # Setup PAL dependencies (uv sync)
mcp-playwright            # Playwright MCP
mcp-chrome                # Chrome DevTools MCP
```

### Helper Functions

```bash
cf-task "task"            # Quick swarm task
af-task "agent" "task"    # Quick agentic task with streaming
generate-claude-md        # Generate CLAUDE.md from project analysis
```

### Generate CLAUDE.md Script

```bash
./devpods/generate-claude-md.sh           # Generate CLAUDE.md
./devpods/generate-claude-md.sh -v        # Verbose mode with preview
./devpods/generate-claude-md.sh -o FILE   # Custom output path
./devpods/generate-claude-md.sh -h        # Show help
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
│   ├── setup.sh            # Main setup script (v7)
│   └── generate-claude-md.sh  # CLAUDE.md generator script
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
OPENROUTER_API_KEY=your-key  # 50+ models
XAI_API_KEY=your-key         # Grok
ANTHROPIC_API_KEY=your-key   # Claude (for PAL orchestration)
```

### n8n-MCP

For workflow management, set environment variables:

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
    "chrome-mcp": {
      "type": "streamable-http",
      "url": "http://127.0.0.1:12306/mcp"
    },
    "n8n-mcp": {
      "command": "npx",
      "args": ["-y", "n8n-mcp"],
      "env": {
        "MCP_MODE": "stdio",
        "LOG_LEVEL": "error"
      }
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
cd $WORKSPACE_FOLDER && npx -y claude-flow@alpha init --force
```

### Spec-Kit Not Found

If `specify` command is not found:

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

---

## 📚 Resources

- [Spec-Kit Documentation](https://github.com/github/spec-kit) - Spec-driven development
- [AI Agent Skills](https://github.com/anthropics/ai-agent-skills) - Universal skill repository
- [n8n-MCP](https://github.com/n8n-io/n8n-mcp) - n8n workflow automation
- [PAL MCP Server](https://github.com/BeehiveInnovations/pal-mcp-server) - Multi-model AI
- [Claude Flow](https://github.com/anthropics/claude-flow) - AI orchestration
- [610 Claude Subagents](https://github.com/ChrisRoyse/610ClaudeSubagents) - Agent library
- [DevPod Documentation](https://devpod.sh/docs) - Dev environments as code

---

## 📦 Version History

### v1.0.4 Alpha (Current)

- **Fixed** Claude Flow initialization (correct directory, no race conditions)
- **Added** Claudish shell helper
- **Added** `pal-setup` alias for PAL dependency installation
- **Added** `aqe-mcp` alias for Agentic QE MCP server
- **Added** `af-help` alias for Agentic Flow help
- **Added** `claude-hierarchical` as full alias for `dsp`
- **Improved** npm cache handling (synchronous, preserves npx cache)
- **Improved** Status reporting with actual initialization state
- **Improved** Error messages with manual fix commands

### v1.0.3 Alpha

- Added Spec-Kit for spec-driven development
- Added AI Agent Skills (38+ skills)
- Added n8n-MCP for workflow automation
- Added PAL MCP for multi-model AI
- Removed wrapper scripts (Claude Code is skills-based)
- CLAUDE.md now generated from specs
- 14-step optimized setup process

### v1.0.2 Alpha

- Initial Claude Flow integration
- 600+ AI agents
- SPARC methodology support

---

## 📊 Installation Summary

The setup script installs:

| Category | Count |
|----------|-------|
| npm global packages | 11 |
| npm local dev packages | 2 |
| Python tools | 2 |
| Shell tools | 1 |
| Git-cloned repos | 2 |
| AI skills | 3 |
| Config files created | 4 |
| Directories created | 9 |
| Bash aliases | 32 |
| Helper functions | 3 |
| MCP registrations | 4 |

### Complete Package List

**npm global:**
- @anthropic-ai/claude-code
- claude-usage-cli
- agentic-qe
- agentic-flow
- agentic-jujutsu
- claudish
- ai-agent-skills
- n8n-mcp
- @playwright/mcp
- chrome-devtools-mcp
- mcp-chrome-bridge

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
