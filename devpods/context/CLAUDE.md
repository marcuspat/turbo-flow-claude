# Claude Code Configuration - Turbo Flow with Claude-Flow Integration

## 🚨 CRITICAL: VERIFICATION-FIRST DEVELOPMENT

This project enforces **"truth is enforced, not assumed"** with manstdatory verification for all operations.

### Truth Verification System
- **Threshold**: 0.95 (95% accuracy required for production)
- **Mode**: Strict verification with auto-rollback
- **Pair Programming**: Real-time collaborative development
- **Byzantine Fault Tolerance**: Protection against incorrect agents

```bash
# Initialize verification system
npx claude-flow@alpha verify init strict     # 95% threshold, auto-rollback
npx claude-flow@alpha pair --start           # Begin collaborative session
npx claude-flow@alpha truth                  # View current truth scores
```

## 🚨 ABSOLUTE EXECUTION RULES

**GOLDEN RULE: "1 MESSAGE = ALL RELATED OPERATIONS"**

### Mandatory Concurrent Patterns
- **TodoWrite**: ALWAYS batch ALL todos in ONE call (5-10+ todos minimum)
- **Task tool (Claude Code)**: ALWAYS spawn ALL agents in ONE message with full instructions
- **File operations**: ALWAYS batch ALL reads/writes/edits in ONE message
- **Bash commands**: ALWAYS batch ALL terminal operations in ONE message
- **Memory operations**: ALWAYS batch ALL memory store/retrieve in ONE message

### File Organization (NEVER save to root)
- `/src` - Source code files
- `/tests` - Test files  
- `/docs` - Documentation and markdown files
- `/config` - Configuration files
- `/scripts` - Utility scripts
- `/examples` - Example code

## 🔴 MANDATORY: Doc-Planner & Microtask-Breakdown

**EVERY coding session, swarm, and hive-mind MUST start with:**

```bash
# ALWAYS start with mandatory agents
cat $WORKSPACE_FOLDER/agents/doc-planner.md
cat $WORKSPACE_FOLDER/agents/microtask-breakdown.md
```

1. **Doc-Planner Agent**: Creates comprehensive documentation plans following SPARC workflow, implements London School TDD methodology, ensures atomic testable tasks

2. **Microtask-Breakdown Agent**: Decomposes phases into atomic 10-minute tasks, follows strict CLAUDE.md principles, creates tasks scoring 100/100 production readiness

## 🤖 Agent Discovery & Selection Protocol

Before starting any task:

```bash
# Count total agents
ls $WORKSPACE_FOLDER/agents/*.md 2>/dev/null | wc -l

# Search for specific functionality
find $WORKSPACE_FOLDER/agents/ -name "*test*"
find $WORKSPACE_FOLDER/agents/ -name "*github*"
find $WORKSPACE_FOLDER/agents/ -name "*security*"

# Sample available agents
ls $WORKSPACE_FOLDER/agents/*.md | shuf | head -10 | sed 's|.*/||g' | sed 's|.md||g'
```

## 🎯 GitHub-First Integration

### GitHub-Enhanced Project Initialization
```bash
# Initialize with GitHub integration, verification, and pair programming
npx claude-flow@alpha github init --verify --pair --training-pipeline

# Alternative: Full-featured initialization
npx claude-flow@alpha init --github-enhanced --verify --pair --project-name "project"
```

### GitHub Specialized Agents (13 Available)
- `github-pr-manager` - AI-powered PR reviews and management
- `github-release-manager` - Automated releases with changelogs
- `github-issue-tracker` - Intelligent issue management
- `github-code-reviewer` - Multi-reviewer code analysis
- `github-workflow-manager` - CI/CD optimization
- `github-security-manager` - Security scanning and fixes
- Plus 7 additional GitHub-specific agents

### GitHub Workflow Automation
```bash
# Complete GitHub repository setup
npx claude-flow@alpha github repo-architect optimize \
  --structure-analysis \
  --workflow-optimization \
  --13-github-agents \
  --enterprise-security

# PR management with verification
npx claude-flow@alpha github pr-manager setup \
  --multi-reviewer \
  --ai-powered-reviews \
  --verification-gates
```

## 🎯 Agent Execution with Claude Code Task Tool

### Correct Pattern: Mandatory Agents + Specialized Execution

