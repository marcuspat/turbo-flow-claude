# Turbo Flow v3.1.0 - Complete Workflows

## Overview

This document outlines comprehensive workflows that fully utilize the Turbo Flow v3.1.0 stack for different development scenarios. Each workflow leverages the complete ecosystem:

### Core Components
- Claude Flow V3 + Claude Flow Browser (59 MCP tools)
- RuVector Neural Engine + RuV Helpers 3D Visualization
- Agent Browser + Trajectory Learning

### Skills
- prd2build, Security Analyzer, UI UX Pro Max
- Worktree Manager, Vercel Deploy

### Testing & Quality
- Agentic QE (Queen Coordinator)
- Visual Regression, Accessibility Auditing

### Frontend
- HeroUI + React + Framer Motion
- Tailwind CSS + TypeScript

---

## Available Workflows

| Workflow | Description | Primary Use Case |
|----------|-------------|------------------|
| **1. New Builds** | Greenfield projects from PRD | Starting fresh projects |
| **2. Continued Builds** | Iterative feature development | Adding features to existing code |
| **3. Refactor Builds** | Technical debt & modernization | Code quality improvements |
| **4. UI Development** | Complete UI/UX workflow | Frontend development & testing |

> **Note:** For the comprehensive UI Development & Testing workflow (Workflow 4), see the [Tech Stack Document](./turbo-flow-tech-stack.md#workflow-4-ui-development--testing-complete-guide).

---

## Workflow 1: New Builds (Greenfield Projects)

### Objective
Start a new project from scratch using PRD-driven development with multi-agent orchestration.

---

### Phase 1: Project Initialization & Specification

#### 1.1 Initialize Turbo Flow Environment
```bash
# Reload shell with Turbo Flow aliases
source ~/.bashrc

# Verify installation
turbo-status

# Initialize Claude Flow in workspace
cf-init

# Start the Claude Flow daemon for background processing
cf-daemon
```

#### 1.2 Create Project Specification with Spec-Kit
```bash
# Initialize specification structure
sk-here

# Or use OpenSpec for API-first design
os-init
```

#### 1.3 Generate Build Plan from PRD
```bash
# Use prd2build command to convert requirements to actionable plan
claude "/prd2build"

# Claude will:
# 1. Parse your Product Requirements Document
# 2. Generate Architecture Decision Records (ADRs)
# 3. Create DDD bounded contexts
# 4. Produce task breakdown for multi-agent execution
```

---

### Phase 2: Architecture & Design

#### 2.1 Spawn Architecture Swarm
```bash
# Initialize hierarchical swarm for architecture design
cf-swarm

# Or use mesh topology for collaborative design
cf-mesh

# Spawn specialized agents
npx claude-flow@alpha agent spawn -t system-architect --name arch-lead
npx claude-flow@alpha agent spawn -t planner --name task-planner
npx claude-flow@alpha agent spawn -t researcher --name tech-researcher
```

#### 2.2 UI/UX Design with Pro Max Skill
```bash
# Claude automatically uses UI UX Pro Max skill for design guidance
claude "Design a modern dashboard interface for our application using HeroUI components"

# The skill provides:
# - Design system recommendations
# - Component architecture guidance
# - Accessibility best practices
# - Responsive design patterns
# - Animation and interaction design
```

#### 2.3 Research with Agent Browser
```bash
# Open reference sites for design inspiration
ab-open "https://dribbble.com/search/dashboard"
ab-snap

# Capture competitor UI patterns
ab-open "https://competitor-site.com/dashboard"
ab-snap

# Close browser session
ab-close
```

---

### Phase 3: Implementation with Multi-Agent Swarm

#### 3.1 Initialize Development Swarm
```bash
# Create full development swarm
npx claude-flow@alpha swarm init dev-swarm \
  --topology hierarchical \
  --agents "coder:3,tester:2,reviewer:1,docs:1"

# Task orchestration with automatic agent routing
npx claude-flow@alpha task orchestrate \
  "Build user authentication system with OAuth" \
  --strategy adaptive
```

#### 3.2 RuVector Memory & Learning
```bash
# Initialize RuVector hooks for pattern learning
ruv-init

# As agents work, RuVector automatically:
# - Routes tasks to best-performing agents
# - Remembers successful patterns
# - Learns from code review feedback

# Check learning statistics
ruv-stats

# Manually remember a successful pattern
ruv-remember "OAuth implementation pattern"

# Recall patterns for similar tasks
ruv-recall "authentication"
```

#### 3.3 Frontend Development with HeroUI
```typescript
// src/components/Dashboard.tsx
import { Button, Card, Input } from "@heroui/react";
import { motion } from "framer-motion";

export function Dashboard() {
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="p-8 dark:bg-gray-900"
    >
      <Card className="max-w-md">
        <h1 className="text-2xl font-bold">Welcome</h1>
        <Input placeholder="Search..." />
        <Button color="primary">Get Started</Button>
      </Card>
    </motion.div>
  );
}
```

---

### Phase 4: Quality Assurance

#### 4.1 Generate Tests with Agentic QE
```bash
# Generate comprehensive tests
aqe-generate

# Or with Claude integration
claude "Use qe-test-architect to create tests for src/services/ with 95% coverage"

# Run full quality pipeline with Queen coordination
claude "Use qe-queen-coordinator to orchestrate: 
  1. Test generation
  2. Coverage analysis  
  3. Security scan
  4. Quality gate at 90% threshold"
```

#### 4.2 Security Analysis
```bash
# Claude automatically uses security-analyzer skill
claude "Analyze the codebase for security vulnerabilities and OWASP compliance"

# The skill performs:
# - Code vulnerability scanning
# - Dependency security analysis
# - Security best practices review
# - OWASP compliance checking
```

#### 4.3 E2E Testing with Agent Browser
```bash
# Automated E2E testing flow
ab-open "http://localhost:3000/login"
ab-snap
ab-fill "@e1" "test@example.com"
ab-fill "@e2" "password123"
ab-click "@e3"  # Login button
ab-snap
# Verify dashboard loaded
ab-close
```

#### 4.4 Quality Gate
```bash
# Run quality gate before deployment
aqe-gate

# Gate checks:
# - Code coverage >= 90%
# - No critical security vulnerabilities
# - All tests passing
# - Performance benchmarks met
```

---

### Phase 5: Documentation & Deployment

#### 5.1 Generate Documentation
```bash
# Spawn documentation agent
npx claude-flow@alpha agent spawn -t api-docs --name doc-writer

# Generate API documentation
npx claude-flow@alpha task create \
  "Generate comprehensive API documentation" \
  --assign doc-writer
```

#### 5.2 Final Memory Consolidation
```bash
# RuVector learns from the successful build
ruv-learn

# Store project patterns for future use
ruv-remember "Project: MyApp - Full build workflow"

# Check what was learned
ruv-stats
```

---

## Workflow 2: Continued Builds (Iterative Development)

### Objective
Continue development on an existing project with feature additions, using learned patterns and existing context.

---

### Phase 1: Context Recovery

#### 1.1 Restore Project Context
```bash
# Start Claude Flow and recover memory
cf-init

# Recall previous project patterns
ruv-recall "MyApp"

# Check what RuVector remembers about this project
ruv-stats

# Route to appropriate workflow based on task
ruv-route "Add payment processing feature"
```

#### 1.2 Review Existing Architecture
```bash
# Use Claude Flow doctor to verify environment
cf-doctor

# Check swarm status if previously running
npx claude-flow@alpha swarm status

# List available agents
cf-list
```

---

### Phase 2: Feature Planning

#### 2.1 Analyze Impact with Swarm
```bash
# Spawn analysis swarm
npx claude-flow@alpha hive-mind spawn \
  "Analyze impact of adding payment processing" \
  --queen-type tactical

# Agents automatically:
# - Review existing codebase
# - Identify affected modules
# - Suggest integration points
# - Flag potential breaking changes
```

#### 2.2 Research External Dependencies
```bash
# Research payment providers
ab-open "https://stripe.com/docs/api"
ab-snap

ab-open "https://docs.paypal.com/api"
ab-snap

# Capture key integration patterns
ab-close
```

#### 2.3 Update Specifications
```bash
# Update project specs with new feature
specify update . --feature "payment-processing"

# Generate ADR for architectural decision
npx claude-flow@alpha adr create "Payment Gateway Selection"
```

---

### Phase 3: Incremental Implementation

#### 3.1 Smart Task Routing
```bash
# RuVector routes based on learned patterns
ruv-route "Implement Stripe integration"

# Claude Flow assigns to best-suited agent based on:
# - Past performance on similar tasks
# - Current agent workload
# - Code familiarity patterns
```

#### 3.2 Spawn Feature Swarm
```bash
# Hierarchical swarm for feature development
npx claude-flow@alpha swarm init payment-feature \
  --topology hierarchical \
  --agents "backend-dev:2,frontend-dev:1,tester:1"

# Orchestrate feature tasks
npx claude-flow@alpha task orchestrate \
  "Implement payment processing with Stripe" \
  --pattern fork-join
```

#### 3.3 Continuous Integration Testing
```bash
# Generate tests for new feature
aqe-generate --scope src/services/payment/

# Run incremental test suite
aqe-gate --incremental

# E2E payment flow testing
ab-open "http://localhost:3000/checkout"
ab-snap
ab-fill "@card-number" "4242424242424242"
ab-fill "@expiry" "12/25"
ab-fill "@cvc" "123"
ab-click "@pay-button"
ab-snap
ab-close
```

---

### Phase 4: UI Enhancement

#### 4.1 Update Components with HeroUI
```bash
# Claude uses UI UX Pro Max for component design
claude "Design a payment form component using HeroUI with proper validation states and loading indicators"
```

#### 4.2 Browser Testing Across Viewports
```bash
# Test responsive design
ab-open "http://localhost:3000/checkout" --viewport 1920x1080
ab-snap --full

ab-open "http://localhost:3000/checkout" --viewport 375x812
ab-snap --full

ab-close
```

---

### Phase 5: Validation & Merge

#### 5.1 Security Review
```bash
# Security scan focusing on payment flow
claude "Use security-analyzer to audit the payment processing implementation for PCI compliance"
```

#### 5.2 Quality Gate for Feature Branch
```bash
# Run full quality assessment
claude "Use qe-queen-coordinator to:
  1. Execute tests with parallel workers
  2. Analyze coverage with risk scoring
  3. Run security scan on payment module
  4. Validate quality gate at 95% threshold
  5. Provide merge recommendation"
```

#### 5.3 Update Memory with Learnings
```bash
# Remember successful patterns from this feature
ruv-remember "Stripe integration pattern"
ruv-remember "Payment form validation pattern"

# Learn from the feature development cycle
ruv-learn
```

---

## Workflow 3: Refactor Builds (Technical Debt & Modernization)

### Objective
Refactor existing codebase to improve maintainability, performance, and security without changing functionality.

---

### Phase 1: Codebase Analysis

#### 1.1 Initialize Refactor Environment
```bash
# Initialize Claude Flow with refactor focus
cf-init

# Run doctor to check environment health
cf-doctor

# Recall any previous refactor patterns
ruv-recall "refactor"
ruv-recall "modernization"
```

#### 1.2 Deep Codebase Analysis with Swarm
```bash
# Spawn analysis swarm for comprehensive review
npx claude-flow@alpha hive-mind spawn \
  "Analyze entire codebase for refactoring opportunities" \
  --consensus byzantine \
  --claude

# Swarm performs:
# - Code complexity analysis
# - Dependency audit
# - Dead code detection
# - Performance hotspot identification
# - Security vulnerability scan
```

#### 1.3 Security Audit
```bash
# Comprehensive security analysis
claude "Use security-analyzer to:
  1. Scan for known vulnerabilities (CVEs)
  2. Check for insecure dependencies
  3. Identify hardcoded credentials
  4. Review authentication flows
  5. Audit API endpoints for OWASP Top 10"
```

#### 1.4 Generate Baseline Tests
```bash
# Capture current behavior with test generation
aqe-generate --mode characterization

# This creates:
# - Snapshot tests for UI components
# - Integration tests for API endpoints
# - Unit tests for critical business logic
# - Performance baselines
```

---

### Phase 2: Refactor Planning

#### 2.1 Create Refactor ADRs
```bash
# Document refactoring decisions
npx claude-flow@alpha adr create "Migrate to TypeScript strict mode"
npx claude-flow@alpha adr create "Replace legacy state management"
npx claude-flow@alpha adr create "Modernize API layer"
```

#### 2.2 Prioritize with Risk Analysis
```bash
# Task orchestration with risk-aware prioritization
npx claude-flow@alpha task orchestrate \
  "Plan refactoring sequence based on risk and dependency analysis" \
  --strategy adaptive

# Claude Flow considers:
# - Dependency chains (what must change first)
# - Risk levels (impact of failure)
# - Test coverage (safety net availability)
# - Business criticality
```

---

### Phase 3: Incremental Refactoring

#### 3.1 Spawn Refactor Swarm
```bash
# Mesh topology for parallel refactoring
npx claude-flow@alpha swarm init refactor-swarm \
  --topology mesh \
  --agents "coder:4,tester:2,reviewer:2"

# Enable continuous learning during refactor
ruv-init
```

#### 3.2 Pattern-Based Refactoring
```bash
# RuVector routes refactor tasks based on patterns
ruv-route "Migrate class components to hooks"
ruv-route "Extract shared utilities"
ruv-route "Implement error boundaries"

# Each task is routed to agents with relevant experience
```

#### 3.3 TDD-Driven Refactoring
```bash
# Use SPARC methodology for test-driven refactor
npx claude-flow@alpha sparc tdd \
  "Refactor user service to repository pattern" \
  --agents specification,pseudocode,architecture,refinement

# SPARC flow:
# S - Specification: Define expected behavior
# P - Pseudocode: Plan implementation approach
# A - Architecture: Design new structure
# R - Refinement: Iterate based on test results
# C - Completion: Verify all tests pass
```

#### 3.4 UI Modernization
```bash
# Claude uses UI UX Pro Max for modern patterns
claude "Refactor legacy Bootstrap components to HeroUI with:
  - Dark mode support
  - Improved accessibility
  - Framer Motion animations
  - Tailwind utility classes"

# Update component library
npm install @heroui/react framer-motion --save
```

---

### Phase 4: Continuous Validation

#### 4.1 Regression Testing
```bash
# Run characterization tests to detect behavioral changes
aqe-gate --baseline

# Compare with baseline:
# - Functional behavior unchanged
# - Performance metrics maintained or improved
# - No new security vulnerabilities
```

#### 4.2 Visual Regression with Agent Browser
```bash
# Capture UI snapshots for comparison
ab-open "http://localhost:3000"
ab-snap --full --output before-refactor/

# After refactoring
ab-open "http://localhost:3000"  
ab-snap --full --output after-refactor/

ab-close

# Compare screenshots for visual regressions
```

#### 4.3 Performance Validation
```bash
# Run performance benchmarks
claude "Use qe-performance-benchmarker to:
  1. Measure page load times
  2. Check bundle sizes
  3. Profile memory usage
  4. Compare with baseline metrics"
```

---

### Phase 5: Migration & Completion

#### 5.1 Staged Rollout with Monitoring
```bash
# Spawn monitoring agent
npx claude-flow@alpha agent spawn -t production-validator --name prod-monitor

# Real-time refactor monitoring
npx claude-flow@alpha workflow monitor \
  --workflow-id "refactor-main" \
  --metrics "progress,performance,errors" \
  --interval 5
```

#### 5.2 Final Security Scan
```bash
# Post-refactor security validation
claude "Use security-analyzer to:
  1. Verify no new vulnerabilities introduced
  2. Confirm dependency updates are secure
  3. Validate API security unchanged
  4. Check for accidental credential exposure"
```

#### 5.3 Quality Gate for Release
```bash
# Final quality gate
claude "Use qe-queen-coordinator to run final assessment:
  1. Full regression test suite
  2. Security compliance check
  3. Performance comparison with baseline
  4. Coverage validation at 90%+ threshold
  5. Generate deployment readiness report"
```

#### 5.4 Consolidate Learnings
```bash
# Remember all successful refactor patterns
ruv-remember "TypeScript strict migration pattern"
ruv-remember "Legacy component modernization pattern"
ruv-remember "Repository pattern implementation"

# Learn from the refactor cycle
ruv-learn

# Check accumulated knowledge
ruv-stats
```

---

## Quick Reference: Turbo Flow Commands by Workflow

| Phase | New Build | Continued Build | Refactor Build |
|-------|-----------|-----------------|----------------|
| **Init** | `cf-init`, `sk-here` | `ruv-recall`, `cf-doctor` | `cf-doctor`, `ruv-recall "refactor"` |
| **Plan** | `/prd2build`, `cf-swarm` | `ruv-route`, `specify update` | `adr create`, `aqe-generate --mode characterization` |
| **Develop** | `cf-swarm`, `ruv-init` | `ruv-route`, task orchestrate | `sparc tdd`, mesh swarm |
| **Test** | `aqe-generate`, `aqe-gate` | `aqe-gate --incremental` | `aqe-gate --baseline` |
| **Security** | security-analyzer skill | security-analyzer (focused) | security-analyzer (comprehensive) |
| **UI** | UI UX Pro Max + HeroUI | Component updates | Component modernization |
| **Browser** | `ab-open`, `ab-snap` | E2E flow testing | Visual regression |
| **Learn** | `ruv-remember`, `ruv-learn` | `ruv-remember` (patterns) | `ruv-remember`, `ruv-learn` |

---

## Agent Topology Selection Guide

| Scenario | Topology | Reason |
|----------|----------|--------|
| New feature with clear hierarchy | `hierarchical` | Lead agent delegates to specialists |
| Collaborative refactoring | `mesh` | Peer-to-peer communication for parallel work |
| Complex research tasks | `byzantine` | Consensus-based decision making |
| Quick bug fixes | Single agent | Overhead not needed |
| Full application build | `star` | Central coordinator with dedicated workers |

---

## Memory & Learning Best Practices

```bash
# Before starting any workflow
ruv-recall "<project-name>"     # Recover project context
ruv-stats                        # Check available patterns

# During development
ruv-route "<task description>"   # Smart task routing
ruv-remember "<pattern name>"    # Save successful patterns

# After completion
ruv-learn                        # Consolidate learnings
ruv-stats                        # Verify knowledge captured
```

---

## Troubleshooting

```bash
# Check system health
turbo-status

# Diagnose Claude Flow issues
cf-doctor

# View swarm status
npx claude-flow@alpha swarm status

# Reset memory if needed
npx @ruvector/cli hooks reset

# View agent logs
npx claude-flow@alpha logs --agent <agent-name>
```

---

## Turbo Flow v3.1.0 New Commands

### Visualization (RuV Helpers)
```bash
ruv-viz              # Start 3D dashboard at localhost:3333
ruv-viz-stop         # Stop visualization server
```

### Worktree Manager
```bash
wt-status            # Check all worktrees status
wt-create            # Create new worktree
wt-clean             # Clean up merged worktrees
```

### Vercel Deployment
```bash
deploy               # Deploy to Vercel
deploy-preview       # Deploy and get preview URL
```

### Claude Flow Browser (59 MCP Tools)
```bash
cfb-open <url>       # Open URL via MCP
cfb-snap             # Capture snapshot
cfb-click <ref>      # Click element (@e1, @e2...)
cfb-fill <ref> <val> # Fill input
cfb-trajectory       # Start recording pattern
cfb-learn <name>     # Save pattern to RuVector
```

---

## UI Development Quick Reference

For complete UI development workflow including:
- Component architecture with multi-agent swarms
- HeroUI + Framer Motion implementation
- Visual regression testing
- Accessibility compliance
- E2E testing with trajectory learning
- One-command Vercel deployment

**See:** [Workflow 4: UI Development & Testing](./turbo-flow-tech-stack.md#workflow-4-ui-development--testing-complete-guide)

---

## Ultimate Cyberpunk Statusline (v3.1.0)

Your terminal now displays 15 components across 3 lines:

```
╔═══════════════════════════════════════════════════════════════════════════════════╗
║ LINE 1: 📁 Project │ 🤖 Model │ 🌿 Branch │ 📟 Version │ 🎨 Style │ 🔗 Session    ║
╠═══════════════════════════════════════════════════════════════════════════════════╣
║ LINE 2: 📊 Tokens │ 🧠 Context │ 💾 Cache │ 💰 Cost │ 🔥 Burn │ ⏱️ Duration       ║
╠═══════════════════════════════════════════════════════════════════════════════════╣
║ LINE 3: ➕ Added │ ➖ Removed │ 📂 Git │ 🌳 Worktree │ 🔌 MCP │ ✅ Status          ║
╚═══════════════════════════════════════════════════════════════════════════════════╝
```

Colors: Magenta • Cyan • Neon Green • Yellow • Pink • Blue • Orange
