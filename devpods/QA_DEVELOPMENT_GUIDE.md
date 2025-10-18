# Orchestrated Agent Development Guide (Claude Code Direct)
## Using @ Commands for Multi-Agent Coordination

This guide shows how to use Claude Code's built-in agent system directly through @ commands, without requiring npx/CLI commands.

---

## Phase 0: Research & Planning (30-60 minutes)

### Spawn Parallel Research Agents

```
@agent-goal-planner and @agent-researcher - I need you both to work in parallel on analyzing improvements for our project. @agent-researcher should analyze the repositories at [REPO_URL_1] and [REPO_URL_2], focusing on the ReasoningBank implementation, Multi-Model Router architecture, and MCP server patterns. Look at how they handle TypeScript implementations, cost optimization, and integration approaches. Document the architecture, code patterns, performance characteristics, and create a technical report that shows how these could apply to our quality engineering system. @agent-goal-planner should wait for the researcher's findings, then create a comprehensive improvement plan with strategic goals, tactical milestones, implementation actions, and success criteria. The plan should be GOAP-style (Goal-Oriented Action Planning) with high-level objectives, measurable checkpoints, specific tasks with preconditions and postconditions, and how to measure completion. Include risk assessment, priority matrix comparing impact vs effort, and phased rollout suggestions for v1.0.5, v1.1.0, and v1.2.0. **CONSTRAINTS:** Maintain backward compatibility, zero breaking changes, keep our better-sqlite3 migration success, prioritize quality engineering domain value over generic features. Store findings in memory with key 'research/project-analysis' for the goal-planner to use.
```

---

## Phase 1: Quick Wins Implementation (3-4 hours)

### Commit Docs and Spawn Implementation Swarm

```
commit improvement docs, and start a swarm of specialized cloud flow agents to work in parallel with shared memory on implementing the improvements defined in Phase 1 per @docs/IMPROVEMENT-PLAN-SUMMARY.md and @docs/AGENTIC-QE-IMPROVEMENT-PLAN.md
```

This spawns multiple agents automatically:
- **backend-dev** - Implements Multi-Model Router and Streaming MCP Tools
- **system-architect** - Designs system architecture and integration points
- **tester** - Writes Phase 1 tests with full coverage
- **reviewer** - Reviews Phase 1 implementation for quality, security, performance
- **researcher** - Creates Phase 1 documentation

### Agent-Specific Instructions

**For backend-dev:**
```
@backend-dev Implement Multi-Model Router for cost optimization. **CONTEXT:** You're implementing backend features with focus on quality, security, performance, and maintainability using TypeScript best practices and AQE patterns. **TASKS:** Create the Multi-Model Router with intelligent model selection based on task complexity, implement streaming support for long-running operations, add cost optimization algorithms, ensure backward compatibility. **REQUIREMENTS:** TypeScript types must be comprehensive and accurate, error handling must be robust and informative, no 'any' types except in controlled scenarios, follow existing code patterns like BaseAgent and hooks system, proper async/await usage, no memory leaks. Implement the router to select cheaper models for simple tests and powerful models for complex scenarios, with fallback strategies for model failures and performance testing for different model configurations.
```

**For reviewer:**
```
@reviewer Review Phase 1 implementation. **MISSION:** Code Review for Phase 1 Implementation. You are conducting comprehensive code review for Multi-Model Router and Streaming MCP Tools. **CONTEXT:** Reviewing backend implementations, architecture, and tests with focus on quality, security, performance, and maintainability using TypeScript best practices and AQE patterns. **REVIEW CRITERIA:** 1. Code Quality - TypeScript types comprehensive and accurate, error handling robust and informative, no 'any' types except in controlled scenarios, follows existing code patterns like BaseAgent and hooks, proper async/await usage, no memory leaks. 2. Architecture - Integration points clean and well-defined, backward compatibility maintained, feature flags properly implemented, configuration migration sound, separation of concerns. 3. Performance - No N+1 query patterns, efficient memory usage, caching where appropriate, no blocking operations in hot paths, streaming efficiency without buffering. 4. Security - No hardcoded credentials, API keys properly managed, input validation on public APIs, safe fallback strategies, rate limit handling. 5. Testing - Comprehensive test coverage, tests validate actual behavior, integration tests included, handles edge cases, proper mocking and isolation.
```

---

## Phase 2: Intelligence Layer (4-5 hours)

### Analyze Integration and Spawn Phase 2 Swarm

```
I'll analyze the integration needs with the goal-planner agent and simultaneously start a specialized swarm for Phase 2 implementation. All operations will run in parallel.
```

This automatically spawns:
- **goal-planner** - Analyzes Phase 1/2 integration needs
- **backend-dev** - Implements QEReasoningBank core
- **ml-developer** - Implements LearningEngine system  
- **code-analyzer** - Implements Pattern Extraction
- **tester** - Enhances FlakyTestHunterAgent and creates Phase 2 integration tests
- **researcher** - Creates Phase 2 documentation
- **system-architect** - Coordinates Phase 2 integration

---

## Phase 3: Final Integration & Release (2-3 hours)

### Deploy Final Swarm

```
Perfect! Let's deploy a specialized swarm to complete Phase 2 and prepare for v1.1.0 release. All agents will work in parallel.
```

This spawns:
- **code-analyzer** - Fixes TypeScript compilation errors
- **tester** - Runs integration tests and fixes failures
- **researcher** - Creates ML Flaky Detection guide, Performance Improvement guide, updates README and other docs for v1.1.0
- **backend-dev** - Updates CLI init for Phase 1+2

---

## Critical Intervention Points