```javascript
// ALWAYS start with mandatory agents
[Single Message - Mandatory Planning]:
  Read("agents/doc-planner.md")
  Read("agents/microtask-breakdown.md")
  
  // Use Task tool with loaded agent instructions
  Task("Doc Planning", "Follow doc-planner methodology to create comprehensive plan", "planner")
  Task("Microtask Breakdown", "Follow microtask-breakdown methodology for atomic tasks", "planner")
  
  // Specialized agents for implementation
  Task("Backend Development", "Build REST API with authentication. Coordinate via hooks.", "backend-dev")
  Task("Frontend Development", "Create React UI. Check memory for API contracts.", "coder")
  Task("Testing", "Write comprehensive test suite. Verify via truth system.", "tester")
  Task("GitHub Integration", "Setup CI/CD workflows with automated releases.", "github-workflow-manager")
  Task("Security Audit", "Review security with verification requirements.", "security-manager")
  
  // Batch ALL todos together
  TodoWrite { todos: [
    {id: "1", content: "Execute doc-planner for architecture", status: "in_progress", priority: "high"},
    {id: "2", content: "Use microtask-breakdown for phases", status: "pending", priority: "high"},
    {id: "3", content: "Design API endpoints with verification", status: "pending", priority: "high"},
    {id: "4", content: "Implement authentication with truth checks", status: "pending", priority: "high"},
    {id: "5", content: "Create React components", status: "pending", priority: "medium"},
    {id: "6", content: "Write comprehensive tests", status: "pending", priority: "medium"},
    {id: "7", content: "Setup GitHub workflows", status: "pending", priority: "medium"},
    {id: "8", content: "Security audit with verification", status: "pending", priority: "low"}
  ]}
  
  // Parallel file operations
  Write "src/server.js"
  Write "src/components/App.jsx" 
  Write "tests/api.test.js"
  Write "config/github-workflows.yml"
```

## 🔄 Verification & Background Management

### Background Task Management
```bash
# Start pair programming with background monitoring
npx claude-flow@alpha pair --start --monitor &

# View background tasks
/bashes

# Check verification output
"Check status of bash_1"
"Show output from bash_1"
```

### Verification Requirements by Agent Type
- **Coder Agents**: Code compilation (35%), tests pass (25%), linting (20%), type safety (20%)
- **Reviewer Agents**: Code analysis, security scan, performance check
- **Tester Agents**: Unit tests, integration tests, coverage check
- **GitHub Agents**: PR validation, workflow success, security compliance

## 🔄 MCP Tools vs Claude Code Division

### Claude Code Handles ALL EXECUTION:
- **Task tool**: Spawn and run agents concurrently for actual work
- File operations (Read, Write, Edit, MultiEdit, Glob, Grep)
- Code generation and programming
- Bash commands and system operations
- Implementation work
- TodoWrite and task management
- Git operations and testing

### MCP Tools ONLY COORDINATE:
- Swarm initialization (topology setup)
- Agent type definitions (coordination patterns)
- Task orchestration (high-level planning)
- Memory management and neural features
- Performance tracking and GitHub integration

**KEY**: MCP coordinates the strategy, Claude Code's Task tool executes with real agents.

## 🚀 Agent Coordination Protocol

Every agent spawned via Task tool MUST:

**BEFORE Work:**
```bash
# Initialize with mandatory agents loaded
npx claude-flow@alpha hooks pre-task --description "[task]"
npx claude-flow@alpha hooks session-restore --session-id "swarm-[id]"
```

**DURING Work:**
```bash
npx claude-flow@alpha hooks post-edit --file "[file]" --memory-key "swarm/[agent]/[step]"
npx claude-flow@alpha hooks notify --message "[what was done]"
```

**AFTER Work:**
```bash
npx claude-flow@alpha hooks post-task --task-id "[task]"
npx claude-flow@alpha hooks session-end --export-metrics true
```

## 📊 SPARC Development Workflow

### Core SPARC Commands
- `npx claude-flow@alpha sparc run <mode> "<task>"` - Execute specific mode
- `npx claude-flow@alpha sparc tdd "<feature>"` - Run complete TDD workflow
- `npx claude-flow@alpha sparc batch <modes> "<task>"` - Parallel execution
- `npx claude-flow@alpha sparc pipeline "<task>"` - Full pipeline processing

### SPARC Workflow Phases
1. **Specification** - Requirements analysis with doc-planner
2. **Pseudocode** - Algorithm design with verification
3. **Architecture** - System design with GitHub integration
4. **Refinement** - TDD implementation with truth verification
5. **Completion** - Integration with automated deployment

## 🎯 Work Chunking Protocol (WCP)

Feature-based agile with CI integration:

### Phase 1: Planning (MANDATORY)
1. **Load Agents**: doc-planner + microtask-breakdown
2. **EPIC Issue**: Business-focused GitHub issue
3. **Feature Breakdown**: 3-7 Features (1-3 days each)
4. **Microtask Decomposition**: 10-minute atomic tasks

