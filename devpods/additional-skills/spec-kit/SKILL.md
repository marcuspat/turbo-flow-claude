---
name: "Spec-Kit Integration"
description: "Build and maintain specification-driven development using GitHub's spec-kit methodology. Use when initializing project specifications, tracking design decisions, creating ADRs, updating requirements, or evolving architecture. Implements constitutional governance, quality gates, and executable specifications."
---

# Spec-Kit Integration

Implement GitHub's spec-kit methodology for specification-driven development (SDD).

**Reference**: https://github.com/github/spec-kit

---

## What This Does

**Initial Build**:
- Create `docs/spec-kit/` structure with constitution, specs, plans, tasks
- Set up governance principles and quality gates
- Generate feature specification directories
- Establish specification templates

**Ongoing Maintenance**:
- Track design decisions and architectural changes
- Update specifications as requirements evolve
- Maintain constitutional compliance
- Generate task breakdowns from specs
- Validate cross-artifact consistency

---

## When to Use

**Automatic triggers**:
- User mentions "spec", "specification", "architecture decision", "requirements"
- Starting new features or major changes
- Making architectural decisions
- Updating project requirements

**Manual activation**:
- "Initialize spec-kit for this project"
- "Create specification for [feature]"
- "Update architecture decision"
- "Track this design decision"
- "Generate implementation plan from spec"

---

## Directory Structure

```
docs/spec-kit/
├── constitution.md           # Project governance (immutable principles)
├── specs/
│   ├── 001-feature-name/
│   │   ├── spec.md          # WHAT and WHY (requirements)
│   │   ├── plan.md          # HOW to build (architecture)
│   │   ├── tasks.md         # Executable task breakdown
│   │   └── checklist.md     # Validation criteria
│   └── 002-another-feature/
│       └── ...
├── decisions/               # Architecture Decision Records (ADRs)
│   ├── 0001-use-typescript.md
│   └── 0002-database-choice.md
└── templates/               # Reusable templates
    ├── spec-template.md
    ├── plan-template.md
    └── adr-template.md
```

---

## Core Workflows

### 1. Initialize Spec-Kit

```bash
# User: "Initialize spec-kit for this project"

# Create directory structure
mkdir -p docs/spec-kit/{specs,decisions,templates}

# Generate constitution.md with project governance
# Generate templates for specs, plans, ADRs
# Create README with workflow guide
```

**Constitution Articles** (customize per project):
1. **Library-First Architecture** - Reusable, testable components
2. **CLI Interface Pattern** - Command-based interactions
3. **Test-First Development** - Tests before implementation
4. **Integration Testing** - End-to-end validation
5. **Supporting Principles** - Code quality, documentation, etc.

---

### 2. Create Feature Specification

```bash
# User: "Create specification for user authentication"

# Step 1: Create feature directory
docs/spec-kit/specs/001-user-authentication/

# Step 2: Generate spec.md (WHAT and WHY)
# - User scenarios
# - Requirements (functional, non-functional)
# - Success criteria
# - Constraints and assumptions

# Step 3: Mark for clarification if needed
# [NEEDS CLARIFICATION]: Specific ambiguities
```

**spec.md Template**:
```markdown
# Feature: [Name]

## Overview
[Brief description]

## User Scenarios
1. **As a [role]**, I want [goal] so that [benefit]
2. ...

## Requirements

### Functional
- REQ-001: [Requirement]
- REQ-002: [Requirement]

### Non-Functional
- PERF-001: [Performance requirement]
- SEC-001: [Security requirement]

## Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Constraints
- Technical constraints
- Business constraints

## [NEEDS CLARIFICATION]
- Ambiguity 1
- Ambiguity 2
```

---

### 3. Create Implementation Plan

```bash
# User: "Create implementation plan for authentication"

# Step 1: Generate plan.md (HOW to build)
# - Tech stack decisions
# - Architecture design
# - Component breakdown
# - Data models
# - API design

# Step 2: Constitutional compliance gates
# Check against constitution.md principles
# Document compliance or exceptions

# Step 3: Quality gates
# - Plan complete ✓
# - Constitutional alignment ✓
# - No unresolved clarifications ✓
```

**plan.md Template**:
```markdown
# Implementation Plan: [Feature]

## Tech Stack
- Language: [Choice and rationale]
- Framework: [Choice and rationale]
- Database: [Choice and rationale]

## Architecture

### Components
1. **[Component]**: [Responsibility]
2. **[Component]**: [Responsibility]

### Data Models
[Schema definitions]

### API Design
[Endpoint specifications]

## Constitutional Compliance

### Article 1: Library-First ✓
[How this complies]

### Article 2: CLI Interface ✓
[How this complies]

### [Continue for all articles]

## Dependencies
- Internal: [List]
- External: [List]

## Risk Assessment
- Risk 1: [Mitigation]
- Risk 2: [Mitigation]
```

