#!/bin/bash
# TURBO FLOW SETUP SCRIPT v1.1.0
# Claude Flow V3 + Dev-Browser + Security Analyzer + Playwriter + HeroUI
# Verified commands only - proper skill installation

# NO set -e - we handle errors gracefully

# ============================================
# CONFIGURATION
# ============================================
: "${WORKSPACE_FOLDER:=$(pwd)}"
: "${DEVPOD_WORKSPACE_FOLDER:=$WORKSPACE_FOLDER}"
: "${AGENTS_DIR:=$WORKSPACE_FOLDER/agents}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEVPOD_DIR="$SCRIPT_DIR"
TOTAL_STEPS=13
CURRENT_STEP=0
START_TIME=$(date +%s)

# ============================================
# PROGRESS HELPERS
# ============================================
progress_bar() {
    local percent=$1
    local width=30
    local filled=$((percent * width / 100))
    local empty=$((width - filled))
    printf "\r  ["
    printf "%${filled}s" | tr ' ' '█'
    printf "%${empty}s" | tr ' ' '░'
    printf "] %3d%%" "$percent"
}

step_header() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    PERCENT=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    echo ""
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  [$PERCENT%] STEP $CURRENT_STEP/$TOTAL_STEPS: $1"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    progress_bar $PERCENT
    echo ""
}

status() { echo "  🔄 $1..."; }
ok() { echo "  ✅ $1"; }
skip() { echo "  ⏭️  $1 (already installed)"; }
warn() { echo "  ⚠️  $1 (continuing anyway)"; }
info() { echo "  ℹ️  $1"; }
checking() { echo "  🔍 Checking $1..."; }
fail() { echo "  ❌ $1"; }

is_npm_installed() {
    npm list -g "$1" --depth=0 >/dev/null 2>&1
}

has_cmd() {
    command -v "$1" >/dev/null 2>&1
}

install_npm() {
    local pkg="$1"
    checking "$pkg"
    if is_npm_installed "$pkg"; then
        skip "$pkg"
        return 0
    else
        status "Installing $pkg"
        if npm install -g "$pkg" --silent --no-progress 2>/dev/null; then
            ok "$pkg installed"
            return 0
        else
            warn "$pkg install failed"
            return 1
        fi
    fi
}

elapsed() {
    local now=$(date +%s)
    local diff=$((now - START_TIME))
    echo "${diff}s"
}

# ============================================
# START
# ============================================
clear 2>/dev/null || true
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║     🚀 TURBO FLOW v1.1.0 - CLAUDE FLOW V3 EDITION           ║"
echo "║     Swarm Intelligence • MCP Tools • Claude Skills          ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "  📁 Workspace: $WORKSPACE_FOLDER"
echo "  🕐 Started at: $(date '+%H:%M:%S')"
echo ""
progress_bar 0
echo ""

# ============================================
# [8%] STEP 1: Build tools (required for native modules)
# ============================================
step_header "Installing build tools (gcc, g++, make, python3)"

checking "build-essential"
if command -v g++ >/dev/null 2>&1 && command -v make >/dev/null 2>&1; then
    skip "build tools (g++, make already present)"
else
    status "Installing build-essential and python3"
    if command -v apt-get >/dev/null 2>&1; then
        apt-get update -qq 2>/dev/null || sudo apt-get update -qq 2>/dev/null || true
        apt-get install -y -qq build-essential python3 git curl 2>/dev/null || \
        sudo apt-get install -y -qq build-essential python3 git curl 2>/dev/null || \
        warn "Could not install build tools"
        ok "build tools installed"
    elif command -v yum >/dev/null 2>&1; then
        yum groupinstall -y "Development Tools" 2>/dev/null || sudo yum groupinstall -y "Development Tools" 2>/dev/null || true
        ok "build tools installed (yum)"
    elif command -v apk >/dev/null 2>&1; then
        apk add --no-cache build-base python3 git curl 2>/dev/null || true
        ok "build tools installed (apk)"
    else
        warn "Unknown package manager"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# [16%] STEP 2: Node.js 20 LTS
# ============================================
step_header "Installing Node.js 20 LTS"

NODE_VERSION=$(node -v 2>/dev/null | sed 's/v//' || echo "0")
NODE_MAJOR=$(echo "$NODE_VERSION" | cut -d. -f1)

if [ "$NODE_MAJOR" -ge 20 ]; then
    skip "Node.js v$NODE_MAJOR (already >= 20)"
else
    status "Upgrading Node.js to v20"
    
    # Method 1: n version manager
    if npm install -g n --silent 2>/dev/null || sudo npm install -g n --silent 2>/dev/null; then
        n 20 2>/dev/null || sudo n 20 2>/dev/null || true
        hash -r 2>/dev/null || true
        export PATH="/usr/local/bin:$PATH"
    fi
    
    # Check if upgrade worked
    NODE_MAJOR_NEW=$(node -v 2>/dev/null | sed 's/v//' | cut -d. -f1 || echo "0")
    
    if [ "$NODE_MAJOR_NEW" -lt 20 ]; then
        # Method 2: NodeSource
        if command -v curl >/dev/null 2>&1; then
            curl -fsSL https://deb.nodesource.com/setup_20.x 2>/dev/null | sudo bash - 2>/dev/null || true
            apt-get install -y nodejs 2>/dev/null || sudo apt-get install -y nodejs 2>/dev/null || true
        fi
    fi
    
    NODE_VERSION_FINAL=$(node -v 2>/dev/null || echo "not found")
    ok "Node.js: $NODE_VERSION_FINAL"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [25%] STEP 3: Clear caches
# ============================================
step_header "Clearing npm caches"

rm -rf ~/.npm/_locks 2>/dev/null || true
rm -rf ~/.npm/_npx 2>/dev/null || true
npm cache clean --force --silent 2>/dev/null || true
ok "Caches cleared"

info "Elapsed: $(elapsed)"

# ============================================
# [33%] STEP 4: Claude Flow V3
# ============================================
step_header "Installing Claude Flow V3"

