#!/bin/bash
# ============================================
# GENERATE-CLAUDE-MD - Dynamic CLAUDE.md Generator
# ============================================
# Generates an optimized CLAUDE.md file based on:
# - Claude Flow generated CLAUDE.md (renamed to .claude-flow/CLAUDE.flow.md)
# - Spec-kit specs (.specify/ directory)
# - Project structure
# - Package.json configuration
# - Existing documentation
# - Git repository info
#
# Usage: ./generate-claude-md.sh [options]
#   -o, --output    Output file (default: CLAUDE.md)
#   -v, --verbose   Show detailed output
#   -f, --force     Overwrite without prompting
#   -h, --help      Show this help
#
# Version: 1.1.0
# ============================================

set -euo pipefail

# ============================================
# CONFIGURATION
# ============================================
OUTPUT_FILE="CLAUDE.md"
VERBOSE=false
FORCE=false
WORKSPACE_DIR="${WORKSPACE_FOLDER:-$(pwd)}"

# Claude Flow generated file locations
CLAUDE_FLOW_ORIGINAL="CLAUDE.md"
CLAUDE_FLOW_BACKUP=".claude-flow/CLAUDE.flow.md"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ============================================
# HELPER FUNCTIONS
# ============================================
log() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }
info() { echo -e "${CYAN}ℹ️${NC}  $1"; }
verbose() { if $VERBOSE; then echo -e "${BLUE}[DEBUG]${NC} $1"; fi; }

show_help() {
    cat << 'EOF'
GENERATE-CLAUDE-MD - Dynamic CLAUDE.md Generator v1.1.0

Generates an optimized CLAUDE.md file based on your project context.
Integrates with Claude Flow by preserving and incorporating its generated context.

USAGE:
    ./generate-claude-md.sh [options]

OPTIONS:
    -o, --output FILE    Output file path (default: CLAUDE.md)
    -v, --verbose        Show detailed output
    -f, --force          Overwrite existing files without prompting
    -h, --help           Show this help message

EXAMPLES:
    ./generate-claude-md.sh                    # Generate CLAUDE.md in current dir
    ./generate-claude-md.sh -o docs/CLAUDE.md  # Output to docs folder
    ./generate-claude-md.sh -v                 # Verbose mode
    ./generate-claude-md.sh -f                 # Force overwrite

CLAUDE FLOW INTEGRATION:
    If Claude Flow has generated a CLAUDE.md file, this script will:
    1. Detect the Claude Flow generated CLAUDE.md
    2. Back it up to .claude-flow/CLAUDE.flow.md
    3. Extract and incorporate its context into the final CLAUDE.md
    4. Merge with spec-kit specs and project analysis

WHAT IT DETECTS:
    - Claude Flow context (.claude-flow/CLAUDE.flow.md or existing CLAUDE.md)
    - Spec-kit specs (.specify/ directory)
    - Project type (Node.js, Python, Rust, Go, etc.)
    - Package manager (npm, yarn, pnpm, uv, pip, cargo)
    - Testing framework (jest, vitest, pytest, playwright)
    - Build tools (typescript, webpack, vite, esbuild)
    - Documentation (README, docs/, wiki/)
    - Git configuration and hooks
    - CI/CD configuration
    - Docker/container setup
    - Available scripts and commands

EOF
    exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -o|--output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -h|--help)
            show_help
            ;;
        *)
            error "Unknown option: $1"
            exit 1
            ;;
    esac
done

# ============================================
# DETECTION FUNCTIONS
# ============================================

detect_project_name() {
    local name=""
    
    # Try package.json
    if [[ -f "package.json" ]]; then
        name=$(jq -r '.name // empty' package.json 2>/dev/null || echo "")
    fi
    
    # Try pyproject.toml
    if [[ -z "$name" && -f "pyproject.toml" ]]; then
        name=$(grep -m1 '^name' pyproject.toml 2>/dev/null | cut -d'"' -f2 || echo "")
    fi
    
    # Try Cargo.toml
    if [[ -z "$name" && -f "Cargo.toml" ]]; then
        name=$(grep -m1 '^name' Cargo.toml 2>/dev/null | cut -d'"' -f2 || echo "")
    fi
    
    # Fallback to directory name
    if [[ -z "$name" ]]; then
        name=$(basename "$(pwd)")
    fi
    
    echo "$name"
}

