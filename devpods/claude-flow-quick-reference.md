# Claude Flow - Quick Reference Cheat Sheet

## Agent Spawning

```bash
# Single agent
/spawn <agent-type> <task-description>

# Examples
/spawn coder "Implement JWT authentication"
/spawn tester "Write unit tests for UserService"
/spawn reviewer "Review PR #123"
```

## Swarm Operations

```bash
# Initialize swarm
/swarm-init <strategy> <objective>

# Strategies: hierarchical, mesh, adaptive
/swarm-init hierarchical "Build authentication system"

# Monitor swarm
/swarm-monitor

# Check status
/swarm-status
```

## SPARC Workflow

```bash
/sparc-architect "Design microservices architecture"
/sparc-coder "Implement user service"
/sparc-tester "Test API endpoints"
/sparc-reviewer "Review implementation"
/sparc-documenter "Generate API docs"
```

## Memory Operations

```javascript
// Store
mcp__claude-flow__memory_usage({
  action: "store",
  key: "path/to/data",
  namespace: "coordination",
  value: JSON.stringify(data)
})

// Retrieve
mcp__claude-flow__memory_usage({
  action: "retrieve",
  key: "path/to/data",
  namespace: "coordination"
})

// Search
mcp__claude-flow__memory_usage({
  action: "search",
  query: "search terms",
  namespace: "coordination"
})
```

## Agent Metadata Template

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

## Common Agent Types

| Type | Purpose | Examples |
|------|---------|----------|
| coder | Code implementation | Write features, refactor |
| planner | Task planning | Break down work, create roadmaps |
| researcher | Information gathering | Research tech, analyze docs |
| reviewer | Code review | PR review, quality checks |
| tester | Testing | Unit tests, integration tests |
| architect | System design | Architecture, tech selection |

## Core Agents (agents/core/)

- **coder** - Code implementation
- **planner** - Task breakdown and planning
- **researcher** - Information gathering
- **reviewer** - Code and quality review
- **tester** - Testing and validation

## Specialized Agents

### GitHub (agents/github/)
- code-review-swarm
- pr-manager
- issue-tracker
- release-manager

### Hive Mind (agents/hive-mind/)
- queen-coordinator
- worker-specialist
- scout-explorer
- swarm-memory-manager

### Consensus (agents/consensus/)
- raft-manager
- quorum-manager
- byzantine-coordinator
- crdt-synchronizer

### SPARC (agents/sparc/)
- specification
- pseudocode
- architecture
- refinement

## MCP Tools Quick Ref

### Swarm Tools
```javascript
// Init swarm
mcp__flow-nexus__swarm_init({ strategy, objective, max_agents })

// Spawn agent
mcp__flow-nexus__agent_spawn({ type, task, context })

// Orchestrate
mcp__flow-nexus__task_orchestrate({ tasks, coordination })
```

### Optimization Tools
```javascript
// Solve
mcp__sublinear-time-solver__solve({ matrix, vector, method })

// PageRank
mcp__sublinear-time-solver__pageRank({ adjacency, dampingFactor })

// Analyze
mcp__sublinear-time-solver__analyzeMatrix({ matrix, checkDominance })
```

### Performance Tools
```javascript
// Benchmark
mcp__claude-flow__benchmark_run({ type, iterations })

// Bottleneck analysis
mcp__claude-flow__bottleneck_analyze({ component, metrics })
```

## Hook Examples

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

## Memory Namespaces

```
coordination/
├── swarm/          # Swarm coordination
│   ├── queen/      # Queen coordinator
│   ├── workers/    # Worker agents
│   └── shared/     # Shared context
├── task/           # Task-specific
└── agent/          # Agent-specific
```

## Common Commands

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

## Swarm Strategies

| Strategy | Best For | Agent Organization |
|----------|----------|-------------------|
| Hierarchical | Complex projects | Tree structure with coordinator |
| Mesh | Distributed tasks | Peer-to-peer network |
| Adaptive | Dynamic workloads | Auto-scaling topology |

## File Organization

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

## Code Quality Checklist

- [ ] Clear naming conventions
- [ ] Single Responsibility Principle
- [ ] Proper error handling
- [ ] TypeScript types defined
- [ ] Tests written (>80% coverage)
- [ ] Documentation added
- [ ] Linter passing
- [ ] Security validated

## Error Handling Pattern

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

## Helper Scripts

```bash
# Quick start
./helpers/quick-start.sh

# Setup GitHub
./helpers/github-setup.sh

# Setup MCP
./helpers/setup-mcp.sh

# Checkpoint manager
./helpers/checkpoint-manager.sh create <name>
./helpers/checkpoint-manager.sh restore <id>
./helpers/checkpoint-manager.sh list
```

## Configuration Files

**settings.json** - Global config
```json
{
  "agents": { "max_concurrent": 10 },
  "mcp": { "server_url": "..." },
  "checkpoints": { "enabled": true }
}
```

**settings.local.json** - Local overrides (gitignored)
```json
{
  "debug": true,
  "agents": { "max_concurrent": 5 }
}
```

## Consensus Protocols

| Protocol | Consistency | Fault Tolerance | Performance |
|----------|-------------|-----------------|-------------|
| Raft | Strong | f+1 failures | Medium |
| Byzantine | Strong | 2f+1 failures | Low |
| Gossip | Eventual | Very High | High |
| Quorum | Configurable | Configurable | Medium-High |
| CRDT | Eventual | Very High | Very High |

## Performance Tips

1. **Enable checkpoints** for long tasks
2. **Use swarms** for parallel work
3. **Cache results** in memory
4. **Batch operations** when possible
5. **Monitor performance** with benchmarks

## Security Best Practices

- Never hardcode secrets
- Use environment variables
- Validate all inputs
- Sanitize outputs
- Implement proper auth/authz
- Use memory namespaces for isolation

## Common Issues & Solutions

**Agent won't spawn:**
- Check metadata syntax
- Verify capabilities
- Review memory limits

**Memory errors:**
- Check MCP connection
- Verify namespace permissions
- Review memory quotas

**Slow performance:**
- Enable checkpoints
- Reduce concurrent agents
- Use appropriate strategy

## Quick Links

- Agents: `agents/**/*.md`
- Commands: `commands/`
- Helpers: `helpers/`
- Settings: `settings.json`

---

**Claude Flow Quick Reference v2.0**

For detailed documentation, see:
- claude-flow-complete-guide.md
- claude-flow-technical-reference.md
