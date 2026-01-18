# Turbo Flow V2.0.0 - Modular Workflow System

**Each workflow is completable in one session and produces tangible outputs.**

---

## 📚 Workflow Overview

| Workflow | Duration | Output | When to Use |
|----------|----------|--------|-------------|
| **WF-01: Setup** | 15 min | Environment ready | First time or new project |
| **WF-02: Specs** | 30-60 min | Requirements database | Starting a new feature |
| **WF-03: Architecture** | 60-90 min | ADR + DDD design | Before implementation |
| **WF-04: Implementation** | 2-4 hrs | Working code | Building the feature |
| **WF-05: Testing** | 30-60 min | Test suite | After implementation |
| **WF-06: Security** | 30 min | Security report | Before deployment |
| **WF-07: Docs** | 30 min | Complete docs | Before PR/deployment |
| **WF-08: Deploy** | 45 min | Deployed & monitored | Production release |

---
## WF-01: Environment Setup Workflow

**Goal:** Set up your development environment with all tools.

**Time:** 15 minutes
**Output:** Ready-to-use development environment

### Prerequisites

```bash
# DevPod environment
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode
```

### Steps

#### Step 1: Run Setup Script (5 min)

```bash
cd /workspaces/turbo-flow-claude
./devpods/setup.sh
```

**What this installs:**
- Node.js 20 LTS
- RuVector Neural Engine
- Claude Flow V3
- Spec-Kit + OpenSpec
- Agentic QE
- Playwriter MCP
- Dev-Browser Skill
- Security Analyzer Skill
- HeroUI + Tailwind
- prd2build command

#### Step 2: Verify Installation (2 min)

```bash
source ~/.bashrc
turbo-status
```

**Expected output:**
```
✅ All tools installed and ready
```

#### Step 3: Initialize Project (5 min)

```bash
cd /workspaces/my-project

# Initialize Spec-Kit
sk-here

# Initialize OpenSpec
os-init

# Initialize Claude Flow
cf-init

# Initialize RuVector hooks
ruv-init
```

#### Step 4: Create Project Structure (3 min)

```bash
mkdir -p src tests docs plans scripts config
```

### ✅ Completion Criteria

- [ ] `turbo-status` shows all green checks
- [ ] `.specify/` directory exists
- [ ] `.claude-flow/` directory exists
- [ ] Can run `claude` command
- [ ] Can run `cf-list` to see agents

### 🎉 You're Ready!

Move to any workflow below based on what you want to do.

---

## WF-02: Spec-First Development Workflow

**Goal:** Create specifications and requirements before writing code.

**Time:** 30-60 minutes
**Output:** Complete specification database

### When to Use

- Starting a new feature
- Starting a new project
- Documenting existing requirements

### Steps

#### Step 1: Create PRD (10-20 min)

Create `prd.md`:

```markdown
# Feature: User Authentication

## Overview
Implement email/password authentication with JWT tokens.

## Requirements
- User registration with email verification
- Login with email/password
- Password reset flow
- JWT token management
- Session management

## Non-Functional
- Response time < 200ms
- 99.9% uptime
- OWASP compliant
```

#### Step 2: Add Requirements to Spec-Kit (10 min)

```bash
# Add functional requirements
sk-add "REQ-001: User registration with email verification" \
  --tag auth --tag user --priority high

sk-add "REQ-002: Login with email/password" \
  --tag auth --priority high

sk-add "REQ-003: Password reset with email link" \
  --tag auth --priority medium

# Add non-functional requirements
sk-add "NFR-001: Response time < 200ms for login" \
  --tag performance --priority high

sk-add "NFR-002: OWASP Top 10 compliance" \
  --tag security --priority critical
```

#### Step 3: Add User Stories (10 min)

```bash
sk-add "US-001: As a user, I want to register with email so I can access the system" \
  --tag user-story --tag auth

sk-add "US-002: As a user, I want to reset my password so I can regain access" \
  --tag user-story --tag auth
```

#### Step 4: Create API Specifications (15 min)