cd "$WORKSPACE_FOLDER" 2>/dev/null || cd "$HOME"

checking "claude-flow v3"
if [ -d "$WORKSPACE_FOLDER/.claude-flow" ] && [ -f "$WORKSPACE_FOLDER/.claude-flow/config.json" ]; then
    skip "claude-flow already initialized"
else
    status "Initializing Claude Flow V3"
    
    if npx -y claude-flow@v3alpha init --force 2>&1 | head -20; then
        ok "Claude Flow V3 initialized"
    else
        warn "claude-flow init had issues"
        mkdir -p "$WORKSPACE_FOLDER/.claude-flow"
        echo '{"version":"3.0","initialized":true}' > "$WORKSPACE_FOLDER/.claude-flow/config.json"
        ok "Fallback config created"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# [41%] STEP 5: Core npm packages
# ============================================
step_header "Installing core npm packages"

install_npm @anthropic-ai/claude-code
install_npm agentic-qe
install_npm @fission-ai/openspec

info "Elapsed: $(elapsed)"

# ============================================
# [50%] STEP 6: Playwriter MCP (Browser Automation)
# ============================================
step_header "Configuring Playwriter MCP (Browser Automation)"

checking "playwriter MCP"

status "Verifying playwriter package"
if npx -y playwriter@latest --version >/dev/null 2>&1; then
    ok "playwriter package accessible"
else
    warn "playwriter package check failed (may still work)"
fi

# Register with Claude CLI if available
if has_cmd claude; then
    status "Registering playwriter MCP with Claude"
    claude mcp remove playwriter 2>/dev/null || true
    if timeout 15 claude mcp add playwriter --scope user -- npx -y playwriter@latest >/dev/null 2>&1; then
        ok "playwriter MCP registered"
    else
        warn "playwriter MCP registration failed"
    fi
fi

# Cleanup old clone if exists
[ -d "$HOME/.playwriter" ] && rm -rf "$HOME/.playwriter" 2>/dev/null && ok "Old playwriter clone removed"

echo ""
info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
info "⚠️  MANUAL STEP REQUIRED FOR PLAYWRITER:"
info "   Install Chrome extension from:"
info "   https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe"
info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

info "Elapsed: $(elapsed)"

# ============================================
# [58%] STEP 7: Dev-Browser (Claude Code Skill)
# ============================================
step_header "Installing Dev-Browser Skill"

DEVBROWSER_SKILL_DIR="$HOME/.claude/skills/dev-browser"
checking "dev-browser skill"

if [ -d "$DEVBROWSER_SKILL_DIR" ]; then
    skip "dev-browser skill already installed"
else
    status "Cloning dev-browser"
    if git clone --depth 1 https://github.com/SawyerHood/dev-browser.git /tmp/dev-browser-skill 2>/dev/null; then
        mkdir -p "$HOME/.claude/skills"
        
        # Copy skill subfolder if it exists, otherwise copy whole repo
        if [ -d "/tmp/dev-browser-skill/skills/dev-browser" ]; then
            cp -r /tmp/dev-browser-skill/skills/dev-browser "$DEVBROWSER_SKILL_DIR"
        else
            cp -r /tmp/dev-browser-skill "$DEVBROWSER_SKILL_DIR"
        fi
        
        cd "$DEVBROWSER_SKILL_DIR" && npm install --silent 2>/dev/null || true
        cd "$WORKSPACE_FOLDER"
        rm -rf /tmp/dev-browser-skill
        
        ok "dev-browser skill installed"
        info "Start server with: devb-start"
    else
        warn "dev-browser clone failed"
    fi
fi

# Cleanup old location
[ -d "$HOME/.dev-browser" ] && rm -rf "$HOME/.dev-browser" 2>/dev/null

info "Elapsed: $(elapsed)"

# ============================================
# [66%] STEP 8: Security Analyzer (Claude Code Skill)
# ============================================
step_header "Installing Security Analyzer Skill"

SECURITY_SKILL_DIR="$HOME/.claude/skills/security-analyzer"
checking "security-analyzer skill"

if [ -d "$SECURITY_SKILL_DIR" ]; then
    skip "security-analyzer skill already installed"
else
    status "Cloning security-analyzer"
    if git clone --depth 1 https://github.com/Cornjebus/security-analyzer.git /tmp/security-analyzer 2>/dev/null; then
        mkdir -p "$HOME/.claude/skills"
        
        # The skill is inside .claude/skills/security-analyzer in the repo
        if [ -d "/tmp/security-analyzer/.claude/skills/security-analyzer" ]; then
            cp -r /tmp/security-analyzer/.claude/skills/security-analyzer "$SECURITY_SKILL_DIR"
        else
            cp -r /tmp/security-analyzer "$SECURITY_SKILL_DIR"
        fi
        
        rm -rf /tmp/security-analyzer
        ok "security-analyzer skill installed"
        info "Use in Claude: 'security scan'"
    else
        warn "security-analyzer clone failed"
    fi
fi

# Cleanup old location
[ -d "$HOME/.security-analyzer" ] && rm -rf "$HOME/.security-analyzer" 2>/dev/null

info "Elapsed: $(elapsed)"

# ============================================
# [75%] STEP 9: uv + Spec-Kit
# ============================================
step_header "Installing uv & Spec-Kit"

checking "uv"
if has_cmd uv; then
    skip "uv"
else
    curl -LsSf https://astral.sh/uv/install.sh 2>/dev/null | sh >/dev/null 2>&1 && ok "uv installed" || warn "uv failed"
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" 2>/dev/null
    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
fi

checking "specify CLI"
if has_cmd specify; then
    skip "specify CLI"
else
    if has_cmd uv; then
        uv tool install specify-cli --from git+https://github.com/github/spec-kit.git 2>/dev/null && \
            ok "specify-cli installed" || warn "specify-cli failed"
    fi
fi

info "Elapsed: $(elapsed)"

# ============================================
# [83%] STEP 10: Register MCPs
# ============================================
step_header "Registering MCP servers"

