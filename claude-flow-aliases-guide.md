# Claude-Flow v2.5.0 Alpha 130 Command Reference

This document provides a comprehensive reference for all shell aliases and utility functions configured for **Claude-Flow v2.5.0 Alpha 130**. These shortcuts streamline your workflow and make interacting with the `claude-flow` toolkit faster and more intuitive.

**Performance Note**: v2.5.0 introduces 100-600x speedup through Claude Code SDK integration, session forking, and in-process MCP servers.

---

## Core Commands

Primary commands for interacting with Claude-Flow, automatically wrapping requests with necessary context.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf` | `./cf-with-context.sh` | Base command. Runs any `claude-flow` command with auto-loaded context. |
| `cf-swarm` | `./cf-with-context.sh swarm` | Initiates a swarm of agents on a task with auto-loaded context. |
| `cf-hive` | `./cf-with-context.sh hive-mind spawn` | Spawns a hive-mind session for complex tasks with auto-loaded context. |
| `cf-dsp` | `claude --dangerously-skip-permissions` | Shortcut for Claude Code CLI, bypassing permission prompts. |
| `dsp` | `claude --dangerously-skip-permissions` | Even shorter alias for `cf-dsp`. |

---

## Initialization & Setup

Commands for setting up and verifying your Claude-Flow environment.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-init` | `npx claude-flow@alpha init --force` | Forces re-initialization of the Claude-Flow environment. |
| `cf-init-nexus` | `npx claude-flow@alpha init --flow-nexus` | Initializes environment with Flow Nexus cloud features enabled. |

---

## Hive-Mind Operations

For managing complex, multi-agent sessions with persistent memory.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-spawn` | `npx claude-flow@alpha hive-mind spawn` | Spawns a new hive-mind session. |
| `cf-wizard` | `npx claude-flow@alpha hive-mind wizard` | Starts interactive wizard to configure a hive-mind session. |
| `cf-resume` | `npx claude-flow@alpha hive-mind resume` | Resumes a previously saved hive-mind session. |
| `cf-status` | `npx claude-flow@alpha hive-mind status` | Checks status of the current hive-mind session. |

---

## Swarm Operations

For simpler, single-prompt agent swarms.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-continue` | `npx claude-flow@alpha swarm --continue-session` | Continues the last swarm session. |
| `cf-swarm-temp` | `npx claude-flow@alpha swarm --temp` | Runs temporary swarm that won't be saved to memory. |
| `cf-swarm-namespace` | `npx claude-flow@alpha swarm --namespace` | Runs swarm within a specific project namespace. |
| `cf-swarm-init` | `npx claude-flow@alpha swarm init` | Initializes a new swarm configuration. |

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

**Note**: Advanced GitHub operations use agent spawn patterns (e.g., `npx claude-flow agent spawn github-modes`).

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

---

## Performance & Analytics

Commands for benchmarking and performance analysis.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-benchmark` | `npx claude-flow@alpha benchmark` | Runs performance benchmarks. |
| `cf-analyze` | `npx claude-flow@alpha analyze` | Analyzes system performance. |
| `cf-optimize` | `npx claude-flow@alpha optimize` | Optimizes configurations. |
| `cf-metrics` | `npx claude-flow@alpha metrics` | Shows performance metrics. |

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

---

## Hive Configuration

Commands for configuring hive-mind topology and behavior.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-hive-init` | `claude-flow hive init` | Initializes hive with default settings. |
| `cf-hive-monitor` | `claude-flow hive monitor` | Monitors hive activity in real-time. |
| `cf-hive-health` | `claude-flow hive health` | Checks hive health status. |
| `cf-hive-config` | `claude-flow hive config set` | Sets hive configuration options. |

---

## Verification & Testing

Commands for validation and testing.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-verify` | `npx claude-flow@alpha verify` | Verifies system integrity. |
| `cf-truth` | `npx claude-flow@alpha truth` | Runs truth validation checks. |
| `cf-test` | `npx claude-flow@alpha test` | Executes test suites. |
| `cf-validate` | `npx claude-flow@alpha validate` | Validates configurations. |

---

## Pairing & Collaboration

Commands for collaborative development.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-pair` | `npx claude-flow@alpha pair --start` | Starts pairing session. |
| `cf-pair-stop` | `npx claude-flow@alpha pair --stop` | Stops pairing session. |
| `cf-pair-status` | `npx claude-flow@alpha pair --status` | Shows pairing status. |