```bash
# Create OpenSpec YAML files
cat > .specify/db/api-auth.yaml << 'EOF'
openapi: 3.0.0
info:
  title: Authentication API
  version: 1.0.0
paths:
  /auth/register:
    post:
      summary: Register new user
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                email:
                  type: string
                password:
                  type: string
      responses:
        '201':
          description: User created
  /auth/login:
    post:
      summary: Login user
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                email:
                  type: string
                password:
                  type: string
      responses:
        '200':
          description: Login successful
          content:
            application/json:
              schema:
                type: object
                properties:
                  token:
                    type: string
EOF
```

#### Step 5: Verify Specifications (5 min)

```bash
# List all requirements
.specify/db/query.sh list-req

# List all user stories
.specify/db/query.sh list-us

# Show traceability matrix
.specify/db/query.sh trace

# Check database integrity
.specify/db/query.sh check
```

### ✅ Completion Criteria

- [ ] All requirements added to database
- [ ] All user stories added
- [ ] API specifications created
- [ ] Traceability matrix shows links
- [ ] Database integrity check passes

### 📤 Output

- `.specify/db/requirements.json`
- `.specify/db/user-stories.json`
- `.specify/db/api-*.yaml`
- `.specify/db/index.json`

### ➡️ Next Workflow

- **WF-03: Architecture** - Design ADR and DDD for these requirements
- **WF-04: Implementation** - Start building (skip architecture if simple feature)

---

## WF-03: Architecture & Design Workflow

**Goal:** Create ADRs and DDD design before implementation.

**Time:** 60-90 minutes
**Output:** Complete architecture documentation

### When to Use

- Complex features requiring architectural decisions
- Features affecting multiple bounded contexts
- Team needs documentation of design decisions

### Steps

#### Step 1: Initialize Swarm (2 min)

```bash
cf-swarm
```

#### Step 2: Spawn Architect Agent (5 min)

```bash
claude
> "I need to design the authentication system. Create DDD bounded contexts and ADRs."
```

Or use agent directly:

```bash
cf-agent architect "Design authentication system with User and Session bounded contexts"
```

#### Step 3: Review DDD Design (20 min)

The architect will create:

**File:** `docs/ddd/bounded-contexts.md`

```markdown
# Bounded Contexts

## User Context
**Responsibility:** User registration, profile management
**Aggregates:** User, EmailVerification
**Entities:** User, Password, EmailToken

## Session Context
**Responsibility:** Authentication, session management
**Aggregates:** Session, Token
**Entities:** Session, JWT, RefreshToken
```

**File:** `docs/ddd/aggregates.md`

```markdown
# Aggregates

## User Aggregate
- Root: User
- Invariants: Email unique, password hashed
- Domain Events: UserRegistered, EmailVerified

## Session Aggregate
- Root: Session
- Invariants: Token valid, not expired
- Domain Events: SessionCreated, SessionExpired
```

#### Step 4: Create ADRs (30 min)

Spawn security architect for security ADRs:

```bash
cf-agent security-architect "Create ADR for JWT vs Session storage for authentication"
```

**File:** `docs/adr/ADR-001-jwt-authentication.md`

```markdown
# ADR-001: JWT for Stateless Authentication

## Status
Accepted

## Context
Need authentication for API. Options: JWT vs Sessions.

## Decision
Use JWT for stateless authentication.

## Consequences
- **Positive:** Scalable, no server-side session storage
- **Negative:** Token revocation requires workaround
- **Mitigation:** Short-lived tokens + refresh tokens
```

#### Step 5: Store Patterns in Memory (10 min)

```bash
# Store architectural patterns
ruv-remember "DDD pattern: User and Session bounded contexts for authentication"

# Store ADR decision
ruv-remember "ADR-001: JWT chosen for stateless authentication with refresh token rotation"
```

#### Step 6: Create Architecture Diagram (15 min)

```bash
claude
> "Create a system architecture diagram showing the authentication flow"
```

**File:** `docs/architecture/authentication-flow.md`

```markdown
# Authentication Flow

```
Client → API Gateway → Auth Service → User Service
                           ↓
                      JWT Token
                           ↓
                       Session Store
```
```

