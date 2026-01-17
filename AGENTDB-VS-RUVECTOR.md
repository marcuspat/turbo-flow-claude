# AgentDB vs RuVector - Usage Guide

**When to use AgentDB versus RuVector in Claude Flow V3**

---

## 🎯 TL;DR - Quick Decision Matrix

| Your Need | Use This | Why |
|-----------|----------|-----|
| **Vector memory storage** | AgentDB | Built into Claude Flow, persistent HNSW indexing |
| **Code intelligence (routing, AST, diff)** | RuVector | ML-based agent routing, code analysis |
| **Distributed swarms (100+ agents)** | RuVector Postgres | Centralized coordination across hosts |
| **Local development (1-15 agents)** | AgentDB | Simpler, already installed |
| **Advanced neural (LoRA, EWC++, Flash Attention)** | RuVector | Native Rust performance |
| **Simple semantic search** | AgentDB | Good enough for most cases |

---

## 📊 Overview

### What They Are

**AgentDB:**
- Vector database component of `@claude-flow/memory` package
- JavaScript/TypeScript implementation with WASM SQLite backend
- **Automatically installed** with Claude Flow V3
- Handles memory storage, pattern persistence, semantic search

**RuVector:**
- **Separate npm package** - high-performance Rust/WASM library
- Optional dependency for Claude Flow
- **Must be installed separately**: `npm install ruvector`
- Provides code intelligence, ML routing, advanced neural features

---

## 🔍 AgentDB - Built-in Vector Memory Storage

### What It Is

Vector database component built into `@claude-flow/memory` that provides:
- Pattern storage and retrieval
- Semantic search via HNSW indexing
- Cross-agent memory sharing
- Session persistence
- 150x-12,500x faster search than brute force

### Core Capabilities

```typescript
import { AgentDBAdapter, HNSWIndex } from '@claude-flow/memory';

// Initialize vector storage with HNSW indexing
const adapter = new AgentDBAdapter({
  dimension: 1536,
  indexType: 'hnsw',
  metric: 'cosine',
  hnswM: 16,
  hnswEfConstruction: 200
});

// Store memory with embedding
await adapter.store({
  id: 'mem-123',
  content: 'User prefers dark mode',
  embedding: vector,
  metadata: { type: 'preference' }
});

// Semantic search (150x-12,500x faster than brute force)
const memories = await adapter.search(queryVector, {
  limit: 10,
  threshold: 0.7
});

// Cross-agent memory sharing
await adapter.enableCrossAgentSharing({
  shareTypes: ['patterns', 'preferences'],
  excludeTypes: ['secrets']
});
```

### When to Use AgentDB

✅ **Memory & Pattern Storage**
- Storing agent memories, patterns, preferences
- Cross-session context persistence
- Pattern learning from successful executions
- Multi-agent memory sharing
- Knowledge base storage

✅ **Semantic Search**
- Finding similar patterns via vector similarity
- RAG (Retrieval Augmented Generation) systems
- Knowledge base semantic search
- Document similarity matching
- Pattern retrieval for agent context

✅ **Local Development**
- Single machine deployment
- 1-15 agents in swarms
- Development environment
- Personal projects
- Quick prototyping

✅ **Already Installed**
- No additional dependencies needed
- Works out of the box with Claude Flow V3
- Zero configuration required

### Performance Characteristics

| Operation | Performance | Target |
|-----------|-------------|--------|
| **HNSW Search** | <1ms for 100K vectors | <1ms |
| **Memory Write** | <5ms | <5ms |
| **Bulk Insert** | 2-3ms per entry (batched) | <5ms |
| **Cache Hit** | <0.1ms | <1ms |
| **Index Build** | 800ms for 100K vectors | <10s |

**Memory Usage:**
- ~500MB for 100K entries
- Cache hit rate: >80%
- Improvement over brute force: 150x-12,500x

### CLI Commands (AgentDB)

```bash
# Initialize memory database
claude-flow memory init

# Store data
claude-flow memory store --key "auth-pattern" --value "JWT tokens" --namespace patterns

# Semantic search
claude-flow memory search --query "authentication patterns"

# List all entries
claude-flow memory list --namespace patterns

# Retrieve specific entry
claude-flow memory retrieve --key "auth-pattern"

# Statistics
claude-flow memory stats
```

