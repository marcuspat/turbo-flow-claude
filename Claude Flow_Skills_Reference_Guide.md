# Claude Flow Skills Reference Guide

> **Comprehensive reference for 26 Claude Flow skills covering AgentDB, swarm orchestration, GitHub integration, neural networks, and development workflows.**

---

## Table of Contents

1. [Overview](#overview)
2. [Quick Reference](#quick-reference)
3. [AgentDB Skills](#agentdb-skills)
   - [AgentDB Vector Search](#agentdb-vector-search)
   - [AgentDB Memory Patterns](#agentdb-memory-patterns)
   - [AgentDB Optimization](#agentdb-optimization)
   - [AgentDB Advanced Features](#agentdb-advanced-features)
   - [AgentDB Learning Plugins](#agentdb-learning-plugins)
4. [Swarm Orchestration Skills](#swarm-orchestration-skills)
   - [Swarm Orchestration](#swarm-orchestration)
   - [Swarm Advanced](#swarm-advanced)
   - [Hive Mind Advanced](#hive-mind-advanced)
   - [Stream Chain](#stream-chain)
5. [GitHub Integration Skills](#github-integration-skills)
   - [GitHub Workflow Automation](#github-workflow-automation)
   - [GitHub Code Review](#github-code-review)
   - [GitHub Project Management](#github-project-management)
   - [GitHub Release Management](#github-release-management)
   - [GitHub Multi-Repo](#github-multi-repo)
6. [Flow Nexus Platform Skills](#flow-nexus-platform-skills)
   - [Flow Nexus Platform](#flow-nexus-platform)
   - [Flow Nexus Swarm](#flow-nexus-swarm)
   - [Flow Nexus Neural](#flow-nexus-neural)
7. [Development & Quality Skills](#development--quality-skills)
   - [SPARC Methodology](#sparc-methodology)
   - [Pair Programming](#pair-programming)
   - [Verification & Quality](#verification--quality)
   - [Performance Analysis](#performance-analysis)
   - [Hooks Automation](#hooks-automation)
8. [Intelligence & Learning Skills](#intelligence--learning-skills)
   - [ReasoningBank with AgentDB](#reasoningbank-with-agentdb)
   - [ReasoningBank Intelligence](#reasoningbank-intelligence)
   - [Agentic Jujutsu](#agentic-jujutsu)
9. [Skill Development](#skill-development)
   - [Skill Builder](#skill-builder)
10. [Installation & Setup](#installation--setup)
11. [Performance Benchmarks](#performance-benchmarks)

---

## Overview

Claude Flow is a comprehensive multi-agent orchestration framework that enables sophisticated AI workflows, distributed systems, and intelligent automation. This reference guide covers 26 specialized skills organized into functional categories.

### Key Capabilities

| Category | Skills | Primary Use Cases |
|----------|--------|-------------------|
| **AgentDB** | 5 skills | Vector search, memory patterns, optimization, distributed systems |
| **Swarm Orchestration** | 4 skills | Multi-agent coordination, topology management, collective intelligence |
| **GitHub Integration** | 5 skills | CI/CD automation, code review, release management, multi-repo coordination |
| **Flow Nexus Platform** | 3 skills | Cloud sandboxes, neural network training, app deployment |
| **Development & Quality** | 5 skills | SPARC methodology, pair programming, verification, performance analysis |
| **Intelligence & Learning** | 3 skills | Adaptive learning, pattern recognition, version control |
| **Skill Development** | 1 skill | Creating custom Claude Code skills |

### Prerequisites

- Node.js 18+
- Claude Flow CLI: `npm install -g claude-flow@alpha`
- Optional: MCP servers for enhanced integration

---

## Quick Reference

### CLI Commands

```bash
# Initialize Claude Flow
npx claude-flow init

# Start swarm orchestration
npx claude-flow swarm start --topology mesh

# AgentDB operations
npx agentdb@latest init
npx agentdb@latest query ./vectors.db "search query"

# SPARC methodology
npx claude-flow sparc architect "Build REST API"

# Performance analysis
npx claude-flow bottleneck detect
```

### MCP Tool Prefixes

| Prefix | Purpose |
|--------|---------|
| `mcp__claude-flow__*` | Core Claude Flow operations |
| `mcp__github__*` | GitHub integration |
| `mcp__flow-nexus__*` | Flow Nexus platform |
| `mcp__agentdb__*` | AgentDB vector operations |

---

## AgentDB Skills

### AgentDB Vector Search

**Purpose**: Implement semantic vector search for intelligent document retrieval, similarity matching, and context-aware querying.

**When to Use**: Building RAG systems, semantic search engines, or intelligent knowledge bases.

#### Quick Start

```bash
# Initialize database
npx agentdb@latest init

# Insert vectors
npx agentdb@latest insert ./vectors.db --embedding "[0.1, 0.2, ...]" --metadata '{"source": "doc1"}'

# Query with semantic search
npx agentdb@latest query ./vectors.db "find similar documents" -k 10
```

#### Key Features

- **HNSW Indexing**: O(log n) complexity, 150x faster than linear search
- **Multiple Distance Metrics**: Cosine (default), Euclidean, Dot Product
- **Hybrid Search**: Combine vector similarity with metadata filters
- **MCP Integration**: Use via `mcp__agentdb__query`, `mcp__agentdb__insert`

#### Performance

| Operation | Speed | Notes |
|-----------|-------|-------|
| Search | <100µs | With HNSW indexing |
| Insert | ~1ms | Single vector |
| Batch Insert | 2ms/100 vectors | 500x faster than individual |

#### RAG Pipeline Example

```typescript
import { AgentDB } from 'agentdb';

const db = await AgentDB.create({ path: './knowledge.db' });

// Index documents
for (const doc of documents) {
  const embedding = await embed(doc.content);
  await db.insert({
    embedding,
    metadata: { id: doc.id, source: doc.source }
  });
}

// Semantic retrieval
const results = await db.query({
  embedding: await embed(userQuery),
  k: 5,
  filter: { source: 'trusted' }
});
```

---

### AgentDB Memory Patterns

**Purpose**: Implement persistent memory patterns for AI agents including session memory, long-term storage, and context management.

**When to Use**: Building stateful agents, chat systems, or intelligent assistants that need memory across sessions.

#### Memory Types

| Type | Scope | Use Case |
|------|-------|----------|
| **Session Memory** | Current conversation | Context continuity |
| **Long-term Memory** | Persistent across sessions | User preferences, learned patterns |
| **Working Memory** | Active task context | Current problem-solving |
| **Episodic Memory** | Event sequences | Experience replay |

#### Quick Start

```bash
# Initialize with memory patterns
npx agentdb@latest init --memory-patterns

# Store memory
npx agentdb@latest memory store "User prefers concise responses"

# Retrieve relevant memories
npx agentdb@latest memory recall "How should I respond to this user?"
```

#### Implementation

```typescript
import { createAgentDBAdapter } from 'agentic-flow/reasoningbank';

const memory = await createAgentDBAdapter({
  dbPath: '.agentdb/memory.db',
  enableCache: true,
  cacheSize: 1000
});

// Store interaction
await memory.store({
  type: 'interaction',
  content: 'User asked about weather',
  embedding: await embed('weather query'),
  timestamp: Date.now()
});

// Recall with context
const relevant = await memory.recall({
  query: 'What did user ask about?',
  k: 5,
  recencyWeight: 0.3
});
```

#### Performance

- **Retrieval**: <1ms with cache hit
- **Storage**: <5ms with immediate sync
- **Cache Hit Rate**: 85-95% typical

---

### AgentDB Optimization

**Purpose**: Optimize AgentDB performance with quantization, indexing, caching, and batch operations.

**When to Use**: Optimizing memory usage, improving search speed, or scaling to millions of vectors.

#### Quantization Strategies

| Type | Memory Reduction | Speed Impact | Accuracy Loss |
|------|------------------|--------------|---------------|
| **Binary** | 32x | Fastest | ~5% |
| **Scalar** | 4x | Fast | <1% |
| **Product** | 8-16x | Medium | ~2% |

#### Configuration

```typescript
const db = await AgentDB.create({
  path: './optimized.db',
  quantization: 'scalar',      // 4x memory reduction
  indexType: 'hnsw',           // O(log n) search
  cacheSize: 10000,            // LRU cache entries
  batchSize: 500               // Batch operation size
});
```

#### Optimization Recipes

**Speed-Optimized**:
```typescript
{
  quantization: 'binary',
  indexType: 'hnsw',
  efSearch: 50,
  cacheSize: 50000
}
```

**Accuracy-Optimized**:
```typescript
{
  quantization: 'none',
  indexType: 'hnsw',
  efSearch: 200,
  efConstruction: 400
}
```

**Mobile/Embedded**:
```typescript
{
  quantization: 'product',
  indexType: 'flat',  // Lower memory overhead
  cacheSize: 1000
}
```

#### Benchmarks

| Configuration | Search Time | Memory | Accuracy |
|--------------|-------------|--------|----------|
| Baseline | 15ms | 100% | 100% |
| HNSW Only | 0.1ms | 100% | 99.5% |
| HNSW + Scalar | 0.08ms | 25% | 99% |
| HNSW + Binary | 0.05ms | 3% | 95% |

---

### AgentDB Advanced Features

**Purpose**: Master advanced capabilities including QUIC synchronization, multi-database management, custom distance metrics, and hybrid search.

**When to Use**: Building distributed AI systems, multi-agent coordination, or advanced vector search applications.

#### QUIC Synchronization

Sub-millisecond latency sync between AgentDB instances:

```typescript
const adapter = await createAgentDBAdapter({
  dbPath: '.agentdb/distributed.db',
  enableQUICSync: true,
  syncPort: 4433,
  syncPeers: [
    '192.168.1.10:4433',
    '192.168.1.11:4433'
  ]
});

// Patterns sync across all peers within ~1ms
await adapter.insertPattern({ /* data */ });
```

#### Custom Distance Metrics

| Metric | Best For | Formula |
|--------|----------|---------|
| **Cosine** | Text embeddings, semantic similarity | `cos(θ) = (A·B)/(‖A‖×‖B‖)` |
| **Euclidean** | Spatial data, image embeddings | `d = √(Σ(aᵢ-bᵢ)²)` |
| **Dot Product** | Recommendation systems | `A·B = Σ(aᵢ×bᵢ)` |

```bash
npx agentdb@latest query ./vectors.db "[0.1,0.2,...]" -m euclidean
```

#### Hybrid Search

Combine vector similarity with metadata filtering:

```typescript
const results = await db.hybridSearch({
  embedding: queryVector,
  k: 10,
  filter: {
    category: 'technical',
    date: { $gte: '2024-01-01' },
    score: { $gte: 0.8 }
  },
  rerank: true  // MMR diversity reranking
});
```

#### Multi-Database Management

```typescript
const manager = new AgentDBManager();

// Register databases
manager.register('users', './users.db');
manager.register('products', './products.db');
manager.register('interactions', './interactions.db');

// Cross-database query
const results = await manager.federatedQuery({
  query: userEmbedding,
  databases: ['users', 'interactions'],
  mergeStrategy: 'score-weighted'
});
```

---

### AgentDB Learning Plugins

**Purpose**: Create and train AI learning plugins with 9 reinforcement learning algorithms.

**When to Use**: Building self-learning agents, implementing RL, or optimizing agent behavior through experience.

#### Available Algorithms

| Algorithm | Type | Best For |
|-----------|------|----------|
| **Decision Transformer** | Offline RL | Sequential decision-making |
| **Q-Learning** | Value-based | Discrete action spaces |
| **SARSA** | On-policy | Safe exploration |
| **Actor-Critic** | Policy gradient | Continuous actions |
| **Active Learning** | Query-based | Sample-efficient learning |
| **Adversarial Training** | Robustness | Attack-resistant models |
| **Curriculum Learning** | Progressive | Complex task learning |
| **Federated Learning** | Distributed | Privacy-preserving |
| **Multi-Task Learning** | Transfer | Shared representations |

#### Quick Start

```bash
# Create learning plugin
npx agentdb@latest create-plugin -t decision-transformer

# Train model
npx agentdb@latest train --plugin ./my-plugin --data ./trajectories.json

# Deploy
npx agentdb@latest deploy --plugin ./my-plugin
```

#### Decision Transformer Example

```typescript
import { DecisionTransformer } from 'agentdb/learning';

const dt = new DecisionTransformer({
  stateSize: 64,
  actionSize: 10,
  contextLength: 20,
  hiddenSize: 256
});

// Train on trajectory data
await dt.train({
  trajectories: trajectoryData,
  epochs: 100,
  batchSize: 64
});

// Generate actions
const action = await dt.predict({
  states: recentStates,
  actions: recentActions,
  returns: targetReturn
});
```

#### Performance

- **Training**: 10-100x faster with WASM acceleration
- **Inference**: <1ms per action
- **Memory**: Optimized for edge deployment

---

## Swarm Orchestration Skills

### Swarm Orchestration

**Purpose**: Orchestrate multi-agent swarms for parallel task execution, dynamic topology, and intelligent coordination.

**When to Use**: Scaling beyond single agents, implementing complex workflows, or building distributed AI systems.

#### Topology Patterns

| Topology | Structure | Best For |
|----------|-----------|----------|
| **Mesh** | Peer-to-peer | Collaborative tasks |
| **Hierarchical** | Queen-worker | Coordinated projects |
| **Star** | Central hub | Aggregation tasks |
| **Ring** | Sequential | Pipeline processing |
| **Adaptive** | Dynamic | Variable workloads |

#### Quick Start

```bash
# Initialize swarm
npx claude-flow swarm start --topology mesh --max-agents 5

# Spawn agents
npx claude-flow agent spawn --type coder
npx claude-flow agent spawn --type tester
npx claude-flow agent spawn --type reviewer

# Orchestrate task
npx claude-flow task run "Build REST API with tests" --mode parallel
```

#### Implementation

```typescript
import { Swarm } from 'claude-flow';

const swarm = new Swarm({
  topology: 'hierarchical',
  queen: 'architect',
  workers: ['backend-dev', 'frontend-dev', 'tester']
});

// Parallel execution
const results = await swarm.execute({
  tasks: [
    { agent: 'backend-dev', task: 'Implement API endpoints' },
    { agent: 'frontend-dev', task: 'Build UI components' },
    { agent: 'tester', task: 'Write test suite' }
  ],
  mode: 'parallel',
  timeout: 300000
});

// Pipeline execution
await swarm.pipeline([
  { stage: 'design', agent: 'architect' },
  { stage: 'implement', agents: ['backend-dev', 'frontend-dev'], parallel: true },
  { stage: 'test', agent: 'tester', after: 'implement' },
  { stage: 'review', agent: 'reviewer', after: 'test' }
]);
```

#### Auto-Orchestration

```typescript
// Let swarm decide execution strategy
await swarm.autoOrchestrate({
  goal: 'Build production-ready API',
  constraints: {
    maxTime: 3600,
    maxAgents: 8,
    qualityThreshold: 0.95
  }
});
```

---

### Swarm Advanced

**Purpose**: Advanced swarm patterns for research, development, testing, and complex distributed workflows.

**When to Use**: Complex multi-stage projects, research workflows, or enterprise-scale orchestration.

#### Advanced Patterns

**Research Swarm**:
```typescript
const research = await swarm.createCluster('research', {
  agents: ['researcher', 'analyst', 'synthesizer'],
  workflow: 'iterative',
  convergenceCriteria: { confidence: 0.9 }
});
```

**Development Swarm**:
```typescript
const dev = await swarm.createCluster('development', {
  agents: ['architect', 'coder', 'tester', 'reviewer'],
  workflow: 'pipeline',
  gates: ['design-review', 'code-review', 'qa-sign-off']
});
```

**Testing Swarm**:
```typescript
const test = await swarm.createCluster('testing', {
  agents: ['unit-tester', 'integration-tester', 'e2e-tester', 'security-tester'],
  workflow: 'parallel',
  aggregation: 'all-pass'
});
```

#### Fault Tolerance

```typescript
const swarm = new Swarm({
  faultTolerance: {
    retries: 3,
    backoff: 'exponential',
    fallbackAgents: true,
    checkpointing: true
  }
});
```

---

### Hive Mind Advanced

**Purpose**: Queen-led collective intelligence system with consensus mechanisms and persistent memory.

**When to Use**: Complex decision-making requiring multiple perspectives, consensus building, or distributed cognition.

#### Queen Types

| Type | Role | Behavior |
|------|------|----------|
| **Strategic** | Long-term planning | Goal decomposition, resource allocation |
| **Tactical** | Short-term execution | Task assignment, coordination |
| **Adaptive** | Dynamic response | Real-time optimization, learning |

#### Worker Specializations

- **Researcher**: Information gathering, analysis
- **Coder**: Implementation, debugging
- **Analyst**: Data processing, insights
- **Tester**: Quality assurance, verification

#### Implementation

```typescript
import { HiveMind } from 'claude-flow/hive';

const hive = new HiveMind({
  queen: {
    type: 'strategic',
    decisionModel: 'weighted-consensus'
  },
  workers: {
    researcher: 2,
    coder: 3,
    analyst: 1,
    tester: 2
  },
  memory: {
    type: 'distributed',
    persistence: 'sqlite-wal'
  }
});

// Collective decision-making
const decision = await hive.decide({
  question: 'Best architecture for real-time system?',
  consensus: 'majority',
  timeout: 30000
});
```

#### Consensus Mechanisms

| Mechanism | Description | Use Case |
|-----------|-------------|----------|
| **Majority** | >50% agreement | Quick decisions |
| **Weighted** | Expertise-based voting | Technical decisions |
| **Byzantine** | Fault-tolerant | Critical systems |
| **Unanimous** | 100% agreement | High-stakes decisions |

#### Performance

- **Batch Spawning**: 10-20x faster than sequential
- **Token Reduction**: 32.3% through shared context
- **Memory**: LRU cache with SQLite WAL persistence

---

### Stream Chain

**Purpose**: Stream-JSON chaining for multi-agent pipelines, data transformation, and sequential workflows.

**When to Use**: Real-time data processing, agent-to-agent output piping, or ETL workflows.

#### Quick Start

```typescript
import { StreamChain } from 'claude-flow/stream';

const chain = new StreamChain()
  .pipe('extractor', { format: 'json' })
  .pipe('transformer', { schema: outputSchema })
  .pipe('loader', { destination: 'database' });

// Process stream
for await (const result of chain.process(inputStream)) {
  console.log('Processed:', result);
}
```

#### Chaining Patterns

```typescript
// Sequential pipeline
const pipeline = chain
  .extract(source)
  .transform(mapping)
  .validate(schema)
  .load(destination);

// Parallel branching
const branches = chain
  .split(data)
  .branch('analysis', analyzeAgent)
  .branch('summary', summarizeAgent)
  .merge('combiner');
```

---

## GitHub Integration Skills

### GitHub Workflow Automation

**Purpose**: Advanced GitHub Actions workflow automation with AI swarm coordination and intelligent CI/CD pipelines.

**When to Use**: Automating CI/CD, managing repository workflows, or implementing intelligent deployment strategies.

#### GitHub Modes

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

#### Quick Start

```bash
# Initialize GitHub integration
npx claude-flow github init --token $GITHUB_TOKEN

# Create automated workflow
npx claude-flow github workflow create --template ci-cd

# Start swarm coordination
npx claude-flow github swarm start --mode gh-coordinator
```

#### Workflow Templates

**CI Pipeline**:
```yaml
# .github/workflows/ci.yml
name: AI-Powered CI
on: [push, pull_request]

jobs:
  swarm-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: claude-flow/swarm-action@v1
        with:
          mode: code-reviewer
          agents: [security, performance, style]
```

**Self-Healing Pipeline**:
```yaml
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
      - uses: claude-flow/diagnose-action@v1
        with:
          mode: auto-fix
          create-pr: true
```

---

### GitHub Code Review

**Purpose**: Comprehensive code review with AI-powered swarm coordination.

**When to Use**: Automating code reviews, ensuring code quality, or implementing review standards.

#### Review Agents

| Agent | Focus Area |
|-------|------------|
| **Security** | Vulnerabilities, injection, auth issues |
| **Performance** | Bottlenecks, optimization opportunities |
| **Architecture** | Design patterns, SOLID principles |
| **Style** | Code formatting, naming conventions |
| **Accessibility** | A11y compliance, inclusive design |

#### Configuration

```yaml
# .swarm/code-review.yml
review:
  agents:
    - security:
        severity: [critical, high, medium]
        auto-block: critical
    - performance:
        thresholds:
          complexity: 15
          duplication: 5%
    - architecture:
        patterns: [solid, clean-architecture]
  
  quality-gates:
    - all-agents-pass
    - no-critical-issues
    - test-coverage: 80%
```

#### Usage

```bash
# Review PR
npx claude-flow github review --pr 123

# Review with specific agents
npx claude-flow github review --pr 123 --agents security,performance
```

---

### GitHub Project Management

**Purpose**: Project management with swarm coordination for issue tracking, sprint planning, and automated triage.

**When to Use**: Managing GitHub projects, automating issue workflows, or coordinating development sprints.

#### Features

- **Automated Triage**: AI-powered issue categorization and assignment
- **Sprint Planning**: Intelligent task decomposition and scheduling
- **Progress Tracking**: Real-time project status monitoring
- **Board Sync**: Automatic project board updates

#### Configuration

```yaml
# .swarm/project-management.yml
project:
  board: "Development Sprint"
  
  triage:
    labels:
      bug: [error, crash, broken]
      feature: [enhancement, new, request]
      docs: [documentation, readme, wiki]
    
    assignment:
      strategy: expertise-match
      fallback: round-robin
  
  sprints:
    duration: 2w
    auto-create: true
    velocity-tracking: true
```

---

### GitHub Release Management

**Purpose**: Release orchestration with AI swarm coordination for automated versioning, testing, deployment, and rollback.

**When to Use**: Managing releases, automating deployments, or implementing release workflows.

#### Swarm Agents

| Agent | Responsibility |
|-------|---------------|
| **Changelog** | Generate release notes |
| **Version** | Semantic version management |
| **Build** | Multi-platform builds |
| **Test** | Pre-release testing |
| **Deploy** | Progressive deployment |

#### Quick Start

```bash
# Prepare release
npx claude-flow github release prepare --version minor

# Execute release
npx claude-flow github release execute --tag v1.2.0

# Rollback if needed
npx claude-flow github release rollback --tag v1.1.0
```

#### Configuration

```yaml
# .swarm/release-management.yml
release:
  versioning: semantic
  
  changelog:
    format: keep-a-changelog
    categories: [added, changed, deprecated, removed, fixed, security]
  
  deployment:
    strategy: progressive
    stages:
      - canary: 5%
      - staging: 25%
      - production: 100%
    rollback:
      trigger: error-rate > 1%
      automatic: true
```

---

### GitHub Multi-Repo

**Purpose**: Multi-repository coordination, synchronization, and architecture management.

**When to Use**: Managing monorepos, coordinating across multiple repositories, or maintaining consistent architecture.

#### Features

- **Cross-Repo Swarms**: Coordinate agents across repositories
- **Dependency Resolution**: Automated version alignment
- **Template Management**: Consistent repository setup
- **Documentation Sync**: Unified documentation

#### Configuration

```yaml
# .swarm/multi-repo.yml
repositories:
  - name: frontend
    path: ./packages/frontend
    dependencies: [shared-types, api-client]
  
  - name: backend
    path: ./packages/backend
    dependencies: [shared-types, database]
  
  - name: shared-types
    path: ./packages/types
    dependents: [frontend, backend]

sync:
  strategy: lock-step
  version-alignment: true
  test-matrix: full
```

---

## Flow Nexus Platform Skills

### Flow Nexus Platform

**Purpose**: Comprehensive Flow Nexus platform management including authentication, sandboxes, app deployment, payments, and challenges.

**When to Use**: Building applications on Flow Nexus, managing cloud resources, or deploying AI-powered apps.

#### Subscription Tiers

| Tier | Credits | Features |
|------|---------|----------|
| **Free** | 100/month | Basic sandboxes, community support |
| **Pro** | 1,000/month | Priority execution, advanced templates |
| **Enterprise** | Unlimited | Custom sandboxes, dedicated support |

#### Quick Start

```bash
# Authenticate
npx flow-nexus auth login

# Create sandbox
npx flow-nexus sandbox create --template node

# Deploy app
npx flow-nexus deploy --app my-app
```

#### MCP Tools

```typescript
// Authentication
await mcp__flow_nexus__auth_login({ email, password });

// Sandbox management
await mcp__flow_nexus__sandbox_create({ template: 'react' });
await mcp__flow_nexus__sandbox_execute({ sandboxId, code });

// App deployment
await mcp__flow_nexus__app_deploy({ appId, version });
```

#### Sandbox Templates

| Template | Stack | Use Case |
|----------|-------|----------|
| `node` | Node.js 20 | API development |
| `python` | Python 3.11 | Data processing |
| `react` | React + Vite | Frontend apps |
| `nextjs` | Next.js 14 | Full-stack apps |

---

### Flow Nexus Swarm

**Purpose**: Cloud-based AI swarm deployment and event-driven workflow automation.

**When to Use**: Deploying swarms to cloud, implementing event-driven workflows, or scaling AI operations.

#### Swarm Templates

| Template | Agents | Use Case |
|----------|--------|----------|
| `full-stack-dev` | architect, frontend, backend, tester | Application development |
| `research-team` | researcher, analyst, writer | Research projects |
| `code-review` | security, performance, style | Code quality |
| `data-pipeline` | extractor, transformer, loader | ETL workflows |

#### Quick Start

```bash
# Deploy swarm to cloud
npx flow-nexus swarm deploy --template full-stack-dev

# Monitor swarm
npx flow-nexus swarm status --id swarm-123

# Scale swarm
npx flow-nexus swarm scale --id swarm-123 --agents 10
```

#### Event-Driven Workflows

```typescript
// Define event-driven workflow
await mcp__flow_nexus__workflow_create({
  name: 'pr-review',
  trigger: 'github.pull_request.opened',
  steps: [
    { agent: 'security-reviewer', action: 'scan' },
    { agent: 'code-reviewer', action: 'review' },
    { agent: 'reporter', action: 'summarize' }
  ]
});
```

---

### Flow Nexus Neural

**Purpose**: Train and deploy neural networks in distributed E2B sandboxes.

**When to Use**: Training ML models, deploying inference endpoints, or building AI-powered features.

#### Supported Architectures

| Architecture | Use Case | Training Tier |
|--------------|----------|---------------|
| **Feedforward** | Classification, regression | Nano - Small |
| **LSTM** | Sequence modeling | Small - Medium |
| **GAN** | Image generation | Medium - Large |
| **Transformer** | NLP, attention-based | Large |

#### Training Tiers

| Tier | Resources | Max Time | Cost |
|------|-----------|----------|------|
| **Nano** | 1 CPU, 1GB RAM | 5 min | 1 credit |
| **Small** | 2 CPU, 4GB RAM | 30 min | 10 credits |
| **Medium** | 4 CPU, 16GB RAM | 2 hours | 50 credits |
| **Large** | 8 CPU, 32GB RAM | 8 hours | 200 credits |

#### Quick Start

```bash
# Create neural network
npx flow-nexus neural create --architecture transformer --name my-model

# Train model
npx flow-nexus neural train --model my-model --data ./training-data.json

# Deploy inference endpoint
npx flow-nexus neural deploy --model my-model --tier small
```

#### Distributed Training

```typescript
// Create distributed training cluster
await mcp__flow_nexus__neural_cluster_create({
  topology: 'ring',
  nodes: 4,
  architecture: 'transformer',
  federated: true  // Privacy-preserving training
});
```

---

## Development & Quality Skills

### SPARC Methodology

**Purpose**: SPARC (Specification, Pseudocode, Architecture, Refinement, Completion) comprehensive development methodology with multi-agent orchestration.

**When to Use**: Structured development projects, complex system design, or team-based development.

#### SPARC Phases

| Phase | Focus | Agent Mode |
|-------|-------|------------|
| **S**pecification | Requirements gathering | `architect` |
| **P**seudocode | Algorithm design | `coder` |
| **A**rchitecture | System design | `architect` |
| **R**efinement | Iteration & testing | `tester`, `optimizer` |
| **C**ompletion | Final delivery | `reviewer` |

#### Quick Start

```bash
# Start SPARC workflow
npx claude-flow sparc start "Build e-commerce platform"

# Run specific phase
npx claude-flow sparc architect "Design payment system"
npx claude-flow sparc coder "Implement checkout flow"
npx claude-flow sparc tester "Create integration tests"
```

#### Mode-Specific Behaviors

**Architect Mode**:
- Generates system diagrams
- Defines API contracts
- Creates data models
- Documents architecture decisions

**Coder Mode**:
- Implements features with TDD
- Follows coding standards
- Creates comprehensive tests
- Documents code

**Tester Mode**:
- Writes unit tests
- Creates integration tests
- Performs security testing
- Generates coverage reports

**Optimizer Mode**:
- Profiles performance
- Identifies bottlenecks
- Implements optimizations
- Benchmarks improvements

---

### Pair Programming

**Purpose**: AI-assisted pair programming with multiple modes, real-time verification, and quality monitoring.

**When to Use**: Collaborative development, learning sessions, or quality-focused coding.

#### Modes

| Mode | Description |
|------|-------------|
| **Driver** | Claude writes, user guides |
| **Navigator** | User writes, Claude guides |
| **Switch** | Alternating roles |
| **TDD** | Test-driven development |
| **Review** | Code review focus |
| **Mentor** | Learning-focused |
| **Debug** | Problem-solving focus |

#### Quick Start

```bash
# Start pair programming session
npx claude-flow pair start --mode tdd

# Commands during session
/suggest     # Get code suggestions
/review      # Request code review
/test        # Generate tests
/refactor    # Suggest refactoring
/optimize    # Performance optimization
```

#### Features

- **Real-time Verification**: Truth-score threshold of 0.95
- **Auto-save**: Session persistence
- **Role Switching**: Automatic or manual
- **Quality Monitoring**: Continuous code analysis

---

### Verification & Quality

**Purpose**: Comprehensive truth scoring, code quality verification, and automatic rollback system.

**When to Use**: Ensuring high-quality outputs, implementing quality gates, or building reliable systems.

#### Truth Scoring

```typescript
import { Verifier } from 'claude-flow/verification';

const verifier = new Verifier({
  threshold: 0.95,
  rollbackOnFailure: true
});

const result = await verifier.verify({
  claim: "This code handles all edge cases",
  evidence: codeAnalysis,
  tests: testResults
});

if (result.score < 0.95) {
  await verifier.rollback();
}
```

#### Quality Gates

| Gate | Threshold | Action on Failure |
|------|-----------|-------------------|
| **Truth Score** | 0.95 | Rollback |
| **Test Coverage** | 80% | Block merge |
| **Security Scan** | No critical | Block deploy |
| **Performance** | <100ms p95 | Alert |

#### Auto-Rollback

```typescript
const deployment = await deploy({
  verification: {
    truthScore: 0.95,
    metrics: ['error-rate', 'latency'],
    rollbackTrigger: {
      errorRate: '> 1%',
      latency: '> 500ms'
    }
  }
});
```

---

### Performance Analysis

**Purpose**: Comprehensive performance analysis, bottleneck detection, and optimization recommendations.

**When to Use**: Optimizing system performance, identifying bottlenecks, or generating performance reports.

#### Bottleneck Categories

| Category | Detection | Typical Fix |
|----------|-----------|-------------|
| **Communication** | High latency between agents | Reduce message size, batch operations |
| **Processing** | High CPU usage | Algorithm optimization, parallelization |
| **Memory** | High memory consumption | Caching, pagination, streaming |
| **Network** | I/O wait time | Connection pooling, async operations |

#### Quick Start

```bash
# Detect bottlenecks
npx claude-flow bottleneck detect

# Generate performance report
npx claude-flow analysis performance-report --format html

# Auto-fix issues
npx claude-flow bottleneck fix --auto
```

#### Report Formats

```bash
# JSON (machine-readable)
npx claude-flow analysis performance-report --format json

# HTML (interactive dashboard)
npx claude-flow analysis performance-report --format html

# Markdown (documentation)
npx claude-flow analysis performance-report --format markdown
```

#### Typical Improvements

| Optimization | Improvement |
|--------------|-------------|
| Batch operations | 25-45% |
| Caching | 30-60% |
| Parallelization | 40-70% |
| Algorithm optimization | 20-50% |

---

### Hooks Automation

**Purpose**: Automated coordination via hooks for pre/post operations, session management, and Git integration.

**When to Use**: Automating development workflows, implementing hooks, or coordinating complex operations.

#### Hook Types

| Hook | Trigger | Use Case |
|------|---------|----------|
| **pre-edit** | Before file edit | Backup, validation |
| **post-edit** | After file edit | Formatting, testing |
| **pre-task** | Before task start | Setup, dependencies |
| **post-task** | After task complete | Cleanup, notification |
| **pre-search** | Before search | Query optimization |
| **post-search** | After search | Result filtering |

#### Configuration

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

#### Three-Phase Memory Protocol

1. **Status Phase**: Report current state
2. **Progress Phase**: Update on ongoing work
3. **Complete Phase**: Final results and learnings

---

## Intelligence & Learning Skills

### ReasoningBank with AgentDB

**Purpose**: Implement ReasoningBank adaptive learning with AgentDB's 150x faster vector database.

**When to Use**: Building self-learning agents, optimizing decision-making, or implementing experience replay.

#### Reasoning Modules

| Module | Purpose |
|--------|---------|
| **PatternMatcher** | Identify recurring patterns |
| **ContextSynthesizer** | Combine context from multiple sources |
| **MemoryOptimizer** | Prune and consolidate memories |
| **ExperienceCurator** | Select relevant experiences |

#### Quick Start

```bash
# Migrate existing ReasoningBank to AgentDB
npx agentdb@latest migrate

# Record experience
npx agentdb@latest experience record --trajectory ./trajectory.json

# Query reasoning
npx agentdb@latest reason "What's the best approach for this task?"
```

#### Implementation

```typescript
import { ReasoningBank } from 'agentic-flow/reasoningbank';

const rb = await ReasoningBank.create({
  adapter: 'agentdb',  // 150x faster
  dbPath: '.agentdb/reasoning.db'
});

// Record trajectory
await rb.recordTrajectory({
  task: 'API Implementation',
  steps: trajectorySteps,
  outcome: 'success',
  learnings: ['Cache improves performance by 60%']
});

// Get recommendation
const strategy = await rb.recommendStrategy({
  task: 'Build REST API',
  context: currentContext
});
```

---

### ReasoningBank Intelligence

**Purpose**: Adaptive learning for pattern recognition, strategy optimization, and continuous improvement.

**When to Use**: Building self-learning agents, optimizing workflows, or implementing meta-cognitive systems.

#### Features

- **Pattern Recognition**: Learn from past experiences
- **Strategy Optimization**: Improve decision-making over time
- **Transfer Learning**: Apply learnings to new domains
- **Meta-Learning**: Learn how to learn better

#### Implementation

```typescript
import { ReasoningBank } from 'claude-flow/reasoning';

const rb = new ReasoningBank({
  persistence: 'agentdb',
  learningRate: 0.1,
  explorationRate: 0.2
});

// Record experience
await rb.recordExperience({
  situation: 'API design decision',
  action: 'Used REST over GraphQL',
  outcome: 'positive',
  reasoning: 'Simpler for CRUD operations'
});

// Get recommendation
const strategy = await rb.recommendStrategy({
  situation: 'API design decision',
  options: ['REST', 'GraphQL', 'gRPC']
});

// Learn pattern
await rb.learnPattern({
  pattern: 'Use REST for simple CRUD',
  confidence: 0.85,
  context: ['crud', 'simple-api']
});
```

---

### Agentic Jujutsu

**Purpose**: Quantum-resistant, self-learning version control for AI agents with ReasoningBank intelligence.

**When to Use**: Multi-agent coordination requiring versioning, pattern discovery, or secure state management.

#### Key Features

| Feature | Benefit |
|---------|---------|
| **23x faster than Git** | 350 ops/s vs 15 ops/s |
| **Self-learning** | ReasoningBank integration |
| **Lock-free** | No merge conflicts |
| **87% auto-resolution** | Automatic conflict handling |
| **Quantum-resistant** | SHA3-512, HQC-128 encryption |

#### Quick Start

```typescript
import { JjWrapper } from 'agentic-jujutsu';

const jj = new JjWrapper({
  workDir: './agent-state',
  enableReasoning: true
});

// Start trajectory
const trajectory = await jj.startTrajectory({
  task: 'Implement feature X',
  agent: 'coder-01'
});

// Make changes
await jj.checkpoint('Implemented base functionality');

// Finalize
await jj.finalizeTrajectory({
  outcome: 'success',
  learnings: ['Pattern A works well here']
});

// Get suggestions from learned patterns
const suggestion = await jj.getSuggestion({
  context: 'Similar feature implementation'
});
```

#### Pattern Discovery

```typescript
// Discover patterns from history
const patterns = await jj.getPatterns({
  minConfidence: 0.8,
  category: 'implementation'
});

// Get learning statistics
const stats = await jj.getLearningStats();
// { totalTrajectories: 150, successRate: 0.87, topPatterns: [...] }
```

---

## Skill Development

### Skill Builder

**Purpose**: Create new Claude Code Skills with proper YAML frontmatter, progressive disclosure structure, and complete directory organization.

**When to Use**: Building custom skills for specific workflows, generating skill templates, or understanding the Claude Skills specification.

#### Skill Structure

```
~/.claude/skills/
└── my-skill/
    ├── SKILL.md          # Required: Main skill file
    ├── README.md         # Optional: Human-readable docs
    ├── scripts/          # Optional: Executable scripts
    ├── resources/        # Optional: Supporting files
    └── docs/             # Optional: Additional documentation
```

#### YAML Frontmatter

```yaml
---
name: "My Skill Name"           # Required: Max 64 chars
description: "What it does and  # Required: Max 1024 chars
when to use it."                # Include BOTH what & when
---
```

#### Quick Start

```bash
# Create skill directory
mkdir -p ~/.claude/skills/my-skill

# Create SKILL.md
cat > ~/.claude/skills/my-skill/SKILL.md << 'EOF'
---
name: "My Skill"
description: "Brief description of what this skill does and when Claude should use it."
---

# My Skill

## What This Skill Does
[Your instructions here]

## Quick Start
[Basic usage]
EOF
```

#### Progressive Disclosure

| Level | Content | Loaded When |
|-------|---------|-------------|
| **1** | Name + Description | Always (startup) |
| **2** | SKILL.md body | When skill triggered |
| **3+** | Referenced files | On-demand |

#### Best Practices

1. **Front-load triggers**: Put key trigger words early in description
2. **Be specific**: Include concrete use cases
3. **Progressive detail**: Start simple, add depth as needed
4. **Include examples**: Show don't tell
5. **Validate format**: Use YAML linter

---

## Installation & Setup

### Prerequisites

```bash
# Node.js 18+
node --version  # Should be >= 18.0.0

# npm or yarn
npm --version
```

### Install Claude Flow

```bash
# Global installation
npm install -g claude-flow@alpha

# Verify installation
npx claude-flow --version
```

### Install AgentDB

```bash
# Via npx (no install needed)
npx agentdb@latest --help

# Or global installation
npm install -g agentdb
```

### Initialize Project

```bash
# Initialize Claude Flow in project
npx claude-flow init

# This creates:
# - .claude/settings.json
# - .swarm/config.yml
# - .agentdb/
```

### MCP Server Setup

```json
// claude_desktop_config.json
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["claude-flow-mcp"]
    },
    "agentdb": {
      "command": "npx",
      "args": ["agentdb-mcp"]
    }
  }
}
```

---

## Performance Benchmarks

### AgentDB Performance

| Operation | Baseline | With HNSW | With Cache |
|-----------|----------|-----------|------------|
| Vector Search (1M) | 15ms | 0.1ms | 0.05ms |
| Insert (single) | 5ms | 1ms | 1ms |
| Batch Insert (100) | 500ms | 2ms | 2ms |

### Memory Optimization

| Configuration | Memory Usage | Search Accuracy |
|--------------|--------------|-----------------|
| No quantization | 100% | 100% |
| Scalar (4x) | 25% | 99% |
| Binary (32x) | 3.1% | 95% |

### Swarm Performance

| Metric | Mesh | Hierarchical | Adaptive |
|--------|------|--------------|----------|
| Spawn time (10 agents) | 2.5s | 2.0s | 2.2s |
| Task distribution | 150ms | 80ms | 100ms |
| Communication overhead | 15% | 8% | 10% |

### Agentic Jujutsu vs Git

| Operation | Git | Agentic Jujutsu | Improvement |
|-----------|-----|-----------------|-------------|
| Commit | 65ms | 2.8ms | 23x |
| Branch | 45ms | 1.9ms | 24x |
| Merge | 180ms | 8.5ms | 21x |
| Throughput | 15 ops/s | 350 ops/s | 23x |

---

## Additional Resources

### Documentation Links

- [Claude Flow GitHub](https://github.com/ruvnet/claude-flow)
- [AgentDB Documentation](https://agentdb.dev)
- [Flow Nexus Platform](https://flow-nexus.dev)
- [Claude Code Skills](https://docs.claude.com/en/docs/claude-code)

### Community

- GitHub Issues: Report bugs and feature requests
- Discussions: Community Q&A
- Discord: Real-time support

---

**Document Version**: 1.0.0  
**Last Updated**: January 2026  
**Skills Covered**: 26  
**Source**: Claude Flow Skills Archive
