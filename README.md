
# 🚀 Turbo Flow Claude v2.0.0

**✨ Agentic Development Environment — Claude Flow V3**

---

## 🏗️ Architecture

```diff
+ ┌─────────────────────────────────────────────────────────────────┐
+ │                    TURBO FLOW v2.0.0                            │
+ ├─────────────────────────────────────────────────────────────────┤
+ │  🎨 INTERFACE: Claude Code (CLI) │ Dev-Browser │ HeroUI       │
+ ├─────────────────────────────────────────────────────────────────┤
+ │  🧠 ORCHESTRATION: Claude Flow V3                               │
+ │  54+ Native Agents │ Unified MCP │ Background Workers           │
+ ├─────────────────────────────────────────────────────────────────┤
+ │  🧪 TESTING: Agentic QE (19 agents) │ Playwriter (AI tests)    │
+ ├─────────────────────────────────────────────────────────────────┤
+ │  🔒 SECURITY: Security Analyzer │ Codex Integration             │
+ ├─────────────────────────────────────────────────────────────────┤
+ │  📄 SPECS: Spec-Kit │ OpenSpec                                   │
+ └─────────────────────────────────────────────────────────────────┘
```

---

## ⚡ Quick Start

### 🐳 DevPod

```bash
# 🍎 macOS
brew install loft-sh/devpod/devpod

# 🪟 Windows
choco install devpod

# 🐧 Linux
curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64"
sudo install devpod /usr/local/bin

# 🚀 Launch
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

---

## 🛠️ Core Stack

| 🛠️ Tool | 🏷️ Alias | 📝 Description |
|------|-------|-------------|
| 🤖 Claude Code | `claude`, `dsp` | Anthropic's AI coding CLI |
| 🧩 Claude Flow V3 | `cf`, `cf-swarm` | Agent orchestration (54+ agents) |
| 🧪 Agentic QE | `aqe` | Testing pipeline (19 agents) |
| 🎭 Playwriter | `playwriter` | AI generates Playwright tests |
| 🌐 Dev-Browser | `devb-start` | Visual AI development |
| 🛡️ Security Analyzer | — | Vulnerability scanning (Claude skill) |
| 📋 Spec-Kit | `sk` | Spec-driven development |
| 📘 OpenSpec | `os` | Fission AI's spec workflow |
| 🧬 Codex | `codex` | OpenAI code agent (optional) |

---

## ⚙️ MCP Configuration

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
    },
    "playwriter": {
      "command": "npx",
      "args": ["-y", "playwriter@latest"]
    }
  }
}
```

---

## 🎮 Key Commands

```diff
+ # Claude Code
+ claude                    # Start Claude
+ dsp                       # Skip permissions mode

+ # Claude Flow V3
+ cf-init                   # Initialize workspace
+ cf-swarm                  # Hierarchical swarm
+ cf-mesh                   # Mesh swarm
+ cf-agent <type> "task"    # Run specific agent
+ cf-list                   # List agents
+ cf-daemon                 # Start background daemon
+ cf-memory-status          # Check memory system
+ cf-security               # Security scan

+ # prd2build (in Claude Code)
+ /prd2build prd.md         # Generate docs from PRD
+ /prd2build prd.md --build # Generate docs + build

+ # Testing
+ aqe-generate              # Generate tests
+ aqe-gate                  # Quality gate

+ # Codex (optional)
+ codex-run "task"          # Run with Claude profile
+ codex-check               # Check setup status

+ # Status
+ turbo-status              # Check all tools
+ turbo-help                # Quick reference
```

---

## 📂 Project Structure

```
/workspaces/turbo-flow-claude/
├── src/                    # 📝 Source code
├── tests/                  # 🧪 Test files
├── docs/                   # 📚 Generated documentation
├── plans/                  # 📈 Research and architecture
├── .claude-flow/           # 🧩 Claude Flow V3 config
├── AGENTS.md               # 🤖 Codex/Claude collaboration protocol
└── CLAUDE.md               # 🧠 Project context
```

---

## 👣 Manual Steps After Setup

1.  **🎭 Playwriter Chrome Extension**  
    https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe

2.  **🧬 Codex (optional)**
    ```bash
    npm install -g @openai/codex
    codex login
    ```

---

## 🔗 Resources

| 📚 Resource | 🔗 URL |
|----------|-----|
| 🧩 Claude Flow V3 | github.com/ruvnet/claude-flow |
| 🚀 Turbo Flow Claude | github.com/marcuspat/turbo-flow-claude |
| 🧪 Agentic QE | npmjs.com/package/agentic-qe |
| 🎭 Playwriter | github.com/remorses/playwriter |
| 🎨 HeroUI | heroui.com |
```
