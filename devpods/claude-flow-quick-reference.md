# Claude Flow - Quick Reference

## ⚡ Quick Start

```bash
# Load a single skill
claude-code --skill skill-name "Your task"

# Load multiple skills (recommended for complex tasks)
claude-code --skill skill1 --skill skill2 "Complex task"

# Example
claude-code --skill pair-programming --skill verification-quality "Build login form"
```

---

## 🎯 Claude Flow Skills (25 Total)

### 🧠 AgentDB Skills - Vector Search & Memory (5)
- **agentdb-vector-search**: Semantic search, RAG systems, knowledge bases (<100µs)
- **agentdb-memory-patterns**: Persistent memory, session management, context preservation
- **agentdb-optimization**: 4-32x memory reduction, 150x faster search, HNSW indexing
- **agentdb-learning**: 9 RL algorithms (Decision Transformer, Q-Learning, Actor-Critic, SARSA)
- **agentdb-advanced**: QUIC sync (<1ms), multi-database coordination, hybrid search, distributed

### 🔄 Flow Nexus Skills - Cloud Platform (3)
- **flow-nexus-platform**: Authentication, sandboxes, deployment, payments, challenges
- **flow-nexus-swarm**: Cloud swarms, event-driven workflows, message queues
- **flow-nexus-neural**: Train & deploy neural networks in E2B sandboxes

### 🐙 Swarm Skills - Multi-Agent Orchestration (3)
- **swarm-orchestration**: Multi-agent coordination, parallel execution, dynamic topology
- **swarm-advanced**: Research, development, testing, complex workflows
- **hive-mind-advanced**: Queen coordinator, worker specialists, adaptive swarms

### 🔧 Workflow Skills - Automation (4)
- **stream-chain**: Stream-JSON chaining, pipelines, data transformation
- **hooks-automation**: Pre/post hooks, Git integration, session management, MCP coordination
- **sparc-methodology**: Specification → Pseudocode → Architecture → Refinement → Completion
- **skill-builder**: Generate React components (TypeScript, hooks, tests, Storybook)

### 📊 GitHub Skills - Integration & DevOps (5)
- **github-code-review**: Multi-agent PR review, security analysis, best practices
- **github-project-management**: Issue tracking, boards, sprints, Agile workflow
- **github-release-management**: Automated versioning, testing, deployment, rollback
- **github-workflow-automation**: CI/CD optimization, parallelization, artifact management
- **github-multi-repo**: Cross-repo sync, package alignment, architecture management

### 🤝 Development Skills - Quality & Performance (3)
- **pair-programming**: Driver/navigator modes, TDD, refactoring, debugging, verification
- **verification-quality**: Code quality checks, automated testing, validation workflows
- **performance-analysis**: Profiling, bottleneck detection, optimization, benchmarking

### 🧩 ReasoningBank Skills - Adaptive Learning (2)
- **reasoningbank-intelligence**: Pattern recognition, strategy optimization, meta-cognition
- **reasoningbank-agentdb**: Trajectory tracking, verdict judgment, 150x speedup, experience replay

---

## 📚 Skill Selection Quick Guide

**Building something? Use these:**

| Task | Skills |
|------|--------|
| Semantic search/RAG | agentdb-vector-search + agentdb-optimization |
| React component | skill-builder + pair-programming + verification-quality |
| Code review | github-code-review + pair-programming |
| Release/deploy | github-release-management + github-workflow-automation |
| Multi-repo work | github-multi-repo + swarm-orchestration |
| Self-learning agent | agentdb-learning + reasoningbank-intelligence |
| Complex system | sparc-methodology + swarm-orchestration |
| Cloud scale | flow-nexus-platform + flow-nexus-swarm |

---

## 🔄 Legacy Commands (For Reference)

### Agent Spawning
```bash
/spawn <agent-type> <task-description>
/spawn coder "Implement JWT authentication"
/spawn tester "Write unit tests for UserService"
/spawn reviewer "Review PR #123"
```

