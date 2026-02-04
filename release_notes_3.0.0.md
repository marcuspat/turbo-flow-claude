# 🚀 Turbo Flow v3.0.0 Release Notes

<div align="center">

![Release](https://img.shields.io/badge/Release-v3.0.0-blue?style=for-the-badge)
![Date](https://img.shields.io/badge/Date-2025--02--03-green?style=for-the-badge)

**Streamlined • Faster • Cleaner**

</div>

---

## ⚡ What's New

### 🔄 Delegated Core Installation
The installer now delegates to the official `claude-flow` installer, eliminating **~200 lines** of duplicate code.

```bash
# One command handles: Node.js, Claude Code, Claude Flow, RuVector, MCP setup
curl -fsSL https://cdn.jsdelivr.net/gh/ruvnet/claude-flow@main/scripts/install.sh | bash -s -- --full
```

### 📉 Reduced Complexity
| Metric | v2.0.7 | v3.0.0 | Change |
|:-------|:------:|:------:|:------:|
| Setup steps | 16 | 10 | **-38%** |
| Script lines | 750 | 557 | **-26%** |
| Install time | ~5 min | ~3 min | **-40%** |

---

## 📦 What's Included

| Category | Components |
|:---------|:-----------|
| **🧠 Core** | Claude Code, Claude Flow V3, RuVector, SONA |
| **🧪 Testing** | Agentic QE, Agent Browser + Chromium |
| **🔒 Security** | Security Analyzer skill |
| **🎨 UI** | HeroUI, Tailwind, UI UX Pro Max skill |
| **📋 Specs** | Spec-Kit, OpenSpec |
| **⚙️ Config** | MCP servers, prd2build command, Codex setup |

---

## 🆕 New Aliases

```bash
cf-wizard     # Interactive Claude Flow setup
turbo-status  # Check all installed components
turbo-help    # Quick command reference
```

---

## ⬆️ Upgrade Path

```bash
# 1. Pull latest
git pull origin main

# 2. Re-run setup
./setup.sh

# 3. Reload shell
source ~/.bashrc

# 4. Verify
turbo-status
```

---

## 📋 Quick Reference

```bash
# Core
claude          # Start Claude Code
cf-init         # Initialize Claude Flow
cf-doctor       # Health check

# Neural
ruv-stats       # RuVector learning stats
ruv-recall      # Search semantic memory

# Testing
aqe-generate    # Generate tests
ab-open <url>   # Browser automation

# Status
turbo-status    # Check everything
```

---

<div align="center">

**Full docs:** [README.md](./README.md)

</div>