### When Agent Takes Shortcuts

```
wait, why did you make the change to only do an init of basic agents? did we forgot to include some of the new agents in the init definitions? use @agent-code-goal-planner to analyze and fix the problem in a proper way, not with a shortcut that will cripple our implementation, this is not acceptable.
```

### Force Proper Analysis

```
@code-goal-planner Analyze agent initialization problem. **CONTEXT:** The createBasicAgents() function only creates 6 agents when there should be 17+ agents according to the CLAUDE.md. The fallback creates only 6 agents instead of all 17 - this is the real bug. **ANALYSIS NEEDED:** Review the CLAUDE.md to identify all 17 agent templates that should exist, check which agent templates are actually in .claude/agents/ directory, analyze why the fallback array only lists 6 agents, determine proper fix that creates all agents. **DELIVERABLES:** Create comprehensive analysis documents showing root cause, step-by-step implementation plan, executive summary, and visual diagrams. Store in /workspaces/[project]/docs/ with filenames like AQE-INIT-AGENT-FIX-ANALYSIS.md, AQE-INIT-COMPREHENSIVE-FIX-PLAN.md, etc.
```

---

## Best Practices

**Multi-Agent Coordination:**
Use parallel agent commands when tasks are independent. Specify shared memory keys for coordination. Give each agent clear, distinct responsibilities. Set explicit deliverables and constraints.

**Intervention Timing:**
Watch for shortcuts or simplified implementations. Verify all requirements are being met (e.g., all 17 agents, not just 6). Check integration points for proper async handling. Ensure testing covers all edge cases before claiming completion.

**Quality Gates:**
All TypeScript must compile with zero errors. All tests must pass before moving to next phase. Documentation must be updated in real-time. Backward compatibility must be verified. No breaking changes unless explicitly planned.

---

---

# Alternative: Using npx CLI Commands

If you prefer to use CLI commands instead of @ commands, here's the equivalent npx workflow:

## Prerequisites

```bash
# Install Claude Code globally (required)
npm install -g @anthropic-ai/claude-code

# Install Claude Flow alpha
npm install -g claude-flow@alpha

# Initialize project with force flag
npx claude-flow@alpha init --force
```

## Configure MCP Servers

```bash
# Add Claude Flow MCP server (required)
claude mcp add claude-flow npx claude-flow@alpha mcp start

# Optional: Enhanced coordination
claude mcp add ruv-swarm npx ruv-swarm mcp start
```

## Phase 0: Research & Planning

```bash
# Spawn researcher for repository analysis
npx claude-flow@alpha swarm spawn researcher "analyze [target repos]" --claude

# Spawn goal-planner for strategy
npx claude-flow@alpha swarm spawn goal-planner "create improvement plan" --claude
```

### Memory Storage

```bash
# Store research findings
npx claude-flow@alpha memory store research "[findings]" \
  --namespace project --reasoningbank

# Configure persistent storage
export MEMORY_PATH=.swarm/memory.db
```

## Phase 1: Quick Wins Implementation

```bash
# Initialize hive-mind for complex orchestration
npx claude-flow@alpha hive-mind spawn "implement Phase 1" \
  --agents backend-dev,system-architect,tester,reviewer \
  --parallel --claude
```

### Individual Agent Spawning

```bash
# Backend development
npx claude-flow@alpha swarm spawn backend-dev \
  "Implement Multi-Model Router with cost optimization" --claude

# System architecture
npx claude-flow@alpha swarm spawn system-architect \
  "Design architecture for Phase 1 integration" --claude

# Testing
npx claude-flow@alpha swarm spawn tester \
  "Write comprehensive Phase 1 tests" --claude

# Code review
npx claude-flow@alpha swarm spawn reviewer \
  "Review Phase 1 implementation for quality and security" --claude
```

## Phase 2: Intelligence Layer

```bash
# Deploy Phase 2 swarm
npx claude-flow@alpha hive-mind spawn "implement Phase 2 intelligence layer" \
  --agents backend-dev,ml-developer,code-analyzer,tester,researcher,system-architect \
  --parallel --claude
```

## Phase 3: Final Integration & Release

```bash
# Comprehensive testing swarm
npx claude-flow@alpha swarm spawn test-suite \
  "run full regression, performance, integration tests" \
  --parallel --max-agents 10 --claude
```

## Memory Management Commands

```bash
# Store memories with semantic search
npx claude-flow@alpha memory store api_key "REST API configuration" \
  --namespace backend --reasoningbank

# Query with semantic search (2-3ms latency)
npx claude-flow@alpha memory query "API config" \
  --namespace backend --reasoningbank

# List all memories
npx claude-flow@alpha memory list --namespace backend --reasoningbank

# Check status and statistics
npx claude-flow@alpha memory status --reasoningbank

# Regular memory optimization
npx claude-flow@alpha memory optimize --compress

# Export critical knowledge
npx claude-flow@alpha memory export \
  --namespace project --format json > knowledge-base.json
```

## Swarm Status and Management

```bash
# Check swarm status
npx claude-flow@alpha swarm status

# Check hive-mind status
npx claude-flow@alpha hive-mind status

# Resume session
npx claude-flow@alpha hive-mind resume session-xxxxx
```

## When to Use Each Approach

**Use @ Commands when:**
- Working directly in Claude Code
- Need immediate agent interaction
- Want conversational coordination
- Prefer natural language over CLI syntax

**Use npx Commands when:**
- Need programmatic control
- Want to script workflows
- Prefer explicit CLI interface
- Need to integrate with other tools/scripts

Both approaches can be mixed and matched as needed for your workflow.