---

## 🚀 RuVector - Advanced Code Intelligence & Neural Computing

### What It Is

High-performance Rust/WASM library providing:
- Q-Learning agent routing (learns from outcomes)
- AST analysis and code structure parsing
- Diff classification and risk scoring
- Coverage-aware task routing
- Graph-based boundary detection
- Advanced neural features (Flash Attention, SONA, LoRA, EWC++)

**Optional Dependency:** Must install separately with `npm install ruvector`

### Core Capabilities

#### 1. Q-Learning Agent Routing

```bash
# Intelligent task routing (80%+ accuracy)
claude-flow route --task "Fix authentication bug" --q-learning

# Output:
# Agent: debugger
# Confidence: 92%
# Reason: Similar bug fixes successful with debugger agent
# Alternatives: coder (75%), security-architect (68%)
```

**How It Works:**
- Learns from past task outcomes
- Builds Q-table of state-action-reward triples
- Recommends agents based on historical success
- Improves over time (reinforcement learning)

#### 2. AST Analysis

```bash
# Code structure analysis
claude-flow analyze ast src/auth/

# Output:
# File: src/auth/handlers.ts
# Functions: 12
# Classes: 3
# Complexity: 45 (cyclomatic)
# Imports: ['express', 'bcrypt', 'jsonwebtoken']
# Exports: ['authMiddleware', 'loginHandler', 'registerHandler']
```

**Features:**
- Symbol extraction (functions, classes, types)
- Complexity metrics (cyclomatic, cognitive)
- Import/export analysis
- Dependency graph generation

#### 3. Diff Classification

```bash
# Classify code changes with risk scoring
claude-flow analyze diff --risk

# Output:
# Category: bugfix
# Risk Score: 0.32 (low)
# Affected Files: 3
# Additions: 47 lines
# Deletions: 12 lines
# Recommendations: Add integration tests for auth changes
```

**Features:**
- Automatic change categorization (feature/bugfix/refactor/docs/test/config)
- Risk scoring (0.0-1.0)
- Affected file analysis
- Actionable recommendations

#### 4. Coverage-Aware Routing

```bash
# Route based on test coverage gaps
claude-flow route --task "Add validation tests" --coverage-aware

# Output:
# Routes to 'tester' if coverage <70%
# Routes to 'coder' if coverage >70%
# Suggests test files to create
```

#### 5. Graph-Based Boundary Detection

```bash
# Find optimal code module boundaries
claude-flow analyze boundaries src/ --algorithm louvain

# Output:
# Detected 5 modules:
#   - Module 1: auth/ (cohesion: 0.87)
#   - Module 2: api/ (cohesion: 0.92)
#   - Module 3: db/ (cohesion: 0.79)
# Suggested splits: 2 boundaries with high coupling
```

**Algorithms:**
- **MinCut** (Stoer-Wagner) - Optimal 2-way partition
- **Louvain** - Community detection (automatic cluster count)
- **Spectral** - K-way clustering
- **Tarjan's SCC** - Circular dependency detection

#### 6. Advanced Neural Features

```typescript
import { FlashAttention } from '@ruvector/attention';
import { SONA } from '@ruvector/sona';

// Flash Attention (2.49x-7.47x speedup)
const attention = new FlashAttention({
  blockSize: 32,
  dimensions: 384,
  temperature: 1.0
});

const result = attention.attention(queries, keys, values);
// Speedup: 5.2x
// Memory: O(N) instead of O(N²)

// SONA learning (LoRA + EWC++)
const sona = new SONA({
  enableLoRA: true,       // Low-rank adaptation
  enableEWC: true,        // Prevents catastrophic forgetting
  learningRate: 0.001
});

// Record learning trajectory
const trajectory = sona.startTrajectory('task-123');
trajectory.recordStep({
  type: 'action',
  content: 'Applied JWT validation fix'
});
await trajectory.complete('success');

// Consolidate (prevents forgetting)
await sona.consolidate();
```

### When to Use RuVector

✅ **Code Analysis & Intelligence**
- AST parsing and symbol extraction
- Complexity analysis (cyclomatic, cognitive)
- Diff classification and risk scoring
- Import dependency analysis
- Code boundary detection using graph algorithms

