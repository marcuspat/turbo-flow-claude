# 🚀 Turbo-Flow Claude v1.0.3 Alpha
## Advanced Agentic Development Environment

**DevPods • GitHub Codespaces • Google Cloud Shell**

[![DevPod](https://img.shields.io/badge/DevPod-Ready-blue?style=flat-square)](https://devpod.sh) [![Claude Flow](https://img.shields.io/badge/Claude%20Flow-SPARC-purple?style=flat-square)](https://github.com/ruvnet/claude-flow) [![Agents](https://img.shields.io/badge/Agents-600+-green?style=flat-square)](https://github.com/ChrisRoyse/610ClaudeSubagents) [![Spec-Kit](https://img.shields.io/badge/Spec--Kit-Enabled-orange?style=flat-square)](https://github.com/github/spec-kit)

---

## What's New in v1.0.3

- **Spec-Kit Integration** - GitHub's spec-driven development workflow (`/speckit.*` commands)
- **AI Agent Skills** - 38+ installable skills for Claude Code via `ai-agent-skills`
- **n8n-MCP Server** - Build n8n workflows with AI assistance
- **PAL MCP Server** - Multi-model AI orchestration (Gemini + GPT + Grok + Ollama)
- **Skills-Based Architecture** - Claude Code now uses skills; wrapper scripts removed
- **Dynamic CLAUDE.md** - Generated from specs instead of pre-loaded

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
| Agentic Flow | `af`, `af-run` | Agent workflow automation |
| Agentic QE | `aqe` | AI-powered testing framework |
| Agentic Jujutsu | `aj` | Git operations assistant |
| Claude Usage | `cu` | API usage tracking |

### New in v1.0.3
| Tool | Alias | Description |
|------|-------|-------------|
| Spec-Kit | `sk`, `sk-init`, `sk-here` | Spec-driven development from GitHub |
| AI Agent Skills | `skills`, `skills-list` | 38+ skills for Claude/Cursor/Codex |
| n8n-MCP | `n8n-mcp` | n8n workflow automation via MCP |
| PAL MCP | `pal` | Multi-model AI (Gemini, GPT, Grok, Ollama) |

### MCP Servers (Auto-Configured)
- Playwright MCP - Browser automation
- Chrome DevTools MCP - Chrome integration
- n8n-MCP - Workflow automation

### Resources
- **600+ AI Agents** - Specialized subagents for any task
- **TypeScript Setup** - Pre-configured with tsconfig.json
- **Project Structure** - src/, tests/, docs/, scripts/, examples/, config/

---

## 🎯 Recommended Workflow

### Spec-Driven Development (New)

```bash
# 1. Initialize spec-kit in your project
sk-here                              # or: specify init . --ai claude

# 2. Start Claude Code
claude

# 3. Follow the spec-kit workflow
/speckit.constitution               # Define project principles
/speckit.specify                    # Write specifications  
/speckit.plan                       # Create implementation plan
/speckit.tasks                      # Break down into tasks
/speckit.implement                  # Build it

# 4. Generate CLAUDE.md from your specs
generate-claude-md
```

### Multi-Model AI with PAL

```bash
# Edit PAL config with your API keys
nano ~/.pal-mcp-server/.env

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
```

---

## 📋 All Available Aliases

```bash
# Claude Code
claude                    # Start Claude Code
dsp                       # claude --dangerously-skip-permissions

# Claude Flow
cf                        # Claude Flow base command
cf-init                   # Initialize claude-flow
cf-swarm "task"           # Run swarm with task
cf-hive "task"            # Spawn hive-mind agents
cf-spawn                  # Spawn hive-mind
cf-status                 # Check hive-mind status
cf-help                   # Show help

# Agentic Tools
af                        # Agentic Flow
af-run                    # Run with agent
af-coder                  # Run coder agent
aqe                       # Agentic QE testing
aj                        # Agentic Jujutsu (git)
cu                        # Claude usage stats

# Spec-Kit
sk                        # Specify CLI
sk-init                   # Initialize new project
sk-check                  # Check installed tools
sk-here                   # Init in current directory with Claude

# AI Agent Skills
skills                    # Base command
skills-list               # List all 38+ skills
skills-search "query"     # Search skills
skills-install <name>     # Install a skill
skills-info <name>        # Get skill details

# MCP Servers
n8n-mcp                   # n8n workflow MCP
pal                       # PAL multi-model MCP
mcp-playwright            # Playwright MCP
mcp-chrome                # Chrome DevTools MCP

# Helper Functions
cf-task "task"            # Quick swarm task
af-task "agent" "task"    # Quick agentic task
generate-claude-md        # Generate CLAUDE.md from specs
```

---

## 📁 Project Structure

```
/workspaces/turbo-flow-claude/
├── agents/                 # 600+ AI agent definitions
├── src/                    # Source code
├── tests/                  # Test files
├── docs/                   # Documentation
├── scripts/                # Utility scripts
├── examples/               # Example code
├── config/                 # Configuration files
├── .specify/               # Spec-kit specs (after sk-here)
├── package.json            # Node.js config (ES modules)
├── tsconfig.json           # TypeScript config
└── CLAUDE.md               # Generated from specs
```

---

## 🔧 Configuration

### PAL MCP (Multi-Model AI)
Edit `~/.pal-mcp-server/.env`:
```bash
GEMINI_API_KEY=your-key      # Google Gemini
OPENAI_API_KEY=your-key      # GPT-5, O3
OPENROUTER_API_KEY=your-key  # 50+ models
XAI_API_KEY=your-key         # Grok
```

### n8n-MCP
For workflow management, add to your n8n instance:
```bash
N8N_API_URL=https://your-n8n.com
N8N_API_KEY=your-api-key
```

### MCP Servers
Auto-configured at `~/.config/claude/mcp.json`

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
```

### Permission Issues
```bash
sudo chown -R $(whoami):staff ~/.devpod
```

### Reload Aliases
```bash
source ~/.bashrc
```

---

## 📚 Resources

- [Spec-Kit Documentation](https://github.com/github/spec-kit) - Spec-driven development
- [AI Agent Skills](https://github.com/skillcreatorai/Ai-Agent-Skills) - Universal skill repository
- [n8n-MCP](https://github.com/czlonkowski/n8n-mcp) - n8n workflow automation
- [PAL MCP Server](https://github.com/BeehiveInnovations/pal-mcp-server) - Multi-model AI
- [Claude Flow](https://github.com/ruvnet/claude-flow) - AI orchestration
- [610 Claude Subagents](https://github.com/ChrisRoyse/610ClaudeSubagents) - Agent library
- [DevPod Documentation](https://devpod.sh/docs) - Dev environments as code

---

## 📦 Version History

### v1.0.3 Alpha (Current)
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

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=marcuspat/turbo-flow-claude&type=Date)](https://www.star-history.com/#marcuspat/turbo-flow-claude&Date)

---

**Ready to start?**
```bash
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```