#### Step 7: Verify Documentation (8 min)

```bash
# Check all ADRs exist
ls docs/adr/

# Check DDD docs exist
ls docs/ddd/

# Verify patterns stored
ruv-recall "authentication patterns"
```

### ✅ Completion Criteria

- [ ] Bounded contexts defined
- [ ] Aggregates and entities documented
- [ ] ADRs created (at least ADR-001)
- [ ] Architecture diagram created
- [ ] Patterns stored in RuVector memory

### 📤 Output

- `docs/ddd/bounded-contexts.md`
- `docs/ddd/aggregates.md`
- `docs/ddd/entities.md`
- `docs/adr/ADR-001-*.md`
- `docs/architecture/*.md`

### ➡️ Next Workflow

- **WF-04: Implementation** - Build the feature

---

## WF-04: Implementation Workflow

**Goal:** Build working code based on specs and architecture.

**Time:** 2-4 hours
**Output:** Complete, tested feature

### When to Use

- After specifications complete (WF-02)
- After architecture complete (WF-03)
- Simple features can skip WF-03

### Steps

#### Step 1: Route Task to Optimal Agent (2 min)

```bash
ruv-route "Implement user authentication with JWT"
```

**Output:** Recommendation for best agent (usually `backend-dev` or `coder`)

#### Step 2: Start Learning Trajectory (1 min)

```bash
# Start trajectory for reinforcement learning
npx @claude-flow/cli@latest hooks intelligence trajectory-start \
  --task "implement JWT authentication" \
  --agent backend-dev
```

#### Step 3: Initialize Swarm (2 min)

```bash
# Hierarchical for structured tasks
cf-swarm
```

#### Step 4: Implement with Swarm (60-120 min)

```bash
claude
> "Implement the authentication feature based on the specs in .specify/db/"
> "Follow the DDD design in docs/ddd/"
> "Follow the ADR decisions in docs/adr/"
```

**Swarm will coordinate:**
- **Coder**: Implements User aggregate
- **Coder**: Implements Session aggregate
- **Coder**: Creates API endpoints
- **Architect**: Reviews implementation
- **Security**: Validates security

#### Step 5: Record Implementation Steps (ongoing)

```bash
# After each major step
npx @claude-flow/cli@latest hooks intelligence trajectory-step \
  --trajectory-id "<id>" \
  --action "implemented User aggregate with password hashing" \
  --result "success" \
  --quality 0.95
```

#### Step 6: Build Frontend with HeroUI (30-60 min)

Create `src/components/LoginForm.tsx`:

```tsx
import { Button, Card, Input } from "@heroui/react";

export function LoginForm() {
  return (
    <Card className="p-6 max-w-md mx-auto">
      <Input label="Email" type="email" variant="bordered" />
      <Input label="Password" type="password" variant="bordered" />
      <Button color="primary" className="w-full mt-4">
        Login
      </Button>
    </Card>
  );
}
```

```tsx
// src/App.tsx
import { LoginForm } from "./components/LoginForm";

function App() {
  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center">
      <LoginForm />
    </div>
  );
}
```

#### Step 7: End Learning Trajectory (2 min)

```bash
npx @claude-flow/cli@latest hooks intelligence trajectory-end \
  --trajectory-id "<id>" \
  --success true \
  --feedback "JWT authentication with refresh token rotation - reusable pattern"
```

### ✅ Completion Criteria

- [ ] Code implements all requirements in `.specify/db/`
- [ ] Code follows DDD design in `docs/ddd/`
- [ ] Code follows ADR decisions in `docs/adr/`
- [ ] Frontend uses HeroUI components
- [ ] Learning trajectory completed

### 📤 Output

- `src/auth/user.ts` - User aggregate
- `src/auth/session.ts` - Session aggregate
- `src/api/auth.ts` - API endpoints
- `src/components/LoginForm.tsx` - UI components
- `src/App.tsx` - Application entry

### ➡️ Next Workflow

- **WF-05: Testing** - Test the implementation
- **WF-06: Security** - Security scan

---

## WF-05: Testing Workflow

**Goal:** Generate and run comprehensive tests.

