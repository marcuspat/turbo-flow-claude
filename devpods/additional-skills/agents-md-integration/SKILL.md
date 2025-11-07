---
name: "AGENTS.md Integration"
description: "Discover, read, and update AGENTS.md files in any project (standard or monorepo). Use when working with agent configurations, build commands, startup/shutdown procedures, testing protocols, or project specifications. Supports Nx, Lerna, Turborepo, and pnpm workspaces."
---

# AGENTS.md Integration

Intelligently discover and manage AGENTS.md files across any project structure.

**Reference**: See https://agents.md for complete specification and examples.

---

## What This Does

- **Discovers** AGENTS.md in project root or monorepo packages
- **Reads** agent specs, build commands, startup/shutdown procedures, testing protocols
- **Updates** specifications, adds features, maintains structure
- **Supports** standard projects and monorepos (Nx, Lerna, Turborepo, pnpm)

---

## When to Use

**Automatic triggers**:
- User mentions "agents", "AGENTS.md", or project setup
- Working on build, test, or deployment configurations
- Adding features or automations

**Manual activation**:
- "Read the AGENTS.md file"
- "What are the build commands?"
- "Update startup procedures"
- "Add feature to AGENTS.md"

---

## Discovery Algorithm

```bash
# 1. Check project root
./AGENTS.md

# 2. Detect monorepo and search packages
# Nx: apps/*/AGENTS.md, libs/*/AGENTS.md
# Lerna/pnpm: packages/*/AGENTS.md
# Turborepo: apps/*/AGENTS.md, packages/*/AGENTS.md

# 3. Fallback: recursive search (excluding node_modules, .git, dist)
find . -name "AGENTS.md" -not -path "*/node_modules/*"
```

---

## AGENTS.md Structure

**Reference**: https://agents.md/#examples for complete examples

### Minimal Structure
```markdown
# Project Name

## Build
- `npm install` - Install dependencies
- `npm run build` - Build project

## Startup
- `npm run dev` - Start development server

## Testing
- `npm test` - Run test suite

## Specifications
See `docs/spec-kit/` for detailed specifications
```

### Complete Structure Skeleton
```markdown
# Project Name

> Brief project description

## Build
- Install: [command]
- Build: [command]
- Clean: [command]

## Startup
- Development: [command]
- Production: [command]
- Watch mode: [command]

## Shutdown
- Graceful: [command]
- Force: [command]
- Cleanup: [command]

## Testing
- Unit: [command]
- Integration: [command]
- E2E: [command]
- Coverage: [command]

## Specifications
See `docs/spec-kit/` for:
- Architecture decisions
- API specifications
- Data models
- Security requirements
- Performance benchmarks

## Agents (Optional)

### Agent: [Name]
- **Role**: [Description]
- **Capabilities**: [List]
- **Languages**: [List]

## Automations (Optional)
- Pre-commit hooks
- CI/CD pipelines
- Code review automation

## Features (Optional)

### Current
- [Feature 1]
- [Feature 2]

### Planned
- [Feature 3]
- [Feature 4]

## Patterns (Optional)
- Code style: [Guidelines]
- Testing conventions: [Rules]
- Documentation: [Requirements]
```

---

## Usage Examples

### Read configuration
```
User: "What are the build commands?"
Claude: [Reads AGENTS.md → Build section]
```

### Update commands
```
User: "Add Docker build command"
Claude: [Updates AGENTS.md → Build section with new command]
```

### Monorepo discovery
```
User: "Find all AGENTS.md files"
Claude: [Searches monorepo packages, lists all files]
```

### Add feature
```
User: "Add GraphQL API to planned features"
Claude: [Appends to Features → Planned section]
```

---

## Integration with docs/spec-kit

When specifications are mentioned:
- Reference `docs/spec-kit/` directory
- Link to specific spec files (architecture.md, api-spec.yaml, etc.)
- Keep AGENTS.md as high-level pointer to detailed specs
- Don't duplicate detailed specs in AGENTS.md

**Example**:
```markdown
## Specifications
- Architecture: `docs/spec-kit/architecture.md`
- API Design: `docs/spec-kit/api-spec.yaml`
- Database Schema: `docs/spec-kit/schema.sql`
- Security: `docs/spec-kit/security-requirements.md`
```

---

## Best Practices

**Reading**:
1. Always discover before assuming location
2. Parse structure to extract commands
3. Look for spec-kit references

**Writing**:
1. Preserve existing format
2. Add to appropriate sections
3. Maintain consistent list formatting
4. Reference spec-kit for details

**Specifications**:
1. Keep AGENTS.md high-level (commands, pointers)
2. Store detailed specs in `docs/spec-kit/`
3. Use AGENTS.md as navigation hub
4. Link to spec files, don't duplicate content

---

## Quick Reference

```bash
# Discovery
"Find AGENTS.md"
"What build commands are configured?"

# Reading
"Show startup procedures"
"What testing commands are available?"
"Where are the specifications?"

# Updating
"Add [command] to build section"
"Update shutdown procedures"
"Add [feature] to planned features"

# Specifications
"Where are the API specs?"  # → docs/spec-kit/api-spec.yaml
"Show architecture docs"     # → docs/spec-kit/architecture.md
```

---

**Remember**: AGENTS.md is a navigation hub. Keep it concise with commands and pointers. Detailed specifications live in `docs/spec-kit/`.
