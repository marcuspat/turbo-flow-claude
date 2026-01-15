# TURBO FLOW CLAUDE - COMMAND MANUAL

**Version 1.0.6 | Powered by RuvVector Neural Engine**

---

## SETUP

```bash
source ~/.bashrc
turbo-init                    # Initialize workspace
turbo-status                  # Check all tools
turbo-help                    # Quick reference
```

---

## RUVECTOR (Neural Engine)

### Core Commands

```bash
ruv                           # Start RuvVector (npx ruvector)
ruv-start                     # Alias for ruv
ruvector-status               # Check RuvVector status
```

### Intelligence Hooks

```bash
ruv-hooks                     # Manage hooks (npx @ruvector/cli hooks)
ruv-init                      # Initialize hooks
ruv-install                   # Install hooks into Claude settings
ruv-stats                     # Show learning statistics
```

### Learning & Routing

```bash
ruv-learn                     # Record learning trajectory
ruv-route "task"              # Route task to best agent
ruv-remember -t edit "note"   # Store in semantic memory
ruv-recall "query"            # Search semantic memory
ruv-export                    # Export session metrics
```

### Swarm Coordination

```bash
ruv-swarm                     # Register swarm agent
npx @ruvector/cli hooks swarm-register <id> <type> --capabilities "rust,async"
npx @ruvector/cli hooks swarm-coordinate <src> <tgt> --weight 0.9
npx @ruvector/cli hooks swarm-optimize "task1,task2"
npx @ruvector/cli hooks swarm-recommend "rust"
npx @ruvector/cli hooks swarm-heal <agent-id>
npx @ruvector/cli hooks swarm-stats
```

### Session Management

```bash
npx @ruvector/cli hooks session-start [--resume]
npx @ruvector/cli hooks session-end [--export-metrics]
```

### Error Learning

```bash
npx @ruvector/cli hooks record-error <cmd> <stderr>
npx @ruvector/cli hooks suggest-fix E0308
npx @ruvector/cli hooks suggest-next <file> -n 3
npx @ruvector/cli hooks should-test <file>
```

### Claude Code Hook Integration

```bash
npx @ruvector/cli hooks pre-edit <file>
npx @ruvector/cli hooks post-edit <file> --success
npx @ruvector/cli hooks pre-command <cmd>
npx @ruvector/cli hooks post-command <cmd> --success
npx @ruvector/cli hooks suggest-context
npx @ruvector/cli hooks track-notification
npx @ruvector/cli hooks pre-compact [--auto]
```

---

## CLAUDE CODE

```bash
claude                        # Start Claude Code
dsp                           # Skip permissions (faster iteration)

# Inside session
/help                         # Show commands
/agents                       # List available agents
/memory                       # Access memory
/clear                        # Clear context
/compact                      # Reduce context size
```

---

## CLAUDE FLOW v3

### Core Commands

```bash
cf-init                       # Initialize workspace
cf-status                     # System status
cf-progress --detailed        # V3 implementation progress
cf-mcp                        # Start MCP server
```

### Swarm & Agents

```bash
cf-swarm                      # Init hierarchical swarm
cf-mesh                       # Init mesh topology
cf-list                       # List all 54+ agents
cf-agent <type> --task "X"    # Run specific agent
cf-coder "task"               # Coder agent
cf-reviewer "task"            # Code review agent
cf-tester "task"              # Testing agent
cf-security "task"            # Security architect

# Full swarm initialization
npx claude-flow@v3alpha swarm init --topology hierarchical-mesh --max-agents 15
npx claude-flow@v3alpha swarm start
npx claude-flow@v3alpha swarm status
```

### Hive-Mind

```bash
npx claude-flow@v3alpha hive-mind spawn "task" --topology hierarchical
npx claude-flow@v3alpha hive-mind wizard
npx claude-flow@v3alpha queen command "directive"
npx claude-flow@v3alpha queen monitor
```

---

## NEURAL (CLAUDE FLOW + RUVECTOR)

```bash
# Training
cf-pretrain                   # Bootstrap intelligence
cf-pretrain --model-type moe  # With MoE routing
cf-train                      # Train patterns
cf-train --pattern_type coordination --training_data "successful workflows"

# Patterns
cf-patterns list              # View learned patterns
cf-patterns list --type coordination

# Routing
cf-route "task"               # Intelligent task routing

# Neural enable
npx claude-flow@v3alpha neural enable --pattern coordination
npx claude-flow@v3alpha neural status
```

### Intelligence Hooks (Trajectory Learning)