---

### 4. Generate Task Breakdown

```bash
# User: "Generate tasks for authentication implementation"

# Step 1: Generate tasks.md from plan.md
# - Phase 1: Setup and scaffolding
# - Phase 2: Core implementation
# - Phase 3: Testing and validation
# - Phase 4: Documentation and deployment

# Step 2: Task dependencies
# Track what must complete before next phase

# Step 3: Parallelization opportunities
# Identify independent tasks
```

**tasks.md Template**:
```markdown
# Tasks: [Feature]

## Phase 1: Setup (Parallel)
- [ ] TASK-001: Set up project structure
- [ ] TASK-002: Install dependencies
- [ ] TASK-003: Configure environment

## Phase 2: Core Implementation (Sequential)
- [ ] TASK-004: Implement authentication service
  - Depends on: TASK-001, TASK-002
- [ ] TASK-005: Create user model
  - Depends on: TASK-001
- [ ] TASK-006: Build authentication middleware
  - Depends on: TASK-004, TASK-005

## Phase 3: Testing (Sequential)
- [ ] TASK-007: Unit tests
  - Depends on: Phase 2 complete
- [ ] TASK-008: Integration tests
  - Depends on: TASK-007

## Phase 4: Documentation (Parallel)
- [ ] TASK-009: API documentation
- [ ] TASK-010: User guide
- [ ] TASK-011: Deployment guide
```

---

### 5. Track Design Decisions (ADRs)

```bash
# User: "Track the decision to use JWT for authentication"

# Create ADR in docs/spec-kit/decisions/
# Format: NNNN-title-with-dashes.md
# Include: Context, Decision, Consequences, Alternatives
```

**ADR Template**:
```markdown
# ADR-NNNN: [Title]

**Status**: Accepted | Proposed | Deprecated | Superseded
**Date**: YYYY-MM-DD
**Deciders**: [Names/Roles]
**Related**: [ADR numbers or specs]

## Context
[What is the issue we're addressing?]
[What factors are driving this decision?]

## Decision
[What are we deciding to do?]

## Rationale
[Why did we choose this option?]
[What makes this the best choice?]

## Consequences

### Positive
- Benefit 1
- Benefit 2

### Negative
- Trade-off 1
- Trade-off 2

### Neutral
- Impact 1
- Impact 2

## Alternatives Considered

### Option 1: [Name]
**Pros**:
**Cons**:
**Why rejected**:

### Option 2: [Name]
**Pros**:
**Cons**:
**Why rejected**:

## Implementation Notes
[Technical details, if any]

## References
- [Links to resources]
```

---

### 6. Update Specifications

```bash
# User: "Update authentication spec to include OAuth support"

# Step 1: Read existing spec.md
# Step 2: Add new requirements
# Step 3: Update plan.md with architectural changes
# Step 4: Update tasks.md with new work items
# Step 5: Check constitutional compliance
# Step 6: Update validation checklist
```

**Update Pattern**:
1. **Identify change** - What's being added/modified/removed
2. **Update spec.md** - Add requirements, scenarios, criteria
3. **Update plan.md** - Adjust architecture if needed
4. **Update tasks.md** - Add/modify task items
5. **Create ADR** - If architectural decision involved
6. **Validate** - Check quality gates and compliance

---

### 7. Validate Cross-Artifact Consistency

```bash
# User: "Validate spec-kit consistency"

# Check that:
# - All requirements in spec.md are addressed in plan.md
# - All plan components have tasks in tasks.md
# - All tasks reference requirements
# - Constitutional compliance is documented
# - No unresolved [NEEDS CLARIFICATION]
# - All ADRs are referenced in relevant specs
```

---

## Quality Gates

### Gate 1: Specification Complete
- ✓ User scenarios defined
- ✓ Requirements documented (functional + non-functional)
- ✓ Success criteria specified
- ✓ Constraints identified
- ✓ No unresolved [NEEDS CLARIFICATION]

### Gate 2: Plan Complete
- ✓ Tech stack decided with rationale
- ✓ Architecture designed
- ✓ Components identified
- ✓ Data models defined
- ✓ API designed
- ✓ Constitutional compliance documented

### Gate 3: Tasks Ready
- ✓ All plan components have tasks
- ✓ Dependencies identified
- ✓ Phases organized
- ✓ Parallelization opportunities noted
- ✓ Test tasks included (test-first principle)

### Gate 4: Implementation Ready
- ✓ All gates 1-3 passed
- ✓ Checklist generated
- ✓ Cross-references validated
- ✓ Team reviewed (if applicable)

---

## Integration with AGENTS.md

The spec-kit skill integrates with AGENTS.md:

**In AGENTS.md**:
```markdown
## Specifications
See `docs/spec-kit/` for detailed specifications:
- Constitution: `docs/spec-kit/constitution.md`
- Features: `docs/spec-kit/specs/###-feature-name/`
- Decisions: `docs/spec-kit/decisions/`