**Time:** 30-60 minutes
**Output:** Complete test suite

### When to Use

- After implementation complete (WF-04)
- Before deployment
- When adding tests to existing code

### Steps

#### Step 1: Generate Tests with Agentic QE (10 min)

```bash
# Generate all tests
aqe-generate

# Or generate specific test types
npx -y agentic-qe generate --type unit
npx -y agentic-qe generate --type integration
npx -y agentic-qe generate --type e2e
```

**What gets generated:**
- Unit tests for all modules
- Integration tests for APIs
- E2E tests for critical flows
- Test fixtures and mocks

#### Step 2: Generate Playwright Tests (10 min)

```bash
claude
> "Generate a Playwright test for the login flow"
```

**File:** `tests/e2e/login.spec.ts`

```typescript
import { test, expect } from '@playwright/test';

test('user can login', async ({ page }) => {
  await page.goto('/login');
  await page.fill('input[name="email"]', 'user@example.com');
  await page.fill('input[name="password"]', 'password123');
  await page.click('button:has-text("Login")');
  await expect(page).toHaveURL('/dashboard');
});
```

#### Step 3: Run Unit Tests (5 min)

```bash
npm test
```

#### Step 4: Run Playwright Tests (10 min)

```bash
npx playwright test

# Or with UI
npx playwright test --ui
```

#### Step 5: Run Quality Gate (10 min)

```bash
aqe-gate
```

**Quality gate checks:**
- Code coverage >= 80%
- All tests passing
- Static analysis (clippy, ESLint)
- No critical vulnerabilities

#### Step 6: Review Test Results (15 min)

```bash
# Coverage report
npm run test:coverage

# Test results
cat coverage/lcov-report/index.html
```

### ✅ Completion Criteria

- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] E2E tests pass
- [ ] Code coverage >= 80%
- [ ] Quality gate passes

### 📤 Output

- `tests/unit/` - Unit tests
- `tests/integration/` - Integration tests
- `tests/e2e/` - E2E tests
- `coverage/` - Coverage reports

### ➡️ Next Workflow

- **WF-06: Security** - Security scanning
- **WF-07: Docs** - Complete documentation

---

## WF-06: Security Workflow

**Goal:** Comprehensive security analysis and hardening.

**Time:** 30 minutes
**Output:** Security report with findings resolved

### When to Use

- After implementation (WF-04)
- After tests pass (WF-05)
- Before deployment
- Regular security audits

### Steps

#### Step 1: Run Security Scan (5 min)

```bash
claude
> "Run a comprehensive security scan on the authentication code"
```

Or:

```bash
cf-security
```

**What gets scanned:**
- CVE vulnerabilities in dependencies
- OWASP Top 10 compliance
- Hardcoded secrets detection
- SQL injection vulnerabilities
- XSS vulnerabilities
- Authentication flaws

#### Step 2: Review Findings (10 min)

Check the security report for:
- Critical vulnerabilities
- High-risk issues
- Medium-risk issues
- Low-risk issues

#### Step 3: Create Security ADRs if Needed (5 min)

```bash
cf-agent security-architect "Draft ADR to mitigate detected XSS vulnerability"
```

#### Step 4: Address Critical Findings (10 min)

```bash
# Example: Fix hardcoded secret
claude
> "Fix the hardcoded API key in src/config.ts"
```

```bash
# Example: Add input validation
claude
> "Add input validation to the login endpoint"
```

#### Step 5: Re-scan (5 min)

```bash
cf-security
```

#### Step 6: Store Security Patterns (5 min)

```bash
ruv-remember "Security pattern: Input validation with Zod schema"
ruv-remember "Security pattern: Environment variables for secrets, never hardcoded"
```

### ✅ Completion Criteria

- [ ] No critical vulnerabilities
- [ ] No high vulnerabilities
- [ ] Security scan passes
- [ ] Security ADRs created if needed
- [ ] Patterns stored in memory

### 📤 Output

- `docs/security/SCAN-REPORT.md`
- `docs/security/ADR-SEC-*.md` (if needed)

### ➡️ Next Workflow