```bash
npx claude-flow@v3alpha hooks intelligence trajectory-start --session "session1"
npx claude-flow@v3alpha hooks intelligence trajectory-step --action "implement" --reward 0.9
npx claude-flow@v3alpha hooks intelligence trajectory-end --verdict success
npx claude-flow@v3alpha hooks intelligence pattern-store --pattern "<pattern>"
npx claude-flow@v3alpha hooks intelligence pattern-search --query "<query>" --limit 10
npx claude-flow@v3alpha hooks intelligence stats
npx claude-flow@v3alpha hooks intelligence attention --focus "<task>"
```

---

## MEMORY (AgentDB)

```bash
cf-memory "query"             # Vector search (150x faster)
npx claude-flow@v3alpha memory init --agentdb
npx claude-flow@v3alpha memory status

# Store/Query
npx claude-flow@v3alpha memory store <key> "<value>" --namespace <ns>
npx claude-flow@v3alpha memory query "<search>" --namespace <ns>
npx claude-flow@v3alpha memory vector-search "<query>" --k 10 --threshold 0.7

# Maintenance
npx claude-flow@v3alpha memory list --namespace <ns>
npx claude-flow@v3alpha memory clear --namespace <ns>
npx claude-flow@v3alpha memory migrate --from json --to agentdb
npx claude-flow@v3alpha memory benchmark --dataset-size 10000
```

### Embeddings

```bash
npx claude-flow@v3alpha embeddings init
npx claude-flow@v3alpha embeddings init --model all-mpnet-base-v2
npx claude-flow@v3alpha embeddings search -q "authentication patterns"
```

---

## SPARC METHODOLOGY

```bash
npx claude-flow@v3alpha sparc tdd "user authentication system"

# Individual phases
npx claude-flow@v3alpha sparc run spec-pseudocode "shopping cart"
npx claude-flow@v3alpha sparc run architect "payment system"
npx claude-flow@v3alpha sparc run coder "checkout flow"
npx claude-flow@v3alpha sparc run security "auth code review"
npx claude-flow@v3alpha sparc run tester "integration tests"
npx claude-flow@v3alpha sparc run documentation "API docs"

npx claude-flow@v3alpha sparc modes
```

---

## HOOKS & WORKERS

```bash
cf-hooks                      # Hook system
npx claude-flow@v3alpha hooks list
npx claude-flow@v3alpha hooks enable pre-edit
npx claude-flow@v3alpha hooks metrics
npx claude-flow@v3alpha hooks config pre-edit --actions "backup,validate"

# Workers (Background)
cf-worker                     # Dispatch background worker
cf-daemon                     # Start background daemon
npx claude-flow@v3alpha worker dispatch --trigger audit --context "./src"
npx claude-flow@v3alpha worker status
npx claude-flow@v3alpha worker results --limit 10
```

---

## TESTING

### Agentic QE

```bash
aqe init                      # Initialize
aqe-generate                  # Generate tests
aqe generate tests src/services/user-service.ts
aqe run --analyze             # Run with analysis
aqe-gate                      # Quality gate check
aqe quality-gate --coverage 95
aqe-flaky                     # Hunt flaky tests
aqe flaky-hunt --runs 100
```

### Playwriter (AI Test Generation)

```bash
playwriter                    # Interactive mode
pw-test "description"         # Generate test from description
pw-test "user can login with valid credentials"
pw-test "e-commerce checkout flow: add item, update quantity, complete purchase"
npx playwright test           # Run generated tests
```

---

## FRONTEND

### Dev-Browser

```bash
dev-browser                   # Launch visual AI development environment
devb                          # Short alias
```

### HeroUI + Tailwind

Pre-installed: @heroui/react, framer-motion, tailwindcss, autoprefixer

---

## SECURITY

```bash
sec-audit                     # Security audit
security-scan                 # Vulnerability scan
npx @claude-flow/security@latest audit --platform linux
npx @claude-flow/security@latest audit --platform darwin
npx @claude-flow/security@latest audit --platform windows
```

---

## SPEC-DRIVEN DEVELOPMENT

### Spec-Kit

```bash
sk                            # Base command
sk-here                       # Init in current directory
sk-check                      # Check specification health
specify init . --ai claude    # Init with Claude AI support

# Slash commands in Claude Code
/speckit.constitution         # View project constitution
/speckit.specify              # Create specifications
/speckit.plan                 # Generate project plan
/speckit.tasks                # List tasks
/speckit.implement            # Begin implementation
```