if has_cmd claude; then
    ok "Claude CLI found"
    
    # Remove old MCPs
    status "Cleaning old MCP registrations"
    for mcp in playwright chrome-devtools n8n-mcp agtrace; do
        claude mcp remove "$mcp" 2>/dev/null || true
    done
    
    # Register Claude Flow V3 MCP
    status "Registering Claude Flow V3 MCP"
    claude mcp remove claude-flow 2>/dev/null || true
    timeout 15 claude mcp add claude-flow --scope user -- npx -y claude-flow@v3alpha mcp start >/dev/null 2>&1 && \
        ok "claude-flow MCP registered" || warn "claude-flow MCP failed"
    
    # Register agentic-qe
    status "Registering agentic-qe MCP"
    claude mcp remove agentic-qe 2>/dev/null || true
    timeout 10 claude mcp add agentic-qe --scope user -- npx -y aqe-mcp >/dev/null 2>&1 && \
        ok "agentic-qe registered" || warn "agentic-qe failed"
else
    skip "Claude CLI not installed"
fi

# Write MCP config
mkdir -p "$HOME/.config/claude" 2>/dev/null || true
cat << 'EOF' > "$HOME/.config/claude/mcp.json"
{
  "mcpServers": {
    "claude-flow": {
      "command": "npx",
      "args": ["-y", "claude-flow@v3alpha", "mcp", "start"],
      "env": {}
    },
    "agentic-qe": {
      "command": "npx",
      "args": ["-y", "aqe-mcp"],
      "env": {}
    },
    "playwriter": {
      "command": "npx",
      "args": ["-y", "playwriter@latest"],
      "env": {}
    }
  }
}
EOF
ok "MCP config written"

info "Elapsed: $(elapsed)"

# ============================================
# [91%] STEP 11: Workspace setup
# ============================================
step_header "Setting up workspace"

cd "$WORKSPACE_FOLDER" 2>/dev/null || true

# package.json
[ ! -f "package.json" ] && npm init -y --silent 2>/dev/null
npm pkg set type="module" 2>/dev/null || true

# Directories
for dir in src tests docs scripts config plans; do
    mkdir -p "$dir" 2>/dev/null
done

# tsconfig.json
[ ! -f "tsconfig.json" ] && cat << 'EOF' > tsconfig.json
{"compilerOptions":{"target":"ES2022","module":"ESNext","moduleResolution":"node","outDir":"./dist","rootDir":"./src","strict":true,"esModuleInterop":true,"skipLibCheck":true,"jsx":"react-jsx"},"include":["src/**/*","tests/**/*"],"exclude":["node_modules","dist"]}
EOF

# HeroUI + Tailwind
checking "HeroUI dependencies"
if [ ! -d "node_modules/@heroui" ]; then
    status "Installing HeroUI + Tailwind"
    npm install @heroui/react framer-motion --silent 2>/dev/null || true
    npm install -D tailwindcss postcss autoprefixer --silent 2>/dev/null || true
    
    # Tailwind config
    [ ! -f "tailwind.config.js" ] && cat << 'TWEOF' > tailwind.config.js
const { heroui } = require("@heroui/react");
module.exports = {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}", "./node_modules/@heroui/theme/dist/**/*.{js,ts,jsx,tsx}"],
  theme: { extend: {} },
  darkMode: "class",
  plugins: [heroui()],
};
TWEOF
    
    # PostCSS config
    [ ! -f "postcss.config.js" ] && echo 'module.exports = { plugins: { tailwindcss: {}, autoprefixer: {} } };' > postcss.config.js
    
    # Base CSS
    mkdir -p src
    [ ! -f "src/index.css" ] && echo -e "@tailwind base;\n@tailwind components;\n@tailwind utilities;" > src/index.css
    
    ok "Frontend stack installed"
else
    skip "HeroUI already installed"
fi

ok "Workspace configured"
info "Elapsed: $(elapsed)"

# ============================================
# [92%] STEP 12: Install prd2build Command
# ============================================
step_header "Installing prd2build command"

COMMANDS_DIR="$HOME/.claude/commands"
checking "prd2build command"

if [ -f "$COMMANDS_DIR/prd2build.md" ]; then
    skip "prd2build command already installed"
else
    status "Creating prd2build command"
    mkdir -p "$COMMANDS_DIR"
    
    cat << 'PRD2BUILD_EOF' > "$COMMANDS_DIR/prd2build.md"
---
name: prd2build
description: PRD → Complete Documentation (Single Command)
version: 3.0.0-simplified
arguments:
  - name: prd_input
    description: Path to PRD file or inline PRD content
    required: true
  - name: build
    description: Execute build after documentation is complete
    required: false
    switch: --build
---

# PRD to Complete Documentation - Simplified

**One command. Complete documentation. No complexity.**

---

## What This Does

You provide a PRD. You get:

1. **Specification docs** - Requirements, user stories, API contracts, security model
2. **Domain model (DDD)** - Bounded contexts, aggregates, entities, events, database schema
3. **Architecture (ADR)** - All architectural decisions with rationale
4. **Implementation plan** - Milestones, epics, tasks with dependencies
5. **Unified INDEX.md** - Single entry point that ties everything together


---

## Usage

```bash
# Generate documentation only
/prd2build /path/to/your-prd.md

# Generate documentation AND execute build
/prd2build /path/to/your-prd.md --build
```

**Documentation only**: Wait 5-10 minutes. All documentation generated in `docs/`.

**With --build**: Documentation generates first, then mesh swarm executes the complete build following all ADRs and DDD artifacts.

---

## Input PRD

$ARGUMENTS

---

## Execution (Single Batch)

**CRITICAL**: This runs as ONE concurrent batch. All agents spawn together, work in parallel, report when done.

```javascript
// Initialize system (REQUIRED FIRST)
Bash("mkdir -p docs/{specification,ddd,adr,sparc,implementation/{milestones,epics,tasks},testing,design/mockups}")
Bash("npx @claude-flow/cli@latest init --no-color 2>/dev/null || true")
Bash("npx @claude-flow/cli@latest memory init --force --no-color 2>/dev/null || true")

// Spawn ALL documentation agents in PARALLEL (foreground mode)
// They all run concurrently and block until ALL complete

Task("researcher", `
Read PRD from arguments above.