## Current Features
[List features with links to specs]
- User Authentication → `docs/spec-kit/specs/001-user-auth/`
```

**In spec-kit**:
- Reference AGENTS.md for build/test commands
- Link to AGENTS.md in constitution for project conventions

---

## Best Practices

### Constitutional Governance
1. **Establish early** - Create constitution.md before first feature
2. **Customize principles** - Adapt to project needs
3. **Enforce compliance** - Check every spec against constitution
4. **Document exceptions** - Explain any principle violations

### Specification Writing
1. **Separate concerns** - WHAT/WHY in spec.md, HOW in plan.md
2. **User-centric** - Start with user scenarios
3. **Measurable criteria** - Success criteria must be testable
4. **Clarify early** - Mark ambiguities immediately

### Design Decisions
1. **Document rationale** - Why, not just what
2. **Consider alternatives** - Show what wasn't chosen
3. **Note consequences** - Both positive and negative
4. **Cross-reference** - Link ADRs to affected specs

### Task Management
1. **Test-first** - Test tasks before implementation tasks
2. **Small increments** - Break large tasks into smaller ones
3. **Track dependencies** - Use "Depends on" explicitly
4. **Identify parallelism** - Mark which tasks can run concurrently

### Maintenance
1. **Update atomically** - Update spec → plan → tasks together
2. **Version decisions** - Date ADRs, mark superseded ones
3. **Validate consistency** - Regularly check cross-references
4. **Archive completed** - Move implemented specs to archive/

---

## Quick Reference

### Initialization
```
"Initialize spec-kit for this project"
"Set up specification structure"
"Create project constitution"
```

### Feature Specifications
```
"Create spec for [feature]"
"Update [feature] requirements"
"Add user scenario to [feature] spec"
```

### Implementation Planning
```
"Create implementation plan for [feature]"
"Update architecture for [feature]"
"Check constitutional compliance"
```

### Design Decisions
```
"Create ADR for [decision]"
"Track decision to use [technology]"
"Document why we chose [approach]"
```

### Task Management
```
"Generate tasks for [feature]"
"Break down [component] into tasks"
"Update task list with [changes]"
```

### Validation
```
"Validate spec-kit consistency"
"Check quality gates for [feature]"
"Review cross-artifact references"
```

---

## Workflow Summary

**New Feature Flow**:
1. `spec.md` → Define WHAT and WHY
2. Clarify ambiguities → Resolve [NEEDS CLARIFICATION]
3. `plan.md` → Define HOW to build
4. Check compliance → Validate against constitution
5. `tasks.md` → Generate executable breakdown
6. `checklist.md` → Create validation criteria
7. Implement → Execute tasks (test-first)
8. Validate → Check against quality gates

**Design Decision Flow**:
1. Identify decision point
2. Research alternatives
3. Create ADR with rationale
4. Update affected specs/plans
5. Link ADR to related specifications

**Update Flow**:
1. Identify change scope
2. Update spec.md → requirements
3. Update plan.md → architecture (if needed)
4. Update tasks.md → work items
5. Create ADR → if architectural
6. Validate → consistency check

---

## Examples

### Example 1: Initialize Project
```
User: "Initialize spec-kit for a REST API project"

Claude:
1. Creating docs/spec-kit/ structure
2. Generating constitution.md with API-specific principles:
   - RESTful design patterns
   - OpenAPI specification requirement
   - API versioning strategy
   - Error handling standards
3. Creating templates for specs, plans, ADRs
4. Setting up first feature: "API Foundation"
```

### Example 2: Track Decision
```
User: "Track the decision to use PostgreSQL over MongoDB"

Claude:
1. Creating ADR-0001-postgresql-database.md
2. Documenting:
   - Context: Need for relational data, ACID compliance
   - Decision: Use PostgreSQL 15+
   - Alternatives: MongoDB, MySQL, SQLite
   - Rationale: Complex relationships, transaction support
   - Consequences: More setup, better data integrity
3. Linking to specs/001-data-layer/plan.md
```

### Example 3: Update Specification
```
User: "Add real-time notifications to the messaging feature"

Claude:
1. Reading specs/003-messaging/spec.md
2. Adding requirements:
   - REQ-015: Real-time message delivery via WebSocket
   - REQ-016: Push notifications for offline users
3. Updating plan.md:
   - Architecture: Add WebSocket server component
   - Tech: Socket.io or native WebSocket API
4. Updating tasks.md:
   - Phase 2: TASK-020: Implement WebSocket server
   - Phase 3: TASK-025: Test real-time delivery
5. Creating ADR-0005-websocket-technology.md
```

---

**Remember**: Spec-kit inverts traditional development—specifications are executable artifacts that drive implementation. Keep WHAT/WHY separate from HOW, enforce constitutional principles, and maintain cross-artifact consistency.
