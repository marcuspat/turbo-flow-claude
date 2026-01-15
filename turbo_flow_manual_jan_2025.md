# TURBO FLOW CLAUDE - COMPLETE USER MANUAL

**Version 1.0.6 Alpha | Lean Stack Edition**

*Powered by RuvVector Neural Engine*

---

## TABLE OF CONTENTS

1. [Introduction](#1-introduction)
2. [What's New in v1.0.6](#2-whats-new-in-v106)
3. [Quick Start](#3-quick-start)
4. [Installation Summary](#4-installation-summary)
5. [Claude Code CLI](#5-claude-code-cli)
6. [Claude Flow v3 Orchestration](#6-claude-flow-v3-orchestration)
7. [SONA Neural Intelligence](#7-sona-neural-intelligence)
8. [15-Agent Swarm System](#8-15-agent-swarm-system)
9. [AgentDB Unified Memory](#9-agentdb-unified-memory)
10. [SPARC Methodology](#10-sparc-methodology)
11. [Agentic QE (Testing Framework)](#11-agentic-qe-testing-framework)
12. [Playwriter (AI Test Generation)](#12-playwriter-ai-test-generation)
13. [Dev-Browser (Visual Development)](#13-dev-browser-visual-development)
14. [Security Analyzer](#14-security-analyzer)
15. [OpenSpec (Spec-Driven Development)](#15-openspec-spec-driven-development)
16. [Spec-Kit](#16-spec-kit)
17. [AI Agent Skills](#17-ai-agent-skills)
18. [HeroUI Frontend Stack](#18-heroui-frontend-stack)
19. [MCP Configuration](#19-mcp-configuration)
20. [Hooks & Automation System](#20-hooks--automation-system)
21. [GitHub Integration](#21-github-integration)
22. [uv Package Manager](#22-uv-package-manager)
23. [Command Reference](#23-command-reference)
24. [Workflows](#24-workflows)
25. [Migration from v1.0.5](#25-migration-from-v105)
26. [Troubleshooting](#26-troubleshooting)
27. [Resources](#27-resources)

---

## 1. INTRODUCTION

### What is Turbo Flow Claude?

Turbo Flow Claude v1.0.6 is a **lean, powerful agentic development environment** that combines AI-powered tools into a unified workflow system. This version represents a complete rewrite with the RuvVector Neural Engine at its core.

### Architecture Overview

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

### Key Highlights

- **54+ Native Agents** - Built into Claude Flow v3
- **SONA Neural Learning** - Self-improving AI with <0.05ms adaptation
- **150x Faster Memory** - HNSW vector search
- **Single Unified MCP** - No more scattered server registrations
- **Lean Stack** - 60% smaller than v1.0.5

---

## 2. WHAT'S NEW IN V1.0.6

### RuvVector Neural Engine

| Feature | Description | Performance |
|---------|-------------|-------------|
| **SONA** | Self-Optimizing Neural Architecture | <0.05ms adaptation |
| **EWC++** | Prevents catastrophic forgetting | 95%+ retention |
| **MoE** | 8 specialized expert routing | Dynamic gating |
| **Flash Attention** | Optimized attention computation | 2.49x-7.47x speedup |
| **HNSW Memory** | Hierarchical vector indexing | 150x faster search |
| **LoRA** | Memory-efficient fine-tuning | 128x compression |

### Lean Stack (60% Smaller)

**Removed (Now Built Into v3):**
- ❌ claudish (multi-model proxy)
- ❌ PAL MCP Server
- ❌ agtrace (observability)
- ❌ n8n-mcp
- ❌ @playwright/mcp (standalone)
- ❌ chrome-devtools-mcp
- ❌ 610ClaudeSubagents (external repo)
- ❌ agentic-flow (separate npm)
- ❌ agentic-jujutsu (separate npm)

**Added:**
- ✅ Playwriter (AI test generation)
- ✅ Dev-Browser (visual development)
- ✅ Security Analyzer (vulnerability scanning)
- ✅ HeroUI + Tailwind (frontend stack)

### Performance Comparison

| Metric | v1.0.5 | v1.0.6 | Improvement |
|--------|--------|--------|-------------|
| npm global packages | 12 | 4 | **-67%** |
| MCP registrations | 5 | 2 | **-60%** |
| Setup time | ~120s | ~80s | **-33%** |
| Memory search | 150ms | <1ms | **150x** |
| Agent spawn | ~800ms | <200ms | **4x** |
| Native agents | 0 | 54+ | **New** |
| Self-learning | None | SONA | **New** |

---

## 3. QUICK START

### DevPod Installation (Recommended)

```bash
# Install DevPod
# macOS:
brew install loft-sh/devpod/devpod

# Windows:
choco install devpod

# Linux:
curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64"
sudo install devpod /usr/local/bin

# Launch Turbo Flow workspace
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

### GitHub Codespaces

```bash
# Via GitHub UI: Code → Codespaces → Create codespace on main
# Or CLI:
gh codespace create -r marcuspat/turbo-flow-claude
```

### Manual Installation

```bash
git clone https://github.com/marcuspat/turbo-flow-claude
cd turbo-flow-claude
./devpods/setup.sh
source ~/.bashrc
```

### First Commands After Setup

```bash
# Load aliases
source ~/.bashrc

# Initialize Claude Flow v3
cf-init

# Start Claude Code
claude

# Or skip permissions for faster iteration
dsp

# Initialize a swarm
cf-swarm

# Check status
turbo-status
```

---

## 4. INSTALLATION SUMMARY

### NPM Global Packages (4)

| Package | Purpose |
|---------|---------|
| `@anthropic-ai/claude-code` | Claude Code CLI |
| `agentic-qe` | AI-powered quality engineering |
| `ai-agent-skills` | Universal skill repository |
| `@fission-ai/openspec` | Spec-driven development |

### Git-Cloned Tools (3)

| Tool | Location | Purpose |
|------|----------|---------|
| Playwriter | `~/.playwriter` | AI test generation from natural language |
| Dev-Browser | `~/.dev-browser` | Visual AI development environment |
| Security Analyzer | `~/.security-analyzer` | Vulnerability scanning |

### Python Tools (via uv)

| Tool | Purpose |
|------|---------|
| `specify-cli` | Spec-Kit CLI for specifications |

### Frontend Stack (Local npm)

| Package | Purpose |
|---------|---------|
| `@heroui/react` | Modern React component library |
| `framer-motion` | Animation library |
| `tailwindcss` | Utility-first CSS |
| `autoprefixer` | CSS vendor prefixing |

### MCP Servers (2)

| Server | Purpose |
|--------|---------|
| `claude-flow` | Unified orchestration (170+ tools) |
| `agentic-qe` | Testing pipeline |

---

## 5. CLAUDE CODE CLI

### Overview

Claude Code is Anthropic's official AI coding tool that lives in your terminal. It understands your codebase, edits files, runs commands, and handles complete workflows through natural language.

### Basic Usage

```bash
# Start Claude Code
claude

# Skip permission prompts (faster iteration)
claude --dangerously-skip-permissions
dsp  # Alias

# Check version
claude --version

# Run diagnostics
claude doctor
```

### Slash Commands (Inside Session)

| Command | Purpose |
|---------|---------|
| `/help` | Show available commands |
| `/agents` | List available subagents |
| `/memory` | Access memory functions |
| `/bug` | Report a bug to Anthropic |
| `/clear` | Clear conversation context |
| `/compact` | Reduce context size |

### CLAUDE.md Project File

Create a `CLAUDE.md` file in your project root to give Claude persistent context:

```markdown
# Project: My Application

## Structure
- `src/` - Main application code
- `tests/` - Test suites
- `docs/` - Documentation

## Conventions
- Use TypeScript for all new files
- Follow REST API naming conventions
- Write tests for all new features

## Commands
- `npm run build` - Build the project
- `npm test` - Run tests
- `npm run lint` - Check code style
```

### Workflow: Using Claude Code

```bash
# 1. Navigate to your project
cd my-project

# 2. Start Claude
claude

# 3. Ask Claude to understand your codebase
> "Analyze this codebase and explain its structure"

# 4. Make changes
> "Add error handling to all API endpoints"

# 5. Run tests
> "Run the test suite and fix any failures"

# 6. Commit changes
> "Create a commit with a descriptive message for these changes"
```

---

## 6. CLAUDE FLOW V3 ORCHESTRATION

### Overview

Claude Flow v3 is a **complete architectural redesign** featuring the RuvVector Neural Engine with self-learning capabilities that no other agent orchestration framework offers.

### Key Features

| Feature | Description |
|---------|-------------|
| **SONA Intelligence** | Self-learning neural architecture |
| **15-Agent Swarms** | Concurrent hierarchical-mesh topology |
| **AgentDB Memory** | 150x faster vector search |
| **100+ MCP Tools** | Unified tool access |
| **Native Multi-Provider** | OpenAI, Google, Ollama built-in |
| **Background Workers** | 12 auto-triggering workers |

### V3 vs V2 Performance

| Metric | V2.7 | V3.0 | Improvement |
|--------|------|------|-------------|
| CLI Startup | ~2.5s | <500ms | 5x faster |
| MCP Init | ~1.8s | <400ms | 4.5x faster |
| Agent Spawn | ~800ms | <200ms | 4x faster |
| Vector Search | 150ms | <1ms | 150x faster |
| Memory Write | 50ms | <5ms | 10x faster |
| Swarm Consensus | ~500ms | <100ms | 5x faster |

### Installation & Initialization

```bash
# Initialize in your project (REQUIRED first step)
npx claude-flow@v3alpha init --force
cf-init  # Alias

# Start MCP server
npx claude-flow@v3alpha mcp start
cf-mcp  # Alias

# Check version
npx claude-flow@v3alpha --version

# List all 54+ agents
npx claude-flow@v3alpha --list
cf-list  # Alias
```

### Running Agents

```bash
# Run with specific agent
npx claude-flow@v3alpha --agent coder --task "Implement user authentication"
cf-agent coder --task "Implement user authentication"  # Alias

# Shortcut aliases for common agents
cf-coder "implement REST endpoint"
cf-reviewer "review authentication code"
cf-tester "create unit tests for user service"
cf-security "audit for vulnerabilities"
```

### Swarm Commands

Swarms coordinate multiple agents for complex tasks:

```bash
# Initialize hierarchical swarm
npx claude-flow@v3alpha swarm init --topology hierarchical-mesh
cf-swarm  # Alias (default hierarchical)

# Initialize mesh topology
npx claude-flow@v3alpha swarm init --topology mesh
cf-mesh  # Alias

# Start swarm with max agents
npx claude-flow@v3alpha swarm start --max-agents 15

# Check swarm status
npx claude-flow@v3alpha swarm status

# Run task with swarm
npx claude-flow@v3alpha swarm "build REST API with authentication" --mode parallel
```

### Swarm Topologies

| Topology | Structure | Best For |
|----------|-----------|----------|
| **hierarchical-mesh** | Queen + domains | V3 default, complex projects |
| **mesh** | Peer-to-peer | Collaborative tasks |
| **hierarchical** | Queen-worker | Coordinated projects |
| **star** | Central hub | Aggregation tasks |
| **ring** | Sequential | Pipeline processing |
| **adaptive** | Dynamic | Variable workloads |

### Hive-Mind Commands

For complex, multi-phase projects:

```bash
# Interactive setup wizard
npx claude-flow@v3alpha hive-mind wizard

# Spawn hive-mind with task
npx claude-flow@v3alpha hive-mind spawn "build enterprise authentication system" \
  --topology hierarchical

# Check status
npx claude-flow@v3alpha hive-mind status
cf-status  # Alias

# Resume a session
npx claude-flow@v3alpha hive-mind resume session-xxxxx

# Queen coordination
npx claude-flow@v3alpha queen command "Deploy to staging"
npx claude-flow@v3alpha queen monitor
npx claude-flow@v3alpha queen delegate --task "API implementation"
npx claude-flow@v3alpha queen aggregate --results
```

### Background Workers

```bash
# Dispatch background worker
npx claude-flow@v3alpha worker dispatch --trigger audit --context "./src"
cf-worker  # Alias

# Check worker status
npx claude-flow@v3alpha worker status

# View worker results
npx claude-flow@v3alpha worker results --limit 10

# Start daemon for continuous workers
npx claude-flow@v3alpha daemon start
cf-daemon  # Alias
```

### Progress & Status

```bash
# Check implementation progress
npx claude-flow@v3alpha progress --detailed
cf-progress  # Alias

# System status
npx claude-flow@v3alpha status
cf-status  # Alias
```

---

## 7. SONA NEURAL INTELLIGENCE

### Overview

SONA (Self-Optimizing Neural Architecture) is v3's revolutionary self-learning system that makes your agents smarter with every interaction.

### Core Components

| Component | Function | Performance |
|-----------|----------|-------------|
| **SONA Core** | Runtime-adaptive learning | <0.05ms adaptation |
| **EWC++** | Prevents catastrophic forgetting | 95%+ retention |
| **MoE** | 8 specialized expert routing | Dynamic gating |
| **Flash Attention** | Optimized attention computation | 2.49x-7.47x speedup |
| **LoRA** | Memory-efficient fine-tuning | 128x compression |
| **Hyperbolic Embeddings** | Hierarchical code representation | Poincaré ball model |

### How SONA Works

```
User Query → [SONA Engine] → Model Response → User Feedback
     ↑                                              │
     └───────────── Learning Signal ───────────────┘
                    (< 1ms adaptation)
```

### Neural Commands

```bash
# Enable neural learning
npx claude-flow@v3alpha neural enable --pattern coordination
cf-neural enable --pattern coordination  # Alias

# Train on successful workflows
npx claude-flow@v3alpha neural train \
  --pattern_type coordination \
  --training_data "successful API development workflows"
cf-train --pattern_type coordination --training_data "..."  # Alias

# View learned patterns
npx claude-flow@v3alpha neural patterns list --type coordination
cf-patterns list --type coordination  # Alias

# Check neural status
npx claude-flow@v3alpha neural status
```

### Pre-training & Routing

```bash
# Bootstrap MoE (Mixture of Experts) intelligence
npx claude-flow@v3alpha hooks pretrain --model-type moe
cf-pretrain --model-type moe  # Alias

# Intelligent task routing (learns over time)
npx claude-flow@v3alpha hooks route "optimize database queries"
cf-route "optimize database queries"  # Alias
```

### Intelligence Hooks (Trajectory Learning)

The 4-step pipeline: RETRIEVE → JUDGE → DISTILL → CONSOLIDATE

```bash
# Start trajectory tracking
npx claude-flow@v3alpha hooks intelligence trajectory-start --session "session1"

# Record step with reward
npx claude-flow@v3alpha hooks intelligence trajectory-step \
  --action "implement authentication" --reward 0.9

# End trajectory
npx claude-flow@v3alpha hooks intelligence trajectory-end --verdict success

# Pattern storage with HNSW indexing
npx claude-flow@v3alpha hooks intelligence pattern-store \
  --pattern "REST API pattern" --embedding "[...]"

# Pattern search
npx claude-flow@v3alpha hooks intelligence pattern-search \
  --query "authentication patterns" --limit 10

# View learning stats
npx claude-flow@v3alpha hooks intelligence stats

# Focus attention on task
npx claude-flow@v3alpha hooks intelligence attention --focus "optimize performance"
```

### SONA Configuration Profiles

```typescript
// Max throughput (real-time chat)
const config = SonaConfig.maxThroughput();

// Max quality (research/batch)
const config = SonaConfig.maxQuality();

// Edge deployment (<5MB memory)
const config = SonaConfig.edgeDeployment();

// Custom configuration
const config = {
  hidden_dim: 256,
  embedding_dim: 256,
  micro_lora_rank: 2,        // 5% faster than rank-1 (SIMD)
  base_lora_rank: 8,
  micro_lora_lr: 0.002,      // +55% quality improvement
  base_lora_lr: 0.0001,
  ewc_lambda: 2000.0,        // Better forgetting prevention
  pattern_clusters: 100,     // 2.3x faster search
  trajectory_capacity: 10000,
  enable_simd: true
};
```

---

## 8. 15-AGENT SWARM SYSTEM

### Overview

V3 introduces a revolutionary 15-agent concurrent swarm architecture with queen-led hierarchical-mesh topology.

### Swarm Topology Diagram

```
                    ┌─────────────────────┐
                    │  QUEEN COORDINATOR  │
                    │     (Agent #1)      │
                    └──────────┬──────────┘
                               │
       ┌───────────────────────┼───────────────────────┐
       │                       │                       │
┌──────▼──────┐        ┌───────▼───────┐       ┌──────▼──────┐
│  SECURITY   │        │     CORE      │       │ INTEGRATION │
│ DOMAIN      │        │    DOMAIN     │       │   DOMAIN    │
│ (Agents 2-4)│        │ (Agents 5-9)  │       │(Agents 10-12)│
└─────────────┘        └───────────────┘       └─────────────┘
       │                       │                       │
       └───────────────────────┼───────────────────────┘
                               │
       ┌───────────────────────┼───────────────────────┐
       │                       │                       │
┌──────▼──────┐        ┌───────▼───────┐       ┌──────▼──────┐
│ QUALITY/TEST│        │  PERFORMANCE  │       │ DEPLOYMENT  │
│ (Agent #13) │        │  (Agent #14)  │       │ (Agent #15) │
└─────────────┘        └───────────────┘       └─────────────┘
```

### Agent Roster

| ID | Agent | Role | Primary Focus |
|----|-------|------|---------------|
| 1 | Queen Coordinator | Orchestration & GitHub | All domains |
| 2 | Security Architect | Security design | api, permissions, core |
| 3 | Security Implementer | CVE fixes | auth-service, hooks |
| 4 | Security Tester | Security TDD | security tests |
| 5 | Core Architect | Core redesign | orchestrator decomposition |
| 6 | Core Implementer | Core implementation | types, config, utils |
| 7 | Memory Specialist | Memory unification | AgentDB, HNSW |
| 8 | Swarm Specialist | Swarm unification | coordination, hive-mind |
| 9 | MCP Specialist | MCP optimization | transport, tools |
| 10 | Integration Architect | Integration | SDK bridge |
| 11 | CLI/Hooks Developer | CLI modernization | interactive prompts |
| 12 | Neural/Learning Dev | SONA integration | learning systems |
| 13 | TDD Test Engineer | London School TDD | all modules |
| 14 | Performance Engineer | Benchmarks | optimization |
| 15 | Release Engineer | Deployment | CI/CD, release |

### Spawning Agents

```bash
# Spawn all agents concurrently
npx claude-flow@v3alpha swarm init v3-implementation \
  --topology hierarchical-mesh \
  --max-agents 15 \
  --github-sync enabled

# Spawn individual agents
npx claude-flow@v3alpha agent spawn queen-coordinator --id 1
npx claude-flow@v3alpha agent spawn security-architect --id 2
npx claude-flow@v3alpha agent spawn memory-specialist --id 7
npx claude-flow@v3alpha agent spawn tdd-test-engineer --id 13

# Spawn by type
npx claude-flow@v3alpha agent spawn --type coder
npx claude-flow@v3alpha agent spawn --type architect --name "My Architect"
```

### Consensus Mechanisms

| Mechanism | Description | Use Case |
|-----------|-------------|----------|
| **majority** | >50% agreement | Quick decisions |
| **weighted** | Expertise-based voting | Technical decisions |
| **byzantine** | Fault-tolerant | Critical systems |
| **unanimous** | 100% agreement | High-stakes decisions |

---

## 9. AGENTDB UNIFIED MEMORY

### Overview

V3 unifies all memory operations through AgentDB with HNSW indexing for 150x faster search.

### Performance Characteristics

| Dataset Size | JSON Query | AgentDB Query | Speedup | Memory Saved |
|--------------|------------|---------------|---------|--------------|
| 100 entries | 0.12ms | 0.10ms | 1.2x | 52% |
| 1,000 entries | 1.18ms | 0.05ms | 23.6x | 54% |
| 10,000 entries | 10.96ms | 0.11ms | 99.6x | 56% |
| 100,000 entries | 109ms | 0.15ms | 727x | 58% |
| 1,000,000 entries | 1,090ms | 0.20ms | 5,450x | 60% |

### Memory Types

| Type | Scope | Use Case |
|------|-------|----------|
| **Session Memory** | Current conversation | Context continuity |
| **Long-term Memory** | Persistent across sessions | User preferences, patterns |
| **Working Memory** | Active task context | Current problem-solving |
| **Episodic Memory** | Event sequences | Experience replay |
| **Coordination Memory** | Cross-agent shared | Swarm coordination |

### Memory Commands

```bash
# Initialize memory with AgentDB
npx claude-flow@v3alpha memory init --agentdb

# Store with semantic embedding
npx claude-flow@v3alpha memory store api_pattern \
  "Use RESTful patterns with JWT auth" \
  --namespace backend

# Simple query
npx claude-flow@v3alpha memory query "authentication patterns" \
  --namespace backend

# Vector search with HNSW (150x faster)
npx claude-flow@v3alpha memory vector-search \
  "user authentication flow" \
  --k 10 --threshold 0.7 --namespace backend
cf-memory "user authentication flow"  # Alias

# Check memory status
npx claude-flow@v3alpha memory status

# List all memories
npx claude-flow@v3alpha memory list --namespace backend

# Clear memory
npx claude-flow@v3alpha memory clear --namespace backend

# Migrate from V2 JSON to V3 AgentDB
npx claude-flow@v3alpha memory migrate --from json --to agentdb

# Benchmark performance
npx claude-flow@v3alpha memory benchmark --dataset-size 10000
```

### Embeddings

```bash
# Initialize embeddings
npx claude-flow@v3alpha embeddings init
npx claude-flow@v3alpha embeddings init --model all-mpnet-base-v2

# Search with embeddings
npx claude-flow@v3alpha embeddings search -q "authentication patterns"
```

---

## 10. SPARC METHODOLOGY

### Overview

SPARC is a systematic development methodology with five phases:

1. **S**pecification - Define requirements and constraints
2. **P**seudocode - Plan logic and data structures
3. **A**rchitecture - Design system structure
4. **R**efinement - TDD (Red-Green-Refactor)
5. **C**ompletion - Integration and deployment

### Available Modes (17)

| Mode | Purpose |
|------|---------|
| `spec-pseudocode` | Requirements and logic planning |
| `architect` | System design |
| `tdd` | Test-driven development |
| `coder` | Implementation |
| `reviewer` | Code review |
| `researcher` | Information gathering |
| `orchestrator` | Task coordination |
| `debugger` | Bug fixing |
| `security` | Security analysis |
| `performance` | Optimization |
| `documentation` | Documentation writing |
| `devops` | Infrastructure and deployment |
| `integration` | System integration |
| `supabase-expert` | Database specialist |
| `cleanup` | Code cleanup |
| `tester` | Test creation |
| `specification` | Requirements analysis |

### Commands

```bash
# Full TDD workflow
npx claude-flow@v3alpha sparc tdd "user authentication system"

# Run specific phases
npx claude-flow@v3alpha sparc run spec-pseudocode "shopping cart feature"
npx claude-flow@v3alpha sparc run architect "payment processing"
npx claude-flow@v3alpha sparc run coder "implement cart functionality"
npx claude-flow@v3alpha sparc run security "analyze authentication code"

# Start complete SPARC workflow
npx claude-flow@v3alpha sparc start "Build e-commerce platform"

# Individual phase commands
npx claude-flow@v3alpha sparc architect "Design payment system"
npx claude-flow@v3alpha sparc coder "Implement checkout flow"
npx claude-flow@v3alpha sparc tester "Create integration tests"

# TDD with specific agents
npx claude-flow@v3alpha sparc tdd "implement payment system" \
  --agents specification,pseudocode,architecture,refinement

# List all available modes
npx claude-flow@v3alpha sparc modes
```

### Workflow: TDD with SPARC

```bash
# 1. Specification Phase
npx claude-flow@v3alpha sparc run spec-pseudocode "Create a user registration system"
# Output: requirements.md, pseudocode outline

# 2. Architecture Phase
npx claude-flow@v3alpha sparc run architect "Design user registration system"
# Output: architecture diagram, component design

# 3. TDD Phase (Red-Green-Refactor)
npx claude-flow@v3alpha sparc tdd "Implement user registration"
# - Writes failing tests first (Red)
# - Implements minimal code to pass (Green)
# - Cleans up code (Refactor)

# 4. Review Phase
npx claude-flow@v3alpha sparc run reviewer "Review user registration implementation"
# Output: code review with suggestions

# 5. Documentation Phase
npx claude-flow@v3alpha sparc run documentation "Document user registration API"
# Output: API documentation, usage examples
```

---

## 11. AGENTIC QE (TESTING FRAMEWORK)

### Overview

Agentic QE (Quality Engineering) Fleet is an AI-powered testing platform:

- **19 Main Agents** for different QE tasks
- **11 TDD Subagents** for test-driven development
- **40 QE Skills** covering testing methodologies
- **Real-time Visualization** of test results
- **Flaky Test Detection** and automatic remediation

### Installation

```bash
# Already installed via setup.sh
# Initialize in your project
aqe init
```

### Commands

```bash
# Initialize AQE in project
npx agentic-qe init
aqe init  # Alias
aqe-init  # Alias

# Generate tests
npx agentic-qe generate tests src/services/user-service.ts
aqe generate tests src/services/user-service.ts  # Alias
aqe-generate  # Alias

# Run tests with AI analysis
npx agentic-qe run --analyze

# Detect flaky tests
npx agentic-qe flaky-hunt --runs 100
aqe-flaky  # Alias

# Quality gate check
npx agentic-qe quality-gate --coverage 95
aqe-gate  # Alias

# MCP server
npx aqe-mcp
aqe-mcp  # Alias
```

### Using with Claude Code

```bash
# Start Claude
claude

# Generate comprehensive tests
> "Use qe-test-generator to create tests for src/services/user-service.ts with 95% coverage"

# Run quality pipeline
> "Initialize AQE fleet: generate tests, execute them, analyze coverage, and run quality gate"

# Hunt for flaky tests
> "Use qe-flaky-test-hunter to analyze the last 100 test runs and identify flaky tests"
```

### QE Agents

| Agent | Purpose |
|-------|---------|
| `qe-test-generator` | Generate comprehensive tests |
| `qe-test-executor` | Run tests in parallel |
| `qe-coverage-analyzer` | Analyze test coverage |
| `qe-quality-gate` | Validate quality thresholds |
| `qe-flaky-test-hunter` | Identify flaky tests |
| `qe-performance-tester` | Performance testing |
| `qe-security-scanner` | Security testing |

### Workflow: Quality Engineering Pipeline

```bash
# 1. Initialize AQE
aqe init

# 2. Generate tests for your services
claude "Use qe-test-generator to create tests for src/services/*.ts"

# 3. Run tests in parallel
claude "Use qe-test-executor to run all tests in parallel"

# 4. Analyze coverage
claude "Use qe-coverage-analyzer to find gaps with 95% target"

# 5. Run quality gate
claude "Use qe-quality-gate to validate against 95% threshold"

# 6. Hunt flaky tests
claude "Use qe-flaky-test-hunter to analyze and fix flaky tests"
```

---

## 12. PLAYWRITER (AI TEST GENERATION)

### Overview

Playwriter is an AI-powered tool that generates Playwright tests from natural language descriptions. New in v1.0.6, it replaces the need for manual test writing.

### Installation

```bash
# Already installed via setup.sh to ~/.playwriter
# Manual installation:
git clone https://github.com/remorses/playwriter ~/.playwriter
cd ~/.playwriter && npm install
```

### Commands

```bash
# Launch interactive mode
playwriter

# Generate test from description
pw-test "user can login with valid credentials"

# Generate comprehensive test suite
pw-test "e-commerce checkout flow: add item, update quantity, complete purchase"

# Generate test with specifics
pw-test "test that login fails with wrong password and shows error message"

# Run generated tests
npx playwright test
```

### Example Usage

```bash
# Simple login test
pw-test "verify user can login with email and password"
# Output: Generated Playwright test file

# Form validation
pw-test "form shows validation errors when submitting empty required fields"

# User flow
pw-test "user can register, verify email, and complete profile setup"

# API testing
pw-test "API returns 401 when accessing protected route without token"
```

### Workflow: AI-Generated Tests

```bash
# 1. Describe the test scenario
pw-test "users can register, login, and reset password"

# 2. Review generated test
cat tests/generated-test.spec.ts

# 3. Run the test
npx playwright test generated-test.spec.ts

# 4. Combine with Agentic QE for analysis
aqe run --analyze
aqe quality-gate --coverage 90
```

---

## 13. DEV-BROWSER (VISUAL DEVELOPMENT)

### Overview

Dev-Browser is a browser-based visual AI development environment. New in v1.0.6, it provides:

- Live preview of components
- AI-assisted development
- HeroUI component library integration
- Visual debugging

### Installation

```bash
# Already installed via setup.sh to ~/.dev-browser
# Manual installation:
git clone https://github.com/SawyerHood/dev-browser ~/.dev-browser
cd ~/.dev-browser && npm install
```

### Commands

```bash
# Launch visual dev environment
cd ~/.dev-browser && npm run dev
dev-browser  # Alias
devb         # Short alias
```

### Features

| Feature | Description |
|---------|-------------|
| **Live Preview** | Real-time component rendering |
| **AI Assistance** | Integrated AI for code generation |
| **Component Library** | HeroUI components built-in |
| **Visual Debugging** | Debug UI issues visually |
| **Hot Reload** | Instant updates on code changes |

### Workflow: Visual Development

```bash
# 1. Launch dev-browser
dev-browser

# 2. Opens browser-based IDE with:
#    - Live preview panel
#    - AI chat interface
#    - Component library sidebar

# 3. Ask AI to generate components
# "Create a user profile card with avatar, name, and bio"

# 4. Preview renders in real-time

# 5. Export code to your project
```

---

## 14. SECURITY ANALYZER

### Overview

Security Analyzer provides vulnerability scanning capabilities as an MCP server. Combined with Claude Flow v3's AIDefence, it provides dual-layer security protection.

### Installation

```bash
# Already installed via setup.sh to ~/.security-analyzer
# Manual installation:
git clone https://github.com/Cornjebus/security-analyzer ~/.security-analyzer
cd ~/.security-analyzer && npm install
```

### Commands

```bash
# Full vulnerability scan
cd ~/.security-analyzer && npm run scan
security-scan  # Alias

# Claude Flow v3 integrated audit
npx @claude-flow/security@latest audit --platform linux
sec-audit  # Alias

# Platform-specific audits
npx @claude-flow/security@latest audit --platform darwin  # macOS
npx @claude-flow/security@latest audit --platform windows
```

### Security Workflow

```bash
# 1. Run vulnerability scan
security-scan

# 2. Run Claude Flow v3 security audit
sec-audit

# 3. Review findings in Claude
claude
> "Analyze the security scan results and prioritize fixes"

# 4. v3's AIDefence handles runtime threats automatically
```

### Integration with Claude Code

```bash
claude
> "Run a security audit on this codebase focusing on authentication"
> "Check for common vulnerabilities like SQL injection and XSS"
> "Review dependencies for known CVEs"
```

---

## 15. OPENSPEC (SPEC-DRIVEN DEVELOPMENT)

### Overview

OpenSpec provides spec-driven development (SDD) for AI coding assistants:

- **Spec Before Code** - Lock intent before implementation
- **Change Tracking** - Proposals, tasks, and spec deltas
- **Multi-Tool Support** - Works with Claude Code, Cursor, Codex, etc.

### Installation

```bash
# Installed by setup.sh
npm install -g @fission-ai/openspec
```

### Commands

```bash
# Initialize OpenSpec in your project
openspec init
os-init  # Alias

# List change proposals
openspec list
os-list  # Alias

# Show a specific change
openspec show add-user-auth

# Validate a change proposal
openspec validate add-user-auth
os-validate  # Alias

# Archive completed change
openspec archive add-user-auth

# Update tool configurations
openspec update
```

### Directory Structure

```
project/
├── openspec/
│   ├── project.md           # Project conventions
│   ├── specs/               # Current truth (source of truth)
│   │   └── auth/
│   │       └── spec.md
│   └── changes/             # Proposed updates
│       └── add-oauth/
│           ├── proposal.md
│           ├── tasks.md
│           └── specs/
│               └── auth/
│                   └── spec.md
└── AGENTS.md                # Auto-generated for AI tools
```

### Slash Commands (In Claude Code)

| Command | Purpose |
|---------|---------|
| `/openspec:proposal` | Create new change proposal |
| `/openspec:apply` | Apply a change proposal |
| `/openspec:validate` | Validate spec formatting |
| `/openspec:archive` | Archive completed change |

### Workflow: Spec-Driven Development

```bash
# 1. Initialize OpenSpec
os-init

# 2. Start Claude Code
claude

# 3. Create a proposal
> "/openspec:proposal Add OAuth authentication"

# 4. Review and iterate
openspec show add-oauth
> "Add acceptance criteria for Google and GitHub OAuth providers"

# 5. Apply the change
> "/openspec:apply add-oauth"

# 6. Archive when complete
openspec archive add-oauth
```

---

## 16. SPEC-KIT

### Overview

Spec-Kit is GitHub's specification management tool that helps maintain project specifications and documentation.

### Installation

```bash
# Installed by setup.sh via uv
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

### Commands

```bash
# Base command
specify
sk  # Alias

# Initialize in current directory
specify init .

# Initialize with Claude AI support
specify init . --ai claude
sk-here  # Alias

# Check specification health
specify check
sk-check  # Alias
```

### Slash Commands (In Claude Code)

| Command | Purpose |
|---------|---------|
| `/speckit.constitution` | View project constitution |
| `/speckit.specify` | Create specifications |
| `/speckit.plan` | Generate project plan |
| `/speckit.tasks` | List tasks |
| `/speckit.implement` | Begin implementation |

### Directory Structure

```
project/
├── .specify/
│   ├── constitution.md    # Project rules and guidelines
│   ├── specs/             # Feature specifications
│   ├── plan.md           # Implementation plan
│   └── tasks/            # Individual tasks
└── CLAUDE.md             # Generated project context
```

### Workflow: Setting Up Spec-Kit

```bash
# 1. Initialize Spec-Kit with Claude
sk-here

# 2. Start Claude with project context
claude

# 3. Use Spec-Kit slash commands
> /speckit.constitution    # View project constitution
> /speckit.specify         # Create specifications
> /speckit.plan           # Generate project plan
> /speckit.tasks          # List tasks
> /speckit.implement      # Begin implementation
```

---

## 17. AI AGENT SKILLS

### Overview

AI Agent Skills is the universal skill repository for AI coding agents:

- **38+ Curated Skills** - Quality over quantity
- **9+ Compatible Agents** - Claude Code, Cursor, Amp, VS Code, Copilot, Goose, Letta, OpenCode
- **One Command Install** - Works everywhere automatically

### Installation

```bash
# Installed by setup.sh
npm install -g ai-agent-skills
```

### CLI Commands

```bash
# List all available skills
npx ai-agent-skills list
skills-list  # Alias

# Search for skills
npx ai-agent-skills search <query>

# Get skill details
npx ai-agent-skills info <skill-name>

# Install a skill
npx ai-agent-skills install <skill-name>
skills-install  # Alias

# Install for specific agent
npx ai-agent-skills install <skill-name> --agent cursor
```

### Supported Agents

| Agent | Flag | Install Location |
|-------|------|------------------|
| Claude Code | `--agent claude` (default) | `~/.claude/skills/` |
| Cursor | `--agent cursor` | `.cursor/skills/` |
| Amp | `--agent amp` | `~/.amp/skills/` |
| VS Code / Copilot | `--agent vscode` | `.github/skills/` |
| Goose | `--agent goose` | `~/.config/goose/skills/` |
| OpenCode | `--agent opencode` | `~/.opencode/skills/` |
| Portable | `--agent project` | `.skills/` |

### Available Skills by Category

**Development:**
| Skill | Description |
|-------|-------------|
| `frontend-design` | Production-grade UI components |
| `mcp-builder` | Create MCP servers |
| `code-review` | Automated PR review |
| `backend-development` | APIs, databases, servers |
| `python-development` | Modern Python patterns |
| `javascript-typescript` | ES6+, Node, React |
| `webapp-testing` | Browser automation |
| `database-design` | Schema optimization |

**Documents:**
| Skill | Description |
|-------|-------------|
| `pdf` | Extract, create, merge PDFs |
| `xlsx` | Excel creation, formulas |
| `docx` | Word documents |
| `pptx` | PowerPoint presentations |

**Creative:**
| Skill | Description |
|-------|-------------|
| `canvas-design` | Visual art and posters |
| `algorithmic-art` | Generative art with p5.js |
| `theme-factory` | Font and color themes |

**Business:**
| Skill | Description |
|-------|-------------|
| `brand-guidelines` | Apply brand styling |
| `internal-comms` | Status updates |
| `lead-research-assistant` | Identify leads |

### Workflow: Installing Skills

```bash
# 1. List available skills
skills-list

# 2. Search for relevant skills
npx ai-agent-skills search "testing"

# 3. Get skill details
npx ai-agent-skills info webapp-testing

# 4. Install the skill
skills-install webapp-testing

# 5. Verify installation
ls ~/.claude/skills/
```

---

## 18. HEROUI FRONTEND STACK

### Overview

HeroUI is a modern, accessible React component library pre-installed with Turbo Flow v1.0.6:

- **@heroui/react** - Complete component library
- **framer-motion** - Animation library
- **tailwindcss** - Utility-first CSS
- **autoprefixer** - CSS vendor prefixing

### Pre-installed Packages

```bash
# Already installed in workspace
npm install -D @heroui/react framer-motion tailwindcss postcss autoprefixer
```

### Using HeroUI

```jsx
// Import components
import { Button, Card, Input, Modal } from '@heroui/react';
import { motion } from 'framer-motion';

// Example component
function LoginForm() {
  return (
    <Card className="p-6 max-w-md">
      <Input label="Email" type="email" />
      <Input label="Password" type="password" />
      <Button color="primary" className="mt-4">
        Login
      </Button>
    </Card>
  );
}
```

### Tailwind Configuration

```javascript
// tailwind.config.js (auto-generated)
module.exports = {
  content: ['./src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

### Integration with Dev-Browser

```bash
# Launch visual dev environment
dev-browser

# HeroUI components are available in the component library sidebar
# Drag and drop to add components
# AI can generate HeroUI code directly
```

---

## 19. MCP CONFIGURATION

### Overview

v1.0.6 uses only **2 MCP servers** instead of 5, with Claude Flow v3 handling 170+ tools internally.

### MCP Configuration File

```json
// ~/.config/claude/mcp.json
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@v3alpha", "mcp", "start"],
      "env": {}
    },
    "agentic-qe": {
      "command": "npx",
      "args": ["-y", "aqe-mcp"],
      "env": {}
    }
  }
}
```

### Claude Flow v3 MCP Tools (100+)

**Swarm & Agents:**
| Tool | Purpose |
|------|---------|
| `mcp__claude-flow__swarm_init` | Initialize swarm |
| `mcp__claude-flow__agent_spawn` | Create agents |
| `mcp__claude-flow__task_orchestrate` | Orchestrate tasks |
| `mcp__claude-flow__queen_command` | Queen directives |
| `mcp__claude-flow__queen_monitor` | Monitor swarm health |

**Memory & Neural:**
| Tool | Purpose |
|------|---------|
| `mcp__claude-flow__memory_usage` | Check memory stats |
| `mcp__claude-flow__memory_search` | Semantic search |
| `mcp__claude-flow__memory_store` | Store patterns |
| `mcp__claude-flow__neural_status` | Neural system status |
| `mcp__claude-flow__neural_train` | Train on patterns |

**Intelligence:**
| Tool | Purpose |
|------|---------|
| `mcp__claude-flow__consensus_vote` | Democratic decisions |
| `mcp__claude-flow__memory_share` | Share across hive |
| `mcp__claude-flow__neural_sync` | Synchronize patterns |
| `mcp__claude-flow__swarm_think` | Collective problem solving |

**GitHub:**
| Tool | Purpose |
|------|---------|
| `mcp__github__repo_analyze` | Repository analysis |
| `mcp__github__pr_manage` | Pull request management |
| `mcp__github__issue_track` | Issue tracking |
| `mcp__github__workflow_automate` | CI/CD automation |

### MCP Management

```bash
# List registered MCP servers
claude mcp list

# Remove server
claude mcp remove <name>

# Add server
claude mcp add <name> --scope user -- <command>
```

---

## 20. HOOKS & AUTOMATION SYSTEM

### Overview

V3 features an enhanced hooks system for automated workflows with pre/post operations.

### Hook Types

| Hook | Trigger | Use Case |
|------|---------|----------|
| `pre-edit` | Before file edit | Backup, validation |
| `post-edit` | After file edit | Formatting, testing |
| `pre-task` | Before task start | Setup, dependencies |
| `post-task` | After task complete | Cleanup, notification |
| `pre-search` | Before search | Query optimization |
| `post-search` | After search | Result filtering |
| `pre-command` | Before CLI command | Validation |
| `post-command` | After CLI command | Logging |
| `session-start` | Session begins | Restore memory |
| `session-end` | Session ends | Save memory |

### Hook Commands

```bash
# List available hooks
npx claude-flow@v3alpha hooks list
cf-hooks  # Alias

# Enable specific hook
npx claude-flow@v3alpha hooks enable pre-edit

# View hook metrics
npx claude-flow@v3alpha hooks metrics

# Configure hook actions
npx claude-flow@v3alpha hooks config pre-edit --actions "backup,validate"
```

### Hooks Configuration

```json
// .claude/settings.json
{
  "hooks": {
    "pre-edit": {
      "enabled": true,
      "actions": ["backup", "lint-check"]
    },
    "post-edit": {
      "enabled": true,
      "actions": ["format", "test", "commit"]
    },
    "session-start": {
      "enabled": true,
      "actions": ["restore-memory", "load-context"]
    },
    "session-end": {
      "enabled": true,
      "actions": ["save-memory", "cleanup"]
    }
  }
}
```

### Three-Phase Memory Protocol

1. **Status Phase**: Report current state
2. **Progress Phase**: Update on ongoing work
3. **Complete Phase**: Final results and learnings

---

## 21. GITHUB INTEGRATION

### Overview

V3 provides 8 specialized GitHub modes for comprehensive repository management.

### GitHub Modes

| Mode | Purpose |
|------|---------|
| `gh-coordinator` | Orchestrate all GitHub operations |
| `pr-manager` | Pull request automation |
| `issue-tracker` | Issue management and triage |
| `release-manager` | Release orchestration |
| `repo-architect` | Repository structure management |
| `code-reviewer` | Automated code review |
| `ci-orchestrator` | CI/CD pipeline management |
| `security-guardian` | Security scanning and alerts |

### GitHub Commands

```bash
# Initialize GitHub integration
npx claude-flow@v3alpha github init --token $GITHUB_TOKEN

# Create automated workflow
npx claude-flow@v3alpha github workflow create --template ci-cd

# Start swarm coordination
npx claude-flow@v3alpha github swarm start --mode gh-coordinator

# Review PR with agents
npx claude-flow@v3alpha github review --pr 123
npx claude-flow@v3alpha github review --pr 123 --agents security,performance

# Prepare release
npx claude-flow@v3alpha github release prepare --version minor

# Execute release
npx claude-flow@v3alpha github release execute --tag v3.0.0
```

### Self-Healing CI Pipeline

```yaml
# .github/workflows/self-healing.yml
name: Self-Healing CI
on:
  workflow_run:
    workflows: ["CI"]
    types: [completed]

jobs:
  analyze-failure:
    if: ${{ github.event.workflow_run.conclusion == 'failure' }}
    runs-on: ubuntu-latest
    steps:
      - uses: claude-flow/diagnose-action@v3
        with:
          mode: auto-fix
          create-pr: true
```

---

## 22. UV PACKAGE MANAGER

### Overview

uv is an ultra-fast Python package manager (written in Rust):

- **10-100x Faster** than pip
- **Lockfile Support** - Reproducible installs
- **Tool Management** - Install CLI tools globally

### Installation

```bash
# Installed by setup.sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Commands

```bash
# Install packages (in project)
uv add requests pandas

# Install tools globally
uv tool install specify-cli

# Create virtual environment
uv venv

# Sync dependencies
uv sync

# Run Python scripts
uv run python script.py

# Pip compatibility
uv pip install package-name
```

---

## 23. COMMAND REFERENCE

### Claude Code Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `claude` | `claude` | Start Claude Code |
| `dsp` | `claude --dangerously-skip-permissions` | Skip permission prompts |

### Claude Flow v3 Aliases

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
cf-task <agent> "task"    # Quick agent task
```

### Agentic QE Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `aqe` | `npx -y agentic-qe` | Base command |
| `aqe-init` | `npx -y agentic-qe init` | Initialize |
| `aqe-generate` | `npx -y agentic-qe generate` | Generate tests |
| `aqe-flaky` | `npx -y agentic-qe flaky` | Hunt flaky tests |
| `aqe-gate` | `npx -y agentic-qe gate` | Quality gate |
| `aqe-mcp` | `npx -y aqe-mcp` | MCP server |

### Testing Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `playwriter` | `cd ~/.playwriter && npm start` | Interactive mode |
| `pw-generate` | `cd ~/.playwriter && npm run generate` | Generate tests |
| `pw-test` | (function) | Generate test from description |

### Frontend Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `dev-browser` | `cd ~/.dev-browser && npm run dev` | Launch visual dev |
| `devb` | `cd ~/.dev-browser && npm run dev` | Short alias |
| `security-scan` | `cd ~/.security-analyzer && npm run scan` | Vulnerability scan |
| `sec-audit` | `npx -y claude-flow@v3alpha security audit` | Security audit |

### Spec Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `sk` | `specify` | Spec-Kit |
| `sk-init` | `specify init` | Initialize |
| `sk-check` | `specify check` | Check installation |
| `sk-here` | `specify init . --ai claude` | Init with Claude |
| `os` | `openspec` | OpenSpec |
| `os-init` | `openspec init` | Init OpenSpec |
| `os-list` | `openspec list` | List changes |
| `os-validate` | `openspec validate` | Validate change |

### Skills Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `skills` | `npx ai-agent-skills` | Base command |
| `skills-list` | `npx ai-agent-skills list` | List skills |
| `skills-install` | `npx ai-agent-skills install` | Install skill |

### Helper Functions

| Function | Description |
|----------|-------------|
| `turbo-init` | Initialize full workspace |
| `turbo-help` | Quick reference |
| `turbo-status` | Check all tools |

### Tmux Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `t` | `tmux` | Tmux |
| `tns` | `tmux new-session -s` | New named session |
| `tat` | `tmux attach-session -t` | Attach to session |
| `tls` | `tmux list-sessions` | List sessions |
| `tks` | `tmux kill-session -t` | Kill session |
| `tsh` | `tmux split-window -h` | Split horizontal |
| `tsv` | `tmux split-window -v` | Split vertical |

---

## 24. WORKFLOWS

### Workflow 1: New Project Setup

```bash
# 1. Create project directory
mkdir my-project && cd my-project

# 2. Initialize all tools
npm init -y
cf-init                   # Claude Flow v3
sk-here                   # Spec-Kit
os-init                   # OpenSpec
aqe init                  # Agentic QE

# 3. Start development
claude
```

### Workflow 2: Feature Development (Full Pipeline)

```bash
# 1. Create specification with OpenSpec
os-init
claude
> "/openspec:proposal Add OAuth authentication"

# 2. Plan with SPARC
npx claude-flow@v3alpha sparc run architect "OAuth authentication"

# 3. Implement with agents
cf-agent coder --task "Implement OAuth following specs"

# 4. Generate tests with AI
pw-test "user can login with Google OAuth"
pw-test "user can login with GitHub OAuth"

# 5. Run quality pipeline
aqe run --analyze
aqe quality-gate --coverage 95

# 6. Security audit
sec-audit

# 7. Archive spec
openspec archive add-oauth
```

### Workflow 3: Quick Task with Swarm

```bash
# Simple task
cf-swarm
npx claude-flow@v3alpha swarm "fix the login bug in auth.ts" --mode parallel
```

### Workflow 4: AI-Powered Testing Pipeline

```bash
# 1. Describe tests in natural language
pw-test "users can register with email"
pw-test "users receive confirmation email after registration"
pw-test "duplicate emails are rejected with error"

# 2. Run and analyze
npx playwright test
aqe run --analyze

# 3. Quality gate
aqe quality-gate --coverage 90

# 4. Hunt for flaky tests
aqe flaky-hunt --runs 50
```

### Workflow 5: Visual Development with HeroUI

```bash
# 1. Launch dev-browser
dev-browser

# 2. Create components visually with AI
# "Create a dashboard with sidebar navigation and stats cards"

# 3. Export to project
# Components use HeroUI + Tailwind

# 4. Run in your app
npm run dev
```

### Workflow 6: Security-First Development

```bash
# 1. Start with security audit
sec-audit

# 2. Initialize with security agent
cf-security "analyze codebase for vulnerabilities"

# 3. Implement with security review
cf-agent coder --task "implement authentication"
npx claude-flow@v3alpha github review --pr 123 --agents security

# 4. Final scan
security-scan
```

### Workflow 7: Neural Learning Pipeline

```bash
# 1. Bootstrap neural intelligence
cf-pretrain --model-type moe

# 2. Train on successful patterns
cf-train --pattern_type coordination \
  --training_data "successful API development workflows"

# 3. Use intelligent routing
cf-route "build user management system"
# Routes to best agent based on learned patterns

# 4. Review what was learned
cf-patterns list --type coordination
```

### Master Prompt Pattern

Use this pattern to maximize agent utilization:

```
"Using Claude Flow v3 swarm with hierarchical-mesh topology:

[Your specific task here]

Steps:
1. Initialize appropriate agents from the 54+ available
2. Train neural patterns on relevant workflows
3. Route tasks to specialized agents
4. Store learnings in AgentDB
5. Produce final deliverable with quality gate"
```

---

## 25. MIGRATION FROM V1.0.5

### Removed Components

These are no longer needed - Claude Flow v3 handles them internally:

| Removed | Replacement |
|---------|-------------|
| `claudish` | v3 native multi-provider routing |
| `pal-mcp-server` | v3 native multi-provider routing |
| `agtrace` | v3 statusline + metrics |
| `n8n-mcp` | v3 MCP integration |
| `@playwright/mcp` | v3 native browser automation |
| `chrome-devtools-mcp` | v3 native browser automation |
| `610ClaudeSubagents` | v3 has 54+ native agents |
| `agentic-flow` (npm) | v3 integrates internally |
| `agentic-jujutsu` (npm) | v3 integrates internally |

### Updated Commands

| v1.0.5 | v1.0.6 |
|--------|--------|
| `cf-hive` | `cf-swarm` |
| `cf-spawn` | `cf-agent <type>` |
| `claudish --model X` | Built into v3 routing |
| `agt-watch` | `cf-progress` |
| `claude-flow@alpha` | `claude-flow@v3alpha` |

### New Commands

```bash
# Neural learning
cf-train                  # Train patterns
cf-route "task"           # Intelligent routing
cf-pretrain               # Bootstrap intelligence

# AI test generation
pw-test "description"     # Generate Playwright test

# Visual development
dev-browser               # Launch visual IDE

# Security
sec-audit                 # Security audit
security-scan             # Vulnerability scan
```

### Migration Steps

```bash
# 1. Update the repository
cd turbo-flow-claude
git pull origin main

# 2. Run new setup
./devpods/setup.sh

# 3. Reload aliases
source ~/.bashrc

# 4. Migrate Claude Flow memory
npx claude-flow@v3alpha memory migrate --from json --to agentdb

# 5. Verify
turbo-status
```

---

## 26. TROUBLESHOOTING

### Verify Installation

```bash
turbo-status
# Shows: Node version, Claude Flow, agents, tools status
```

### Claude Flow v3 Issues

```bash
# Re-initialize
cf-init

# Check progress
cf-progress --detailed

# Retrain neural patterns
cf-pretrain --model-type moe

# Check memory status
npx claude-flow@v3alpha memory status
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

### Security Analyzer Issues

```bash
# Reinstall
rm -rf ~/.security-analyzer
git clone https://github.com/Cornjebus/security-analyzer ~/.security-analyzer
cd ~/.security-analyzer && npm install
```

### Node.js < 20

```bash
# Upgrade Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs

# Or with n
sudo npm install -g n
sudo n 20
```

### MCP Issues

```bash
# List registered servers
claude mcp list

# Remove problematic server
claude mcp remove claude-flow

# Re-add
claude mcp add claude-flow --scope user -- npx -y claude-flow@v3alpha mcp start

# Check config
cat ~/.config/claude/mcp.json
```

### Permission Issues

```bash
# Fix DevPod permissions
sudo chown -R $(whoami):staff ~/.devpod
find ~/.devpod -type d -exec chmod 755 {} \;
```

### Memory Issues

```bash
# Check memory status
npx claude-flow@v3alpha memory status

# Clear memory
npx claude-flow@v3alpha memory clear --namespace all

# Migrate if needed
npx claude-flow@v3alpha memory migrate --from json --to agentdb
```

---

## 27. RESOURCES

### Official Documentation

| Resource | URL |
|----------|-----|
| Turbo Flow Claude | https://github.com/marcuspat/turbo-flow-claude |
| Claude Flow v3 | https://github.com/ruvnet/claude-flow |
| Claude Code | https://code.claude.com/docs |
| Anthropic Docs | https://docs.anthropic.com |

### Tools Documentation

| Tool | URL |
|------|-----|
| Agentic QE | https://www.npmjs.com/package/agentic-qe |
| Playwriter | https://github.com/remorses/playwriter |
| Dev-Browser | https://github.com/SawyerHood/dev-browser |
| Security Analyzer | https://github.com/Cornjebus/security-analyzer |
| HeroUI | https://heroui.com |
| OpenSpec | https://github.com/Fission-AI/OpenSpec |
| Spec-Kit | https://github.com/github/spec-kit |
| AI Agent Skills | https://github.com/skillcreatorai/Ai-Agent-Skills |

### Community

| Resource | URL |
|----------|-----|
| Agentics Foundation Discord | https://discord.com/invite/dfxmpwkG2D |
| Claude Flow Issues | https://github.com/ruvnet/claude-flow/issues |
| Turbo Flow Issues | https://github.com/marcuspat/turbo-flow-claude/issues |

### Credits

| Contributor | Contribution |
|-------------|--------------|
| Reuven Cohen (ruvnet) | Claude Flow v3, RuvVector |
| Marcus Patman | Turbo Flow Claude |
| Anthropic | Claude Code CLI |
| Fission AI | OpenSpec |
| GitHub | Spec-Kit |
| remorses | Playwriter |
| SawyerHood | Dev-Browser |
| Cornjebus | Security Analyzer |
| HeroUI Team | HeroUI Component Library |

---

## APPENDIX: QUICK START CHEAT SHEET

```bash
# ═══════════════════════════════════════════════════════════
# TURBO FLOW v1.0.6 - QUICK START CHEAT SHEET
# ═══════════════════════════════════════════════════════════

# SETUP
source ~/.bashrc              # Load aliases
turbo-init                    # Initialize workspace
turbo-status                  # Check all tools
turbo-help                    # Quick reference

# CLAUDE CODE
claude                        # Start Claude
dsp                          # Skip permissions mode

# CLAUDE FLOW v3
cf-init                       # Initialize
cf-swarm                      # Hierarchical swarm
cf-agent coder "task"         # Run agent
cf-list                       # List 54+ agents

# NEURAL (RUVVECTOR)
cf-pretrain                   # Bootstrap intelligence
cf-train                      # Train patterns
cf-route "task"               # Intelligent routing
cf-patterns list              # View patterns

# MEMORY
cf-memory "query"             # Search memory
npx claude-flow@v3alpha memory status  # Check status

# SPARC
npx claude-flow@v3alpha sparc tdd "task"  # TDD workflow
npx claude-flow@v3alpha sparc modes       # List modes

# TESTING
aqe init                      # Initialize AQE
aqe-generate                  # Generate tests
aqe-gate                      # Quality gate
pw-test "description"         # AI test generation

# FRONTEND
dev-browser                   # Visual development
# HeroUI + Tailwind pre-installed

# SECURITY
sec-audit                     # Security audit
security-scan                 # Vulnerability scan

# SPECS
sk-here                       # Init Spec-Kit
os-init                       # Init OpenSpec

# SKILLS
skills-list                   # Browse skills
skills-install NAME           # Install skill
```

---

*End of Manual*

*Generated for Turbo Flow Claude v1.0.6 Alpha (Lean Stack Edition)*

*Powered by RuvVector Neural Engine*

*For updates: https://github.com/marcuspat/turbo-flow-claude*