✅ **ML-Based Routing**
- Q-Learning agent routing (learns from outcomes)
- Coverage-aware task routing (routes to tester if coverage low)
- Pattern-based agent selection
- Learning from feedback (80%+ accuracy)
- Route optimization over time

✅ **Advanced Neural Computing**
- Flash Attention (2.49x-7.47x faster than naive implementation)
- SONA learning (<0.05ms adaptation time)
- LoRA fine-tuning (128x memory compression)
- EWC++ (prevents catastrophic forgetting)
- ReasoningBank pattern storage with trajectory learning

✅ **Large-Scale Production**
- RuVector Postgres for centralized state
- 100+ agents distributed across hosts
- Real-time pattern synchronization
- Centralized learning persistence
- Full SQL + pgvector queries

✅ **Performance-Critical Applications**
- Native Rust performance (faster than JavaScript)
- WASM fallback for universal compatibility
- Sub-millisecond routing decisions
- Optimized graph algorithms

### Performance Characteristics

| Operation | Performance | Speedup |
|-----------|-------------|---------|
| **ONNX Inference** | ~400ms | Initial embedding |
| **HNSW Search** | ~0.045ms | 8,800x faster than inference |
| **Memory Cache** | ~0.01ms | 40,000x speedup |
| **Native Rust** | <0.5ms | p50 latency |
| **WASM Fallback** | 10-50ms | Universal compatibility |
| **Q-Learning Route** | <1ms | ML decision |
| **AST Analysis** | 50-200ms | Full parse + symbols |
| **Flash Attention** | 2.49x-7.47x | vs naive O(N²) |

### CLI Commands (RuVector)

```bash
# Installation
npm install ruvector

# Verify installation
npx ruvector status

# Q-Learning routing
claude-flow route --task "Implement auth" --q-learning

# AST analysis
claude-flow analyze ast src/ --complexity
claude-flow analyze symbols src/api.ts

# Diff analysis
claude-flow analyze diff --risk
claude-flow analyze diff --base main --target feature

# Coverage routing
claude-flow route --task "Add tests" --coverage-aware

# Graph analysis
claude-flow analyze boundaries src/ --algorithm louvain
claude-flow analyze circular src/  # Circular dependencies

# Statistics
claude-flow route stats
npx ruvector hooks stats

# Learning feedback
claude-flow route feedback --task-id task-123 --success true
```

---

## 🔄 How They Work Together

### Architecture Relationship

```
┌──────────────────────────────────────────────────────────────────┐
│                      Claude Flow V3                              │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  @claude-flow/memory (AgentDB) ← CORE MEMORY LAYER              │
│  ┌────────────────────────────────────────────┐                 │
│  │ UnifiedMemoryService                       │                 │
│  │  ├─ SQLite Backend (structured data)       │                 │
│  │  ├─ AgentDB Backend (vector storage)       │ ← Built-in     │
│  │  └─ Hybrid Backend (SQLite + AgentDB)      │   Required     │
│  │                                            │                 │
│  │ Features:                                  │                 │
│  │  • Pattern storage & retrieval             │                 │
│  │  • Semantic search (HNSW 150x faster)      │                 │
│  │  • Cross-agent memory sharing              │                 │
│  │  • Session persistence                     │                 │
│  │  • Vector quantization (4-32x compression) │                 │
│  └────────────────────────────────────────────┘                 │
│                                                                  │
│  ruvector (Optional) ← INTELLIGENCE LAYER                       │
│  ┌────────────────────────────────────────────┐                 │
│  │ RuVector Intelligence Layer                │                 │
│  │  ├─ Q-Learning Router (ML routing)         │                 │
│  │  ├─ AST Analyzer (code structure)          │ ← Optional     │
│  │  ├─ Diff Classifier (risk scoring)         │   Add-on       │
│  │  ├─ Coverage Router (test-aware)           │                 │
│  │  ├─ Graph Analyzer (boundaries)            │                 │
│  │  └─ Flash Attention (2.49x-7.47x speedup)  │                 │
│  │                                            │                 │
│  │ Features:                                  │                 │
│  │  • ML-based agent routing (learns)         │                 │
│  │  • Code structure analysis                 │                 │
│  │  • Neural optimizations (SONA, LoRA, EWC++)│                 │
│  │  • Advanced graph algorithms               │                 │
│  └────────────────────────────────────────────┘                 │
└──────────────────────────────────────────────────────────────────┘
```

