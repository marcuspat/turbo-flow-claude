# Research Swarm Integration Guide

## Overview

Research Swarm is now integrated into Turbo Flow Claude, providing local AI research capabilities with anti-hallucination controls, SQLite-based memory, and multi-agent swarm coordination.

## Installation

Research Swarm v1.2.2 is automatically installed during Turbo Flow setup via `devpods/setup.sh`.

**Manual Installation:**
```bash
npm install -g research-swarm --ignore-scripts
```

## Quick Start

### Basic Research Commands

```bash
# Simple research task
rs-researcher "Analyze quantum computing trends"

# Research with analyst perspective
rs-analyst "Market analysis of AI tools"

# Critical review perspective
rs-critic "Evaluate blockchain scalability solutions"
```

### Advanced Research

```bash
# Research with anti-hallucination controls and citations
rs-verify "Research topic with source verification"

# Deep research with custom depth (1-10, default: 5)
rs-deep "Complex research query" 8

# Goal-oriented research with GOAP planning
rs-goal "Build comprehensive market analysis"

# Parallel multi-task research swarm
rs-swarm "task 1" "task 2" "task 3"
```

## Available Aliases

### Core Commands
- `rs` - Research Swarm base command
- `rs-researcher` - Run researcher agent
- `rs-analyst` - Run analyst agent
- `rs-critic` - Run critic agent

### Job Management
- `rs-list` - List all research jobs
- `rs-view <job-id>` - View job details
- `rs-init` - Initialize SQLite database

### Swarm Operations
- `rs-swarm` - Run parallel research swarm
- `rs-parallel` - Alias for swarm operations

### GOALIE (Goal-Oriented AI)
- `rs-goal` - Goal-oriented research with GOAP planning
- `rs-goal-plan` - Create GOAP plan (no execution)
- `rs-goal-decompose` - Decompose goal using GOALIE

### AgentDB Learning
- `rs-learn` - Run learning session (memory distillation)
- `rs-stats` - Show learning statistics
- `rs-benchmark` - Run ReasoningBank benchmark

### HNSW Vector Search
- `rs-hnsw-init` - Initialize HNSW vector index
- `rs-hnsw-build` - Build HNSW graph from vectors
- `rs-hnsw-search` - Search for similar vectors
- `rs-hnsw-stats` - Show graph statistics

### MCP Server
- `rs-mcp` - Start MCP server
- `rs-mcp-start` - Start MCP server for tools

### Quick Shortcuts
- `rsr` - Quick researcher
- `rsa` - Quick analyst
- `rsc` - Quick critic
- `rsl` - Quick list jobs
- `rsg` - Quick goal research
- `rsv` - Quick vector search

## Utility Functions

### rs-task
Quick research task with researcher agent:
```bash
rs-task "Your research query"
```

### rs-deep
Research with custom depth level (1-10):
```bash
rs-deep "Your query" 8
```

### rs-verify
Research with high anti-hallucination controls:
```bash
rs-verify "Research requiring citations"
```

### rs-multi
Parallel research swarm:
```bash
rs-multi "task 1" "task 2" "task 3"
```

### rs-goal-task
Goal-oriented deep research:
```bash
rs-goal-task "Build comprehensive analysis"
```

### rs-search
Vector similarity search:
```bash
rs-search "search query" -k 10
```

## Environment Variables

Configure Research Swarm behavior with these environment variables:

```bash
# Research depth (1-10 scale)
export RESEARCH_DEPTH=8

# Anti-hallucination level
export ANTI_HALLUCINATION_LEVEL=high  # low|medium|high

# Require citations
export CITATION_REQUIRED=true

# Enable self-learning
export ENABLE_REASONINGBANK=true

# Time budget in minutes
export RESEARCH_TIME_BUDGET=60
```

## Core Features

### 1. Multi-Hour Deep Analysis
- Extended research tasks with temporal trend tracking
- Recursive five-phase framework

### 2. Anti-Hallucination Controls
- 51-layer verification cascade
- Citation enforcement
- Source documentation

### 3. AgentDB Self-Learning
- SQLite-based ReasoningBank
- Pattern storage and retrieval
- Self-improvement capabilities

### 4. HNSW Vector Search
- 150x faster similarity matching
- Efficient pattern recognition

### 5. Concurrent Multi-Agent Execution
- Parallel task processing
- Swarm coordination
- Goal-oriented planning (GOAP)

## Integration with Turbo Flow

Research Swarm integrates seamlessly with other Turbo Flow components:

### With Claude Flow
```bash
# Combine research with Claude Flow swarm
cf-swarm "$(rs-researcher 'research topic')"
```

### With Agentic Flow
```bash
# Use research results with agentic agents
af-researcher --task "$(rs-task 'your query')"
```

## Database Location

Research Swarm stores all data locally in SQLite:
- Database location: `~/.research-swarm/`
- No cloud dependencies
- Full privacy control

## Examples

### Example 1: Basic Research
```bash
rs-researcher "Latest developments in AI code generation"
```

### Example 2: Verified Research
```bash
ANTI_HALLUCINATION_LEVEL=high CITATION_REQUIRED=true \
rs-researcher "Analysis of quantum computing applications"
```

### Example 3: Deep Research
```bash
rs-deep "Comprehensive analysis of kubernetes security best practices" 9
```

### Example 4: Parallel Research Swarm
```bash
rs-swarm \
  "Research AI trends 2025" \
  "Analyze DevOps tools landscape" \
  "Study cloud cost optimization strategies"
```

### Example 5: Goal-Oriented Research
```bash
rs-goal "Create comprehensive market analysis for AI development tools"
```

## Troubleshooting

### Database Initialization
If research jobs fail, initialize the database:
```bash
rs-init
```

### Vector Index
Build or rebuild HNSW index:
```bash
rs-hnsw-init
rs-hnsw-build
```

### Check Statistics
View learning statistics:
```bash
rs-stats
rs-benchmark
```

## MCP Server Integration

Research Swarm provides an MCP (Model Context Protocol) server:

```bash
# Start MCP server
rs-mcp-start

# Use with Claude Desktop or other MCP clients
```

## Resources

- **Gist Documentation**: https://gist.github.com/ruvnet/08edfd463d1b946b2060ddbff86da8ad
- **NPM Package**: https://www.npmjs.com/package/research-swarm
- **Version**: 1.2.2

## Next Steps

1. Initialize the database: `rs-init`
2. Try a simple research task: `rs-researcher "test query"`
3. Explore goal-oriented research: `rs-goal "your goal"`
4. Enable learning features: `rs-learn`

---

**Note**: Research Swarm requires Node.js 16.0.0+ and stores all data locally with no cloud dependencies.