### Phase 2: GitHub Structure
5. **Create Sub-Issues** with GitHub CLI
6. **EPIC Template** with verification requirements
7. **Link Dependencies** and success criteria

### Phase 3: Execution with Verification  
8. **One Feature at a Time**: Complete with 100% CI before next
9. **Swarm Deployment**: For complex features (2+ issues)
10. **Truth Verification**: All changes must pass 0.95 threshold

### Phase 4: CI Integration
11. **Mandatory CI**: 100% success required before progression
12. **Playwright Integration**: Visual verification for frontend work
13. **Monitor with ML**: Predictive monitoring and auto-rollback

## 🛡️ Continuous Integration Protocol

Fix→Test→Commit→Push→Monitor→Repeat until 100%:

### Research Phase
1. **Deep Research Sources**: YouTube transcripts, GitHub repos, blog posts, Context7 MCP
2. **Analysis**: Root causes vs symptoms, severity categorization
3. **Targeted Fixes**: Focus on specific CI failures

### Implementation Phase  
4. **Implementation-First**: Fix logic not test expectations
5. **Iterate Until Success**: Keep trying different approaches, never give up
6. **Swarm Execution**: Systematic TDD with coordination

### Monitoring Phase
7. **Active Monitoring**: Always check after pushing
8. **Intelligent Monitoring**: Smart backoff, auto-merge, swarm coordination
9. **Integration**: Regular commits, PR on milestones

## 🎯 Ultimate Hive Project Launch Command

```bash
# Complete GitHub-integrated hive deployment with all features
npx claude-flow@alpha hive-mind spawn \
  "Deploy complete GitHub-integrated enterprise development environment with full repository automation, 
   13 specialized GitHub agents, AI-powered PR management, automated releases, security scanning, 
   performance optimization, truth verification system, pair programming mode, machine learning 
   training pipeline, and real-time workflow orchestration" \
  --agents 25 \
  --github-agents all-13 \
  --categories "github,development,security,performance,consensus,coordination" \
  --topology adaptive \
  --verify \
  --pair \
  --training-pipeline \
  --github-enhanced \
  --stream-chain \
  --mle-star-workflow \
  --truth-threshold 0.95 \
  --auto-benchmark \
  --github-checkpoints \
  --automated-releases \
  --pr-automation \
  --security-scanning \
  --performance-monitoring \
  --claude
```

## 📊 Performance & Metrics

- **84.8% SWE-Bench solve rate**
- **32.3% token reduction**  
- **2.8-4.4x speed improvement**
- **Truth accuracy rate**: >95%
- **Integration success rate**: >90%

## ⚡ Essential Aliases

```bash
# Add to .bashrc/.zshrc
alias cf-init="npx claude-flow@alpha init --verify --pair --github-enhanced"
alias cf-github-hive="npx claude-flow@alpha hive-mind spawn --github-enhanced --agents 13 --claude"
alias cf-verify="npx claude-flow@alpha verify"
alias cf-truth="npx claude-flow@alpha truth"
alias cf-pair="npx claude-flow@alpha pair --start"
```

## 🎯 Master Prompting Pattern

**ALWAYS include in prompts:**
"Identify all subagents useful for this task, utilize claude-flow hivemind to maximize ability to accomplish the task, start with doc-planner and microtask-breakdown, ensure truth verification above 0.95 threshold."

## 🔧 Development Principles

1. **Verification-First**: Truth is enforced, not assumed
2. **Doc-First**: ALWAYS start with doc-planner and microtask-breakdown  
3. **GitHub-Centric**: All operations integrate with GitHub workflows
4. **Batch Everything**: Multiple operations in single messages
5. **Iterate Until Success**: Never give up, deep research when stuck
6. **Visual Verification**: Use Playwright for frontend work
7. **Concurrent Execution**: Parallel operations for maximum efficiency

## 📊 Progress Format

```
📊 Progress Overview
├── Verification: ✅ Truth: 0.97 | ✅ Pair: Active
├── Planning: ✅ doc-planner | ✅ microtask-breakdown  
├── Total: X | ✅ Complete: X | 🔄 Active: X | ⭕ Todo: X
├── GitHub: ✅ PR: X | ✅ Issues: X | ✅ CI: PASS
└── Priority: 🔴 HIGH | 🟡 MEDIUM | 🟢 LOW
```

---

**Success = Verification-First + Doc-First + GitHub-Centric + Concurrent Execution + Persistent Iteration**