### Complementary Relationship

**AgentDB** = Data storage layer (what agents remember)
**RuVector** = Intelligence layer (how agents learn and route)

**Example Workflow:**

```typescript
// 1. RuVector routes task to optimal agent (ML-based)
const routing = await ruvector.hooks_route({
  task: "Implement authentication"
});
// Returns: security-architect (92% confidence)

// 2. Agent executes task, stores outcome in AgentDB
await agentdb.store({
  content: "JWT authentication implemented successfully",
  type: "episodic",
  embedding: await generateEmbedding("JWT auth success"),
  metadata: { agent: 'security-architect', outcome: 'success' }
});

// 3. RuVector learns from outcome (via SONA)
await sona.recordStep({
  action: "routed to security-architect",
  reward: 1.0  // success
});

// 4. Next similar task benefits from learning
const nextRouting = await ruvector.hooks_route({
  task: "Add OAuth2 support"
});
// Returns: security-architect (95% confidence - learned!)
```

**Key Insight:** They work together, not as alternatives.

---

## ⚖️ Feature Comparison Matrix

| Feature | AgentDB | RuVector | Notes |
|---------|---------|----------|-------|
| **Vector Storage** | ✅ Built-in | ✅ Optional | AgentDB sufficient for most |
| **HNSW Indexing** | ✅ 150x-12,500x | ✅ Same | Both use HNSW algorithm |
| **Semantic Search** | ✅ JavaScript | ✅ Rust (faster) | AgentDB ~1ms, RuVector ~0.045ms |
| **Memory Persistence** | ✅ SQLite/Hybrid | ✅ Postgres option | AgentDB local, RuVector distributed |
| **Cache Management** | ✅ LRU cache | ✅ Advanced cache | Both have caching |
| **Q-Learning Routing** | ❌ | ✅ Only RuVector | ML-based agent selection |
| **AST Analysis** | ❌ | ✅ Only RuVector | Code structure parsing |
| **Diff Classification** | ❌ | ✅ Only RuVector | Change risk scoring |
| **Coverage Routing** | ❌ | ✅ Only RuVector | Test-aware routing |
| **Graph Algorithms** | ❌ | ✅ Only RuVector | MinCut, Louvain, Spectral |
| **Flash Attention** | ❌ | ✅ Only RuVector | 2.49x-7.47x speedup |
| **SONA Learning** | ❌ | ✅ Only RuVector | <0.05ms adaptation |
| **LoRA Fine-tuning** | ❌ | ✅ Only RuVector | 128x compression |
| **EWC++ Consolidation** | ❌ | ✅ Only RuVector | Prevents forgetting |
| **Distributed Postgres** | ❌ | ✅ Only RuVector | 100+ agent coordination |
| **Installation** | Auto (with CLI) | Manual (`npm install`) | AgentDB easier |
| **Platform Support** | ✅ Universal (WASM) | ✅ Rust + WASM | Both cross-platform |

---

## 🎯 Decision Guide by Use Case

### Scenario 1: Building a RAG System

**Use:** AgentDB ✅

**Why:** AgentDB provides everything needed for RAG:
- Vector storage for document embeddings
- HNSW semantic search (150x faster)
- Pattern storage for learned responses
- Cross-session persistence

**Setup:**
```bash
# Initialize AgentDB (already installed)
claude-flow memory init
claude-flow embeddings init --provider agentic-flow

# Store documents with embeddings
claude-flow memory store --key "doc1" --value "content..." --namespace docs

# Semantic search
claude-flow memory search --query "authentication patterns"
```

**Don't Need:** RuVector (unless you also want ML routing)

---

### Scenario 2: Intelligent Agent Routing

**Use:** RuVector ✅

**Why:** RuVector provides ML-based routing that learns from outcomes:
- Q-Learning agent selection (80%+ accuracy)
- Learns which agents work best for task types
- Coverage-aware routing (routes to tester if low coverage)
- Improves recommendations over time

**Setup:**
```bash
# Install RuVector
npm install ruvector

# Get ML-based routing recommendations
claude-flow route --task "Debug performance issue" --q-learning

# Returns optimal agent based on learned patterns
```

