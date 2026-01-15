# Claude Flow V3 Skills Reference Guide

> **Complete reference for Claude Flow V3 - The leading agent orchestration platform featuring SONA neural intelligence, 15-agent concurrent swarms, AgentDB unification, and 100+ MCP tools.**
>
> **Version: v3.0.0 (v3alpha) | Released: January 2026**

---

## Table of Contents

1. [What's New in V3](#whats-new-in-v3)
2. [V3 Architecture](#v3-architecture)
3. [Installation & Quick Start](#installation--quick-start)
4. [SONA Neural Intelligence](#sona-neural-intelligence)
5. [15-Agent Swarm System](#15-agent-swarm-system)
6. [AgentDB Unified Memory](#agentdb-unified-memory)
7. [ReasoningBank Intelligence](#reasoningbank-intelligence)
8. [Hooks & Automation System](#hooks--automation-system)
9. [MCP Tools Reference](#mcp-tools-reference)
10. [GitHub Integration](#github-integration)
11. [CLI Commands](#cli-commands)
12. [Performance Benchmarks](#performance-benchmarks)
13. [Migration from V2](#migration-from-v2)

---

## What's New in V3

Claude Flow V3 represents a complete architectural redesign with self-learning neural capabilities that no other agent orchestration framework offers.

### Key Improvements

| Metric | V2 | V3 | Improvement |
|--------|-----|-----|-------------|
| **Security Score** | 45/100 | 90/100 | 2x safer |
| **CLI Startup** | ~2.5s | <500ms | 5x faster |
| **Vector Search** | 150ms | <1ms | 150x faster |
| **Memory Usage** | 512MB | <256MB | 50% reduction |
| **Agent Spawn** | ~800ms | <200ms | 4x faster |
| **Codebase** | 130k lines | 78k lines | 40% reduction |

### V3 Exclusive Features

- **SONA (Self-Optimizing Neural Architecture)**: <0.05ms adaptation, learns optimal agent routing
- **EWC++ (Elastic Weight Consolidation)**: Prevents catastrophic forgetting of successful patterns
- **MoE (Mixture of Experts)**: 8 specialized experts with dynamic gating network
- **Flash Attention**: 2.49x-7.47x speedup for attention computations
- **Hyperbolic Embeddings**: Poincaré ball model for hierarchical code structure
- **LoRA (Low-Rank Adaptation)**: 128x memory compression for efficient fine-tuning
- **15-Agent Concurrent Swarms**: Hierarchical-mesh topology with queen coordination
- **Scoped Packages**: Modular `@claude-flow/*` architecture

---

## V3 Architecture

### Scoped Package Structure

```
v3/
├── @claude-flow/security/      # CVE remediation & security patterns
├── @claude-flow/memory/        # AgentDB unification module
├── @claude-flow/integration/   # agentic-flow integration
├── @claude-flow/performance/   # Flash Attention optimization
├── @claude-flow/swarm/         # 15-agent coordination
├── @claude-flow/cli/           # CLI modernization
├── @claude-flow/neural/        # SONA learning integration
├── @claude-flow/hooks/         # Event-driven lifecycle + ReasoningBank
├── @claude-flow/testing/       # TDD London School framework
├── @claude-flow/deployment/    # Release & CI/CD
├── @claude-flow/plugins/       # RuVector WASM plugins
└── @claude-flow/shared/        # Shared utilities & types
```

### Architecture Decision Records (ADRs)

| ADR | Decision | Impact |
|-----|----------|--------|
| ADR-001 | Adopt agentic-flow as core foundation | Eliminate 10,000+ duplicate lines |
| ADR-002 | Domain-Driven Design structure | Bounded contexts, clean architecture |
| ADR-003 | Single coordination engine | Unified SwarmCoordinator |
| ADR-004 | Plugin-based architecture | Microkernel pattern |
| ADR-005 | MCP-first API design | Consistent interfaces |
| ADR-006 | Unified memory service | AgentDB integration |
| ADR-007 | Event sourcing for state changes | Full audit trail |
| ADR-008 | Vitest over Jest | 10x faster testing |
| ADR-009 | Hybrid memory backend default | SQLite + AgentDB |
| ADR-010 | Remove Deno support | Node.js 20+ focus |

---

## Installation & Quick Start

### Prerequisites

- Node.js 20+ (required)
- npm 10+ or Bun 1.0+

### Installation

```bash
# NPX (recommended - always latest)
npx claude-flow@v3alpha init --force
npx claude-flow@v3alpha --help

# NPM global install
npm install -g claude-flow@v3alpha
claude-flow --version  # v3.0.0-alpha

# Bun (faster)
bun add claude-flow@v3alpha
bunx claude-flow@v3alpha init
```

### Quick Start

```bash
# 1. Initialize project
npx claude-flow@v3alpha init --force

# 2. Start MCP server for Claude Code integration
npx claude-flow@v3alpha mcp start

# 3. Run a task with agents
npx claude-flow@v3alpha --agent coder --task "Implement user authentication"

# 4. List available agents
npx claude-flow@v3alpha --list

# 5. Initialize swarm
npx claude-flow@v3alpha swarm init --topology hierarchical-mesh
```

### MCP Server Configuration

```json
// claude_desktop_config.json
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["claude-flow@v3alpha", "mcp", "start"]
    }
  }
}
```

---

## SONA Neural Intelligence

SONA (Self-Optimizing Neural Architecture) is V3's revolutionary self-learning system that makes your agents smarter with every interaction.

### Core Components

| Component | Function | Performance |
|-----------|----------|-------------|
| **SONA Core** | Runtime-adaptive learning | <0.05ms adaptation |
| **EWC++** | Prevents catastrophic forgetting | Retains 95%+ past knowledge |
| **MoE** | 8 specialized expert routing | Dynamic gating network |
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

### SONA CLI Commands

```bash
# Enable neural learning
npx claude-flow@v3alpha neural enable --pattern coordination

# Train on successful workflows
npx claude-flow@v3alpha neural train \
  --pattern_type coordination \
  --training_data "successful API development workflows"

# View learned patterns
npx claude-flow@v3alpha neural patterns list --type coordination

# Check neural status
npx claude-flow@v3alpha neural status
```

### Intelligence Hooks (Trajectory Learning)

```bash
# 4-step pipeline: RETRIEVE, JUDGE, DISTILL, CONSOLIDATE

# Start trajectory tracking
npx claude-flow@v3alpha hooks intelligence trajectory-start --session "<session>"

# Record step with reward
npx claude-flow@v3alpha hooks intelligence trajectory-step \
  --action "<action>" --reward 0.9

# End trajectory
npx claude-flow@v3alpha hooks intelligence trajectory-end --verdict success

# Pattern storage with HNSW indexing (150x faster search)
npx claude-flow@v3alpha hooks intelligence pattern-store \
  --pattern "<pattern>" --embedding "[...]"

npx claude-flow@v3alpha hooks intelligence pattern-search \
  --query "<query>" --limit 10

# Learning stats and attention focus
npx claude-flow@v3alpha hooks intelligence stats
npx claude-flow@v3alpha hooks intelligence learn --experience '{"type":"success"}'
npx claude-flow@v3alpha hooks intelligence attention --focus "<task>"

# Full intelligence system (SONA, MoE, HNSW, EWC++, Flash Attention)
npx claude-flow@v3alpha hooks intelligence
npx claude-flow@v3alpha hooks intelligence reset --confirm
```

---

## 15-Agent Swarm System

V3 introduces a revolutionary 15-agent concurrent swarm architecture with queen-led hierarchical-mesh topology.

### Swarm Topology

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
| 10 | Integration Architect | agentic-flow integration | SDK bridge |
| 11 | CLI/Hooks Developer | CLI modernization | interactive prompts |
| 12 | Neural/Learning Dev | SONA integration | learning systems |
| 13 | TDD Test Engineer | London School TDD | all modules |
| 14 | Performance Engineer | Benchmarks | optimization |
| 15 | Release Engineer | Deployment | CI/CD, release |

### Swarm Initialization

```bash
# Initialize 15-agent swarm
npx claude-flow@v3alpha swarm init v3-implementation \
  --topology hierarchical-mesh \
  --max-agents 15 \
  --github-sync enabled

# Spawn all agents concurrently
npx claude-flow@v3alpha agent spawn queen-coordinator --id 1
npx claude-flow@v3alpha agent spawn security-architect --id 2 &
npx claude-flow@v3alpha agent spawn security-implementer --id 3 &
npx claude-flow@v3alpha agent spawn security-tester --id 4 &
npx claude-flow@v3alpha agent spawn core-architect --id 5 &
npx claude-flow@v3alpha agent spawn core-implementer --id 6 &
npx claude-flow@v3alpha agent spawn memory-specialist --id 7 &
npx claude-flow@v3alpha agent spawn swarm-specialist --id 8 &
npx claude-flow@v3alpha agent spawn mcp-specialist --id 9 &
npx claude-flow@v3alpha agent spawn integration-architect --id 10 &
npx claude-flow@v3alpha agent spawn cli-hooks-developer --id 11 &
npx claude-flow@v3alpha agent spawn neural-learning-developer --id 12 &
npx claude-flow@v3alpha agent spawn tdd-test-engineer --id 13 &
npx claude-flow@v3alpha agent spawn performance-engineer --id 14 &
npx claude-flow@v3alpha agent spawn release-engineer --id 15 &
wait
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

```bash
# Initialize hive-mind swarm
npx claude-flow@v3alpha hive-mind spawn "build microservices" \
  --topology hierarchical

# Use adaptive coordination
npx claude-flow@v3alpha swarm "optimize performance" \
  --coordinator adaptive-coordinator

# Queen coordination tools
npx claude-flow@v3alpha queen command "Deploy to staging"
npx claude-flow@v3alpha queen monitor
npx claude-flow@v3alpha queen delegate --task "API implementation"
npx claude-flow@v3alpha queen aggregate --results
```

### Consensus Mechanisms

| Mechanism | Description | Use Case |
|-----------|-------------|----------|
| **majority** | >50% agreement | Quick decisions |
| **weighted** | Expertise-based voting | Technical decisions |
| **byzantine** | Fault-tolerant | Critical systems |
| **unanimous** | 100% agreement | High-stakes decisions |

---

## AgentDB Unified Memory

V3 unifies all memory operations through AgentDB with HNSW indexing for 150x faster search.

### Performance Characteristics

| Operation | V2 | V3 | Improvement |
|-----------|-----|-----|-------------|
| Vector Search (1M) | 15ms | <0.1ms | 150x faster |
| Insert (single) | 5ms | <1ms | 5x faster |
| Batch Insert (100) | 500ms | 2ms | 250x faster |
| Semantic Search | 150ms | <1ms | 150x faster |
| Pattern Retrieval | 150ms | 0.5ms | 300x faster |

### Memory Types

| Type | Scope | Use Case |
|------|-------|----------|
| **Session Memory** | Current conversation | Context continuity |
| **Long-term Memory** | Persistent across sessions | User preferences, learned patterns |
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

# Semantic search
npx claude-flow@v3alpha memory query "authentication patterns" \
  --namespace backend

# Vector search with HNSW
npx claude-flow@v3alpha memory vector-search \
  "user authentication flow" \
  --k 10 --threshold 0.7 --namespace backend

# Store with explicit embedding
npx claude-flow@v3alpha memory store-vector api_design \
  "REST endpoints" \
  --namespace backend \
  --metadata '{"version":"v2"}'

# Check memory status
npx claude-flow@v3alpha memory status

# Migrate from V2 JSON to V3 AgentDB
npx claude-flow@v3alpha memory migrate --from json --to agentdb

# Benchmark performance
npx claude-flow@v3alpha memory benchmark --dataset-size 10000
```

### Database Schema

```sql
-- Core pattern storage
CREATE TABLE patterns (
  id TEXT PRIMARY KEY,
  title TEXT,
  content TEXT,
  namespace TEXT,
  components JSON,
  created_at DATETIME
);

-- Semantic embeddings with HNSW indexing
CREATE TABLE pattern_embeddings (
  pattern_id TEXT PRIMARY KEY,
  embedding BLOB,        -- 1024-dim float32 array
  embedding_type TEXT    -- 'hash' or 'openai'
);

-- Sequential reasoning trajectories
CREATE TABLE task_trajectories (
  id TEXT PRIMARY KEY,
  pattern_id TEXT,
  step_number INTEGER,
  action TEXT,
  result TEXT
);

-- Knowledge graph links
CREATE TABLE pattern_links (
  source_pattern_id TEXT,
  target_pattern_id TEXT,
  link_type TEXT,        -- causes, requires, conflicts, enhances, alternative
  strength REAL
);
```

### Quantization Strategies

| Type | Memory Reduction | Speed Impact | Accuracy Loss |
|------|------------------|--------------|---------------|
| **Binary** | 32x | Fastest | ~5% |
| **Scalar** | 4x | Fast | <1% |
| **Product** | 8-16x | Medium | ~2% |

```typescript
const db = await AgentDB.create({
  path: './optimized.db',
  quantization: 'scalar',      // 4x memory reduction
  indexType: 'hnsw',           // O(log n) search
  cacheSize: 10000,            // LRU cache entries
  batchSize: 500               // Batch operation size
});
```

---

## ReasoningBank Intelligence

V3 integrates ReasoningBank for advanced pattern recognition and strategy optimization.

### MMR Ranking (4-Factor Scoring)

| Factor | Weight | Purpose |
|--------|--------|---------|
| Semantic Similarity | 40% | Find conceptually related memories |
| Recency | 20% | Prioritize recent learnings |
| Reliability | 30% | Trust proven patterns |
| Diversity | 10% | Discover novel approaches |

### Reasoning Modules

| Module | Purpose |
|--------|---------|
| **PatternMatcher** | Identify recurring patterns |
| **ContextSynthesizer** | Combine context from multiple sources |
| **MemoryOptimizer** | Prune and consolidate memories |
| **ExperienceCurator** | Select relevant experiences |
| **CausalRecall** | Trace cause-effect relationships |
| **SkillLibrary** | Auto-consolidate successful patterns |

### Pattern Link Types

| Type | Relationship | Example |
|------|--------------|---------|
| **causes** | X leads to Y | "Caching causes faster response" |
| **requires** | X needs Y first | "Deploy requires tests pass" |
| **conflicts** | X incompatible with Y | "Sync conflicts with async" |
| **enhances** | X improves Y | "Indexing enhances search" |
| **alternative** | X substitutes for Y | "gRPC alternative to REST" |

### Cognitive Diversity Patterns

| Strategy | Description | Best For |
|----------|-------------|----------|
| **Convergent** | Focus on single best solution | Clear requirements |
| **Divergent** | Explore multiple possibilities | Brainstorming |
| **Lateral** | Creative indirect approaches | Novel problems |
| **Systems** | Holistic interconnected thinking | Architecture |
| **Critical** | Evaluate and challenge assumptions | Code review |
| **Adaptive** | Learn and evolve strategies | Long-running tasks |

### ReasoningBank Commands

```bash
# Initialize ReasoningBank
npx claude-flow@v3alpha memory init --reasoningbank

# Store with reasoning context
npx claude-flow@v3alpha memory store api_pattern \
  "Use environment variables for secrets" \
  --reasoningbank

# Query with semantic search
npx claude-flow@v3alpha memory query "API configuration" \
  --reasoningbank

# Check statistics
npx claude-flow@v3alpha memory status --reasoningbank
```

### Bayesian Confidence Learning

```typescript
// Patterns improve over time based on outcomes
const pattern = {
  id: 'caching-strategy',
  confidence: 0.5,  // Initial
  // Success: +10-20% confidence
  // Failure: -10-15% confidence
  // Automatic reliability scoring
};
```

---

## Hooks & Automation System

V3 features an enhanced hooks system for automated workflows with pre/post operations.

### Hook Types

| Hook | Trigger | Use Case |
|------|---------|----------|
| **pre-edit** | Before file edit | Backup, validation |
| **post-edit** | After file edit | Formatting, testing |
| **pre-task** | Before task start | Setup, dependencies |
| **post-task** | After task complete | Cleanup, notification |
| **pre-search** | Before search | Query optimization |
| **post-search** | After search | Result filtering |
| **pre-command** | Before CLI command | Validation |
| **post-command** | After CLI command | Logging |
| **session-start** | Session begins | Restore memory, load context |
| **session-end** | Session ends | Save memory, cleanup |
| **session-restore** | Session restored | Reload state |

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

### Hooks CLI Commands

```bash
# List available hooks
npx claude-flow@v3alpha hooks list

# Enable specific hook
npx claude-flow@v3alpha hooks enable pre-edit

# View hook metrics
npx claude-flow@v3alpha hooks metrics

# Configure hook actions
npx claude-flow@v3alpha hooks config pre-edit \
  --actions "backup,validate"
```

### Three-Phase Memory Protocol

1. **Status Phase**: Report current state
2. **Progress Phase**: Update on ongoing work  
3. **Complete Phase**: Final results and learnings

---

## MCP Tools Reference

V3 provides 100+ MCP tools organized by category.

### Tool Categories

| Category | Tool Count | Purpose |
|----------|------------|---------|
| Swarm & Agents | 15+ | Multi-agent orchestration |
| Memory & Neural | 20+ | Persistent learning |
| GitHub Integration | 10+ | Repository management |
| Flow Nexus | 10+ | Cloud sandboxes |
| Intelligence | 15+ | SONA, reasoning |
| Coordination | 10+ | Inter-agent communication |

### Core MCP Tools

#### Swarm & Agents
```typescript
mcp__claude-flow__swarm_init      // Initialize swarm
mcp__claude-flow__agent_spawn     // Create agents
mcp__claude-flow__task_orchestrate // Orchestrate tasks
mcp__claude-flow__queen_command   // Queen directives
mcp__claude-flow__queen_monitor   // Monitor swarm health
mcp__claude-flow__queen_delegate  // Delegate tasks
mcp__claude-flow__queen_aggregate // Aggregate results
mcp__claude-flow__agent_assign    // Assign tasks to workers
```

#### Memory & Neural
```typescript
mcp__claude-flow__memory_usage    // Check memory stats
mcp__claude-flow__memory_search   // Semantic search
mcp__claude-flow__memory_store    // Store patterns
mcp__claude-flow__neural_status   // Neural system status
mcp__claude-flow__neural_train    // Train on patterns
mcp__claude-flow__neural_patterns // View learned patterns
```

#### Intelligence
```typescript
mcp__claude-flow__consensus_vote  // Democratic decisions
mcp__claude-flow__memory_share    // Share across hive
mcp__claude-flow__neural_sync     // Synchronize patterns
mcp__claude-flow__swarm_think     // Collective problem solving
mcp__claude-flow__coordination_sync // Bidirectional sync
```

#### GitHub Integration
```typescript
mcp__github__repo_analyze         // Repository analysis
mcp__github__pr_manage            // Pull request management
mcp__github__issue_track          // Issue tracking
mcp__github__workflow_automate    // CI/CD automation
```

### MCP Tool Prefixes

| Prefix | Purpose |
|--------|---------|
| `mcp__claude-flow__*` | Core Claude Flow operations |
| `mcp__github__*` | GitHub integration |
| `mcp__flow-nexus__*` | Flow Nexus platform |
| `mcp__agentdb__*` | AgentDB vector operations |

---

## GitHub Integration

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

### GitHub CLI Commands

```bash
# Initialize GitHub integration
npx claude-flow@v3alpha github init --token $GITHUB_TOKEN

# Create automated workflow
npx claude-flow@v3alpha github workflow create --template ci-cd

# Start swarm coordination
npx claude-flow@v3alpha github swarm start --mode gh-coordinator

# Review PR with agents
npx claude-flow@v3alpha github review --pr 123

# Review with specific agents
npx claude-flow@v3alpha github review --pr 123 \
  --agents security,performance

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

## CLI Commands

### Complete Command Reference

```bash
# ═══════════════════════════════════════════════════════════════
# INITIALIZATION
# ═══════════════════════════════════════════════════════════════
npx claude-flow@v3alpha init --force
npx claude-flow@v3alpha mcp start
npx claude-flow@v3alpha --version

# ═══════════════════════════════════════════════════════════════
# AGENTS
# ═══════════════════════════════════════════════════════════════
npx claude-flow@v3alpha --list                    # List all agents
npx claude-flow@v3alpha --agent coder --task "..." # Run with agent
npx claude-flow@v3alpha agent spawn --type coder
npx claude-flow@v3alpha agent spawn --type architect --name "My Architect"

# ═══════════════════════════════════════════════════════════════
# SWARM
# ═══════════════════════════════════════════════════════════════
npx claude-flow@v3alpha swarm init --topology hierarchical-mesh
npx claude-flow@v3alpha swarm start --max-agents 15
npx claude-flow@v3alpha swarm status
npx claude-flow@v3alpha swarm "build REST API" --mode parallel

# ═══════════════════════════════════════════════════════════════
# HIVE-MIND
# ═══════════════════════════════════════════════════════════════
npx claude-flow@v3alpha hive-mind spawn "task" --topology hierarchical
npx claude-flow@v3alpha hive-mind wizard
npx claude-flow@v3alpha queen command "directive"
npx claude-flow@v3alpha queen monitor

# ═══════════════════════════════════════════════════════════════
# MEMORY
# ═══════════════════════════════════════════════════════════════
npx claude-flow@v3alpha memory init --agentdb
npx claude-flow@v3alpha memory store <key> "<value>" --namespace <ns>
npx claude-flow@v3alpha memory query "<search>" --namespace <ns>
npx claude-flow@v3alpha memory vector-search "<query>" --k 10
npx claude-flow@v3alpha memory status
npx claude-flow@v3alpha memory migrate --from json --to agentdb
npx claude-flow@v3alpha memory benchmark --dataset-size 10000

# ═══════════════════════════════════════════════════════════════
# NEURAL / SONA
# ═══════════════════════════════════════════════════════════════
npx claude-flow@v3alpha neural enable --pattern coordination
npx claude-flow@v3alpha neural train --pattern_type <type> --training_data "..."
npx claude-flow@v3alpha neural patterns list --type coordination
npx claude-flow@v3alpha neural status

# ═══════════════════════════════════════════════════════════════
# HOOKS / INTELLIGENCE
# ═══════════════════════════════════════════════════════════════
npx claude-flow@v3alpha hooks list
npx claude-flow@v3alpha hooks enable pre-edit
npx claude-flow@v3alpha hooks metrics
npx claude-flow@v3alpha hooks intelligence trajectory-start --session "<id>"
npx claude-flow@v3alpha hooks intelligence trajectory-step --action "<act>" --reward 0.9
npx claude-flow@v3alpha hooks intelligence trajectory-end --verdict success
npx claude-flow@v3alpha hooks intelligence pattern-store --pattern "<p>"
npx claude-flow@v3alpha hooks intelligence pattern-search --query "<q>" --limit 10
npx claude-flow@v3alpha hooks intelligence stats
npx claude-flow@v3alpha hooks intelligence attention --focus "<task>"

# ═══════════════════════════════════════════════════════════════
# SPARC METHODOLOGY
# ═══════════════════════════════════════════════════════════════
npx claude-flow@v3alpha sparc start "Build e-commerce platform"
npx claude-flow@v3alpha sparc architect "Design payment system"
npx claude-flow@v3alpha sparc coder "Implement checkout flow"
npx claude-flow@v3alpha sparc tester "Create integration tests"
npx claude-flow@v3alpha sparc tdd "implement payment system" \
  --agents specification,pseudocode,architecture,refinement

# ═══════════════════════════════════════════════════════════════
# GITHUB
# ═══════════════════════════════════════════════════════════════
npx claude-flow@v3alpha github init --token $GITHUB_TOKEN
npx claude-flow@v3alpha github workflow create --template ci-cd
npx claude-flow@v3alpha github swarm start --mode gh-coordinator
npx claude-flow@v3alpha github review --pr 123 --agents security,performance
npx claude-flow@v3alpha github release prepare --version minor
npx claude-flow@v3alpha github release execute --tag v3.0.0

# ═══════════════════════════════════════════════════════════════
# EMBEDDINGS
# ═══════════════════════════════════════════════════════════════
npx claude-flow@v3alpha embeddings init
npx claude-flow@v3alpha embeddings init --model all-mpnet-base-v2
npx claude-flow@v3alpha embeddings search -q "authentication patterns"

# ═══════════════════════════════════════════════════════════════
# WORKERS (Background)
# ═══════════════════════════════════════════════════════════════
npx claude-flow@v3alpha worker dispatch --trigger audit --context "./src"
npx claude-flow@v3alpha worker status
npx claude-flow@v3alpha worker results --limit 10

# ═══════════════════════════════════════════════════════════════
# SECURITY
# ═══════════════════════════════════════════════════════════════
npx @claude-flow/security@latest audit --platform linux
npx @claude-flow/security@latest audit --platform darwin
npx @claude-flow/security@latest audit --platform windows
```

---

## Performance Benchmarks

### V3 Performance Targets

| Category | V2.7 | V3.0 Target | Improvement |
|----------|------|-------------|-------------|
| CLI Startup | ~2.5s | <500ms | 5x faster |
| MCP Init | ~1.8s | <400ms | 4.5x faster |
| Agent Spawn | ~800ms | <200ms | 4x faster |
| Vector Search | 150ms/query | <1ms/query | 150x faster |
| Memory Write | 50ms | <5ms | 10x faster |
| Swarm Consensus | ~500ms | <100ms | 5x faster |
| Flash Attention | N/A | 2.49x-7.47x | New feature |
| Memory Usage | 512MB | <256MB | 50% reduction |

### AgentDB Performance

| Dataset Size | JSON Query | AgentDB Query | Speedup | Memory Saved |
|--------------|------------|---------------|---------|--------------|
| 100 entries | 0.12ms | 0.10ms | 1.2x | 52% |
| 1,000 entries | 1.18ms | 0.05ms | 23.6x | 54% |
| 10,000 entries | 10.96ms | 0.11ms | 99.6x | 56% |
| 100,000 entries | 109ms | 0.15ms | 727x | 58% |
| 1,000,000 entries | 1,090ms | 0.20ms | 5,450x | 60% |

### SONA Neural Performance

| Metric | Value | Notes |
|--------|-------|-------|
| Learning Overhead | <1ms | Sub-millisecond adaptation |
| Pattern Discovery | 0.5ms | 300x faster than V2 |
| Quality Improvement | +55% | With LoRA fine-tuning |
| Forgetting Prevention | 95%+ | EWC++ retention |
| Throughput | 2,211 ops/sec | SIMD optimized |
| Cost Savings | 60% | Intelligent LLM routing |

### TDD Coverage Targets

| Category | Target |
|----------|--------|
| Unit Tests | 90% |
| Integration Tests | 80% |
| E2E Tests | 70% |
| Security Tests | 95% |

---

## Migration from V2

### Breaking Changes

| Area | V2 | V3 | Migration |
|------|-----|-----|-----------|
| Package structure | Monolithic | Scoped `@claude-flow/*` | Update imports |
| Memory backend | JSON default | AgentDB default | Run migrate command |
| Deno support | Supported | Removed | Use Node.js 20+ |
| Hook system | Basic | ReasoningBank integrated | Update hook configs |

### Migration Steps

```bash
# 1. Backup existing data
cp -r ./data ./data-backup-v2

# 2. Update to V3
npm install -g claude-flow@v3alpha

# 3. Run migration
npx claude-flow@v3alpha migrate --from v2

# 4. Verify installation
npx claude-flow@v3alpha --version
npx claude-flow@v3alpha hooks metrics
```

### Import Changes

```typescript
// V2
import { Swarm } from 'claude-flow';
import { AgentDB } from 'agentdb';

// V3
import { Swarm } from '@claude-flow/swarm';
import { AgentDB } from '@claude-flow/memory';
```

### Memory Migration

```bash
# Migrate JSON to AgentDB
npx claude-flow@v3alpha memory migrate --from json --to agentdb

# Verify migration
npx claude-flow@v3alpha memory status
```

### Configuration Migration

```yaml
# V2 .swarm/config.yml
memory:
  backend: json
  path: ./data/memory.json

# V3 .swarm/config.yml  
memory:
  backend: agentdb
  path: .agentdb/memory.db
  indexType: hnsw
  quantization: scalar
```

---

## Additional Resources

### Documentation Links

- [Claude Flow GitHub](https://github.com/ruvnet/claude-flow)
- [V3 Implementation Issue](https://github.com/ruvnet/claude-flow/issues/927)
- [NPM Package](https://www.npmjs.com/package/claude-flow)
- [AgentDB Documentation](https://github.com/evo-ninja/agent-db)
- [SONA RuVector](https://crates.io/crates/ruvector-sona)

### Community

- GitHub Issues: [Report bugs](https://github.com/ruvnet/claude-flow/issues)
- GitHub Discussions: [Community Q&A](https://github.com/ruvnet/claude-flow/discussions)
- Discord: [Agentics Foundation](https://discord.com/invite/dfxmpwkG2D)

### Related Packages

- **agentic-flow v2.0+**: Multi-provider agent execution engine
- **agentdb v2.0+**: High-performance vector database
- **ruvector-sona**: Self-Optimizing Neural Architecture (Rust)

---

**Document Version**: 2.0.0  
**Last Updated**: January 2026  
**Claude Flow Version**: v3.0.0 (v3alpha)  
**Skills Covered**: 30+  
**MCP Tools**: 100+  
**Agents**: 64+ specialized + 15 concurrent swarm

---

*Built with ❤️ by [rUv](https://github.com/ruvnet) | Powered by SONA Neural Intelligence*
