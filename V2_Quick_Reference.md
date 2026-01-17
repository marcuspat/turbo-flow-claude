# Turbo Flow v2.0.0 Quick Reference

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
```

### 3. Manual Steps

1. **Playwriter extension** — Install from [Chrome Web Store](https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe)

2. **Codex (optional)**
   ```bash
   npm install -g @openai/codex
   codex login
   ```

### 4. First Run

```bash
claude                 # Start Claude Code
cf-init                # Initialize Claude Flow
sk-here                # Initialize Spec-Kit
```

You're ready. Create a `prd.md` and run `/prd2build prd.md` in Claude Code.

---

## Status Check

```bash
turbo-status          # Check all installations
turbo-help            # Show this reference
```

---

## Claude Code

```bash
claude                # Start Claude Code
dsp                   # Start with skip permissions
```

**Slash commands (inside Claude Code):**
```
/prd2build prd.md           # Generate docs from PRD
/prd2build prd.md --build   # Generate docs + execute build
```

---

## Claude Flow V3

```bash
cf-init               # Initialize workspace
cf-list               # List available agents
cf-daemon             # Start background daemon

# Agents
cf-agent architect "task"
cf-agent code-analyzer "task"
cf-agent security-architect "task"

# Swarms
cf-swarm              # Hierarchical (boss/workers)
cf-mesh               # Mesh (peer-to-peer)

# Memory
cf-memory status
cf-memory search "query"

# Security
cf-security           # Run security scan
```

---

## RuVector (Neural Engine)

```bash
ruv                   # Start RuVector
ruv-init              # Initialize hooks
ruv-stats             # Learning statistics
ruvector-status       # Full status check

# Routing
ruv-route "task"      # Get agent recommendation

# Memory
ruv-remember -t edit "description"
ruv-recall "query"
ruv-learn             # Record trajectory
```

---

## Specs

```bash
# Spec-Kit
sk-here               # Init in current dir
sk-check              # Validate specs
sk-list               # List requirements
sk-add "requirement"  # Add requirement

# OpenSpec
os-init               # Initialize
os-tree               # Visualize spec tree
```

---

## Testing (Agentic QE)

```bash
aqe-generate          # Generate tests
aqe-gate              # Run quality gate
```

---

## Browser Automation

```bash
playwriter            # Run Playwriter
devb-start            # Start Dev-Browser server
```

**Note:** Playwriter requires Chrome extension:
https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe

---

## Codex (Optional)

```bash
codex-login           # Authenticate
codex-run "task"      # Run with Claude profile
codex-check           # Check setup status
```

---

## Key Paths

| Path | Contents |
|------|----------|
| `~/.claude/commands/` | Custom slash commands |
| `~/.claude/skills/` | Installed skills |
| `~/.config/claude/mcp.json` | MCP server config |
| `~/.codex/config.toml` | Codex configuration |
| `.claude-flow/` | Project Claude Flow config |
| `.ruvector/` | Project RuVector data |

---

## Project Structure

```
docs/
├── specification/    # Requirements, stories, API
├── ddd/              # Bounded contexts, aggregates
├── adr/              # Architecture decisions
└── implementation/   # INDEX.md (source of truth)
```

---

## MCP Servers

Registered servers (check with `claude mcp list`):

| Server | Command |
|--------|---------|
| claude-flow | `npx -y claude-flow@v3alpha mcp start` |
| agentic-qe | `npx -y aqe-mcp` |
| playwriter | `npx -y playwriter@latest` |