**Still Use:** AgentDB for storing the outcomes

---

### Scenario 3: Code Analysis & Refactoring

**Use:** RuVector ✅

**Why:** RuVector provides advanced code analysis:
- AST parsing for code structure
- Complexity metrics for identifying hotspots
- Graph algorithms for finding module boundaries
- Diff analysis for risk assessment

**Setup:**
```bash
# Install RuVector
npm install ruvector

# AST analysis
claude-flow analyze ast src/ --complexity

# Detect module boundaries
claude-flow analyze boundaries src/ --algorithm louvain

# Analyze diff risk
claude-flow analyze diff --risk

# Find circular dependencies
claude-flow analyze circular src/
```

**AgentDB Role:** Stores the analysis results for future reference

---

### Scenario 4: Small Local Development (1-8 agents)

**Use:** AgentDB only ✅

**Why:** AgentDB handles everything for small teams:
- Memory storage sufficient
- Semantic search fast enough (<1ms)
- No ML routing needed (rule-based works fine)
- Simpler setup, fewer dependencies

**Setup:**
```bash
# Default config uses AgentDB (hybrid backend)
claude-flow memory init
claude-flow swarm init --topology hierarchical --max-agents 8

# That's it - fully functional!
```

**Don't Need:** RuVector (optional optimization, not required)

---

### Scenario 5: Large Production Swarms (100+ agents)

**Use:** RuVector Postgres ✅

**Why:** Centralized coordination required for scale:
- Distributed agents across multiple hosts
- Real-time pattern synchronization
- Centralized learning state
- Full SQL query capabilities
- Production-grade reliability

**Setup:**
```bash
# Run centralized Postgres
docker run -d \
  --name ruvector-postgres \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=ruvector \
  -v ruvector-data:/var/lib/postgresql/data \
  ruvnet/ruvector-postgres

# Configure Claude Flow to use it
claude-flow config set memory.backend postgres
claude-flow config set memory.postgresUrl "postgresql://postgres:ruvector@localhost:5432/ruvector"

# Install RuVector for distributed intelligence
npm install ruvector
```

**Benefits vs AgentDB SQLite:**

| Feature | AgentDB SQLite | RuVector Postgres |
|---------|---------------|-------------------|
| **Multi-Agent Coordination** | Single machine | Distributed across hosts |
| **Pattern Sharing** | File-based | Real-time synchronized |
| **Learning Persistence** | Local only | Centralized, backed up |
| **Swarm Scale** | 1-15 agents | 100+ agents |
| **Query Language** | Basic KV | Full SQL + pgvector |
| **High Availability** | Single point of failure | Replicated |

---

### Scenario 6: Advanced Neural Learning

**Use:** RuVector ✅

**Why:** RuVector provides cutting-edge neural features:
- **SONA** - Self-Optimizing Neural Architecture (<0.05ms)
- **LoRA** - Low-rank adaptation (128x compression)
- **EWC++** - Prevents catastrophic forgetting (preserves 95%+ knowledge)
- **Flash Attention** - 2.49x-7.47x speedup
- **ReasoningBank** - Trajectory-based pattern learning

**Setup:**
```bash
npm install ruvector

# Use SONA via Claude Flow hooks
claude-flow hooks intelligence trajectory-start --task "implement feature"
claude-flow hooks intelligence trajectory-step --action "wrote tests"
claude-flow hooks intelligence trajectory-end --verdict success

# Check learned patterns
claude-flow hooks intelligence pattern-search --query "testing"
```

**AgentDB Role:** Stores the learned patterns persistently

---

## 📦 Installation Guide

### AgentDB (Included - No Action Needed)

```bash
# Already installed with Claude Flow V3
npm install -g @claude-flow/cli@alpha

# Initialize memory
claude-flow memory init

# Verify
claude-flow memory stats
# Backend: hybrid (SQLite + AgentDB)
# HNSW Indexing: ✓ Enabled
```

**Status:** ✅ Already configured in your environment

---

### RuVector (Optional - Install When Needed)