---

## SPARC Methodology

Commands for Specification, Pseudocode, Architecture, Refinement, Completion workflow.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-sparc-init` | `npx claude-flow@alpha sparc init` | Initializes SPARC workflow. |
| `cf-sparc-plan` | `npx claude-flow@alpha sparc plan` | Creates plan for current task. |
| `cf-sparc-execute` | `npx claude-flow@alpha sparc execute` | Executes planned actions. |
| `cf-sparc-review` | `npx claude-flow@alpha sparc review` | Reviews execution results. |

**Note**: SPARC operations primarily use agent spawn patterns (e.g., `npx claude-flow sparc run specification "task"`).

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

---

## Monitoring & Debugging

Commands for system monitoring and troubleshooting.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-monitor` | `claude-monitor` | Opens monitoring interface. |
| `cf-logs` | `npx claude-flow@alpha logs` | Views system logs. |
| `cf-debug` | `npx claude-flow@alpha debug` | Enables debug mode. |
| `cf-trace` | `npx claude-flow@alpha trace` | Shows execution traces. |

---

## Help & Documentation

Commands for accessing documentation and help resources.

| Alias | Command | Description |
|-------|---------|-------------|
| `cf-help` | `npx claude-flow@alpha --help` | Shows help information. |
| `cf-docs` | `echo 'Visit: https://github.com/ruvnet/claude-flow/wiki'` | Opens documentation wiki. |
| `cf-examples` | `echo 'Visit: https://github.com/ruvnet/claude-flow/tree/main/examples'` | Opens examples repository. |

---

## Utility Functions

Advanced shell functions that accept arguments for dynamic operations.

### `cf-task "your task description"`
Quickly starts a swarm for a given task using the `--claude` flag.

```bash
cf-task "Build a REST API with authentication"
```

### `cf-hive-ns "your task" "namespace"`
Spawns a hive-mind session for a task within a specified namespace.

```bash
cf-hive-ns "Implement user management" "auth-service"
```

### `cf-search "query"`
Searches the memory and includes recent context in the query.

```bash
cf-search "authentication patterns"
```

### `cf-sandbox "template_name" "sandbox_name"`
Creates a new Flow Nexus cloud sandbox from a template.

```bash
cf-sandbox "node" "api-development"
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

## Installation

To install these aliases, the setup script automatically appends them to your `~/.bashrc`. After installation, run:

```bash
source ~/.bashrc
```

Or start a new terminal session to activate all aliases.

---

## Performance Features (v2.5.0)

- **Session Forking**: 10-20x faster parallel agent spawning
- **Hook Matchers**: 2-3x faster selective hook execution  
- **In-Process MCP**: 50-100x faster tool calls
- **4-Level Permissions**: USER → PROJECT → LOCAL → SESSION
- **Real-time Control**: Pause, resume, terminate agents mid-execution

**Combined Performance Gain**: 100-600x speedup potential

---

## Important Notes

- **Agent Syntax**: Most agents use `@agent-name "task"` syntax in Claude Code rather than CLI commands
- **MCP Tools**: Flow Nexus and coordination features use MCP tool syntax (e.g., `mcp__flow-nexus__*`)
- **Hooks Configuration**: Hooks are configured in `.claude/settings.json` during initialization
- **Windows Users**: See Windows Installation Guide for SQLite and special setup requirements

---

## Quick Start

```bash
# 1. Initialize Claude-Flow
cf-init

# 2. Start a simple task
cf-swarm "build a REST API" --claude

# 3. Or launch full hive-mind for complex projects
cf-wizard
cf-spawn "build enterprise system" --claude

# 4. Check memory and status
cfm                  # Memory stats
cfst                 # Current status
cf-session list      # List sessions
```

---

For complete documentation, visit the [Claude-Flow Wiki](https://github.com/ruvnet/claude-flow/wiki).