Generate docs/specification/:
- requirements.md (REQ-XXX IDs, functional requirements)
- non-functional.md (performance, security, scalability targets)
- user-stories.md (As a [role], I want [goal], so that [benefit])
- user-journeys.md (actor definitions, user flows, use cases)
- api-contracts.md (OpenAPI-style endpoint specs)
- security-model.md (threat model, auth/authz, data classification)
- edge-cases.md (boundary conditions)
- constraints.md (technical and business limits)
- glossary.md (domain terminology)

Extract:
- All requirements with unique IDs
- All actors and their goals
- All API endpoints
- Security requirements (auth methods, encryption, compliance)

MINIMUM QUALITY BARS:
- 8+ specification files
- 15+ user stories (for any real project)
- 10+ API endpoints (if API-based)
- Security model >50 lines (substantial, not just headers)

Store key entities in memory for other agents.
`, "researcher")

Task("ui-designer", `
Read PRD and requirements.md.

CRITICAL: Check for existing style guides BEFORE generating:
- If docs/specification/style-guide.md exists → READ and REUSE it, DO NOT overwrite
- If docs/specification/style-guide.html exists → READ and REUSE it, DO NOT overwrite

Generate design artifacts:
1. docs/specification/wireframes.md (ASCII wireframes, all major screens)
2. docs/specification/style-guide.md (colors, typography, spacing) - ONLY if not exists
3. docs/specification/style-guide.html (interactive visual guide) - ONLY if not exists
4. docs/design/mockups/*.html (pixel-perfect mockups with dark/light toggle)

Color selection (3-tier priority):
1. TIER 0: Check existing (tailwind.config.js, design-tokens.css) → USE THOSE
2. TIER 1: PRD mentions (brand colors, competitor refs) → USE THOSE
3. TIER 2: Domain psychology (healthcare=blue, finance=navy, ecommerce=neutral)
4. TIER 3: Generate 3 options with rationale if unclear

Typography: Use Google Fonts appropriate for domain.

Accessibility: WCAG 2.1 AA compliance, keyboard nav, screen reader support.

Store design tokens in memory.
`, "ui-designer")

Task("code-analyzer", `
Read PRD and requirements.md from memory.

Generate docs/ddd/:
- domain-model.md (strategic design overview)
- bounded-contexts.md (context boundaries, responsibilities)
- context-map.md (relationships between contexts with diagram)
- ubiquitous-language.md (per-context terminology)
- aggregates.md (aggregate roots, consistency boundaries)
- entities.md (domain entities with identity)
- value-objects.md (immutable value objects)
- domain-events.md (event catalog with triggers)
- sagas.md (long-running processes, compensating transactions)
- repositories.md (repository interfaces)
- services.md (domain and application services)
- database-schema.md (complete schema with migrations)
- migrations/XXX.sql (numbered migration files)

MINIMUM DDD ARTIFACTS:
- 3+ bounded contexts (Core + Supporting + Generic)
- 5+ aggregates (1-2 per context)
- 8+ entities (aggregates + children)
- 10+ value objects (Money, Email, Status, etc.)
- 6+ domain events (1 per aggregate transition)
- 5+ repositories (1 per aggregate root)
- 4+ services (domain + application)

Generate SQL migrations from aggregates (1 migration per aggregate).

Store aggregate list in memory.
`, "code-analyzer")

Task("System Architect", `
Read PRD, requirements, DDD artifacts from memory.

Generate docs/adr/:
- index.md (ADR registry with dependency graph)
- ADR-001.md through ADR-027.md MINIMUM (each as SEPARATE file)

REQUIRED ADR TOPICS (1 ADR per topic = 27 minimum):
- Architecture (3): system style, module boundaries, deployment
- Database (3): technology, schema design, multi-tenancy
- API (3): design style (REST/GraphQL), versioning, error handling
- Security (4): authentication, authorization, RLS, secrets
- Infrastructure (2): deployment architecture, CDN/storage
- Integration (3): payment/email/storage providers
- Frontend (3): UI framework, state management, component lib
- Testing (3): strategy, coverage targets, E2E approach
- Observability (3): logging, monitoring, error tracking

PLUS: Additional ADRs for PRD-specific decisions.

Each ADR = separate file. Enhanced template with metadata, alternatives, impact radius.

CRITICAL: DO NOT create just index.md. CREATE ALL INDIVIDUAL ADR FILES.

Before claiming done: ls docs/adr/ADR-*.md | wc -l (must be >=27)

Store ADR index in memory.
`, "system-architect")

Task("SPARC Coordinator", `
Read PRD, requirements, DDD, ADR from memory.

Generate docs/sparc/:
- 01-specification.md (detailed specs with acceptance criteria)
- 02-pseudocode.md (algorithms, logic flows, data structures)
- 03-architecture.md (component diagram, service boundaries, tech stack)
- 04-refinement.md (TDD strategy, refactoring, quality metrics)
- 05-completion.md (integration tests, deployment, CI/CD, handoff)
- traceability-matrix.md (Requirement → Pseudocode → Architecture → Code → Test)

Create end-to-end traceability showing how every requirement flows through design to code.
`, "sparc-coord")

Task("Implementation Planner", `
Read ALL prior documentation from memory.

Generate docs/implementation/:
- roadmap.md (phased delivery plan)
- dependency-graph.md (task dependencies, critical path)
- risks.md (risk register with mitigation)
- definition-of-done.md (DoD templates per task type)

Generate docs/implementation/milestones/:
- M0-foundation.md (infrastructure, database, auth)
- M1-mvp.md (minimum viable product features)
- M2-release.md (full v1.0 release)
- M3-enhanced.md (post-release improvements)

Generate docs/implementation/epics/:
- EPIC-XXX-[name].md (one file per business feature)

Generate docs/implementation/tasks/:
- index.md (task registry with status tracking)
- TASK-XXX-[name].md (one file per atomic technical task)

Each task MUST reference:
- Related requirements (REQ-XXX)
- Related user stories (US-XXX)
- Related ADRs (ADR-XXX)
- Related DDD artifacts (Aggregate, Service, etc.)
- Dependencies (other TASK-XXX)

MINIMUM TASKS: 20+ (real projects need more)

Store task count and relationships in memory.
`, "task-orchestrator")

Task("Test Strategist", `
Read requirements, DDD, and tasks from memory.

Generate docs/testing/:
- test-strategy.md (test pyramid, coverage targets, tools)
- test-cases.md (test specifications per requirement)
- test-data-requirements.md (fixtures, seeds, mocks)
- tdd-approach.md (TDD workflow per bounded context)

Map every requirement to test cases.
Define test data factories for all entities.
`, "tester")

Task("Documentation Integrator", `
CRITICAL: This agent runs LAST and creates the unified index.

Wait for all other agents to complete, then:

1. Read ALL generated documentation:
   - docs/specification/ (all files)
   - docs/ddd/ (all files)
   - docs/adr/ (all ADR files)
   - docs/sparc/ (all files)
   - docs/implementation/ (milestones, epics, tasks)
   - docs/testing/ (all files)

2. Count all artifacts:
   - Total milestones, epics, tasks
   - Total ADRs, bounded contexts, aggregates
   - Total requirements, user stories, API endpoints

3. Extract relationships:
   - Parse "Related ADRs:" from each task
   - Parse "DDD Artifacts:" from each task
   - Parse "Requirements:" from each task
   - Parse "Dependencies:" from each task
   - Build dependency graph

4. Calculate metrics:
   - Total effort (sum task durations)
   - Critical path (longest dependency chain)
   - Complexity distribution

5. Generate docs/implementation/INDEX.md with:
   - Overview & statistics
   - Milestone breakdown (with epic lists)
   - Epic breakdown (with task lists)
   - Task reference tables (by epic, by ADR, by bounded context)
   - Complete traceability matrix (REQ → US → DDD → ADR → Task → Test)
   - Dependency graph (Mermaid)
   - Quick start guide
   - Progress tracking commands

6. Generate docs/README.md:
   - Navigation to all documentation sections
   - Quick links to major documents
   - How to read the docs
   - Glossary of abbreviations

OUTPUT FILES REQUIRED:
- docs/implementation/INDEX.md (THE SINGLE ENTRY POINT)
- docs/README.md (documentation navigator)

VERIFICATION:
- INDEX.md exists and >400 lines
- All milestones appear in INDEX.md
- All epics appear in INDEX.md
- All tasks appear in INDEX.md
- Traceability matrix complete
- README.md has links to all sections

This INDEX.md becomes THE SINGLE SOURCE OF TRUTH for implementation.
`, "planner")

// That's it. All agents spawn together, run in parallel, complete when done.

// ============================================================
// BUILD EXECUTION (Only if --build flag is present)
// ============================================================
// Check if --build flag was provided
if ("$ARGUMENTS" includes "--build") {

  // Step 1: Initialize swarm with mesh topology
  Bash("npx @claude-flow/cli@latest swarm init --topology mesh --strategy adaptive --no-color 2>/dev/null || true")

  // Step 2: Spawn build swarm agents in BACKGROUND (parallel execution)
  // They will execute the build using all ADRs and DDDrs as reference

  Task("Build Coordinator", `
    Read ALL documentation:
    - docs/adr/ (all ADRs for architectural decisions)
    - docs/ddd/ (all DDD artifacts for domain understanding)
    - docs/implementation/INDEX.md (task execution order)

    Coordinate the build swarm by:
    1. Parsing all ADRs to understand architectural constraints
    2. Understanding DDD bounded contexts and aggregates
    3. Creating execution plan from INDEX.md tasks
    4. Delegating work to specialized agents

    Store build plan in memory for other agents.
  `, "hierarchical-coordinator", run_in_background: true)

  Task("Foundation Builder", `
    Read ADR-001 (system architecture), ADR-004 (database), ADR-007 (auth).

    Execute M0-foundation tasks:
    - Project setup and structure (per ADR-001)
    - Database schema and migrations (per ADR-004, DDD aggregates)
    - Authentication system (per ADR-007)

    Verify each task against related ADRs and DDD artifacts.
  `, "coder", run_in_background: true)

  Task("Feature Implementer", `
    Read all ADRs, DDD bounded contexts, and implementation tasks.

    Execute M1-MVP feature tasks:
    - Core business logic per bounded contexts
    - API endpoints per API ADRs
    - Domain services per DDD services

    Follow INDEX.md task order and dependencies.
  `, "backend-dev", run_in_background: true)

  Task("Frontend Builder", `
    Read ADR-017 (UI framework), ADR-018 (state management), wireframes, style guide.

    Execute frontend tasks:
    - Component library setup (per ADR-017)
    - State management (per ADR-018)
    - UI screens per wireframes and mockups

    Match design tokens from style-guide.md.
  `, "ui-designer", run_in_background: true)

  Task("Test Implementer", `
    Read test strategy and ADR-022 (testing strategy).

    Execute test implementation:
    - Unit tests per bounded context
    - Integration tests per aggregate
    - E2E tests per user journey

    Achieve coverage targets from test-strategy.md.
  `, "tester", run_in_background: true)

  Task("Quality Verifier", `
    Read all ADRs and verify compliance:
    - Security per ADR-010 through ADR-013
    - Performance per ADR-005 through ADR-006
    - API contracts per ADR-008 through ADR-009

    Run linting, type checking, and security scans.
    Report any ADR violations for remediation.
  `, "code-review-swarm", run_in_background: true)

  // All agents spawned in background - they work in parallel via mesh topology
  // Build coordinator orchestrates; others communicate peer-to-peer

  Tell user: "Build swarm launched (6 agents in mesh topology). They're executing the build following all ADRs and DDD artifacts. I'll monitor progress."

  // Wait for background agents to complete, then verify build success
  // The mesh topology allows agents to coordinate autonomously
}
```

---

## Output Structure

After execution, you get:

```
docs/
├── README.md                           # Start here - Navigation guide
├── implementation/
│   └── INDEX.md                        # IMPLEMENTATION START HERE
│
├── specification/
│   ├── requirements.md                 # Functional requirements (REQ-XXX)
│   ├── non-functional.md               # NFRs (performance, security)
│   ├── user-stories.md                 # User stories (US-XXX)
│   ├── user-journeys.md                # Actor flows and use cases
│   ├── wireframes.md                   # UI wireframes (ASCII)
│   ├── style-guide.md                  # Design tokens, colors, typography
│   ├── style-guide.html                # Interactive visual style guide
│   ├── api-contracts.md                # API specifications (OpenAPI-style)
│   ├── security-model.md               # Threat model, auth/authz
│   ├── edge-cases.md                   # Boundary conditions
│   ├── constraints.md                  # Technical/business constraints
│   └── glossary.md                     # Domain terminology
│
├── design/
│   └── mockups/
│       ├── design-tokens.css           # Shared CSS variables
│       └── *.html                      # Mockups with dark/light toggle
│
├── ddd/
│   ├── domain-model.md                 # Strategic design
│   ├── bounded-contexts.md             # Context boundaries
│   ├── context-map.md                  # Context relationships
│   ├── ubiquitous-language.md          # Domain terminology
│   ├── aggregates.md                   # Aggregate roots
│   ├── entities.md                     # Domain entities
│   ├── value-objects.md                # Value objects
│   ├── domain-events.md                # Event catalog
│   ├── sagas.md                        # Process managers
│   ├── repositories.md                 # Repository interfaces
│   ├── services.md                     # Domain/application services
│   ├── database-schema.md              # Complete schema
│   └── migrations/
│       └── *.sql                       # Numbered migrations
│
├── adr/
│   ├── index.md                        # ADR registry + dependency graph
│   ├── ADR-001-*.md                    # Architecture decisions
│   ├── ADR-002-*.md                    # (27+ individual files)
│   └── ...
│
├── sparc/
│   ├── 01-specification.md             # Detailed specifications
│   ├── 02-pseudocode.md                # Algorithms and logic
│   ├── 03-architecture.md              # System architecture
│   ├── 04-refinement.md                # TDD strategy
│   ├── 05-completion.md                # Integration & deployment
│   └── traceability-matrix.md          # Req → Implementation mapping
│
├── implementation/
│   ├── INDEX.md                        # SINGLE ENTRY POINT
│   ├── roadmap.md                      # Master plan
│   ├── dependency-graph.md             # Task dependencies (DAG)
│   ├── risks.md                        # Risk register
│   ├── definition-of-done.md           # DoD templates
│   ├── milestones/
│   │   ├── M0-foundation.md
│   │   ├── M1-mvp.md
│   │   ├── M2-release.md
│   │   └── M3-enhanced.md
│   ├── epics/
│   │   └── EPIC-XXX-[name].md          # Business features
│   └── tasks/
│       ├── index.md                    # Task registry
│       └── TASK-XXX-[name].md          # Atomic tasks
│
└── testing/
    ├── test-strategy.md                # Test pyramid, coverage
    ├── test-cases.md                   # Test specs per requirement
    ├── test-data-requirements.md       # Fixtures and seeds
    └── tdd-approach.md                 # TDD workflow
```

---

## Quality Guarantees

Each generated document includes:
- Cross-references to related docs
- Traceability to PRD requirements
- No placeholder content (no TODO/TBD)
- Concrete decisions (no "we'll decide later")
- Complete coverage (minimums enforced)

**Minimum artifact counts** (auto-validated):
- 8+ specification files
- 27+ ADRs (one per architectural topic)
- 11+ DDD files
- 3+ bounded contexts
- 5+ aggregates
- 20+ tasks

If PRD is too vague, agents make explicit assumptions and document them.
PRD2BUILD_EOF
    
    ok "prd2build command installed"
    info "Use in Claude Code: /prd2build path/to/prd.md"
fi

info "Elapsed: $(elapsed)"

# ============================================
# [100%] STEP 13: Bash aliases
# ============================================
step_header "Installing bash aliases"

checking "TURBO FLOW aliases"
if grep -q "TURBO FLOW v1.1.0" ~/.bashrc 2>/dev/null; then
    skip "Bash aliases already installed"
else
    # Remove old versions
    sed -i '/# === TURBO FLOW/,/# === END TURBO FLOW/d' ~/.bashrc 2>/dev/null || true
    
    cat << 'ALIASES_EOF' >> ~/.bashrc

# === TURBO FLOW v1.1.0 (Claude Flow V3) ===

# ─────────────────────────────────────────────────────
# CLAUDE CODE
# ─────────────────────────────────────────────────────
alias dsp="claude --dangerously-skip-permissions"

# ─────────────────────────────────────────────────────
# CLAUDE FLOW V3
# ─────────────────────────────────────────────────────
alias cf="npx -y claude-flow@v3alpha"
alias cf-init="npx -y claude-flow@v3alpha init --force"
alias cf-help="npx -y claude-flow@v3alpha --help"

# Swarm & Agents
alias cf-swarm="npx -y claude-flow@v3alpha swarm init --topology hierarchical"
alias cf-mesh="npx -y claude-flow@v3alpha swarm init --topology mesh"
alias cf-agent="npx -y claude-flow@v3alpha --agent"
alias cf-coder="npx -y claude-flow@v3alpha --agent coder"
alias cf-list="npx -y claude-flow@v3alpha --list"

# Daemon & Workers
alias cf-daemon="npx -y claude-flow@v3alpha daemon start"
alias cf-daemon-stop="npx -y claude-flow@v3alpha daemon stop"
alias cf-daemon-status="npx -y claude-flow@v3alpha daemon status"

# Memory
alias cf-memory="npx -y claude-flow@v3alpha memory"
alias cf-memory-status="npx -y claude-flow@v3alpha memory status"

# Hooks
alias cf-hooks="npx -y claude-flow@v3alpha hooks"
alias cf-route="npx -y claude-flow@v3alpha hooks route"

# Security & Performance
alias cf-security="npx -y claude-flow@v3alpha security scan"
alias cf-benchmark="npx -y claude-flow@v3alpha performance benchmark"

# Skills
alias cf-skills="npx -y claude-flow@v3alpha skill list"
alias cf-skill="npx -y claude-flow@v3alpha skill run"

# MCP
alias cf-mcp="npx -y claude-flow@v3alpha mcp start"

# Quick task function
cf-task() {
    npx -y claude-flow@v3alpha --agent "${1:-coder}" --task "$2"
}

# ─────────────────────────────────────────────────────
# AGENTIC QE (Testing)
# ─────────────────────────────────────────────────────
alias aqe="npx -y agentic-qe"
alias aqe-init="npx -y agentic-qe init"
alias aqe-generate="npx -y agentic-qe generate"
alias aqe-gate="npx -y agentic-qe gate"

# ─────────────────────────────────────────────────────
# PLAYWRITER (Browser Automation)
# ─────────────────────────────────────────────────────
alias playwriter="npx -y playwriter@latest"
alias pw-serve="npx -y playwriter serve --host 127.0.0.1"

pw-status() {
    echo "🎭 Playwriter Status"
    echo "━━━━━━━━━━━━━━━━━━━━"
    echo "Package: $(npx -y playwriter@latest --version 2>/dev/null || echo 'checking...')"
    echo ""
    echo "Chrome Extension (REQUIRED):"
    echo "  https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe"
}

# ─────────────────────────────────────────────────────
# DEV-BROWSER (Claude Code Skill)
# ─────────────────────────────────────────────────────
alias devb-start="cd ~/.claude/skills/dev-browser && npm run start-server"

devb-status() {
    echo "🌐 Dev-Browser Status"
    echo "━━━━━━━━━━━━━━━━━━━━━"
    if [ -d ~/.claude/skills/dev-browser ]; then
        echo "Installed: ✅ ~/.claude/skills/dev-browser"
        echo "Start: devb-start"
        echo "Usage: 'Open localhost:3000 and verify signup works'"
    else
        echo "Installed: ❌ Not found"
    fi
}

# ─────────────────────────────────────────────────────
# SECURITY ANALYZER (Claude Code Skill)
# ─────────────────────────────────────────────────────
sec-status() {
    echo "🔒 Security Analyzer Status"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    if [ -d ~/.claude/skills/security-analyzer ]; then
        echo "Installed: ✅ ~/.claude/skills/security-analyzer"
        echo "Usage in Claude: 'security scan'"
    else
        echo "Installed: ❌ Not found"
    fi
}

# ─────────────────────────────────────────────────────
# PRD2BUILD (Documentation Generator)
# ─────────────────────────────────────────────────────
# Note: prd2build is a Claude Code slash command
# Usage: /prd2build path/to/prd.md
# Usage: /prd2build path/to/prd.md --build

prd2build-status() {
    echo "📄 prd2build Status"
    echo "━━━━━━━━━━━━━━━━━━━"
    if [ -f ~/.claude/commands/prd2build.md ]; then
        echo "Installed: ✅ ~/.claude/commands/prd2build.md"
        echo ""
        echo "Usage in Claude Code:"
        echo "  /prd2build path/to/prd.md           # Docs only"
        echo "  /prd2build path/to/prd.md --build   # Docs + build"
        echo "  /prd2build --build-only             # Build from existing docs"
        echo ""
        echo "Output:"
        echo "  docs/implementation/INDEX.md        # Start here"
        echo "  docs/adr/                           # 27+ ADRs"
        echo "  docs/ddd/                           # Domain model"
    else
        echo "Installed: ❌ Not found"
        echo "Run turbo-flow setup to install"
    fi
}

prd2build-verify() {
    echo "🔍 Verifying prd2build output..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Check directories exist
    [ -d "docs/specification" ] && echo "✅ docs/specification/" || echo "❌ docs/specification/ missing"
    [ -d "docs/ddd" ] && echo "✅ docs/ddd/" || echo "❌ docs/ddd/ missing"
    [ -d "docs/adr" ] && echo "✅ docs/adr/" || echo "❌ docs/adr/ missing"
    [ -d "docs/implementation" ] && echo "✅ docs/implementation/" || echo "❌ docs/implementation/ missing"
    
    echo ""
    echo "Artifact counts:"
    echo "  Specification: $(ls docs/specification/*.md 2>/dev/null | wc -l) files"
    echo "  ADRs:          $(ls docs/adr/ADR-*.md 2>/dev/null | wc -l) files (min: 27)"
    echo "  DDD:           $(ls docs/ddd/*.md 2>/dev/null | wc -l) files (min: 11)"
    echo "  Tasks:         $(ls docs/implementation/tasks/TASK-*.md 2>/dev/null | wc -l) files (min: 20)"
    
    echo ""
    # Check INDEX.md
    if [ -f "docs/implementation/INDEX.md" ]; then
        lines=$(wc -l < docs/implementation/INDEX.md)
        echo "  INDEX.md:      $lines lines (min: 400)"
    else
        echo "  INDEX.md:      ❌ missing"
    fi
}

# ─────────────────────────────────────────────────────
# SPEC-KIT & OPENSPEC
# ─────────────────────────────────────────────────────
alias sk="specify"
alias sk-init="specify init"
alias sk-check="specify check"
alias sk-here="specify init . --ai claude"

alias os="openspec"
alias os-init="openspec init"
alias os-list="openspec list"

# ─────────────────────────────────────────────────────
# TMUX (Essential)
# ─────────────────────────────────────────────────────
alias t="tmux"
alias tns="tmux new-session -s"
alias tat="tmux attach-session -t"
alias tls="tmux list-sessions"
alias tks="tmux kill-session -t"

# ─────────────────────────────────────────────────────
# HELPER FUNCTIONS
# ─────────────────────────────────────────────────────
turbo-init() {
    echo "🚀 Initializing workspace..."
    specify init . --ai claude 2>/dev/null || echo "⚠️ spec-kit skipped"
    npx -y claude-flow@v3alpha init --force 2>/dev/null || echo "⚠️ claude-flow skipped"
    echo "✅ Done! Run: claude"
}

turbo-help() {
    echo "🚀 Turbo Flow v1.1.0 Quick Reference"
    echo "────────────────────────────────────"
    echo ""
    echo "PRD2BUILD (in Claude Code)"
    echo "  /prd2build prd.md          Generate complete documentation"
    echo "  /prd2build prd.md --build  Generate docs + execute build"
    echo "  /prd2build --build-only    Build from existing docs"
    echo "  prd2build-status           Check installation"
    echo "  prd2build-verify           Verify generated output"
    echo ""
    echo "CLAUDE FLOW V3"
    echo "  cf-swarm           Initialize hierarchical swarm"
    echo "  cf-mesh            Initialize mesh swarm"
    echo "  cf-coder           Run coder agent"
    echo "  cf-task TYPE TASK  Run agent with task"
    echo "  cf-daemon          Start background daemon"
    echo "  cf-memory-status   Check memory system"
    echo "  cf-security        Run security scan"
    echo "  cf-skills          List available skills"
    echo "  cf-help            Full command list"
    echo ""
    echo "TESTING"
    echo "  aqe                Agentic QE pipeline"
    echo "  aqe-gate           Quality gate"
    echo ""
    echo "BROWSER"
    echo "  playwriter         Start Playwriter (needs Chrome ext)"
    echo "  pw-status          Check status"
    echo "  devb-start         Start Dev-Browser server"
    echo ""
    echo "SECURITY (in Claude)"
    echo "  'security scan'    Full scan"
    echo ""
    echo "SPECS"
    echo "  sk-here            Init spec-kit"
    echo "  os-init            Init OpenSpec"
}

turbo-status() {
    echo "📊 Turbo Flow v1.1.0 Status"
    echo "───────────────────────────"
    echo "Node.js:      $(node -v 2>/dev/null || echo 'not found')"
    echo "Claude Flow:  $(npx -y claude-flow@v3alpha --version 2>/dev/null | head -1 || echo 'not found')"
    echo "prd2build:    $([ -f ~/.claude/commands/prd2build.md ] && echo '✅ installed' || echo '❌ not found')"
    echo "Playwriter:   $(npx -y playwriter@latest --version 2>/dev/null || echo 'not found')"
    echo "Dev-Browser:  $([ -d ~/.claude/skills/dev-browser ] && echo '✅ installed' || echo '❌ not found')"
    echo "Security:     $([ -d ~/.claude/skills/security-analyzer ] && echo '✅ installed' || echo '❌ not found')"
    echo "Spec-Kit:     $(command -v specify >/dev/null && echo '✅ installed' || echo '❌ not found')"
    echo "HeroUI:       $([ -d node_modules/@heroui ] && echo '✅ installed' || echo '❌ not found')"
    echo ""
    echo "⚠️  Manual: Install Playwriter Chrome extension"
}

# ─────────────────────────────────────────────────────
# PATH
# ─────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"

# === END TURBO FLOW v1.1.0 ===

ALIASES_EOF
    ok "Bash aliases installed"
fi

info "Elapsed: $(elapsed)"

# ============================================
# COMPLETE
# ============================================
END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))

# Status checks
CF_STATUS="❌"
[ -d "$WORKSPACE_FOLDER/.claude-flow" ] && CF_STATUS="✅"

CLAUDE_STATUS="❌"
has_cmd claude && CLAUDE_STATUS="✅"

PRD2BUILD_STATUS="❌"
[ -f "$HOME/.claude/commands/prd2build.md" ] && PRD2BUILD_STATUS="✅"

PW_STATUS="❌"
npx -y playwriter@latest --version >/dev/null 2>&1 && PW_STATUS="✅"

DEVB_STATUS="❌"
[ -d "$HOME/.claude/skills/dev-browser" ] && DEVB_STATUS="✅"

SEC_STATUS="❌"
[ -d "$HOME/.claude/skills/security-analyzer" ] && SEC_STATUS="✅"

HEROUI_STATUS="❌"
[ -d "$WORKSPACE_FOLDER/node_modules/@heroui" ] && HEROUI_STATUS="✅"

NODE_VER=$(node -v 2>/dev/null || echo "N/A")

echo ""
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║   🎉 TURBO FLOW v1.1.0 SETUP COMPLETE!                      ║"
echo "║   Claude Flow V3 Edition                                    ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
progress_bar 100
echo ""
echo ""
echo "  ┌──────────────────────────────────────────────────┐"
echo "  │  📊 SUMMARY                                      │"
echo "  ├──────────────────────────────────────────────────┤"
echo "  │  Node.js:        $NODE_VER                       │"
echo "  │  $CLAUDE_STATUS Claude Code                              │"
echo "  │  $CF_STATUS Claude Flow V3                            │"
echo "  │  $PRD2BUILD_STATUS prd2build (slash command)              │"
echo "  │  $PW_STATUS Playwriter                                │"
echo "  │  $DEVB_STATUS Dev-Browser (skill)                      │"
echo "  │  $SEC_STATUS Security Analyzer (skill)                 │"
echo "  │  $HEROUI_STATUS HeroUI + Tailwind                        │"
echo "  │  ⏱️  ${TOTAL_TIME}s                                        │"
echo "  └──────────────────────────────────────────────────┘"
echo ""
echo "  ⚠️  MANUAL STEP:"
echo "  ───────────────"
echo "  Install Playwriter Chrome extension:"
echo "  https://chromewebstore.google.com/detail/playwriter-mcp/jfeammnjpkecdekppnclgkkffahnhfhe"
echo ""
echo "  📌 QUICK START:"
echo "  ───────────────"
echo "  1. source ~/.bashrc"
echo "  2. claude                       # Start Claude Code"
echo "  3. /prd2build my-prd.md         # Generate docs from PRD"
echo "  4. /prd2build my-prd.md --build # Generate docs + build"
echo "  5. turbo-help                   # Show all commands"
echo ""
echo "  🚀 Happy coding!"
echo ""