```bash
# Global installation
npm install -g ruvector

# Or local to project
npm install ruvector

# Verify installation
npx ruvector status
# RuVector v0.1.95
# Features:
#   • Q-Learning Router: ✓
#   • AST Analysis: ✓
#   • Diff Classification: ✓
#   • Coverage Routing: ✓
#   • Graph Analysis: ✓

# Check in Claude Flow
claude-flow doctor
# Should show: RuVector: v0.1.95 (optional features available)
```

**Status:** ❌ Not currently installed (optional)

---

### RuVector Postgres (Production - Docker Required)

```bash
# Pull and run container
docker run -d \
  --name ruvector-postgres \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=ruvector \
  -v ruvector-data:/var/lib/postgresql/data \
  ruvnet/ruvector-postgres

# Configure Claude Flow
claude-flow config set memory.backend postgres
claude-flow config set memory.postgresUrl "postgresql://postgres:ruvector@localhost:5432/ruvector"

# Verify connection
claude-flow memory stats
# Backend: postgres
# Connection: ✓ Connected
# Vectors: 0
```

**Status:** ❌ Not needed for local development

---

## 🛠️ Configuration Examples

### Default (AgentDB Only) - Recommended for Most Users

```json
{
  "version": "3.0.0",
  "memory": {
    "type": "hybrid",
    "path": "./data",
    "hnsw": {
      "m": 16,
      "ef": 200
    }
  },
  "swarm": {
    "topology": "hierarchical-mesh",
    "maxAgents": 15
  }
}
```

**Packages Required:**
- ✅ `@claude-flow/cli` (installed)
- ✅ `@claude-flow/memory` (installed)

**Features Enabled:**
- Vector storage with HNSW
- Semantic search
- Pattern persistence
- Session memory

---

### With RuVector Intelligence - Advanced Users

```json
{
  "version": "3.0.0",
  "memory": {
    "type": "hybrid",
    "path": "./data"
  },
  "ruvector": {
    "enabled": true,
    "qLearning": true,
    "astAnalysis": true,
    "diffClassification": true,
    "coverageRouting": true
  },
  "neural": {
    "enabled": true,
    "sona": true,
    "ewc": true
  }
}
```

**Packages Required:**
- ✅ `@claude-flow/cli` (installed)
- ✅ `@claude-flow/memory` (installed)
- ⚠️ `ruvector` (install with `npm install ruvector`)

**Additional Features:**
- ML-based agent routing
- Code analysis tools
- Advanced neural learning
- Graph algorithms

---

### Production with RuVector Postgres - Enterprise

```json
{
  "version": "3.0.0",
  "memory": {
    "backend": "postgres",
    "postgresUrl": "postgresql://postgres:ruvector@localhost:5432/ruvector"
  },
  "ruvector": {
    "enabled": true,
    "centralizedLearning": true,
    "distributedCoordination": true
  },
  "swarm": {
    "topology": "hierarchical-mesh",
    "maxAgents": 100
  }
}
```

**Packages Required:**
- ✅ `@claude-flow/cli`
- ✅ `@claude-flow/memory`
- ⚠️ `ruvector`
- ⚠️ RuVector Postgres (Docker)

**For:**
- 100+ agents across multiple hosts
- Production deployments
- Centralized pattern sharing
- High availability

---

## 🎓 Recommendations by Developer Profile

### **Beginner: AgentDB Only** ⭐

**Who:** New to Claude Flow, exploring features

**Use:**
- AgentDB (comes installed)
- Default hybrid backend
- 1-5 agents for learning

**Setup:**
```bash
claude-flow memory init
# Done!
```

**Benefits:**
- Simple setup
- No extra dependencies
- Fast enough for learning

---

### **Intermediate: AgentDB + Basic RuVector**

**Who:** Regular users, multiple projects

**Use:**
- AgentDB for memory storage
- RuVector for Q-Learning routing
- 5-15 agents in swarms

**Setup:**
```bash
npm install ruvector
claude-flow memory init
# Use both as needed
```

**Benefits:**
- Intelligent routing (learns over time)
- Code analysis tools available
- Still simple configuration

---

### **Advanced: Full RuVector Integration**

**Who:** Power users, complex projects

**Use:**
- AgentDB + RuVector
- All neural features (SONA, LoRA, EWC++, Flash Attention)
- Code analysis, graph algorithms
- 15+ agents with ML coordination

