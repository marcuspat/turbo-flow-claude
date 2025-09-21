# 🚀 Turbo-Flow Claude v1.0.1 Alpha: 
# Advanced Agentic Development Environment

**Supporting Devpods, Github Codespaces, and more!**

**Features 600+ AI agents, Claude Flow, SPARC methodology, and automatic context loading!**


[![DevPod](https://img.shields.io/badge/DevPod-Ready-blue?style=flat-square)](https://devpod.sh) [![Claude Flow](https://img.shields.io/badge/Claude%20Flow-SPARC-purple?style=flat-square)](https://github.com/ruvnet/claude-flow) [![Agents](https://img.shields.io/badge/Agents-600+-green?style=flat-square)](https://github.com/ChrisRoyse/610ClaudeSubagents)

---

## ⚡ Quick Start Devpods

```bash
# 1. Install DevPod
# macOS: brew install loft-sh/devpod/devpod 
# Windows: choco install devpod
# Linux: curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" && sudo install devpod /usr/local/bin

# 2. Setup Devpod provider and configuration.

# 3. Launch workspace
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

That's it! You now have a cloud development environment ready to use.

---

## ⚡ Quick Start Codespaces

```bash

# 1. Create a new Codespace
# 2. Launch the Codespace in VS Code.
# 3. Upload the Codespace Boot Script and Run Script.

See the github_codespaces_setup.md in the root of this project.
```
---

## 🔧 The Magic: Automatic Context Loading

```bash
After setup, use these **enhanced commands** that automatically load context files:

### 🎯 **Main Commands**
```bash
cf-swarm "build a tic-tac-toe game"    # Swarm with auto-loaded context
cf-hive "create a REST API"            # Hive-mind with auto-loaded context  
cf "memory stats"                      # Any Claude Flow command with context
dsp                                    # claude --dangerously-skip-permissions
```

### 🤖 **What Gets Auto-Loaded**
- **CLAUDE.md** - Development rules and patterns
- **doc-planner.md** - Planning agent (SPARC methodology)
- **microtask-breakdown.md** - Task decomposition agent
- **Agent Library** - Info about 600+ available agents

### 🔄 **Before vs After**
```bash
# ❌ OLD WAY
(cat CLAUDE.md && cat agents/doc-planner.md && cat agents/microtask-breakdown.md) | npx claude-flow@alpha swarm "build game" --claude

# ✅ NEW WAY
cf-swarm "build game"
```

---

## 🎯 Usage Examples

```bash
# 🎮 Game development
cf-swarm "build a multiplayer tic-tac-toe with real-time updates"

# 🌐 Web development  
cf-hive "create a full-stack blog with authentication and admin panel"

# 🔍 Analysis tasks
cf "analyze this codebase and suggest improvements"

# 📊 Agent discovery
cf-swarm "First discover relevant agents with 'find agents/ -name \"*game*\"' then build a space invaders game"
```

---

## 🌟 What's Included

### 🔥 **Core Features**
- **600+ AI Agents** - From [610ClaudeSubagents](https://github.com/ChrisRoyse/610ClaudeSubagents) + custom additions
- **SPARC Methodology** - Systematic development workflow
- **Automatic Context Loading** - No more manual file piping
- **Claude Flow Integration** - Advanced AI orchestration
- **Playwright Integration** - Visual verification for UI work
- **Advanced Monitoring** - Usage tracking with [Claude Monitor](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor)

### 🛠️ **Development Tools**
- **Claude Code CLI** - Official Claude development tools
- **Docker-in-Docker** - Container development support
- **Node.js & TypeScript** - Modern JavaScript development
- **Playwright** - Automated testing and screenshots
- **tmux Workspace** - 4-window terminal setup

---

## 🚀 Setup Options

### 🎯 **Option 1: Standalone Workspace (Recommended)**
```bash
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```
Perfect for new projects or dedicated Claude development.

### 🔄 **Option 2: Add to Existing Project**
```bash
# Clone configuration
git clone https://github.com/marcuspat/turbo-flow-claude claude-config

# Copy to your project
cp -r claude-config/.devcontainer ./
cp -r claude-config/devpods ./

# Launch
devpod up . --ide vscode
```

---

## 🌍 Cloud Provider Setup

Choose your preferred cloud provider:

### 🌊 **DigitalOcean (Recommended)**
```bash
devpod provider add digitalocean
devpod provider use digitalocean
devpod provider update digitalocean --option DIGITALOCEAN_ACCESS_TOKEN=your_token
devpod provider update digitalocean --option DROPLET_SIZE=s-4vcpu-8gb  # $48/month
```

### ☁️ **AWS**
```bash
devpod provider add aws
devpod provider use aws
devpod provider update aws --option AWS_INSTANCE_TYPE=t3.medium  # $30/month
```

### 🔵 **Azure** | 🌥️ **GCP** | 🏢 **Rackspace** | 🖥️ **Local Docker**
📋 Need setup instructions? Check out our comprehensive DevPod Provider Guide for detailed configuration steps.
[**📖 Setup Guide**](https://github.com/marcuspat/turbo-flow-claude/blob/main/devpod_provider_setup_guide.md)

---

## 🖥️ What Happens After Setup

### 🔄 **Automatic Installation**
- Installs Claude Code, Claude Flow, and 600+ agents
- Sets up tmux workspace with 4 windows
- Configures automatic context loading
- Installs development tools (Playwright, TypeScript, etc.)

### 🖥️ **tmux Workspace**
- **Window 0**: Primary Claude workspace
- **Window 1**: Secondary Claude workspace
- **Window 2**: Claude usage monitor
- **Window 3**: System monitor (htop)

Access with: `tmux attach -t workspace`

---

## 🎯 Complete Prompting Examples

### 🌟 **Master Pattern**
Always include this for maximum effectiveness:
```
"Identify all subagents that could be useful for this task and utilize the claude-flow hivemind to maximize your ability to accomplish the task."
```

### 🚀 **Full Project Development**
```
"I need to build a REST API for a todo application. Look in agents/ and:
1. Identify all useful subagents for this task
2. Create a complete development plan with visualizations
3. Utilize claude-flow hivemind to maximize our ability
4. Chain agents for planning, implementation, testing, deployment"
```

### 🏗️ **Infrastructure Project**
```
"Research using Kubernetes to deploy LLM services. Put output in research/ folder.
- Draw from YouTube transcripts, GitHub repos, blog posts
- Spawn 5 agents to work concurrently
- Keep iterating until clear implementation path exists"
```

---

## 📁 File Structure

After setup:
```
/workspaces/turbo-flow-claude/
├── 🤖 agents/              # 600+ AI agents
├── 📋 CLAUDE.md            # Development rules
├── 📋 FEEDCLAUDE.md        # Streamlined instructions
├── ⚡ claude-flow          # SPARC workflow tools
├── 🔧 cf-with-context.sh   # Context loading wrapper
└── 📁 [your project files]
```

---

## 🎛️ Management Commands

```bash
# Create/delete workspace
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
devpod delete turbo-flow-claude --force

# Start/stop (saves money)
devpod stop turbo-flow-claude      # Stop billing
devpod up turbo-flow-claude --ide vscode  # Resume

# List workspaces
devpod list
```

---

## 🔧 Troubleshooting

### 🔐 **Permission Issues**
```bash
sudo chown -R $(whoami):staff ~/.devpod && \
find ~/.devpod -type d -exec chmod 755 {} \; && \
find ~/.devpod -name "*provider*" -type f -exec chmod +x {} \;
```

### 🔗 **Connection Issues**
```bash
killall "Code"  # Close VSCode
devpod up turbo-flow-claude --ide vscode  # Retry
```

### ✅ **Verify Installation**
```bash
echo "Agents: $(ls -1 /workspaces/turbo-flow-claude/agents/*.md 2>/dev/null | wc -l)"
echo "Claude-code: $(which claude && echo '✓' || echo '✗')"
echo "Claude-monitor: $(which claude-monitor && echo '✓' || echo '✗')"
```

---

## 📚 Resources

- [DevPod Documentation](https://devpod.sh/docs)
- [Claude Flow SPARC](https://github.com/ruvnet/claude-flow) by Reuven Cohen
- [610ClaudeSubagents](https://github.com/ChrisRoyse/610ClaudeSubagents) by Christopher Royse
- [Claude Monitor](https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor) by Maciek-roboblog
- [Turbo Flow Aliases Guide](https://github.com/marcuspat/turbo-flow-claude/blob/main/claude-flow-aliases-guide.md)
- [Github Codespaces Setup Guide](https://github.com/marcuspat/turbo-flow-claude/blob/main/github_codespaces_setup.md)

---

## 📦 Detailed Provider Configuration

<details>
<summary>Click to expand full provider setup instructions</summary>

### 🌊 **DigitalOcean Provider**
1. Sign up at [DigitalOcean](https://www.digitalocean.com/)
2. Generate API token with read/write permissions
3. Configure:
```bash
devpod provider add digitalocean
devpod provider use digitalocean
devpod provider update digitalocean --option DIGITALOCEAN_ACCESS_TOKEN=your_token
devpod provider update digitalocean --option DROPLET_SIZE=s-4vcpu-8gb
```

### ☁️ **AWS Provider**
```bash
pip install awscli
aws configure
devpod provider add aws
devpod provider use aws
devpod provider update aws --option AWS_INSTANCE_TYPE=t3.medium
devpod provider update aws --option AWS_REGION=us-east-1
```

### 🔵 **Azure Provider**
```bash
brew install azure-cli  # macOS
az login
devpod provider add azure
devpod provider use azure
devpod provider update azure --option AZURE_VM_SIZE=Standard_B2s
devpod provider update azure --option AZURE_LOCATION=eastus
```

### 🌥️ **Google Cloud Provider**
```bash
curl https://sdk.cloud.google.com | bash
gcloud auth login
devpod provider add gcp
devpod provider use gcp
devpod provider update gcp --option GOOGLE_PROJECT_ID=your-project
devpod provider update gcp --option GOOGLE_MACHINE_TYPE=e2-medium
```

### 🖥️ **Local Docker Provider**
```bash
devpod provider add docker
devpod provider use docker
# No additional configuration needed
```

</details>

---

🎯 **Ready to supercharge your development with 600+ AI agents?**

```bash
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```