### Swarm Operations
```bash
/swarm-init <strategy> <objective>
/swarm-init hierarchical "Build authentication system"
/swarm-monitor
/swarm-status
```

### SPARC Workflow
```bash
/sparc-architect "Design microservices architecture"
/sparc-coder "Implement user service"
/sparc-tester "Test API endpoints"
/sparc-reviewer "Review implementation"
/sparc-documenter "Generate API docs"
```

---

## 💾 Memory Operations

```javascript
// Store data
mcp__claude-flow__memory_usage({
  action: "store",
  key: "path/to/data",
  namespace: "coordination",
  value: JSON.stringify(data)
})

// Retrieve data
mcp__claude-flow__memory_usage({
  action: "retrieve",
  key: "path/to/data",
  namespace: "coordination"
})

// Search data
mcp__claude-flow__memory_usage({
  action: "search",
  query: "search terms",
  namespace: "coordination"
})
```

## 📦 Memory Namespaces

```
coordination/
├── swarm/          # Swarm coordination
│   ├── queen/      # Queen coordinator
│   ├── workers/    # Worker agents
│   └── shared/     # Shared context
├── task/           # Task-specific
└── agent/          # Agent-specific
```

---

## 🛠️ MCP Tools Reference

### Swarm Tools
```javascript
mcp__flow-nexus__swarm_init({ strategy, objective, max_agents })
mcp__flow-nexus__agent_spawn({ type, task, context })
mcp__flow-nexus__task_orchestrate({ tasks, coordination })
```

### Optimization Tools
```javascript
mcp__sublinear-time-solver__solve({ matrix, vector, method })
mcp__sublinear-time-solver__pageRank({ adjacency, dampingFactor })
mcp__sublinear-time-solver__analyzeMatrix({ matrix, checkDominance })
```

### Performance Tools
```javascript
mcp__claude-flow__benchmark_run({ type, iterations })
mcp__claude-flow__bottleneck_analyze({ component, metrics })
```

---

## 👥 Agent Metadata & Types

### Agent Types
| Type | Purpose | Examples |
|------|---------|----------|
| coder | Code implementation | Write features, refactor |
| planner | Task planning | Break down work, roadmaps |
| researcher | Research | Research tech, analyze docs |
| reviewer | Code review | PR review, quality checks |
| tester | Testing | Unit tests, integration |
| architect | System design | Architecture, tech selection |

### Core Agents (agents/core/)
- **coder** - Code implementation
- **planner** - Task breakdown and planning
- **researcher** - Information gathering
- **reviewer** - Code and quality review
- **tester** - Testing and validation

### Specialized Agents
**GitHub** (agents/github/): code-review-swarm, pr-manager, issue-tracker, release-manager
**Hive Mind** (agents/hive-mind/): queen-coordinator, worker-specialist, scout-explorer, swarm-memory-manager
**Consensus** (agents/consensus/): raft-manager, quorum-manager, byzantine-coordinator, crdt-synchronizer
**SPARC** (agents/sparc/): specification, pseudocode, architecture, refinement

### Agent Metadata Template
```yaml
---
name: my-agent
type: developer|coordinator|analyst|specialist
color: "#FF6B35"
description: Brief description
capabilities:
  - capability_1
  - capability_2
priority: high|medium|low
hooks:
  pre: |
    echo "Starting..."
  post: |
    echo "Complete!"
---
```

---

## 🔗 Common Commands

### Analysis
```bash
/bottleneck-detect <component>
/performance-report
/token-usage
```

### GitHub
```bash
/github/pr-manager review <PR#>
/github/issue-tracker triage <repo>
/github/release-manager create <version>
```

### Hive Mind
```bash
/hive-mind-init <strategy>
/hive-mind-spawn <type> <count>
/hive-mind-consensus <decision>
/hive-mind-status
```

### Optimization
```bash
/topology-optimize
/parallel-execute <tasks>
/cache-manage
```

---

## 🎯 Swarm Strategies

| Strategy | Best For | Organization |
|----------|----------|---------------|
| Hierarchical | Complex projects | Tree with coordinator |
| Mesh | Distributed tasks | Peer-to-peer network |
| Adaptive | Dynamic workloads | Auto-scaling topology |

