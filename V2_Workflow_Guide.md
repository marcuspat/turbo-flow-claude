## 🚀 Turbo Flow v2.0.0 Workflow Guide

**Operational Playbook for Spec-Driven Development & Agentic Orchestration**

---

## 📋 Table of Contents

1.  **Workflow 1:** 📝 The Spec-First Approach (Spec-Kit + OpenSpec)
2.  **Workflow 2:** 🧠 Architecture & DDD with Claude Flow V3
3.  **Workflow 3:** 🤖 The Agentic Build (`prd2build`)
4.  **Workflow 4:** 🧠 Intelligent Routing & Pattern Learning
5.  **Workflow 5:** 🐝 Swarm Coordination (Mesh vs Hierarchical)
6.  **Workflow 6:** 🔒 Security & Compliance

---

## 📝 Workflow 1: The Spec-First Approach

**Goal:** Define requirements and specifications *before* writing code, ensuring implementation drift is prevented.

**Tools Used:** `Spec-Kit` (`sk`), `OpenSpec` (`os`).

### Step 1: Initialize Specs

Initialize the specification tracking for your current directory.

```bash
# Initialize Spec-Kit (Specify CLI)
sk-here

# Initialize OpenSpec
os-init
```

**What happens:**
*   `sk-here`: Creates `.specify/` folder and a local database to track requirements.
*   `os-init`: Creates an `openspec.yaml` file to manage API specifications.

### Step 2: Define Requirements

Create a requirement using Spec-Kit.

```bash
# Add a requirement (interactive)
sk-add

# Add a requirement (direct)
sk-add "User must be able to login with email" --tag auth --priority high
```

### Step 3: Validate Specifications

Ensure your specs are valid before generating code.

```bash
# Check status of Spec-Kit
sk-check

# List all requirements
sk-list

# Visualize OpenSpec tree
os-tree
```

**Output Example:**
```text
[REQ-001] User must be able to login with email
  ├─ Priority: High
  ├─ Status: Draft
  └─ Tag: auth
```

---

## 🧠 Workflow 2: Architecture & DDD with Claude Flow V3

**Goal:** Use Claude Flow V3's "Hive Mind" to manage ADRs (Architecture Decision Records) and DDD (Domain-Driven Design).

**Tools Used:** `claude-flow@v3alpha` (alias `cf`).

### Step 1: Initialize Claude Flow V3

```bash
cf-init
```

**What happens:**
*   Initializes the Hive Mind (Queen-led coordination).
*   Sets up local ReasoningBank (pattern memory).
*   Prepares ADR tracking.

### Step 2: Create Architecture Decisions (ADRs)

Use the Architect agent to draft an ADR.

```bash
# Spawn architect agent
cf-agent architect "Create an ADR for authentication using JWT vs Sessions"
```

**Inside Claude Code:**
> "Draft ADR-001: Authentication Strategy. Context: High security required. Options: 1. JWT, 2. Server Sessions. Decision: JWT..."

### Step 3: Domain-Driven Design (DDD) Modeling

Generate Bounded Contexts and Aggregates.

```bash
# Spawn Code Analyzer for DDD
cf-agent code-analyzer "Model the User and Payment bounded contexts"
```

**Artifacts Generated:**
1.  `docs/ddd/bounded-contexts.md`
2.  `docs/ddd/aggregates.md`
3.  `docs/ddd/entities.md`

### Step 4: Memory & Pattern Storage

Store successful architectural decisions in the ReasoningBank so the system "learns."

```bash
# Check memory status
cf-memory status

# Search for similar past decisions (HNSW - 150x faster)
cf-memory search "authentication pattern"
```

---

## 🤖 Workflow 3: The Agentic Build (`prd2build`)

**Goal:** Transform Specs + ADRs into a complete codebase using the "Swarm."

**Tools Used:** `prd2build` (Slash Command), Claude Flow Swarm.

### Step 1: Prepare the PRD

Ensure your Product Requirements Document is ready.

```bash
# You can create a simple PRD.md if you don't have one
cat << 'EOF' > prd.md
# Project: My SaaS App

## Requirements
- User Authentication
- Payment Processing
- Admin Dashboard
EOF
```

### Step 2: Run the Generator

Execute the `prd2build` command inside Claude Code.

```bash
# Start Claude Code
claude

# Run the slash command
/prd2build prd.md
```

**What Happens (The "Magic"):**

```diff
+ 1. RESEARCHER Agent reads PRD.
+    → Extracts 8+ requirements.
+    → Extracts user stories.
+
+ 2. ARCHITECT Agent generates ADRs.
+    → Creates 27+ Architecture Decision Records.
+    → Aligns with Claude Flow V3 patterns.
+
+ 3. UI DESIGNER creates style guide.
+    → Uses OpenSpec definitions.
+
+ 4. CODE ANALYZER defines DDD.
+    → Bounded Contexts.
+    → Aggregates.
+
+ 5. BUILD SWARM executes code.
+    → Backend Dev (API) using ADR-001.
+    → Frontend Dev (UI) using ADR-017.
+    → Tester (Tests) using Test Strategy.
```

