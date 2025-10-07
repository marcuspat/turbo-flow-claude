# Claude Flow & Agentic Flow Aliases Guide

This document provides a comprehensive reference for all shell aliases and utility functions configured for **Claude-Flow v2.5.0 Alpha 130** and **Agentic-Flow**. These shortcuts streamline your workflow and make interacting with both frameworks faster and more intuitive.

**Performance Note**: Claude-Flow v2.5.0 introduces 100-600x speedup through Claude Code SDK integration, session forking, and in-process MCP servers. Agentic-Flow adds multi-model routing with up to 99% cost savings.

---

## Table of Contents

- [Claude-Flow Aliases](#claude-flow-aliases)
  - [Core Commands](#core-commands)
  - [Initialization & Setup](#initialization--setup)
  - [Hive-Mind Operations](#hive-mind-operations)
  - [Swarm Operations](#swarm-operations)
  - [Memory Management](#memory-management)
  - [Neural Operations (SAFLA)](#neural-operations-safla)
  - [Goal Planning (GOAP)](#goal-planning-goap)
  - [Agent Management](#agent-management)
  - [Hooks System](#hooks-system)
  - [GitHub Integration](#github-integration)
  - [Flow Nexus Cloud](#flow-nexus-cloud)
  - [Performance & Analytics](#performance--analytics)
  - [Benchmarking System](#benchmarking-system)
  - [Hive-Mind Configuration](#hive-mind-configuration)
  - [Verification & Testing](#verification--testing)
  - [Pairing & Collaboration](#pairing--collaboration)
  - [SPARC Methodology](#sparc-methodology)
  - [Quick Commands](#quick-commands-shortcuts)
  - [Monitoring & Debugging](#monitoring--debugging)
  - [Help & Documentation](#help--documentation)
  - [Utility Functions](#claude-flow-utility-functions)
- [Agentic-Flow Aliases](#agentic-flow-aliases)
  - [Core Commands](#agentic-flow-core-commands)
  - [Agent Execution](#agent-execution)
  - [Model Optimization](#model-optimization)
  - [Provider Selection](#provider-selection)
  - [MCP Server Management](#mcp-server-management)
  - [Custom MCP Servers](#custom-mcp-servers)
  - [Specific MCP Servers](#specific-mcp-servers)
  - [Agent Types](#agent-types-150-agents)
  - [GitHub Integration Agents](#github-integration-agents)
  - [Swarm Coordinators](#swarm-coordinators)
  - [Docker Deployment](#docker-deployment)
  - [Information & Help](#information--help)
  - [Environment Setup](#environment-setup)
  - [Quick Commands](#agentic-flow-quick-commands)
  - [Utility Functions](#agentic-flow-utility-functions)

---

# Claude-Flow Aliases

## Core Commands

Primary commands for interacting with Claude-Flow, automatically wrapping requests with necessary context.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf` | `./cf-with-context.sh` | Base command. Runs any `claude-flow` command with auto-loaded context (CLAUDE.md, CCFOREVER.md, agents). |
| `cf-swarm` | `./cf-with-context.sh swarm` | Initiates a swarm of agents on a task with auto-loaded context. |
| `cf-hive` | `./cf-with-context.sh hive-mind spawn` | Spawns a hive-mind session for complex tasks with auto-loaded context. |
| `cf-dsp` | `claude --dangerously-skip-permissions` | Shortcut for Claude Code CLI, bypassing permission prompts. |
| `dsp` | `claude --dangerously-skip-permissions` | Even shorter alias for `cf-dsp`. |

**Example Usage:**
```bash
cf swarm "Build a REST API with authentication"
cf-hive "Implement enterprise microservices architecture"
dsp  # Quick access to Claude Code without permissions
```

---

## Initialization & Setup

Commands for setting up and verifying your Claude-Flow environment.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-init` | `npx claude-flow@alpha init --force` | Forces re-initialization of the Claude-Flow environment. |
| `cf-init-nexus` | `npx claude-flow@alpha init --flow-nexus` | Initializes environment with Flow Nexus cloud features enabled. |

**Example Usage:**
```bash
cf-init              # Initialize or reinitialize Claude-Flow
cf-init-nexus        # Initialize with cloud capabilities
```

---

## Hive-Mind Operations

For managing complex, multi-agent sessions with persistent memory.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-spawn` | `npx claude-flow@alpha hive-mind spawn` | Spawns a new hive-mind session. |
| `cf-wizard` | `npx claude-flow@alpha hive-mind wizard` | Starts interactive wizard to configure a hive-mind session. |
| `cf-resume` | `npx claude-flow@alpha hive-mind resume` | Resumes a previously saved hive-mind session. |
| `cf-status` | `npx claude-flow@alpha hive-mind status` | Checks status of the current hive-mind session. |

**Example Usage:**
```bash
cf-wizard            # Interactive setup
cf-spawn "Build user authentication system"
cf-status            # Check current session
cf-resume session-12345  # Resume previous session
```

---

## Swarm Operations

For simpler, single-prompt agent swarms.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-continue` | `npx claude-flow@alpha swarm --continue-session` | Continues the last swarm session. |
| `cf-swarm-temp` | `npx claude-flow@alpha swarm --temp` | Runs temporary swarm that won't be saved to memory. |
| `cf-swarm-namespace` | `npx claude-flow@alpha swarm --namespace` | Runs swarm within a specific project namespace. |
| `cf-swarm-init` | `npx claude-flow@alpha swarm init` | Initializes a new swarm configuration. |

**Example Usage:**
```bash
cf-continue          # Continue last swarm
cf-swarm-temp "Quick prototype without saving"
cf-swarm-namespace auth-service "Implement OAuth2"
```

---

## Memory Management

For interacting with the agent's long-term SQLite-based memory system.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-memory-stats` | `npx claude-flow@alpha memory stats` | Displays statistics about memory usage. |
| `cf-memory-list` | `npx claude-flow@alpha memory list` | Lists all items in memory. |
| `cf-memory-query` | `npx claude-flow@alpha memory query` | Queries memory with a specific search term. |
| `cf-memory-recent` | `npx claude-flow@alpha memory query --recent` | Shows most recent memory entries. |
| `cf-memory-clear` | `npx claude-flow@alpha memory clear` | Clears the entire memory. |
| `cf-memory-export` | `npx claude-flow@alpha memory export` | Exports memory to a file. |
| `cf-memory-import` | `npx claude-flow@alpha memory import` | Imports memory from a file. |

**Example Usage:**
```bash
cfm                  # Quick memory stats (shortcut)
cf-memory-query "authentication patterns"
cf-memory-export ./backup.db
cf-memory-import ./backup.db
```

---

## Neural Operations (SAFLA)

Self-Aware Feedback Loop Algorithm commands for intelligent learning systems.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-neural-init` | `npx claude-flow@alpha neural init` | Initializes the neural module in current project. |
| `cf-neural-init-force` | `npx claude-flow@alpha neural init --force` | Force overwrites existing neural module. |
| `cf-neural-init-target` | `npx claude-flow@alpha neural init --target` | Installs neural module to custom directory. |
| `cf-neural-train` | `npx claude-flow@alpha neural train` | Trains neural patterns from data. |
| `cf-neural-predict` | `npx claude-flow@alpha neural predict` | Makes predictions using trained models. |
| `cf-neural-status` | `npx claude-flow@alpha neural status` | Shows neural system status. |
| `cf-neural-models` | `npx claude-flow@alpha neural models` | Lists available neural models. |

**Note**: Neural agents use `@agent-safla-neural "task"` syntax in Claude Code, not CLI commands.

**Example Usage:**
```bash
cf-neural-init       # Initialize neural capabilities
cf-neural-train      # Train on current dataset
cf-neural-status     # Check training progress
```

---

## Goal Planning (GOAP)

Goal-Oriented Action Planning commands for intelligent task decomposition.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-goal-init` | `npx claude-flow@alpha goal init` | Initializes the goal module in current project. |
| `cf-goal-init-force` | `npx claude-flow@alpha goal init --force` | Force overwrites existing goal module. |
| `cf-goal-init-target` | `npx claude-flow@alpha goal init --target` | Installs goal module to custom directory. |
| `cf-goal-plan` | `npx claude-flow@alpha goal plan` | Creates an action plan for a goal. |
| `cf-goal-execute` | `npx claude-flow@alpha goal execute` | Executes a planned goal. |
| `cf-goal-status` | `npx claude-flow@alpha goal status` | Shows goal execution status. |

**Note**: GOAP agents use `@agent-goal-planner "task"` syntax in Claude Code, not CLI commands.

**Example Usage:**
```bash
cf-goal-init         # Initialize goal planning
cf-goal-plan "Deploy microservices to production"
cf-goal-execute      # Execute the plan
cf-goal-status       # Check execution progress
```

---

## Agent Management

Commands for managing specialized agents.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-agents-list` | `npx claude-flow@alpha agents list` | Lists all available agents. |
| `cf-agents-spawn` | `npx claude-flow@alpha agents spawn` | Spawns a new agent instance. |
| `cf-agents-status` | `npx claude-flow@alpha agents status` | Shows status of all agents. |
| `cf-agents-assign` | `npx claude-flow@alpha agents assign` | Assigns tasks to specific agents. |

**Note**: Most agent operations use `@agent-name "task"` syntax in Claude Code for direct invocation.

**Example Usage:**
```bash
cfa                  # Quick agent list (shortcut)
cf-agents-status     # Check all agents
```

---

## Hooks System

Commands for managing automated workflow hooks.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-hooks-list` | `npx claude-flow@alpha hooks list` | Lists all configured hooks. |
| `cf-hooks-enable` | `npx claude-flow@alpha hooks enable` | Enables specific hooks. |
| `cf-hooks-disable` | `npx claude-flow@alpha hooks disable` | Disables specific hooks. |
| `cf-hooks-config` | `npx claude-flow@alpha hooks config` | Configures hook settings. |

**Note**: Hooks are primarily configured in `.claude/settings.json` via the init command.

**Example Usage:**
```bash
cf-hooks-list        # See all hooks
cf-hooks-enable pre-commit
cf-hooks-disable post-deploy
```

---

## GitHub Integration

Commands for GitHub repository management and automation.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-github-init` | `npx claude-flow@alpha github init` | Initializes GitHub integration with automatic releases. |
| `cf-github-sync` | `npx claude-flow@alpha github sync` | Synchronizes with GitHub repository. |
| `cf-github-pr` | `npx claude-flow@alpha github pr` | Manages pull requests. |
| `cf-github-issues` | `npx claude-flow@alpha github issues` | Manages GitHub issues. |
| `cf-github-analyze` | `npx claude-flow@alpha github analyze` | Analyzes repository health. |
| `cf-github-migrate` | `npx claude-flow@alpha github migrate` | Migrates repository data. |

**Example Usage:**
```bash
cf-github-init       # Setup GitHub integration
cfg                  # Quick GitHub analysis (shortcut)
cf-github-pr create "New feature implementation"
```

---

## Flow Nexus Cloud

Commands for cloud-based AI development platform.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-nexus-login` | `npx claude-flow@alpha nexus login` | Logs into Flow Nexus platform. |
| `cf-nexus-sandbox` | `npx claude-flow@alpha nexus sandbox` | Manages cloud sandboxes. |
| `cf-nexus-swarm` | `npx claude-flow@alpha nexus swarm` | Deploys cloud-based swarms. |
| `cf-nexus-deploy` | `npx claude-flow@alpha nexus deploy` | Deploys applications to cloud. |
| `cf-nexus-challenges` | `npx claude-flow@alpha nexus challenges` | Accesses coding challenges. |
| `cf-nexus-marketplace` | `npx claude-flow@alpha nexus marketplace` | Accesses template marketplace. |

**Note**: Flow Nexus primarily uses MCP tool syntax: `mcp__flow-nexus__user_register({...})`.

**Example Usage:**
```bash
cf-nexus-login       # Authenticate
cfn "Deploy distributed API swarm"  # Quick swarm (shortcut)
cf-nexus-sandbox create --template node
```

---

## Performance & Analytics

Commands for benchmarking and performance analysis.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-benchmark` | `npx claude-flow@alpha benchmark` | Runs performance benchmarks. |
| `cf-analyze` | `npx claude-flow@alpha analyze` | Analyzes system performance. |
| `cf-optimize` | `npx claude-flow@alpha optimize` | Optimizes configurations. |
| `cf-metrics` | `npx claude-flow@alpha metrics` | Shows performance metrics. |

**Example Usage:**
```bash
cf-benchmark         # Run full benchmark suite
cf-metrics           # View current metrics
```

---

## Benchmarking System

Comprehensive performance testing and analysis commands.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-swarm-bench` | `swarm-bench` | Main benchmarking command. |
| `cf-bench-run` | `swarm-bench run` | Runs benchmark suite. |
| `cf-bench-load` | `swarm-bench load-test` | Performs load testing. |
| `cf-bench-swe` | `swarm-bench swe-bench official` | Runs SWE-bench evaluation. |
| `cf-bench-multi` | `swarm-bench swe-bench multi-mode` | Multi-mode SWE-bench comparison. |
| `cf-bench-compare` | `swarm-bench compare` | Compares benchmark results. |
| `cf-bench-monitor` | `swarm-bench monitor --dashboard` | Opens real-time monitoring dashboard. |
| `cf-bench-diagnose` | `swarm-bench diagnose` | Diagnoses performance issues. |
| `cf-bench-analyze` | `swarm-bench analyze-errors` | Analyzes error patterns. |
| `cf-bench-optimize` | `swarm-bench optimize` | Optimizes based on benchmarks. |

**Example Usage:**
```bash
cf-bench-run         # Standard benchmark
cf-bench-load        # Load testing
cf-bench-monitor     # Live dashboard
```

---

## Hive-Mind Configuration

Commands for configuring hive-mind topology and behavior.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-hive-init` | `claude-flow hive init` | Initializes hive with default settings. |
| `cf-hive-monitor` | `claude-flow hive monitor` | Monitors hive activity in real-time. |
| `cf-hive-health` | `claude-flow hive health` | Checks hive health status. |
| `cf-hive-config` | `claude-flow hive config set` | Sets hive configuration options. |

**Example Usage:**
```bash
cf-hive-init         # Initialize hive
cf-hive-monitor      # Watch agents work
cf-hive-health       # Health check
```

---

## Verification & Testing

Commands for validation and testing.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-verify` | `npx claude-flow@alpha verify` | Verifies system integrity. |
| `cf-truth` | `npx claude-flow@alpha truth` | Runs truth validation checks. |
| `cf-test` | `npx claude-flow@alpha test` | Executes test suites. |
| `cf-validate` | `npx claude-flow@alpha validate` | Validates configurations. |

**Example Usage:**
```bash
cf-verify            # System verification
cf-test              # Run tests
```

---

## Pairing & Collaboration

Commands for collaborative development.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-pair` | `npx claude-flow@alpha pair --start` | Starts pairing session. |
| `cf-pair-stop` | `npx claude-flow@alpha pair --stop` | Stops pairing session. |
| `cf-pair-status` | `npx claude-flow@alpha pair --status` | Shows pairing status. |

**Example Usage:**
```bash
cf-pair              # Start pair programming
cf-pair-status       # Check session
cf-pair-stop         # End session
```

---

## SPARC Methodology

Commands for Specification, Pseudocode, Architecture, Refinement, Completion workflow.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-sparc-init` | `npx claude-flow@alpha sparc init` | Initializes SPARC workflow. |
| `cf-sparc-plan` | `npx claude-flow@alpha sparc plan` | Creates plan for current task. |
| `cf-sparc-execute` | `npx claude-flow@alpha sparc execute` | Executes planned actions. |
| `cf-sparc-review` | `npx claude-flow@alpha sparc review` | Reviews execution results. |

**Note**: SPARC operations primarily use agent spawn patterns.

**Example Usage:**
```bash
cf-sparc-init        # Start SPARC workflow
cf-sparc-plan        # Create execution plan
cf-sparc-execute     # Execute plan
cf-sparc-review      # Review results
```

---

## Quick Commands (Shortcuts)

Single-letter and abbreviated aliases for common operations.

| Alias | Base Command | Description |
|-------|--------------|-------------|
| `cfs` | `cf-swarm` | Quick shortcut for swarm operations. |
| `cfh` | `cf-hive` | Quick shortcut for hive-mind spawn. |
| `cfr` | `cf-resume` | Quick shortcut for resume session. |
| `cfst` | `cf-status` | Quick shortcut for status check. |
| `cfm` | `cf-memory-stats` | Quick shortcut for memory stats. |
| `cfmq` | `cf-memory-query` | Quick shortcut for memory query. |
| `cfa` | `cf-agents-list` | Quick shortcut for agent list. |
| `cfg` | `cf-github-analyze` | Quick shortcut for GitHub analysis. |
| `cfn` | `cf-nexus-swarm` | Quick shortcut for Nexus swarm. |

**Example Usage:**
```bash
cfs "Build REST API"         # Quick swarm
cfm                          # Memory stats
cfa                          # List agents
```

---

## Monitoring & Debugging

Commands for system monitoring and troubleshooting.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-monitor` | `claude-monitor` | Opens monitoring interface. |
| `cf-logs` | `npx claude-flow@alpha logs` | Views system logs. |
| `cf-debug` | `npx claude-flow@alpha debug` | Enables debug mode. |
| `cf-trace` | `npx claude-flow@alpha trace` | Shows execution traces. |

**Example Usage:**
```bash
cf-monitor           # Real-time monitoring
cf-logs              # View logs
cf-debug             # Enable debugging
```

---

## Help & Documentation

Commands for accessing documentation and help resources.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-help` | `npx claude-flow@alpha --help` | Shows help information. |
| `cf-docs` | `echo 'Visit: https://github.com/ruvnet/claude-flow/wiki'` | Opens documentation wiki. |
| `cf-examples` | `echo 'Visit: https://github.com/ruvnet/claude-flow/tree/main/examples'` | Opens examples repository. |

**Example Usage:**
```bash
cf-help              # Show all commands
cf-docs              # View documentation
cf-examples          # See examples
```

---

## Claude-Flow Utility Functions

Advanced shell functions that accept arguments for dynamic operations.

### `cf-task "your task description"`
Quickly starts a swarm for a given task using the `--claude` flag.

```bash
cf-task "Build a REST API with authentication"
cf-task "Implement user management system"
```

### `cf-hive-ns "your task" "namespace"`
Spawns a hive-mind session for a task within a specified namespace.

```bash
cf-hive-ns "Implement user management" "auth-service"
cf-hive-ns "Build payment gateway" "payments"
```

### `cf-search "query"`
Searches the memory and includes recent context in the query.

```bash
cf-search "authentication patterns"
cf-search "API design decisions"
```

### `cf-sandbox "template_name" "sandbox_name"`
Creates a new Flow Nexus cloud sandbox from a template.

```bash
cf-sandbox "node" "api-development"
cf-sandbox "python" "ml-training"
```

### `cf-session [list | resume <id> | status]`
Helper to manage hive-mind sessions.

```bash
cf-session list                    # List all sessions
cf-session resume session-12345    # Resume specific session
cf-session status                  # Check current status
```

### `cf-hive-topology "topology" [options]`
Initializes hive with specific topology (mesh, hierarchical, ring, star).

```bash
cf-hive-topology mesh --agents 8
cf-hive-topology hierarchical --agents 12
cf-hive-topology ring --agents 6
```

### `cf-bench-quick`
Runs quick benchmark comparison across multiple configurations.

```bash
cf-bench-quick
```

### `cf-load-test [agents] [tasks]`
Performs load testing with specified agent and task counts.

```bash
cf-load-test 50 100    # 50 agents, 100 tasks
cf-load-test           # Uses defaults: 20 agents, 200 tasks
```

---

# Agentic-Flow Aliases

## Agentic-Flow Core Commands

Primary commands for interacting with Agentic-Flow and its context wrapper system.

| Alias | Command | Description |
|-------|---------|-------------|
| `af` | `./af-with-context.sh` | Base command. Runs any `agentic-flow` command with auto-loaded context. |
| `agentic-flow` | `npx agentic-flow` | Direct access to agentic-flow CLI without context wrapper. |

**Example Usage:**
```bash
af --agent coder --task "Build REST API"
agentic-flow --list  # Direct command
```

---

## Agent Execution

Commands for running agents with various execution modes.

| Alias | Command | Description |
|-------|---------|-------------|
| `af-run` | `npx agentic-flow --agent` | Run a specific agent (requires agent name and task). |
| `af-stream` | `npx agentic-flow --stream` | Enable real-time streaming output during agent execution. |
| `af-parallel` | `npx agentic-flow` | Run multi-agent swarm (uses TOPIC, DIFF, DATASET env vars). |

**Example Usage:**
```bash
af-run coder --task "Build REST API"
af-stream --agent researcher --task "Analyze trends"
export TOPIC="API security" DIFF="feat: OAuth" DATASET="logs.csv"
af-parallel
```

---

## Model Optimization

Commands for intelligent model selection and cost optimization.

| Alias | Command | Description |
|-------|---------|-------------|
| `af-optimize` | `npx agentic-flow --optimize` | Auto-select optimal model for task (balanced quality/cost). |
| `af-optimize-cost` | `npx agentic-flow --optimize --priority cost` | Prioritize cheapest models (99% savings). |
| `af-optimize-quality` | `npx agentic-flow --optimize --priority quality` | Prioritize highest quality models. |
| `af-optimize-speed` | `npx agentic-flow --optimize --priority speed` | Prioritize fastest response models. |
| `af-optimize-privacy` | `npx agentic-flow --optimize --priority privacy` | Use only local ONNX models (100% offline). |

**Optimization Priorities:**
- **quality**: 70% quality, 20% speed, 10% cost
- **balanced**: 40% quality, 40% cost, 20% speed (default)
- **cost**: 70% cost, 20% quality, 10% speed
- **speed**: 70% speed, 20% quality, 10% cost
- **privacy**: Local-only, zero cloud API calls

**Example Usage:**
```bash
afo --agent coder --task "Build API"  # Shortcut for optimize
af-optimize-cost --agent tester --task "Write tests"
af-optimize-privacy --agent researcher --task "Analyze medical data"
```

---

## Provider Selection

Commands for selecting specific AI model providers.

| Alias | Command | Description |
|-------|---------|-------------|
| `af-openrouter` | `npx agentic-flow --model` | Use OpenRouter models (99% cost savings). |
| `af-gemini` | `npx agentic-flow --provider gemini` | Use Google Gemini models (98% cost savings). |
| `af-onnx` | `npx agentic-flow --provider onnx` | Use local ONNX models (100% free). |
| `af-anthropic` | `npx agentic-flow --provider anthropic` | Use Anthropic Claude models (premium quality). |

**Provider Comparison:**
- **Anthropic**: $3-15 per 1M tokens, premium quality
- **OpenRouter**: $0.06-0.55 per 1M tokens, 97-99% savings
- **Gemini**: $0.075-1.25 per 1M tokens, 95-98% savings
- **ONNX**: $0 (free), local inference, privacy-focused

**Example Usage:**
```bash
af-gemini --agent coder --task "Build API"
af-onnx --agent researcher --task "Analyze private data"
af-openrouter meta-llama/llama-3.1-8b-instruct --task "Code review"
```

---

## MCP Server Management

Commands for managing Model Context Protocol (MCP) servers (213 tools total).

| Alias | Command | Description |
|-------|---------|-------------|
| `af-mcp-start` | `npx agentic-flow mcp start` | Start all MCP servers (213 tools). |
| `af-mcp-stop` | `npx agentic-flow mcp stop` | Stop all MCP servers. |
| `af-mcp-status` | `npx agentic-flow mcp status` | Check status of MCP servers. |
| `af-mcp-list` | `npx agentic-flow mcp list` | List all 213 available MCP tools. |

**Available MCP Servers:**
- `claude-flow` - 101 tools (neural networks, GitHub, workflows)
- `flow-nexus` - 96 tools (cloud sandboxes, distributed swarms)
- `agentic-payments` - 10 tools (payment authorization, signatures)
- `claude-flow-sdk` - 6 tools (in-process memory, coordination)

**Example Usage:**
```bash
af-mcp-start         # Start all servers
afm                  # Quick list (shortcut)
af-mcp-status        # Check status
```

---

## Custom MCP Servers

Commands for adding and managing custom MCP servers (v1.2.1+).

| Alias | Command | Description |
|-------|---------|-------------|
| `af-mcp-add` | `npx agentic-flow mcp add` | Add custom MCP server to configuration. |
| `af-mcp-remove` | `npx agentic-flow mcp remove` | Remove MCP server from configuration. |
| `af-mcp-enable` | `npx agentic-flow mcp enable` | Enable previously disabled MCP server. |
| `af-mcp-disable` | `npx agentic-flow mcp disable` | Disable MCP server without removing. |
| `af-mcp-test` | `npx agentic-flow mcp test` | Test MCP server configuration. |
| `af-mcp-export` | `npx agentic-flow mcp export` | Export MCP configuration to file. |
| `af-mcp-import` | `npx agentic-flow mcp import` | Import MCP configuration from file. |

**Configuration Location**: `~/.agentic-flow/mcp-config.json`

**Example Usage:**
```bash
# Add weather MCP server
af-mcp-add weather '{"command":"npx","args":["-y","weather-mcp"],"env":{"API_KEY":"xxx"}}'

# Add GitHub MCP server (flag style)
af-mcp-add github --npm @modelcontextprotocol/server-github --env "GITHUB_TOKEN=ghp_xxx"

# Test configuration
af-mcp-test weather

# Backup configuration
af-mcp-export ./mcp-backup.json
af-mcp-import ./mcp-backup.json
```

---

## Specific MCP Servers

Quick commands for starting individual MCP servers.

| Alias | Command | Description |
|-------|---------|-------------|
| `af-mcp-claude` | `npx agentic-flow mcp start claude-flow` | Start Claude Flow MCP server (101 tools). |
| `af-mcp-nexus` | `npx agentic-flow mcp start flow-nexus` | Start Flow Nexus MCP server (96 tools). |
| `af-mcp-payments` | `npx agentic-flow mcp start agentic-payments` | Start payment authorization server (10 tools). |

**Example Usage:**
```bash
af-mcp-claude        # Only Claude Flow tools
af-mcp-nexus         # Only Flow Nexus tools
```

---

## Agent Types (150+ Agents)

### Core Development Agents

| Alias | Command | Description |
|-------|---------|-------------|
| `af-coder` | `npx agentic-flow --agent coder` | Implementation specialist for clean, efficient code. |
| `af-reviewer` | `npx agentic-flow --agent reviewer` | Code review and quality assurance. |
| `af-tester` | `npx agentic-flow --agent tester` | Comprehensive testing with 90%+ coverage. |
| `af-researcher` | `npx agentic-flow --agent researcher` | Deep research and information gathering. |
| `af-planner` | `npx agentic-flow --agent planner` | Strategic planning and task decomposition. |

### Specialized Development Agents

| Alias | Command | Description |
|-------|---------|-------------|
| `af-backend` | `npx agentic-flow --agent backend-dev` | REST/GraphQL API development. |
| `af-mobile` | `npx agentic-flow --agent mobile-dev` | React Native mobile applications. |
| `af-ml` | `npx agentic-flow --agent ml-developer` | Machine learning model creation. |
| `af-architect` | `npx agentic-flow --agent system-architect` | System design and architecture. |
| `af-cicd` | `npx agentic-flow --agent cicd-engineer` | CI/CD pipeline creation. |
| `af-docs` | `npx agentic-flow --agent api-docs` | OpenAPI/Swagger documentation. |
| `af-perf` | `npx agentic-flow --agent perf-analyzer` | Performance bottleneck detection. |

**Example Usage:**
```bash
afc --task "Build REST API"              # Shortcut for coder
af-backend --task "Create GraphQL schema"
af-ml --task "Train sentiment model"
```

---

## GitHub Integration Agents

| Alias | Command | Description |
|-------|---------|-------------|
| `af-pr` | `npx agentic-flow --agent pr-manager` | Pull request lifecycle management. |
| `af-code-review` | `npx agentic-flow --agent code-review-swarm` | Multi-agent code review coordination. |
| `af-issue` | `npx agentic-flow --agent issue-tracker` | Intelligent issue management. |
| `af-release` | `npx agentic-flow --agent release-manager` | Automated release coordination. |

**Example Usage:**
```bash
af-pr --task "Review PR #123"
af-code-review --task "Analyze security vulnerabilities"
```

---

## Swarm Coordinators

| Alias | Command | Description |
|-------|---------|-------------|
| `af-hierarchical` | `npx agentic-flow --agent hierarchical-coordinator` | Tree-based leadership coordination. |
| `af-mesh` | `npx agentic-flow --agent mesh-coordinator` | Peer-to-peer agent coordination. |
| `af-adaptive` | `npx agentic-flow --agent adaptive-coordinator` | Dynamic topology switching. |
| `af-swarm-memory` | `npx agentic-flow --agent swarm-memory-manager` | Cross-agent memory synchronization. |

**Example Usage:**
```bash
af-mesh --task "Coordinate distributed API build"
af-hierarchical --task "Manage large codebase refactor"
```

**To see all 150+ agents**: `af-list`

---

## Docker Deployment

Commands for containerized agent deployment.

| Alias | Command | Description |
|-------|---------|-------------|
| `af-docker-build` | `docker build -f deployment/Dockerfile -t agentic-flow .` | Build Agentic Flow Docker image. |
| `af-docker-run` | `docker run --rm -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY agentic-flow` | Run agent in Docker container. |

**Docker Benefits:**
- ✅ All 203 MCP tools work (full subprocess support)
- ✅ Reproducible builds and deployments
- ✅ Works on Kubernetes, ECS, Cloud Run, Fargate
- ✅ Isolated execution environment

**Example Usage:**
```bash
af-docker-build
af-docker-run --agent coder --task "Build API"
```

---

## Information & Help

Commands for accessing documentation and system information.

| Alias | Command | Description |
|-------|---------|-------------|
| `af-list` | `npx agentic-flow --list` | List all 150+ available agents. |
| `af-help` | `npx agentic-flow --help` | Show help information and usage. |
| `af-version` | `npx agentic-flow --version` | Display Agentic Flow version. |

**Example Usage:**
```bash
af-list              # See all agents
af-help              # Get help
af-version           # Check version
```

---

## Environment Setup

Quick commands for setting API keys.

| Alias | Command | Description |
|-------|---------|-------------|
| `af-env-anthropic` | `export ANTHROPIC_API_KEY=` | Set Anthropic API key. |
| `af-env-openrouter` | `export OPENROUTER_API_KEY=` | Set OpenRouter API key. |
| `af-env-gemini` | `export GOOGLE_GEMINI_API_KEY=` | Set Google Gemini API key. |

**Example Usage:**
```bash
af-env-anthropic sk-ant-xxx
af-env-openrouter sk-or-v1-xxx
af-env-gemini xxxxx

# Or set directly:
export ANTHROPIC_API_KEY=sk-ant-xxx
export OPENROUTER_API_KEY=sk-or-v1-xxx
export GOOGLE_GEMINI_API_KEY=xxxxx
```

---

## Agentic-Flow Quick Commands

Single-letter and abbreviated aliases for common operations.

| Alias | Base Command | Description |
|-------|--------------|-------------|
| `afr` | `af-run` | Quick shortcut for running agents. |
| `afs` | `af-stream` | Quick shortcut for streaming execution. |
| `afo` | `af-optimize` | Quick shortcut for optimization. |
| `afm` | `af-mcp-list` | Quick shortcut for MCP tool list. |
| `afc` | `af-coder` | Quick shortcut for coder agent. |
| `afrev` | `af-reviewer` | Quick shortcut for reviewer agent. |
| `aft` | `af-tester` | Quick shortcut for tester agent. |

**Example Usage:**
```bash
afc --task "Build API"           # Quick coder
afs --agent researcher --task "Analyze trends"
afo --agent coder --task "Build auth"
```

---

## Agentic-Flow Utility Functions

Advanced shell functions that accept arguments for dynamic operations.

### `af-task "agent" "task description"`
Quickly run an agent task with streaming output enabled.

```bash
af-task coder "Build REST API with authentication"
af-task researcher "Analyze AI trends in 2025"
```

### `af-opt-task "agent" "task description"`
Run an agent task with automatic model optimization.

```bash
af-opt-task reviewer "Review security vulnerabilities"
af-opt-task tester "Write comprehensive unit tests"
```

### `af-cheap "agent" "task description"`
Run an agent task with maximum cost optimization (99% savings).

```bash
af-cheap coder "Write simple CRUD functions"
af-cheap tester "Generate basic test cases"
```

**Cost Comparison:**
- **Without optimization**: $0.08/task (Claude Sonnet 4.5)
- **With af-cheap**: $0.001/task (Llama 3.1 8B)
- **Savings**: 99% ($237/month for 100 daily tasks)

### `af-private "agent" "task description"`
Run an agent task using only local ONNX models (100% offline, free).

```bash
af-private researcher "Analyze confidential medical data"
af-private coder "Process sensitive customer information"
```

**Privacy Benefits:**
- ✅ 100% local processing (no cloud API calls)
- ✅ GDPR/HIPAA compliant
- ✅ $0 cost
- ✅ ~6 tokens/sec CPU, 60-300 tokens/sec GPU

### `af-openai "model" [options]`
Run agent with specific OpenRouter model.

```bash
af-openai meta-llama/llama-3.1-8b-instruct --agent coder --task "Build API"
af-openai deepseek/deepseek-chat-v3.1 --agent reviewer --task "Review code"
```

**Popular OpenRouter Models:**
- `meta-llama/llama-3.1-8b-instruct` - 99% cost savings
- `deepseek/deepseek-chat-v3.1` - Superior code generation, 97% savings
- `google/gemini-2.5-flash-preview` - Fastest responses, 95% savings
- `anthropic/claude-3.5-sonnet` - Full Claude via OpenRouter

### `af-gemini-task "agent" "task description"`
Run agent task using Google Gemini (fast, cost-effective).

```bash
af-gemini-task researcher "Analyze market trends"
af-gemini-task coder "Build simple web scraper"
```

**Gemini Benefits:**
- ✅ 2.5 Flash: FREE up to rate limits
- ✅ Fastest responses (avg 1.5s)
- ✅ 98% cost savings vs Claude

### `af-swarm "topic" "diff" "dataset"`
Run multi-agent swarm with three parallel agents.

```bash
af-swarm "API security" "feat: add OAuth2" "response_times.csv"
# Spawns: researcher + code-reviewer + data-analyst
```

### `af-add-mcp "name" "command"`
Add custom MCP server to configuration.

```bash
af-add-mcp weather 'npx @modelcontextprotocol/server-weather'
af-add-mcp github '{"command":"npx","args":["server-github"]}'
```

### `af-benchmark "task description"`
Run quick benchmark comparison with optimization.

```bash
af-benchmark "Generate API documentation"
af-benchmark "Analyze code performance"
```

---

## Cost Optimization Examples

### Scenario 1: Without Optimization (Always Claude Sonnet 4.5)
```bash
# 100 code reviews/day × $0.08 each = $8/day = $240/month
npx agentic-flow --agent reviewer --task "Review PR"
```

### Scenario 2: With Optimization (DeepSeek R1)
```bash
# 100 code reviews/day × $0.012 each = $1.20/day = $36/month
# Savings: $204/month (85% reduction)
af-optimize --agent reviewer --task "Review PR"
```

### Scenario 3: Maximum Savings (Llama 3.1 8B)
```bash
# 100 simple tasks/day × $0.001 each = $0.10/day = $3/month
# Savings: $237/month (99% reduction)
af-cheap tester "Write unit tests"
```

### Scenario 4: Zero Cost (Local ONNX)
```bash
# 100 private tasks/day × $0.00 each = $0/month
# Savings: $240/month (100% reduction)
af-private researcher "Analyze confidential data"
```

---

## Model Tier Reference

### Tier 1: Flagship (Premium Quality)
- **Claude Sonnet 4.5**: $3/$15 per 1M tokens
- **GPT-4o**: $2.50/$10 per 1M tokens
- **Gemini 2.5 Pro**: $0.00/$2.00 per 1M tokens

### Tier 2: Cost-Effective (2025 Breakthrough)
- **DeepSeek R1**: $0.55/$2.19 per 1M tokens (85% cheaper, flagship quality)
- **DeepSeek Chat V3**: $0.14/$0.28 per 1M tokens (98% cheaper)

### Tier 3: Balanced
- **Gemini 2.5 Flash**: $0.07/$0.30 per 1M tokens (fastest)
- **Llama 3.3 70B**: $0.30/$0.30 per 1M tokens (open-source)

### Tier 4: Budget
- **Llama 3.1 8B**: $0.055/$0.055 per 1M tokens (ultra-low cost)

### Tier 5: Local/Privacy
- **ONNX Phi-4**: FREE (offline, private, no API)

---

## Quick Start Guide

### 1. Installation
```bash
# Run the setup script (installs both Claude-Flow and Agentic-Flow)
./setup.sh

# Activate aliases
source ~/.bashrc
```

### 2. Set API Keys
```bash
# Required for Claude models
export ANTHROPIC_API_KEY=sk-ant-...

# Optional: For 99% cost savings
export OPENROUTER_API_KEY=sk-or-v1-...

# Optional: For speed optimization
export GOOGLE_GEMINI_API_KEY=xxxxx
```

### 3. Initialize Claude-Flow
```bash
cf-init              # Initialize Claude-Flow environment
```

### 4. Start MCP Servers (Optional)
```bash
af-mcp-start         # Starts all 213 tools
# or
cf-mcp-start         # Same servers, Claude-Flow command
```

### 5. Run Your First Agents

**Claude-Flow (Swarm Coordination):**
```bash
# Simple swarm
cfs "Build REST API with authentication"

# Complex hive-mind
cf-wizard
cf-spawn "Build enterprise microservices system"
```

**Agentic-Flow (Cost-Optimized Agents):**
```bash
# Basic execution
afc --task "Build REST API" --stream

# With optimization (recommended)
af-optimize --agent coder --task "Build REST API"

# Maximum cost savings
af-cheap coder "Build simple function"

# Privacy mode (offline)
af-private researcher "Analyze sensitive data"
```

### 6. Add Custom Tools
```bash
# Add weather data
af-mcp-add weather 'npx @modelcontextprotocol/server-weather'

# Add GitHub integration
af-mcp-add github --npm @modelcontextprotocol/server-github
```

---

## Deployment Comparison

| Feature | Claude-Flow | Agentic-Flow |
|---------|-------------|--------------|
| **Primary Use** | Multi-agent swarm coordination | Cost-optimized single agents |
| **MCP Tools** | 213 (all servers) | 213 (all servers) |
| **Model Options** | Claude only | Claude, OpenRouter, Gemini, ONNX |
| **Cost Optimization** | ❌ No | ✅ Yes (up to 99% savings) |
| **Privacy Mode** | ❌ No | ✅ Yes (local ONNX) |
| **Swarm Support** | ✅ Advanced (hive-mind) | ✅ Basic (parallel) |
| **Memory System** | ✅ Persistent SQLite | ✅ Shared memory |
| **Best For** | Complex multi-agent tasks | Cost-sensitive workflows |

---

## Performance Characteristics

### Claude-Flow Performance (v2.5.0)
- **Session Forking**: 10-20x faster parallel agent spawning
- **Hook Matchers**: 2-3x faster selective hook execution
- **In-Process MCP**: 50-100x faster tool calls
- **Combined Speedup**: 100-600x potential gain

### Agentic-Flow Performance

**ONNX Local Inference:**
- **CPU**: ~6 tokens/sec, ~2GB RAM
- **GPU**: 60-300 tokens/sec, ~3GB VRAM
- **Cost**: $0.00 (100% free)
- **Privacy**: 100% local processing

**Cloud APIs:**
- **Latency**: 1-3 seconds first token
- **Throughput**: Variable by provider
- **Cost**: $0.055-15 per 1M tokens

**Model Selection:**
- **Optimization**: <100ms overhead
- **Rule-based routing**: Instant
- **Quality assessment**: Built-in agent profiles

---

## Common Workflows

### Workflow 1: Cost-Optimized Development
```bash
# Initialize environment
cf-init
af-mcp-start

# Development tasks (cheap models)
af-cheap coder "Implement user CRUD"
af-cheap tester "Write unit tests"

# Code review (quality model)
af-optimize --agent reviewer --task "Review security" --priority quality

# Deploy
cf-github-pr create "New feature implementation"
```

### Workflow 2: Privacy-First Analysis
```bash
# All processing stays local
af-private researcher "Analyze patient medical records"
af-private coder "Process confidential financial data"
af-private tester "Test sensitive algorithms"
```

### Workflow 3: Complex Multi-Agent System
```bash
# Claude-Flow for coordination
cf-wizard
cf-hive-topology mesh --agents 12
cf-spawn "Build distributed microservices platform"

# Monitor progress
cf-hive-monitor
cfst  # Check status
```

### Workflow 4: Rapid Prototyping
```bash
# Use fast Gemini models
af-gemini-task coder "Quick prototype REST API"
af-gemini-task tester "Generate basic tests"

# Review with optimized model
af-optimize-speed --agent reviewer --task "Quick review"
```

---

## Troubleshooting

### Problem: Agent Not Found
```bash
# List all available agents
af-list              # Agentic-Flow agents
cfa                  # Claude-Flow agents
```

### Problem: MCP Tools Not Working
```bash
# Check MCP server status
af-mcp-status        # or cf-mcp-status

# Restart MCP servers
af-mcp-stop
af-mcp-start
```

### Problem: High API Costs
```bash
# Enable optimization
af-optimize --agent coder --task "your task"

# Or use cost priority
af-cheap coder "your task"

# Or go fully offline
af-private coder "your task"
```

### Problem: Privacy Concerns
```bash
# Use local-only mode (no cloud API calls)
af-private researcher "sensitive task"

# Verify no cloud calls
af-onnx --agent researcher --task "your task"
```

### Problem: Slow Performance
```bash
# Use speed-optimized models
af-optimize-speed --agent coder --task "your task"

# Or use Gemini (fastest)
af-gemini-task coder "your task"
```

### Problem: Context Not Loading
```bash
# Verify context wrapper scripts exist
ls -l cf-with-context.sh af-with-context.sh

# Recreate if needed
chmod +x cf-with-context.sh af-with-context.sh
```

---

## Installation Script Summary

The setup script (`setup.sh`) automatically installs:

1. ✅ Claude Code CLI
2. ✅ Claude Monitor (usage tracking)
3. ✅ Claude-Flow v2.5.0 Alpha 130
4. ✅ Agentic-Flow (latest)
5. ✅ Context wrapper scripts (cf-with-context.sh, af-with-context.sh)
6. ✅ All aliases (appended to ~/.bashrc)
7. ✅ Claude subagents
8. ✅ Playwright for testing
9. ✅ TypeScript configuration

After installation:
```bash
source ~/.bashrc      # Activate all aliases
cf-init               # Initialize Claude-Flow
af-mcp-start          # Start MCP servers
```

---

## Additional Resources

### Claude-Flow
- **Documentation**: https://github.com/ruvnet/claude-flow/wiki
- **Examples**: https://github.com/ruvnet/claude-flow/tree/main/examples
- **GitHub**: https://github.com/ruvnet/claude-flow

### Agentic-Flow
- **GitHub**: https://github.com/ruvnet/agentic-flow
- **npm Package**: https://npmjs.com/package/agentic-flow
- **Model Benchmarks**: `docs/agentic-flow/benchmarks/`
- **Integration Guides**: `docs/guides/`

### MCP Protocol
- **Official Docs**: https://modelcontextprotocol.io
- **Anthropic MCP**: https://docs.anthropic.com/en/docs/agents-and-tools/mcp

---

## Summary

This guide covers **all aliases** from the `aliases.sh` script:

**Claude-Flow (cf-*):**
- 80+ aliases for swarm coordination, hive-mind operations, memory management, neural ops, GOAP, GitHub integration, Flow Nexus cloud, benchmarking, and more
- 10 utility functions for advanced workflows

**Agentic-Flow (af-*):**
- 60+ aliases for cost-optimized agents, multi-model routing, MCP management, and specialized agents
- 10 utility functions for cost optimization and privacy

**Key Benefits:**
- **Claude-Flow**: 100-600x performance speedup, advanced multi-agent coordination
- **Agentic-Flow**: Up to 99% cost savings, local privacy-first inference
- **Combined**: Best of both worlds - fast coordination + cost optimization

**Get Started:**
```bash
source ~/.bashrc              # Activate all aliases
cf-init                       # Initialize Claude-Flow
af-mcp-start                  # Start 213 MCP tools

# Claude-Flow: Complex coordination
cfs "Build distributed system"

# Agentic-Flow: Cost-optimized tasks
af-cheap coder "Build REST API"

# Agentic-Flow: Privacy-first
af-private researcher "Analyze sensitive data"
```

For complete documentation, visit the GitHub repositories and documentation links above.