---

## 📐 File Organization

```
src/
  modules/
    feature/
      feature.service.ts      # Business logic
      feature.controller.ts   # HTTP handling
      feature.repository.ts   # Data access
      feature.types.ts        # Type definitions
      feature.test.ts         # Tests
```

---

## ✅ Code Quality Checklist

- [ ] Clear naming conventions
- [ ] Single Responsibility Principle
- [ ] Proper error handling
- [ ] TypeScript types defined
- [ ] Tests written (>80% coverage)
- [ ] Documentation added
- [ ] Linter passing
- [ ] Security validated

---

## 🚨 Error Handling Pattern

```typescript
try {
  const result = await operation();
  return result;
} catch (error) {
  logger.error('Operation failed', { error, context });
  
  if (error instanceof ValidationError) {
    throw new BadRequestError('Invalid input', error);
  }
  
  throw new InternalServerError('Unexpected error', error);
}
```

---

## 🪝 Hook Examples

```bash
# Pre-hook: Validate environment
hooks:
  pre: |
    if [ ! -f "package.json" ]; then
      echo "⚠️  No package.json found"
      exit 1
    fi

# Post-hook: Store results
hooks:
  post: |
    memory_store "task_complete" "$(date -Iseconds)"
    npm run lint --if-present
```

---

## ⚙️ Configuration Files

**settings.json** - Global config
```json
{
  "agents": { "max_concurrent": 10 },
  "mcp": { "server_url": "..." },
  "checkpoints": { "enabled": true }
}
```

**settings.local.json** - Local overrides
```json
{
  "debug": true,
  "agents": { "max_concurrent": 5 }
}
```

---

## 🚀 Helper Scripts

```bash
./helpers/quick-start.sh                 # Quick start
./helpers/github-setup.sh                # Setup GitHub
./helpers/setup-mcp.sh                   # Setup MCP
./helpers/checkpoint-manager.sh create <n>    # Create checkpoint
./helpers/checkpoint-manager.sh restore <id>  # Restore checkpoint
./helpers/checkpoint-manager.sh list          # List checkpoints
```

---

## 🔐 Consensus Protocols

| Protocol | Consistency | Fault Tolerance | Performance |
|----------|-------------|-----------------|-------------|
| Raft | Strong | f+1 failures | Medium |
| Byzantine | Strong | 2f+1 failures | Low |
| Gossip | Eventual | Very High | High |
| Quorum | Configurable | Configurable | Medium-High |
| CRDT | Eventual | Very High | Very High |

---

## 💡 Performance Tips

1. **Load appropriate skills** - Choose 2-4 complementary skills
2. **Enable checkpoints** - For long-running tasks
3. **Use swarms** - For parallel work
4. **Cache results** - In memory namespaces
5. **Batch operations** - When possible
6. **Monitor performance** - Use performance-analysis skill

---

## 🔒 Security Best Practices

- Never hardcode secrets
- Use environment variables
- Validate all inputs
- Sanitize outputs
- Implement proper auth/authz
- Use memory namespaces for isolation

---

## 🐛 Troubleshooting

**Skill won't load:**
- Verify skill name spelling
- Check prerequisites (Node 18+, gh CLI, MCP)
- Review MCP connection

**Agent won't spawn:**
- Check metadata syntax
- Verify capabilities
- Review memory limits

**Memory errors:**
- Check MCP connection
- Verify namespace permissions
- Review memory quotas

**Slow performance:**
- Load performance-analysis skill
- Enable checkpoints
- Reduce concurrent agents

---

## 📚 Quick Links

- Skills: `--skill` flag in Claude Code
- Agents: `agents/**/*.md`
- Commands: `commands/`
- Helpers: `helpers/`
- Settings: `settings.json`
- MCP Server: `flow-nexus` (required for cloud features)

---

**Claude Flow Quick Reference v3.0**
*Optimized for Claude Code Skills*

Last updated: 2025
For detailed docs: See individual SKILL.md files in skills/ directory