- **WF-07: Docs** - Complete documentation
- **WF-08: Deploy** - Deployment preparation

---

## WF-07: Documentation Workflow

**Goal:** Complete documentation for the feature.

**Time:** 30 minutes
**Output:** Complete, production-ready documentation

### When to Use

- After implementation (WF-04)
- After testing (WF-05)
- After security (WF-06)
- Before PR/deployment

### Steps

#### Step 1: Run prd2build for Auto-Docs (5 min)

```bash
claude
> "Generate complete documentation for the authentication feature"
```

Or:

```bash
# If you have a PRD
/prd2build prd.md
```

#### Step 2: Verify Generated Docs (10 min)

Check that these exist:

```bash
# Specification
ls docs/specification/
# requirements.md, user-stories.md, api-contracts.md

# DDD
ls docs/ddd/
# bounded-contexts.md, aggregates.md, entities.md

# ADR
ls docs/adr/
# ADR-001 through ADR-027+

# Implementation
ls docs/implementation/
# INDEX.md (single source of truth)
```

#### Step 3: Update INDEX.md (5 min)

```bash
cat docs/implementation/INDEX.md
```

Verify traceability:
- Requirements → ADR → Code Files
- User Stories → Implementation → Tests
- API Specs → Endpoints → Tests

#### Step 4: Create API Documentation (5 min)

```bash
# If using OpenSpec
os-tree
```

#### Step 5: Create User Documentation (5 min)

Create `docs/user-guide/authentication.md`:

```markdown
# Authentication User Guide

## Registration
1. Go to /register
2. Enter email and password
3. Verify email via link

## Login
1. Go to /login
2. Enter email and password
3. Click "Login"

## Password Reset
1. Go to /forgot-password
2. Enter email
3. Check email for reset link
```

### ✅ Completion Criteria

- [ ] All specification docs complete
- [ ] DDD docs complete
- [ ] ADRs documented
- [ ] INDEX.md traces all requirements
- [ ] User guide complete
- [ ] API documentation complete

### 📤 Output

- `docs/specification/` - Complete specs
- `docs/ddd/` - Complete DDD
- `docs/adr/` - Complete ADRs
- `docs/implementation/INDEX.md` - Traceability matrix
- `docs/user-guide/` - User documentation

### ➡️ Next Workflow

- **WF-08: Deploy** - Deploy to production

---

## WF-08: Deployment Workflow

**Goal:** Deploy feature to production safely.

**Time:** 45 minutes
**Output:** Deployed and monitored feature

### When to Use

- All documentation complete (WF-07)
- Ready for production release
- Regular deployments

### Steps

#### Step 1: Pre-Deployment Checklist (10 min)

```bash
# Run quality gate
aqe-gate

# Run security scan
cf-security

# Verify documentation
cat docs/implementation/INDEX.md

# Check memory patterns
ruv-stats
```

**Checklist:**
- [ ] All tests passing (aqe-gate)
- [ ] No critical vulnerabilities (cf-security)
- [ ] Documentation complete (INDEX.md)
- [ ] Performance benchmarks met
- [ ] Learning patterns stored

#### Step 2: Build for Production (5 min)

```bash
npm run build
```

#### Step 3: Deploy to Staging (10 min)

```bash
# Your deployment command
npm run deploy:staging
```

#### Step 4: Run E2E Tests on Staging (5 min)

```bash
npx playwright test --project=staging
```

#### Step 5: Monitor Staging (5 min)

```bash
# Check logs
# Check error rates
# Check performance
```

#### Step 6: Deploy to Production (5 min)

```bash
npm run deploy:production
```

#### Step 7: Post-Deployment Monitoring (10 min)

```bash
# Monitor metrics
# Check error rates
# Check performance
# Check logs for issues
```

#### Step 8: Store Deployment Pattern (5 min)

```bash
ruv-remember "Successful deployment pattern: Blue-green deployment with zero downtime"
```

#### Step 9: Trigger Consolidation (2 min)

```bash
npx @claude-flow/cli@latest hooks worker dispatch --trigger consolidate
```

#### Step 10: Update Runbook (3 min)