**Setup:**
```bash
npm install ruvector
claude-flow memory init
claude-flow config set ruvector.enabled true
claude-flow config set neural.sona true
```

**Benefits:**
- All features unlocked
- Maximum intelligence
- Learns from everything

---

### **Enterprise: RuVector Postgres**

**Who:** Production teams, large scale

**Use:**
- RuVector Postgres for centralized state
- Distributed agents across hosts
- 100+ agent swarms
- HA and backup

**Setup:**
```bash
docker run -d ruvnet/ruvector-postgres
claude-flow config set memory.backend postgres
npm install ruvector
```

**Benefits:**
- Production-grade reliability
- Scales to 100+ agents
- Centralized learning
- Team coordination

---

## 🔧 Practical Examples

### Example 1: Pattern Storage (AgentDB)

```bash
# Store successful authentication pattern
claude-flow memory store \
  --key "auth-jwt-pattern" \
  --value "JWT with 15min access + 7day refresh tokens" \
  --namespace patterns \
  --tags "auth,jwt,security"

# Later, search for it
claude-flow memory search --query "authentication token strategy"
# Returns: auth-jwt-pattern (similarity: 0.94)
```

**Uses:** AgentDB only

---

### Example 2: Intelligent Task Routing (RuVector)

```bash
# First time routing (no history)
claude-flow route --task "Fix SQL injection vulnerability" --q-learning
# Agent: security-architect (60% confidence - guessing)

# After 5 similar tasks successfully handled by security-architect...
claude-flow route --task "Prevent XSS attack" --q-learning
# Agent: security-architect (95% confidence - learned!)
```

**Uses:** RuVector for routing, AgentDB stores outcomes

---

### Example 3: Code Refactoring (Both)

```bash
# 1. RuVector analyzes code structure
claude-flow analyze boundaries src/ --algorithm louvain
# Suggested modules: auth/, api/, db/ (high cohesion)

# 2. RuVector routes refactoring task
claude-flow route --task "Refactor auth module" --q-learning
# Agent: architect (89% confidence)

# 3. AgentDB stores refactoring patterns
claude-flow memory store \
  --key "refactor-auth-module" \
  --value "Split into: handlers/, middleware/, services/" \
  --namespace patterns

# 4. Future similar tasks find this pattern
claude-flow memory search --query "refactor authentication"
# Returns: refactor-auth-module (similarity: 0.91)
```

**Uses:** Both - RuVector for analysis, AgentDB for persistence

---

## 📈 Performance Comparison

### AgentDB Performance

| Operation | Latency | Throughput | Memory |
|-----------|---------|------------|--------|
| **Store** | <5ms | 200 ops/s | Low |
| **Retrieve** | <1ms | 1000 ops/s | Low |
| **HNSW Search** | <1ms (100K) | 1000 queries/s | ~500MB |
| **Bulk Insert** | 2-3ms/entry | 333 ops/s | Medium |
| **Cache Hit** | <0.1ms | 10,000 ops/s | Minimal |

**Best For:** Most users (JavaScript, WASM, universal)

---

### RuVector Performance

| Operation | Latency | Throughput | Memory |
|-----------|---------|------------|--------|
| **HNSW Search** | ~0.045ms | 22,000 queries/s | ~400MB |
| **Q-Learning Route** | <1ms | 1000 routes/s | Low |
| **AST Analysis** | 50-200ms | 5-20 files/s | Medium |
| **Flash Attention** | 2.49x-7.47x faster | Variable | O(N) vs O(N²) |
| **Graph MinCut** | 100-500ms | Depends on size | Medium |

**Best For:** Performance-critical applications (Native Rust)

**Speedup Over AgentDB:**
- HNSW search: **22x faster** (0.045ms vs 1ms)
- Overall: RuVector optimized for speed, AgentDB for simplicity

---

## ✅ Your Current Setup (As Configured)

Based on your V3 installation:

### What's Already Working

✅ **AgentDB Installed & Configured**
- Location: `~/.config/claude-flow/config.json`
- Memory database: `~/.swarm/memory.db` (126.47 MB)
- Backend: hybrid (SQLite + AgentDB)
- HNSW indexing: enabled (m=16, ef=200)
- Status: Fully operational