### Step 3: Review the Implementation Index

The generator creates a `docs/implementation/INDEX.md`.

```bash
cat docs/implementation/INDEX.md
```

This file acts as the **Single Source of Truth**, linking every Requirement → ADR → Code File.

---

## 🧠 Workflow 4: Intelligent Routing & Pattern Learning

**Goal:** Let the system learn which agents are best for specific tasks, saving time and money.

**Tools Used:** Claude Flow V3 Hooks (`hooks`), SONA.

### Step 1: Route a Task

Ask the system who should do the work based on history.

```bash
# Ask for routing recommendation
claude-flow hooks route "Refactor the user service"
```

**Output:**
```text
Recommendation: backend-dev
Confidence: 92%
Reason: High historical success rate on refactoring tasks.
Cost Saving: 15% (using Haiku vs Opus)
```

### Step 2: Learning from Trajectories

The system automatically tracks outcomes. You can view what it has learned.

```bash
# View learning stats
claude-flow hooks metrics

# View neural patterns
claude-flow neural patterns
```

**SONA (Self-Optimizing Neural Architecture):**
*   Adapts routing in <0.05ms.
*   Prevents catastrophic forgetting (EWC++).
*   Improves accuracy over time.

### Step 3: Pattern Consolidation

Consolidate learned patterns to optimize memory.

```bash
# Trigger consolidation
claude-flow hooks worker dispatch --trigger consolidate
```

---

## 🐝 Workflow 5: Swarm Coordination

**Goal:** Orchestrate multiple agents working in parallel using different topologies.

**Tools Used:** `cf-swarm`, `cf-mesh`.

### Scenario A: Hierarchical Swarm (Boss/Workers)
Best for: Structured tasks with clear authority.

```bash
# Initialize Hierarchy
cf-swarm

# Define objective in Claude Code
"Implement the Authentication feature using Hierarchical Swarm"
```

**Structure:**
```text
      [Queen Coordinator]
             |
    +----+----+----+
    |    |    |    |
 [Coder] [Tester] [Architect]
```

### Scenario B: Mesh Swarm (Peer-to-Peer)
Best for: Complex problem solving where agents need to talk to each other directly.

```bash
# Initialize Mesh
cf-mesh
```

**Structure:**
```text
[Coder] <-------> [Tester] <-------> [Architect]
    ^              ^              ^
    |______________|______________|
```

### Scenario C: Byzantine Consensus
Best for: Critical decisions where you need fault tolerance (e.g., Security Audit).

```bash
# Initialize with Byzantine fault tolerance
claude-flow swarm init --topology hierarchical --consensus byzantine
```

**Feature:** Tolerates up to 1/3 of agents failing or returning bad results.

---

## 🔒 Workflow 6: Security & Compliance

**Goal:** Use AIDefence and Security Skills to ensure code is safe.

**Tools Used:** `Security Analyzer` Skill, `cf-security`.

### Step 1: Run Security Scan

```bash
# Via Claude Flow
cf-security

# Or via Claude Code Skill
claude
"Run a full security scan on the auth module"
```

**Checks Performed:**
*   CVE Scanning (Common Vulnerabilities).
*   OWASP Top 10 compliance.
*   Hardcoded secrets detection.
*   SQL Injection / XSS analysis.

### Step 2: Generate ADR for Security

If a vulnerability is found, create a mandated fix.

```bash
cf-agent security-architect "Draft ADR to mitigate SQL injection vulnerability found in scan"
```

**Result:** A new ADR is created and pushed to `docs/adr/`.

---

## 🚀 Turbo Command Reference

| Workflow | Command | Tool | Description |
| :--- | :--- | :--- | :--- |
| **Specs** | `sk-here` | Spec-Kit (Initialize) |
| **Specs** | `sk-check` | Spec-Kit (Validate) |
| **Specs** | `os-init` | OpenSpec (Initialize) |
| **Architecture** | `cf-init` | Claude Flow V3 (Init) |
| **Architecture** | `cf-agent architect` | Spawn Architect Agent |
| **Routing** | `claude-flow hooks route` | Intelligent Routing |
| **Build** | `/prd2build prd.md` | Full Agentic Build |
| **Swarm** | `cf-swarm` | Hierarchical Swarm |
| **Swarm** | `cf-mesh` | Mesh Swarm |
| **Security** | `cf-security` | Security Scan |
| **Memory** | `cf-memory status` | Check Memory/Patterns |