### OpenSpec

```bash
os                            # Base command
os-init                       # Initialize
os-list                       # List changes
os-validate                   # Validate spec
openspec show <n>             # Show proposal
openspec archive <n>          # Archive completed

# Slash commands in Claude Code
/openspec:proposal "Name"     # Create change proposal
/openspec:apply               # Apply proposal
/openspec:validate            # Validate specs
/openspec:archive             # Archive change
```

---

## GITHUB INTEGRATION

```bash
npx claude-flow@v3alpha github init --token $GITHUB_TOKEN
npx claude-flow@v3alpha github workflow create --template ci-cd
npx claude-flow@v3alpha github swarm start --mode gh-coordinator
npx claude-flow@v3alpha github review --pr 123 --agents security,performance
npx claude-flow@v3alpha github release prepare --version minor
npx claude-flow@v3alpha github release execute --tag v3.0.0
```

---

## AI AGENT SKILLS

```bash
skills-list                   # List 38+ skills
npx ai-agent-skills search <query>
npx ai-agent-skills info <skill-name>
skills-install <skill-name>   # Install skill
npx ai-agent-skills install <skill-name> --agent cursor
```

---

## MODEL EXPORT/IMPORT

### RuvVector Export/Import

```bash
# Export RuvVector session & learned patterns
npx @ruvector/cli hooks session-end --export-metrics
npx @ruvector/cli hooks compress    # Compress storage (70-83% savings)
```

### Claude Flow Export/Import

```bash
# Export trained model
npx claude-flow@v3alpha neural export --output ./model-export/
npx claude-flow@v3alpha memory export --output ./memory-export/

# Import into new environment
npx claude-flow@v3alpha neural import --input ./model-export/
npx claude-flow@v3alpha memory import --input ./memory-export/

# Full state backup
npx claude-flow@v3alpha backup create --include neural,memory,config
npx claude-flow@v3alpha backup restore --from ./backup/
```

---

## MCP MANAGEMENT

```bash
claude mcp list               # List registered servers
claude mcp remove <n>         # Remove server
claude mcp add <n> --scope user -- <command>
cat ~/.config/claude/mcp.json # View config
```

---

## TROUBLESHOOTING

```bash
turbo-status                  # Full status check
ruvector-status               # RuvVector status
ruv-init                      # Re-initialize RuvVector hooks
cf-init                       # Re-initialize Claude Flow
cf-progress --detailed        # Check v3 progress
cf-pretrain --model-type moe  # Retrain neural patterns
npx claude-flow@v3alpha memory status
npx claude-flow@v3alpha memory migrate --from json --to agentdb
npx @ruvector/cli hooks cache-stats  # LRU cache statistics
```

---

## HELPERS DIRECTORY

Claude Flow v3 helpers are located in the following paths:

| Helper | Path | Purpose |
|--------|------|---------|
| Security | `@claude-flow/security/` | CVE remediation, security patterns |
| Memory | `@claude-flow/memory/` | AgentDB unification, HNSW indexing |
| Integration | `@claude-flow/integration/` | agentic-flow integration |
| Performance | `@claude-flow/performance/` | Flash Attention optimization |
| Swarm | `@claude-flow/swarm/` | 15-agent coordination |
| CLI | `@claude-flow/cli/` | CLI modernization |
| Neural | `@claude-flow/neural/` | SONA learning integration |
| Hooks | `@claude-flow/hooks/` | Event-driven lifecycle, ReasoningBank |
| Testing | `@claude-flow/testing/` | TDD London School framework |
| Deployment | `@claude-flow/deployment/` | Release, CI/CD |
| Plugins | `@claude-flow/plugins/` | RuVector WASM plugins |
| Shared | `@claude-flow/shared/` | Shared utilities, types |

---

## RUVECTOR TECHNICAL SPECS

| Component | Performance | Description |
|-----------|-------------|-------------|
| **SONA** | <0.05ms | Self-Optimizing Neural Architecture |
| **EWC++** | 95%+ retention | Prevents catastrophic forgetting |
| **MoE** | 8 experts | Dynamic gating for routing |
| **HNSW** | 150x faster | Vector search index |
| **GNN** | Multi-head attention | Graph neural network layers |
| **Q-Learning** | α=0.1, γ=0.95 | Agent routing |
| **LRU Cache** | 1000 entries | ~10x faster lookups |
| **Compression** | 70-83% | gzip storage reduction |

---

**Version 1.0.6 | Lean Stack Edition | Powered by RuvVector Neural Engine**