✅ **Features Active**
- Vector storage
- Semantic search (150x-12,500x faster)
- Pattern learning
- Session persistence
- Cross-agent memory sharing

### What's Optional

⚠️ **RuVector Not Installed**
- Status: Not installed (optional)
- Impact: No ML routing, no code analysis tools
- Installation: `npm install -g ruvector`

**Do You Need It?**

**Install RuVector if you want:**
- ✅ ML-based agent routing (learns which agents work best)
- ✅ Code analysis tools (AST, complexity, boundaries)
- ✅ Diff classification and risk scoring
- ✅ Advanced neural features (Flash Attention, SONA, LoRA)

**Skip RuVector if you:**
- ❌ Only need memory storage and search (AgentDB handles this)
- ❌ Prefer simpler setup
- ❌ Don't need code intelligence features

---

## 🚀 Quick Start Commands

### Using AgentDB (Current Setup)

```bash
# Store a pattern (works now)
claude-flow memory store --key "test" --value "My pattern" --namespace dev

# Search patterns (works now)
claude-flow memory search --query "pattern"

# List all entries (works now)
claude-flow memory list

# Get statistics (works now)
claude-flow memory stats
```

### Adding RuVector (Optional Enhancement)

```bash
# Step 1: Install RuVector
npm install -g ruvector

# Step 2: Verify installation
npx ruvector status

# Step 3: Use new features
claude-flow route --task "Fix bug" --q-learning          # ML routing
claude-flow analyze ast src/                             # Code analysis
claude-flow analyze diff --risk                          # Risk scoring
claude-flow analyze boundaries src/ --algorithm louvain  # Module detection

# Step 4: Verify in doctor
claude-flow doctor
# Should show: RuVector v0.1.95 (features available)
```

---

## 🔗 Resources

### AgentDB Documentation

- Package: `@claude-flow/memory`
- README: `/home/lyle/dev/claude-flow/v3/@claude-flow/memory/README.md`
- ADR: ADR-006 (Unified Memory Service)
- ADR: ADR-009 (Hybrid Backend)

### RuVector Documentation

- Package: `ruvector` (npm)
- README: `/home/lyle/dev/claude-flow/v3/@claude-flow/cli/src/ruvector/README.md`
- ADR: ADR-017 (RuVector Integration)
- GitHub: https://github.com/ruvnet/ruvector
- npm: https://www.npmjs.com/package/ruvector

### Related Packages

**RuVector Ecosystem:**
- `@ruvector/attention` - Flash Attention mechanisms
- `@ruvector/sona` - SONA learning engine
- `@ruvector/gnn` - Graph Neural Networks
- `@ruvector/graph-node` - Graph database with Cypher
- `@ruvector/rvlite` - Standalone database

---

## 📊 Summary Table

| Aspect | AgentDB | RuVector |
|--------|---------|----------|
| **Installation** | Auto (included) | Manual (`npm install`) |
| **Primary Use** | Memory storage | Code intelligence |
| **Performance** | Fast (JavaScript) | Faster (Rust) |
| **Complexity** | Simple | Advanced |
| **Learning** | Pattern storage | ML routing + neural |
| **Code Analysis** | No | Yes (AST, diff, graph) |
| **Distributed** | Local only | Postgres option |
| **Required?** | Yes (core feature) | No (optional) |
| **Best For** | Most users | Power users, production |

---

## 🎯 Final Recommendation

**For Your Setup:**

**Keep using AgentDB** (already working perfectly):
- ✅ Memory database initialized
- ✅ HNSW indexing enabled
- ✅ Pattern learning active
- ✅ Semantic search functional

**Consider adding RuVector if you:**
- Want ML-based agent routing that learns from outcomes
- Need code analysis tools (AST, complexity, boundaries)
- Want advanced neural features (Flash Attention, SONA, LoRA)
- Building production swarms with 50+ agents

**To add RuVector:**
```bash
npm install -g ruvector
claude-flow doctor  # Verify detection
```

**Current Status:**
- AgentDB: ✅ Active and optimized
- RuVector: ⚠️ Optional (not installed)
- Recommendation: **Try AgentDB first, add RuVector later if needed**

---

**Document Created:** 2026-01-16
**Claude Flow Version:** v3.0.0-alpha.119
**Last Updated:** 2026-01-16