detect_project_type() {
    local types=()
    
    [[ -f "package.json" ]] && types+=("nodejs")
    [[ -f "pyproject.toml" || -f "setup.py" || -f "requirements.txt" ]] && types+=("python")
    [[ -f "Cargo.toml" ]] && types+=("rust")
    [[ -f "go.mod" ]] && types+=("go")
    [[ -f "Gemfile" ]] && types+=("ruby")
    [[ -f "pom.xml" || -f "build.gradle" ]] && types+=("java")
    [[ -f "composer.json" ]] && types+=("php")
    
    if [[ ${#types[@]} -eq 0 ]]; then
        echo "unknown"
    else
        echo "${types[*]}"
    fi
}

detect_package_manager() {
    local managers=()
    
    # Node.js
    [[ -f "pnpm-lock.yaml" ]] && managers+=("pnpm")
    [[ -f "yarn.lock" ]] && managers+=("yarn")
    [[ -f "package-lock.json" ]] && managers+=("npm")
    [[ -f "bun.lockb" ]] && managers+=("bun")
    
    # Python
    [[ -f "uv.lock" || -f ".python-version" ]] && managers+=("uv")
    [[ -f "Pipfile.lock" ]] && managers+=("pipenv")
    [[ -f "poetry.lock" ]] && managers+=("poetry")
    [[ -f "requirements.txt" ]] && managers+=("pip")
    
    # Others
    [[ -f "Cargo.lock" ]] && managers+=("cargo")
    [[ -f "go.sum" ]] && managers+=("go")
    
    echo "${managers[*]:-unknown}"
}

detect_frameworks() {
    local frameworks=()
    
    if [[ -f "package.json" ]]; then
        local deps=$(cat package.json 2>/dev/null)
        
        # Frontend frameworks
        echo "$deps" | grep -q '"react"' && frameworks+=("react")
        echo "$deps" | grep -q '"vue"' && frameworks+=("vue")
        echo "$deps" | grep -q '"svelte"' && frameworks+=("svelte")
        echo "$deps" | grep -q '"@angular/core"' && frameworks+=("angular")
        echo "$deps" | grep -q '"next"' && frameworks+=("nextjs")
        echo "$deps" | grep -q '"nuxt"' && frameworks+=("nuxt")
        echo "$deps" | grep -q '"astro"' && frameworks+=("astro")
        
        # Backend frameworks
        echo "$deps" | grep -q '"express"' && frameworks+=("express")
        echo "$deps" | grep -q '"fastify"' && frameworks+=("fastify")
        echo "$deps" | grep -q '"hono"' && frameworks+=("hono")
        echo "$deps" | grep -q '"@nestjs/core"' && frameworks+=("nestjs")
        
        # Testing
        echo "$deps" | grep -q '"jest"' && frameworks+=("jest")
        echo "$deps" | grep -q '"vitest"' && frameworks+=("vitest")
        echo "$deps" | grep -q '"playwright"' && frameworks+=("playwright")
        echo "$deps" | grep -q '"cypress"' && frameworks+=("cypress")
        
        # Build tools
        echo "$deps" | grep -q '"typescript"' && frameworks+=("typescript")
        echo "$deps" | grep -q '"vite"' && frameworks+=("vite")
        echo "$deps" | grep -q '"webpack"' && frameworks+=("webpack")
        echo "$deps" | grep -q '"esbuild"' && frameworks+=("esbuild")
        echo "$deps" | grep -q '"tsup"' && frameworks+=("tsup")
    fi
    
    # Python frameworks
    if [[ -f "requirements.txt" || -f "pyproject.toml" ]]; then
        local pydeps=$(cat requirements.txt pyproject.toml 2>/dev/null || echo "")
        echo "$pydeps" | grep -qi "django" && frameworks+=("django")
        echo "$pydeps" | grep -qi "flask" && frameworks+=("flask")
        echo "$pydeps" | grep -qi "fastapi" && frameworks+=("fastapi")
        echo "$pydeps" | grep -qi "pytest" && frameworks+=("pytest")
    fi
    
    echo "${frameworks[*]:-none detected}"
}

detect_available_scripts() {
    if [[ -f "package.json" ]]; then
        jq -r '.scripts // {} | keys[]' package.json 2>/dev/null || echo ""
    fi
}

detect_directory_structure() {
    local dirs=()
    
    [[ -d "src" ]] && dirs+=("src/")
    [[ -d "lib" ]] && dirs+=("lib/")
    [[ -d "app" ]] && dirs+=("app/")
    [[ -d "pages" ]] && dirs+=("pages/")
    [[ -d "components" ]] && dirs+=("components/")
    [[ -d "tests" || -d "test" || -d "__tests__" ]] && dirs+=("tests/")
    [[ -d "docs" ]] && dirs+=("docs/")
    [[ -d "scripts" ]] && dirs+=("scripts/")
    [[ -d "config" ]] && dirs+=("config/")
    [[ -d "public" ]] && dirs+=("public/")
    [[ -d "assets" ]] && dirs+=("assets/")
    [[ -d "api" ]] && dirs+=("api/")
    [[ -d "utils" || -d "helpers" ]] && dirs+=("utils/")
    [[ -d "types" ]] && dirs+=("types/")
    [[ -d "hooks" ]] && dirs+=("hooks/")
    [[ -d "services" ]] && dirs+=("services/")
    [[ -d "models" ]] && dirs+=("models/")
    [[ -d "controllers" ]] && dirs+=("controllers/")
    [[ -d "routes" ]] && dirs+=("routes/")
    [[ -d "middleware" ]] && dirs+=("middleware/")
    [[ -d "agents" ]] && dirs+=("agents/")
    
    echo "${dirs[*]:-minimal structure}"
}

detect_spec_kit() {
    if [[ -d ".specify" ]]; then
        local specs=()
        [[ -f ".specify/constitution.md" ]] && specs+=("constitution")
        [[ -f ".specify/spec.md" ]] && specs+=("spec")
        [[ -f ".specify/plan.md" ]] && specs+=("plan")
        [[ -f ".specify/tasks.md" ]] && specs+=("tasks")
        echo "${specs[*]:-initialized but empty}"
    else
        echo "not initialized"
    fi
}

detect_ci_cd() {
    local ci=()
    
    [[ -f ".github/workflows/"*.yml || -f ".github/workflows/"*.yaml ]] 2>/dev/null && ci+=("github-actions")
    [[ -f ".gitlab-ci.yml" ]] && ci+=("gitlab-ci")
    [[ -f "Jenkinsfile" ]] && ci+=("jenkins")
    [[ -f ".circleci/config.yml" ]] && ci+=("circleci")
    [[ -f ".travis.yml" ]] && ci+=("travis")
    [[ -f "azure-pipelines.yml" ]] && ci+=("azure-devops")
    
    echo "${ci[*]:-none detected}"
}

detect_containerization() {
    local containers=()
    
    [[ -f "Dockerfile" ]] && containers+=("docker")
    [[ -f "docker-compose.yml" || -f "docker-compose.yaml" || -f "compose.yml" ]] && containers+=("docker-compose")
    [[ -f ".devcontainer/devcontainer.json" ]] && containers+=("devcontainer")
    [[ -f "devpod.yaml" ]] && containers+=("devpod")
    [[ -f "kubernetes/"*.yaml || -f "k8s/"*.yaml ]] 2>/dev/null && containers+=("kubernetes")
    
    echo "${containers[*]:-none}"
}

get_git_info() {
    if [[ -d ".git" ]]; then
        local branch=$(git branch --show-current 2>/dev/null || echo "unknown")
        local remote=$(git remote get-url origin 2>/dev/null || echo "none")
        echo "branch: $branch, remote: $remote"
    else
        echo "not a git repository"
    fi
}

# ============================================
# CLAUDE FLOW INTEGRATION
# ============================================

detect_claude_flow_md() {
    # Check if there's an existing CLAUDE.md that was generated by Claude Flow
    # Claude Flow typically generates a CLAUDE.md with specific markers
    
    local claude_flow_found=false
    local source_file=""
    
    # First check if backup already exists
    if [[ -f "$CLAUDE_FLOW_BACKUP" ]]; then
        verbose "Found existing Claude Flow backup at $CLAUDE_FLOW_BACKUP"
        source_file="$CLAUDE_FLOW_BACKUP"
        claude_flow_found=true
    # Check if current CLAUDE.md looks like it was generated by Claude Flow
    elif [[ -f "$CLAUDE_FLOW_ORIGINAL" ]]; then
        # Check for Claude Flow markers or patterns
        if grep -q -E "(claude-flow|Claude Flow|SPARC|hive-mind|swarm)" "$CLAUDE_FLOW_ORIGINAL" 2>/dev/null; then
            verbose "Detected Claude Flow generated CLAUDE.md"
            source_file="$CLAUDE_FLOW_ORIGINAL"
            claude_flow_found=true
        elif grep -q -E "^#.*Project|^##.*Overview" "$CLAUDE_FLOW_ORIGINAL" 2>/dev/null; then
            # Generic CLAUDE.md that might have been created by Claude Flow
            verbose "Found existing CLAUDE.md (possibly from Claude Flow)"
            source_file="$CLAUDE_FLOW_ORIGINAL"
            claude_flow_found=true
        fi
    fi
    
    if $claude_flow_found; then
        echo "$source_file"
    else
        echo ""
    fi
}

backup_claude_flow_md() {
    local source_file="$1"
    
    # Don't backup if source is already the backup location
    if [[ "$source_file" == "$CLAUDE_FLOW_BACKUP" ]]; then
        verbose "Claude Flow CLAUDE.md already backed up"
        return 0
    fi
    
    # Create .claude-flow directory if it doesn't exist
    mkdir -p "$(dirname "$CLAUDE_FLOW_BACKUP")"
    
    # Backup the file
    if [[ -f "$source_file" ]]; then
        cp "$source_file" "$CLAUDE_FLOW_BACKUP"
        success "Backed up Claude Flow CLAUDE.md to $CLAUDE_FLOW_BACKUP"
        return 0
    fi
    
    return 1
}

extract_claude_flow_context() {
    local source_file="$1"
    
    if [[ ! -f "$source_file" ]]; then
        echo ""
        return
    fi
    
    # Read the entire Claude Flow generated content
    cat "$source_file"
}

read_spec_content() {
    local file="$1"
    if [[ -f "$file" ]]; then
        cat "$file"
    else
        echo ""
    fi
}

# ============================================
# MAIN GENERATION
# ============================================

log "Analyzing project structure..."
cd "$WORKSPACE_DIR"

# ============================================
# HANDLE CLAUDE FLOW GENERATED CLAUDE.MD
# ============================================
CLAUDE_FLOW_SOURCE=$(detect_claude_flow_md)
CLAUDE_FLOW_CONTENT=""

if [[ -n "$CLAUDE_FLOW_SOURCE" ]]; then
    log "Found Claude Flow context at: $CLAUDE_FLOW_SOURCE"
    
    # Backup if it's the original CLAUDE.md (not already backed up)
    if [[ "$CLAUDE_FLOW_SOURCE" == "$CLAUDE_FLOW_ORIGINAL" ]]; then
        if ! $FORCE; then
            warn "Existing CLAUDE.md will be backed up to $CLAUDE_FLOW_BACKUP"
            read -p "Continue? [Y/n] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Nn]$ ]]; then
                log "Aborted by user"
                exit 0
            fi
        fi
        backup_claude_flow_md "$CLAUDE_FLOW_SOURCE"
    fi
    
    # Extract content for incorporation
    CLAUDE_FLOW_CONTENT=$(extract_claude_flow_context "$CLAUDE_FLOW_BACKUP")
    verbose "Extracted $(echo "$CLAUDE_FLOW_CONTENT" | wc -l) lines from Claude Flow context"
else
    verbose "No Claude Flow generated CLAUDE.md found"
fi

# Detect everything
PROJECT_NAME=$(detect_project_name)
PROJECT_TYPE=$(detect_project_type)
PACKAGE_MANAGER=$(detect_package_manager)
FRAMEWORKS=$(detect_frameworks)
SCRIPTS=$(detect_available_scripts)
DIR_STRUCTURE=$(detect_directory_structure)
SPEC_KIT=$(detect_spec_kit)
CI_CD=$(detect_ci_cd)
CONTAINERS=$(detect_containerization)
GIT_INFO=$(get_git_info)

verbose "Project: $PROJECT_NAME"
verbose "Type: $PROJECT_TYPE"
verbose "Package Manager: $PACKAGE_MANAGER"
verbose "Frameworks: $FRAMEWORKS"
verbose "Spec-Kit: $SPEC_KIT"
verbose "Claude Flow Context: $([ -n "$CLAUDE_FLOW_CONTENT" ] && echo "included" || echo "none")"

log "Generating CLAUDE.md..."

# ============================================
# GENERATE THE FILE
# ============================================

cat > "$OUTPUT_FILE" << HEADER
# CLAUDE.md - Project Intelligence for $PROJECT_NAME

> Auto-generated by generate-claude-md.sh v1.1.0 on $(date '+%Y-%m-%d %H:%M:%S')
> Regenerate with: \`./devpods/generate-claude-md.sh\` or \`generate-claude-md\`

---

## Project Overview

| Attribute | Value |
|-----------|-------|
| **Name** | $PROJECT_NAME |
| **Type** | $PROJECT_TYPE |
| **Package Manager** | $PACKAGE_MANAGER |
| **Frameworks** | $FRAMEWORKS |
| **CI/CD** | $CI_CD |
| **Containers** | $CONTAINERS |
| **Git** | $GIT_INFO |
| **Claude Flow Context** | $([ -n "$CLAUDE_FLOW_CONTENT" ] && echo "✅ Included" || echo "❌ Not found") |
| **Spec-Kit** | $([ -d ".specify" ] && echo "✅ Initialized" || echo "❌ Not initialized") |

---

HEADER

# Add Claude Flow context if available
if [[ -n "$CLAUDE_FLOW_CONTENT" ]]; then
    cat >> "$OUTPUT_FILE" << 'CLAUDE_FLOW_HEADER'
## Claude Flow Context

> This section contains context generated by Claude Flow during project initialization or orchestration.
> Original file preserved at: `.claude-flow/CLAUDE.flow.md`

CLAUDE_FLOW_HEADER

    # Add the Claude Flow content with proper formatting
    echo "$CLAUDE_FLOW_CONTENT" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "---" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Add spec-kit content if available
if [[ -d ".specify" ]]; then
    cat >> "$OUTPUT_FILE" << 'SPECKIT_HEADER'
## Spec-Kit Specifications

This project uses spec-driven development. The specifications below define the project's constitution, requirements, and implementation plan.

SPECKIT_HEADER

    if [[ -f ".specify/constitution.md" ]]; then
        cat >> "$OUTPUT_FILE" << 'EOF'
### Constitution

EOF
        cat ".specify/constitution.md" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        echo "---" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    fi
    
    if [[ -f ".specify/spec.md" ]]; then
        cat >> "$OUTPUT_FILE" << 'EOF'
### Specifications

EOF
        cat ".specify/spec.md" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        echo "---" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    fi
    
    if [[ -f ".specify/plan.md" ]]; then
        cat >> "$OUTPUT_FILE" << 'EOF'
### Implementation Plan

EOF
        cat ".specify/plan.md" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        echo "---" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    fi
    
    if [[ -f ".specify/tasks.md" ]]; then
        cat >> "$OUTPUT_FILE" << 'EOF'
### Tasks

EOF
        cat ".specify/tasks.md" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        echo "---" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    fi
else
    cat >> "$OUTPUT_FILE" << 'NO_SPECKIT'
## Spec-Kit Specifications

> **Note:** Spec-kit is not initialized. Run `sk-here` or `specify init . --ai claude` to enable spec-driven development.

---

NO_SPECKIT
fi

# Project Structure
cat >> "$OUTPUT_FILE" << STRUCTURE
## Project Structure

\`\`\`
$(find . -maxdepth 2 -type d ! -path '*/\.*' ! -path './node_modules*' ! -path './dist*' ! -path './.git*' ! -path './build*' ! -path './__pycache__*' ! -path './venv*' ! -path './.venv*' 2>/dev/null | head -30 | sed 's|^\./||' | sort)
\`\`\`

Key directories: $DIR_STRUCTURE

---

STRUCTURE

# Available Scripts
if [[ -n "$SCRIPTS" ]]; then
    cat >> "$OUTPUT_FILE" << 'SCRIPTS_HEADER'
## Available Scripts

SCRIPTS_HEADER
    
    echo "| Script | Command |" >> "$OUTPUT_FILE"
    echo "|--------|---------|" >> "$OUTPUT_FILE"
    
    for script in $SCRIPTS; do
        echo "| \`$script\` | \`npm run $script\` |" >> "$OUTPUT_FILE"
    done
    
    echo "" >> "$OUTPUT_FILE"
    echo "---" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Development Commands
cat >> "$OUTPUT_FILE" << COMMANDS
## Development Commands

### Quick Reference

\`\`\`bash
# Package management
COMMANDS

case "$PACKAGE_MANAGER" in
    *npm*)
        cat >> "$OUTPUT_FILE" << 'NPM_CMDS'
npm install              # Install dependencies
npm run dev              # Start development server
npm run build            # Build for production
npm run test             # Run tests
npm run lint             # Lint code
NPM_CMDS
        ;;
    *yarn*)
        cat >> "$OUTPUT_FILE" << 'YARN_CMDS'
yarn install             # Install dependencies
yarn dev                 # Start development server
yarn build               # Build for production
yarn test                # Run tests
yarn lint                # Lint code
YARN_CMDS
        ;;
    *pnpm*)
        cat >> "$OUTPUT_FILE" << 'PNPM_CMDS'
pnpm install             # Install dependencies
pnpm dev                 # Start development server
pnpm build               # Build for production
pnpm test                # Run tests
pnpm lint                # Lint code
PNPM_CMDS
        ;;
    *uv*)
        cat >> "$OUTPUT_FILE" << 'UV_CMDS'
uv sync                  # Install dependencies
uv run python main.py    # Run application
uv run pytest            # Run tests
uv run ruff check .      # Lint code
UV_CMDS
        ;;
    *pip*)
        cat >> "$OUTPUT_FILE" << 'PIP_CMDS'
pip install -r requirements.txt  # Install dependencies
python main.py                   # Run application
pytest                           # Run tests
flake8 .                         # Lint code
PIP_CMDS
        ;;
    *cargo*)
        cat >> "$OUTPUT_FILE" << 'CARGO_CMDS'
cargo build              # Build project
cargo run                # Run application
cargo test               # Run tests
cargo clippy             # Lint code
cargo fmt                # Format code
CARGO_CMDS
        ;;
esac

cat >> "$OUTPUT_FILE" << 'COMMANDS_END'
```

---

COMMANDS_END

# Coding Guidelines
cat >> "$OUTPUT_FILE" << 'GUIDELINES'
## Coding Guidelines

### General Principles

1. **Clarity over cleverness** - Write code that is easy to understand
2. **Consistent formatting** - Follow the project's established style
3. **Meaningful names** - Use descriptive variable and function names
4. **Small functions** - Keep functions focused on a single task
5. **Test coverage** - Write tests for new functionality

### File Organization

- Keep related code together
- Use index files for clean exports
- Separate concerns (logic, UI, data)
- Follow the existing project structure

### Commit Guidelines

- Use conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`, `test:`
- Keep commits focused and atomic
- Write clear commit messages

---

GUIDELINES

# Claude-specific instructions
cat >> "$OUTPUT_FILE" << 'CLAUDE_INSTRUCTIONS'
## Instructions for Claude

### When Working on This Project

1. **Read specs first** - Check `.specify/` for project specifications before making changes
2. **Follow existing patterns** - Match the code style and architecture already in place
3. **Run tests** - Verify changes don't break existing functionality
4. **Update docs** - Keep documentation in sync with code changes
5. **Small PRs** - Make incremental changes that are easy to review

### Preferred Approaches

- Use TypeScript/type hints when available
- Prefer async/await over callbacks
- Use early returns to reduce nesting
- Extract reusable logic into utility functions
- Add comments for complex business logic

### Things to Avoid

- Don't modify generated files directly
- Don't commit sensitive data or API keys
- Don't add unnecessary dependencies
- Don't skip error handling
- Don't ignore linter warnings

---

CLAUDE_INSTRUCTIONS

# MCP Tools available
cat >> "$OUTPUT_FILE" << 'MCP_SECTION'
## Available MCP Tools

If running in Turbo-Flow environment, these MCP servers are available:

| Tool | Usage | Description |
|------|-------|-------------|
| Playwright | Browser automation | Automated testing and web scraping |
| Chrome DevTools | DOM inspection | Debug and inspect web pages |
| n8n | Workflow automation | Build and run n8n workflows |
| PAL | Multi-model AI | Query Gemini, GPT, Grok, Ollama |

### Using MCP Tools

```
# In Claude, you can use:
"Use playwright to test the login flow"
"Use chrome devtools to inspect the DOM"
"Use pal to get Gemini's opinion on this approach"
```

---

MCP_SECTION

# Footer
cat >> "$OUTPUT_FILE" << FOOTER
## Regenerating This File

This file is auto-generated based on project analysis. To regenerate:

\`\`\`bash
# Using the script
./devpods/generate-claude-md.sh

# Using the alias (if Turbo-Flow is installed)
generate-claude-md

# With custom output location
./devpods/generate-claude-md.sh -o docs/CLAUDE.md

# Force overwrite without prompts
./devpods/generate-claude-md.sh -f

# Verbose mode
./devpods/generate-claude-md.sh -v
\`\`\`

### What Gets Analyzed

- \`.claude-flow/CLAUDE.flow.md\` - Claude Flow generated context (backed up from original CLAUDE.md)
- \`.specify/\` - Spec-kit specifications
- \`package.json\` / \`pyproject.toml\` / \`Cargo.toml\` - Project configuration
- Directory structure - Project organization
- CI/CD configuration - Deployment setup
- Container configuration - Docker/DevPod setup

### Claude Flow Integration

If Claude Flow has generated a \`CLAUDE.md\` file:
1. It is automatically detected and backed up to \`.claude-flow/CLAUDE.flow.md\`
2. Its content is incorporated into the "Claude Flow Context" section above
3. The original insights are preserved while adding project analysis

---

*Generated by [Turbo-Flow Claude](https://github.com/marcuspat/turbo-flow-claude)*
FOOTER

# ============================================
# COMPLETE
# ============================================

success "Generated $OUTPUT_FILE"
log "File size: $(wc -c < "$OUTPUT_FILE") bytes, $(wc -l < "$OUTPUT_FILE") lines"

# Summary
echo ""
log "Content sources:"
if [[ -n "$CLAUDE_FLOW_CONTENT" ]]; then
    echo -e "  ${GREEN}✅${NC} Claude Flow context (from $CLAUDE_FLOW_BACKUP)"
else
    echo -e "  ${YELLOW}⚠️${NC}  No Claude Flow context found"
fi

if [[ -d ".specify" ]]; then
    echo -e "  ${GREEN}✅${NC} Spec-kit specifications"
else
    echo -e "  ${YELLOW}⚠️${NC}  Spec-kit not initialized (run: sk-here)"
fi

echo -e "  ${GREEN}✅${NC} Project analysis ($PROJECT_TYPE, $FRAMEWORKS)"

if $VERBOSE; then
    echo ""
    log "Preview (first 60 lines):"
    echo "─────────────────────────────────────────"
    head -60 "$OUTPUT_FILE"
    echo "─────────────────────────────────────────"
fi

echo ""
success "Done! Claude can now use $OUTPUT_FILE for project context."

if [[ -n "$CLAUDE_FLOW_CONTENT" ]]; then
    info "Claude Flow original preserved at: $CLAUDE_FLOW_BACKUP"
fi