Create `docs/runbook/deployment.md`:

```markdown
# Deployment Runbook

## Pre-Deployment
- [ ] aqe-gate passes
- [ ] cf-security clean
- [ ] INDEX.md verified

## Deployment Steps
1. npm run build
2. npm run deploy:staging
3. npx playwright test --project=staging
4. npm run deploy:production

## Post-Deployment
- Monitor error rates
- Check performance
- Review logs
```

### ✅ Completion Criteria

- [ ] All pre-deployment checks pass
- [ ] Staging tests pass
- [ ] Production deployment successful
- [ ] No critical errors in production
- [ ] Performance metrics met
- [ ] Deployment pattern stored

### 📤 Output

- Deployed feature in production
- `docs/runbook/deployment.md`
- Updated memory patterns

### ➡️ Next Workflow

- **WF-09: Optimization** - Continuous improvement

---

## WF-09: Continuous Optimization Workflow

**Goal:** Continuously improve system performance and patterns.

**Time:** 30 minutes (weekly/bi-weekly)
**Output:** Optimized system and updated patterns

### When to Use

- Regular maintenance
- Performance issues detected
- New patterns discovered

### Steps

#### Step 1: Check System Metrics (5 min)

```bash
# Check swarm status
npx -y claude-flow@v3alpha swarm status

# Check learning stats
ruv-stats

# Check memory
cf-memory-status
```

#### Step 2: Identify Optimization Opportunities (10 min)

```bash
# Trigger optimization worker
npx @claude-flow/cli@latest hooks worker dispatch --trigger optimize
```

#### Step 3: Review Learned Patterns (10 min)

```bash
# Search for patterns
ruv-recall "authentication patterns"
ruv-recall "deployment patterns"
ruv-recall "performance optimizations"
```

#### Step 4: Consolidate Patterns (5 min)

```bash
# Trigger consolidation
npx @claude-flow/cli@latest hooks worker dispatch --trigger consolidate
```

### ✅ Completion Criteria

- [ ] System metrics reviewed
- [ ] Optimization opportunities identified
- [ ] Patterns consolidated
- [ ] Memory updated

### 📤 Output

- Updated memory patterns
- Optimization recommendations

---

## 🚀 Quick Start Guide

### New Project? Start Here:

```bash
# Day 1: Setup
WF-01: Environment Setup (15 min)

# Day 2: Plan
WF-02: Spec-First Development (60 min)
WF-03: Architecture & Design (90 min)

# Day 3-4: Build
WF-04: Implementation (2-4 hrs)

# Day 5: Validate
WF-05: Testing (60 min)
WF-06: Security (30 min)
WF-07: Documentation (30 min)

# Day 6: Deploy
WF-08: Deployment (45 min)

# Ongoing:
WF-09: Optimization (30 min/week)
```

### Existing Codebase? Start Here:

```bash
# Skip WF-01, start with:
WF-05: Testing - Add tests
WF-06: Security - Security scan
WF-07: Documentation - Generate docs
```

---

## 📊 Workflow Decision Tree

```
Starting a new feature?
├─ Yes → Have PRD?
│         ├─ Yes → WF-02: Specs (60 min)
│         │        ↓
│         │        WF-03: Architecture (90 min)
│         │        ↓
│         │        WF-04: Implementation (2-4 hrs)
│         │        ↓
│         │        WF-05: Testing (60 min)
│         │        ↓
│         │        WF-06: Security (30 min)
│         │        ↓
│         │        WF-07: Documentation (30 min)
│         │        ↓
│         │        WF-08: Deploy (45 min)
│         │
│         └─ No → Write PRD first, then WF-02
│
└─ No (Existing codebase)
   → WF-05: Testing
   → WF-06: Security
   → WF-07: Documentation
   → WF-08: Deploy
```

---

## 🎯 Summary

Each workflow is:
- **Completable** in one session
- **Independent** (can do in any order after WF-01)
- **Produces** tangible outputs
- **Verifiable** with completion criteria

**Total time to production:** 3-5 days for new feature

---

**Version:** 2.0.0
**Last Updated:** 2026-01-18
