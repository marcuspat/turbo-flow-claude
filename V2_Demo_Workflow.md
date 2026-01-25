# Turbo Flow v2.0.2 - Complete End-to-End Demo Workflow

**A Comprehensive Simulation from Product Requirement to Production Deployment**

---

## Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Demo Scenario](#demo-scenario)
4. [Phase 0: PR Creation](#phase-0-pr-creation)
5. [Phase 1: Requirements & Architecture](#phase-1-requirements--architecture)
6. [Phase 2: Design & Specification](#phase-2-design--specification)
7. [Phase 3: Implementation](#phase-3-implementation)
8. [Phase 4: QE Verification](#phase-4-qe-verification)
9. [Phase 5: Integration Testing](#phase-5-integration-testing)
10. [Phase 6: Load Testing (100 Users)](#phase-6-load-testing-100-users)
11. [Phase 7: Security Audit](#phase-7-security-audit)
12. [Phase 8: Documentation](#phase-8-documentation)
13. [Phase 9: Deployment](#phase-9-deployment)
14. [NLP Prompt Reference](#nlp-prompt-reference)

---

## Overview

This demo workflow simulates building a complete feature using **Turbo Flow v2.0.2** from initial product requirement through production deployment. It demonstrates:

- **Complete PR (Product Requirement)** creation process
- **All Turbo Flow components** in action
- **QE (Quality Engineering) pipeline** after every phase
- **ruvLLM** for intelligent code generation
- **ruvbrowswer** for 100-user load simulation
- **NLP-driven** workflow execution

### Tools Demonstrated

| Tool | Purpose | Demo Usage |
|------|---------|------------|
| **Spec-Kit** | Requirements management | PR to user stories |
| **Claude Flow V3** | 54+ agents, swarm coordination | Multi-agent implementation |
| **RuVector** | Neural learning engine | Pattern storage & retrieval |
| **ruvLLM** | Intelligent code generation | Smart code completion |
| **Agentic QE** | 19 testing agents | Quality gates after each phase |
| **ruvbrowswer** | Chromium automation | 100-user load simulation |
| **Security Analyzer** | OWASP scanning | Vulnerability detection |
| **OpenSpec** | API specifications | OpenAPI generation |

---

## Prerequisites

### Environment Setup (One-Time)

```bash
# Launch DevPod environment
devpod up https://github.com/marcuspat/turbo-flow-claude --ide vscode

# Run complete setup (15 steps)
cd /workspaces/github-com-marcuspat-turbo-flow-claude
./devpods/setup.sh

# Reload shell
source ~/.bashrc

# Verify installation
turbo-status
```

### Quick Verification

```bash
# Start Claude Code
claude

# Initialize all tools
cf-init        # Claude Flow V3
sk-here        # Spec-Kit
os-init        # OpenSpec
ruv-init       # RuVector hooks
```

---

## Demo Scenario

### Feature: Real-Time Collaborative Task Board

**Product Requirement**: Build a real-time collaborative task board where multiple users can simultaneously create, edit, move, and delete tasks with live updates.

**Core Requirements**:
1. Real-time WebSocket synchronization
2. Multi-user collaboration with presence indicators
3. Drag-and-drop task management
4. Task CRUD operations
5. User authentication and authorization
6. Audit trail for all changes

**Success Criteria**:
- 100 concurrent users
- <100ms latency for updates
- 99.9% uptime
- Zero data loss

---

## Phase 0: PR Creation

**Duration**: 30 minutes

### Step 1: Create PR Document

**NLP Prompt**:
```
Create a comprehensive Product Requirement document for a real-time collaborative
task board application. Include:

1. Executive Summary
2. Problem Statement
3. Target Users
4. Functional Requirements
5. Non-Functional Requirements
6. Technical Constraints
7. Success Metrics
8. User Stories

Save this as plans/research/task-board-pr.md
```

**Generated PR Structure**:

```markdown
# PR: Real-Time Collaborative Task Board

## Executive Summary
A web-based collaborative task management system enabling real-time
multi-user interaction with drag-and-drop functionality.

## Problem Statement
Current task management tools lack real-time collaboration, causing:
- Version conflicts (67% of teams report issues)
- Lost changes (23% of updates)
- Poor remote team experience

## Target Users
- Remote development teams (5-50 members)
- Product management teams
- Agile/scrum teams

## Functional Requirements
FR-001: User authentication with JWT
FR-002: Real-time WebSocket connection
FR-003: Task CRUD operations
FR-004: Drag-and-drop interface
FR-005: Multi-user presence indicators
FR-006: Audit logging

## Non-Functional Requirements
NFR-001: Support 100 concurrent users
NFR-002: <100ms update latency
NFR-003: 99.9% availability
NFR-004: Zero data loss
NFR-005: Mobile responsive

## Technical Constraints
- WebSocket-only for real-time (no polling)
- Stateless API design
- Horizontal scalability
- PostgreSQL for persistence
- Redis for pub/sub

## Success Metrics
- 100 concurrent users supported
- <100ms p95 latency
- <1% error rate
- 100% test coverage on critical paths
```

### Step 2: Extract Requirements to Spec-Kit

**NLP Prompt**:
```
Extract all requirements from the PR document and add them to Spec-Kit.
Tag each requirement with appropriate category: auth, realtime, ui, persistence.
```

**Bash Commands**:
```bash
# Initialize Spec-Kit if not already done
sk-here

# Add requirements (simulated - Claude Code would do this via NLP)
specify add "User authentication with JWT tokens and refresh rotation" \
  --tag auth --priority critical --id FR-001

specify add "Real-time WebSocket connection for live updates" \
  --tag realtime --priority critical --id FR-002

specify add "Task CRUD operations (Create, Read, Update, Delete)" \
  --tag ui --priority high --id FR-003

specify add "Drag-and-drop interface for task management" \
  --tag ui --priority high --id FR-004

specify add "Multi-user presence indicators showing active users" \
  --tag realtime --priority medium --id FR-005

specify add "Audit logging for all state changes" \
  --tag persistence --priority high --id FR-006

specify add "Support 100 concurrent users" \
  --tag performance --priority critical --id NFR-001

specify add "Update latency under 100ms" \
  --tag performance --priority critical --id NFR-002

specify add "99.9% availability target" \
  --tag reliability --priority critical --id NFR-003

specify add "Zero data loss guarantee" \
  --tag reliability --priority critical --id NFR-004

# List all requirements
specify list

# Validate specification
specify check
```

### Step 3: Initial QE Pipeline - Requirements Validation

**NLP Prompt**:
```
Run the initial QE pipeline to validate requirements completeness:
1. Check for ambiguous requirements
2. Identify missing edge cases
3. Verify testability of each requirement
4. Generate requirements coverage report
```

**Bash Commands**:
```bash
# Run Agentic QE for requirements validation
npx -y agentic-qe validate --mode requirements --source .specify/

# Expected output: Requirements validation report
# - Ambiguity check: PASS
# - Completeness check: PASS
# - Testability check: PASS
# - Traceability check: PASS
```

---

## Phase 1: Requirements & Architecture

**Duration**: 60-90 minutes

### Step 1: Architecture Decision Records (ADRs)

**NLP Prompt**:
```
Create comprehensive Architecture Decision Records for the task board system:

1. ADR-001: WebSocket vs Server-Sent Events
2. ADR-002: Authentication Strategy (JWT with Refresh Tokens)
3. ADR-003: Database Design (PostgreSQL with JSONB)
4. ADR-004: Real-time Synchronization (Redis Pub/Sub)
5. ADR-005: Conflict Resolution Strategy (Operational Transformation)
6. ADR-006: Scalability Pattern (Horizontal Pod Autoscaler)

For each ADR, include:
- Context and problem statement
- Considered alternatives with pros/cons
- Decision with rationale
- Consequences and implications

Store these in docs/adr/
```

**Generated ADR Structure**:

```markdown
# ADR-001: WebSocket Communication Protocol

## Status
Accepted

## Context
Need real-time bidirectional communication for collaborative task board.

## Decision
Use WebSocket (RFC 6455) with fallback to Server-Sent Events.

## Alternatives Considered

| Option | Pros | Cons |
|--------|------|------|
| WebSocket | True bidirectional, low latency | Complex state management |
| SSE | Simple, auto-reconnect | Unidirectional only |
| Long Polling | Universal compatibility | High latency, server load |
| WebRTC | True P2P, lowest latency | Complex setup, STUN/TURN needed |

## Rationale
- Bidirectional communication required for collaboration
- Sub-second latency requirement (NFR-002)
- Browser support >97% (caniuse.com)
- Fallback to SSE ensures compatibility

## Consequences
- Positive: Real-time updates <100ms achievable
- Positive: Reduced server load vs polling
- Negative: Requires connection state management
- Negative: Need heartbeat mechanism for dead connections

## Implementation
```typescript
// WebSocket connection manager
class WSConnection {
  private ws: WebSocket;
  private heartbeat: NodeJS.Timeout;

  connect(url: string) {
    this.ws = new WebSocket(url);
    this.setupHeartbeat();
  }
}
```

---

# ADR-002: Authentication Strategy

## Status
Accepted

## Context
Users must authenticate securely while maintaining real-time connection.

## Decision
JWT access tokens (15min TTL) with refresh token rotation (7-day TTL).

## Alternatives Considered

| Option | Pros | Cons |
|--------|------|------|
| JWT + Refresh | Stateless, scalable | Token revocation complexity |
| Session Cookies | Simple revocation | Stateful, harder to scale |
| API Keys | Simple for service accounts | No user context, security risk |

## Rationale
- Stateless design enables horizontal scaling
- Short-lived tokens minimize attack window
- Refresh rotation prevents token replay attacks

## Implementation
```typescript
interface TokenPair {
  accessToken: string;  // 15min, JWT
  refreshToken: string; // 7days, rotated, stored in DB
}
```
```

### Step 2: Domain-Driven Design (DDD)

**NLP Prompt**:
```
Create DDD bounded contexts and aggregates for the task board domain:

1. Identify bounded contexts
2. Define aggregates and entities
3. Map relationships
4. Define value objects
5. Specify domain events

Create docs/ddd/ with:
- bounded-contexts.md
- aggregates.md
- entities.md
- value-objects.md
- domain-events.md
```

**Generated DDD Structure**:

```markdown
# Bounded Contexts

## 1. Collaboration Context
**Responsibility**: Real-time user interaction and presence
- **Aggregates**: Session, Presence
- **Entities**: User, Connection

## 2. Task Management Context
**Responsibility**: Task lifecycle and organization
- **Aggregates**: TaskBoard, Task
- **Entities**: Column, Tag

## 3. Authentication Context
**Responsibility**: User identity and access control
- **Aggregates**: User, AuthSession
- **Entities**: RefreshToken, AuditLog

## 4. Audit Context
**Responsibility**: Change tracking and compliance
- **Aggregates**: AuditTrail
- **Entities**: AuditEvent

---

# Aggregates

## TaskBoard Aggregate
**Root**: TaskBoard
**Entities**: Column, Task
**Value Objects**: BoardId, Permissions
**Invariants**:
- Max 100 tasks per board
- Tasks must belong to columns
- Column order must be sequential

## Task Aggregate
**Root**: Task
**Value Objects**: TaskId, Title, Description, Position
**Invariants**:
- Title required (1-200 chars)
- Position unique within column
- Soft delete only (audit trail)

---

# Domain Events

```typescript
// Task events
event TaskCreated { taskId: string, boardId: string, position: number }
event TaskMoved { taskId: string, fromColumn: string, toColumn: string, position: number }
event TaskUpdated { taskId: string, changes: Partial<Task> }
event TaskDeleted { taskId: string, deletedBy: string }

// Collaboration events
event UserJoined { userId: string, boardId: string, timestamp: Date }
event UserLeft { userId: string, boardId: string, timestamp: Date }
event PresenceUpdate { userId: string, status: 'active' | 'idle' | 'away' }

// Authentication events
event UserLoggedIn { userId: string, sessionId: string }
event RefreshTokenUsed { userId: string, oldToken: string, newToken: string }
```
```

### Step 3: Store Patterns in RuVector Memory

**Bash Commands**:
```bash
# Store architectural patterns
ruv-remember -t architecture "WebSocket with heartbeat for real-time collaboration"
ruv-remember -t architecture "JWT 15min access + 7day refresh token rotation"
ruv-remember -t architecture "PostgreSQL JSONB for flexible task metadata"
ruv-remember -t architecture "Redis pub/sub for horizontal scaling"
ruv-remember -t architecture "Operational Transformation for conflict resolution"

# Store DDD patterns
ruv-remember -t ddd "4 bounded contexts: Collaboration, TaskMgmt, Auth, Audit"
ruv-remember -t ddd "TaskBoard aggregate root with invariants enforcement"

# Store requirements patterns
ruv-remember -t requirement "100 concurrent users via horizontal autoscaling"
ruv-remember -t requirement "<100ms latency via WebSocket + Redis"
```

### Step 4: QE Pipeline - Architecture Validation

**NLP Prompt**:
```
Run QE pipeline to validate architecture:
1. Review all ADRs for completeness
2. Check DDD model consistency
3. Validate invariants are enforceable
4. Verify domain events cover all state changes
5. Generate architecture coverage report
```

**Bash Commands**:
```bash
# Run architecture validation
npx -y agentic-qe validate --mode architecture \
  --adr-path docs/adr/ \
  --ddd-path docs/ddd/

# Expected output: Architecture validation report
# - ADR completeness: 6/6 PASS
# - DDD consistency: PASS
# - Invariants enforceable: PASS
# - Domain events coverage: 10/10 PASS
```

---

## Phase 2: Design & Specification

**Duration**: 45-60 minutes

### Step 1: API Specification with OpenSpec

**NLP Prompt**:
```
Generate OpenAPI 3.0 specifications for the task board API using OpenSpec.

Include endpoints for:
1. Authentication (/auth/login, /auth/refresh, /auth/logout)
2. Task Management (/tasks, /tasks/:id, /tasks/:id/move)
3. Real-time (/ws/connect)
4. Presence (/presence)
5. Audit (/audit)

For each endpoint, specify:
- Request/response schemas
- Authentication requirements
- Rate limiting
- Error responses

Save to openspec.yaml and generate docs/specification/api-contracts.md
```

**Generated OpenAPI Structure**:

```yaml
# openspec.yaml
openapi: 3.0.0
info:
  title: Task Board API
  version: 1.0.0
  description: Real-time collaborative task management

paths:
  /auth/login:
    post:
      summary: User login
      requestBody:
        content:
          application/json:
            schema:
              type: object
              required: [email, password]
              properties:
                email: { type: string, format: email }
                password: { type: string, format: password }
      responses:
        200:
          content:
            application/json:
              schema:
                type: object
                properties:
                  accessToken: { type: string }
                  refreshToken: { type: string }
                  user: { $ref: '#/components/schemas/User' }

  /tasks:
    get:
      summary: List tasks
      parameters:
        - name: boardId
          in: query
          required: true
          schema: { type: string }
      responses:
        200:
          content:
            application/json:
              schema:
                type: array
                items: { $ref: '#/components/schemas/Task' }

    post:
      summary: Create task
      requestBody:
        content:
          application/json:
            schema: { $ref: '#/components/schemas/TaskCreate' }
      responses:
        201:
          content:
            application/json:
              schema: { $ref: '#/components/schemas/Task' }

  /tasks/{id}:
    get:
      summary: Get task by ID
      parameters:
        - name: id
          in: path
          required: true
          schema: { type: string }
    patch:
      summary: Update task
    delete:
      summary: Delete task

  /tasks/{id}/move:
    post:
      summary: Move task to column
      requestBody:
        content:
          application/json:
            schema:
              type: object
              required: [columnId, position]
              properties:
                columnId: { type: string }
                position: { type: integer }

  /ws/connect:
    get:
      summary: WebSocket connection
      description: Upgrades to WebSocket protocol

components:
  schemas:
    User:
      type: object
      properties:
        id: { type: string, format: uuid }
        email: { type: string, format: email }
        name: { type: string }
        avatar: { type: string, format: uri }

    Task:
      type: object
      properties:
        id: { type: string, format: uuid }
        title: { type: string, minLength: 1, maxLength: 200 }
        description: { type: string }
        columnId: { type: string }
        position: { type: integer }
        tags: { type: array, items: { type: string } }
        assigneeId: { type: string, format: uuid }
        createdBy: { type: string, format: uuid }
        createdAt: { type: string, format: date-time }
        updatedAt: { type: string, format: date-time }

  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
```

### Step 2: Frontend Component Design

**NLP Prompt**:
```
Design the frontend component structure using HeroUI and Tailwind CSS.

Create component hierarchy for:
1. TaskBoard (main container)
2. Column (vertical task list)
3. TaskCard (draggable task)
4. PresenceIndicator (user avatars)
5. AuthModal (login/signup)

Include:
- Component props interfaces
- State management approach
- Animation specifications (Framer Motion)
- Responsive breakpoints

Save to docs/specification/components.md
```

**Generated Component Structure**:

```typescript
// Component hierarchy
interface ComponentSpec {
  TaskBoard: {
    props: {
      boardId: string;
      readonly?: boolean;
    };
    state: {
      tasks: Task[];
      columns: Column[];
      presences: Presence[];
      connected: boolean;
    };
    children: ['Column'];
  };

  Column: {
    props: {
      columnId: string;
      title: string;
      position: number;
    };
    children: ['TaskCard', 'AddTaskButton'];
    animations: ['slideIn', 'reorder'];
  };

  TaskCard: {
    props: {
      task: Task;
      draggable: boolean;
    };
    children: ['TaskTitle', 'TaskDescription', 'TaskTags', 'TaskAssignee'];
    animations: ['hover', 'drag', 'drop'];
    dragEvents: ['onDragStart', 'onDragEnd', 'onDrop'];
  };

  PresenceIndicator: {
    props: {
      users: User[];
      maxVisible?: number;
    };
    animations: ['pulse', 'avatarAppear'];
  };
}

// Responsive breakpoints
const breakpoints = {
  mobile: '375px',
  tablet: '768px',
  desktop: '1024px',
  wide: '1280px',
};
```

### Step 3: Test Specification

**NLP Prompt**:
```
Generate comprehensive test specifications covering:

Unit Tests:
- Task aggregate invariants
- JWT token generation/validation
- WebSocket connection management
- Domain event emission

Integration Tests:
- API endpoint contracts
- WebSocket message flow
- Database transaction boundaries
- Redis pub/sub propagation

E2E Tests:
- Complete user workflows
- Multi-user collaboration
- Authentication flows
- Error scenarios

Save to docs/specification/test-plan.md
```

### Step 4: ruvLLM Code Generation Preparation

**Bash Commands**:
```bash
# Store component patterns for ruvLLM
ruv-remember -t component "TaskBoard: columns array with drag-drop reordering"
ruv-remember -t component "TaskCard: draggable with Framer Motion animations"
ruv-remember -t component "PresenceIndicator: avatar stack with pulse animation"

# Store API patterns
ruv-remember -t api "REST with JWT bearer auth, 15min TTL"
ruv-remember -t api "WebSocket upgrade with token query param"

# Store testing patterns
ruv-remember -t test "Vitest for unit, Supertest for integration, Playwright for E2E"
```

### Step 5: QE Pipeline - Specification Validation

**Bash Commands**:
```bash
# Validate API specifications
npx -y agentic-qe validate --mode api \
  --spec-file openspec.yaml

# Expected output: API specification validation
# - Endpoint completeness: 12/12 PASS
# - Schema consistency: PASS
# - Authentication coverage: PASS
# - Error response coverage: PASS

# Validate component specifications
npx -y agentic-qe validate --mode frontend \
  --spec-file docs/specification/components.md
```

---

## Phase 3: Implementation

**Duration**: 2-4 hours

### Step 1: Initialize Swarm Coordination

**NLP Prompt**:
```
Initialize a hierarchical-mesh swarm with specialized agents:
1. Coordinator - orchestrates implementation
2. Architect - ensures design consistency
3. Backend Developer - implements API and WebSocket
4. Frontend Developer - implements React components
5. Security Architect - implements security patterns
6. Tester - writes tests alongside code

Store coordination state in RuVector memory for cross-agent communication.
```

**Bash Commands**:
```bash
# Initialize hierarchical-mesh swarm (V3 queen + peer communication)
cf-swarm

# Alternative for smaller teams (6-8 agents)
npx -y claude-flow@v3alpha swarm init \
  --topology hierarchical \
  --max-agents 8 \
  --strategy specialized \
  --consensus raft

# Verify swarm status
npx -y claude-flow@v3alpha swarm status
```

### Step 2: ruvLLM-Assisted Backend Implementation

**NLP Prompt**:
```
Implement the backend using ruvLLM for intelligent code generation:

1. Generate TypeScript interfaces from OpenAPI spec
2. Implement authentication middleware with JWT
3. Create WebSocket server with heartbeat
4. Implement task CRUD endpoints
5. Add Redis pub/sub for real-time sync
6. Write repository layer with PostgreSQL
7. Implement domain event dispatching

Use ruvLLM to:
- Suggest optimal implementations based on learned patterns
- Generate boilerplate code
- Apply security best practices automatically
- Include error handling patterns

Store all code in src/backend/
```

**Generated Backend Structure**:

```typescript
// src/backend/server.ts
import express from 'express';
import { createServer } from 'http';
import { WebSocketServer, WebSocket } from 'ws';
import jwt from 'jsonwebtoken';
import Redis from 'ioredis';

const app = express();
const server = createServer(app);
const wss = new WebSocketServer({ server, path: '/ws' });
const redis = new Redis(process.env.REDIS_URL);
const pubsub = redis.duplicate();

// JWT Authentication middleware
app.use('/api', (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) return res.status(401).json({ error: 'No token' });

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch (err) {
    return res.status(401).json({ error: 'Invalid token' });
  }
});

// WebSocket connection handling
wss.on('connection', (ws: WebSocket, req) => {
  const token = new URL(req.url, 'http://localhost').searchParams.get('token');

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const userId = decoded.sub;

    // Store connection
    wsStore.set(userId, ws);

    // Send presence event
    broadcast({
      type: 'USER_JOINED',
      userId,
      timestamp: new Date(),
    });

    // Heartbeat
    ws.isAlive = true;
    ws.on('pong', () => ws.isAlive = true);

    // Message handling
    ws.on('message', async (data) => {
      const message = JSON.parse(data.toString());
      await handleWebSocketMessage(userId, message, ws);
    });

    // Cleanup on disconnect
    ws.on('close', () => {
      wsStore.delete(userId);
      broadcast({
        type: 'USER_LEFT',
        userId,
        timestamp: new Date(),
      });
    });
  } catch (err) {
    ws.close();
  }
});

// Redis pub/sub for multi-server sync
pubsub.subscribe('task-events', (err) => {
  if (err) console.error('Redis subscribe error:', err);
});

pubsub.on('message', (channel, message) => {
  if (channel === 'task-events') {
    const event = JSON.parse(message);
    broadcast(event);
  }
});

// Broadcast to all connected clients
function broadcast(event: any) {
  const data = JSON.stringify(event);
  wsStore.forEach((ws) => {
    if (ws.readyState === WebSocket.OPEN) {
      ws.send(data);
    }
  });
}

// Heartbeat interval
const interval = setInterval(() => {
  wsStore.forEach((ws) => {
    if (!ws.isAlive) return ws.terminate();
    ws.isAlive = false;
    ws.ping();
  });
}, 30000);

wss.on('close', () => clearInterval(interval));

// API Routes
app.use('/api/auth', authRoutes);
app.use('/api/tasks', taskRoutes);
app.use('/api/boards', boardRoutes);
app.use('/api/presence', presenceRoutes);
app.use('/api/audit', auditRoutes);

server.listen(3000, () => {
  console.log('Server running on port 3000');
});

// Heartbeat interval
const interval = setInterval(() => {
  wss.clients.forEach((ws) => {
    if (!ws.isAlive) return ws.terminate();
    ws.isAlive = false;
    ws.ping();
  });
}, 30000);

wss.on('close', () => clearInterval(interval));

export { app, server, wss };
```

**ruvLLM Integration Example**:

```typescript
// Using ruvLLM for intelligent code suggestions
import { ruvLLM } from '@ruvector/llm';

// Get intelligent code completion based on context
const completion = await ruvLLM.complete({
  context: {
    file: 'src/backend/routes/tasks.ts',
    cursor: { line: 45, column: 12 },
    patterns: ['task-crud', 'jwt-auth', 'error-handling'],
  },
  prompt: 'Implement POST /api/tasks endpoint with validation',
});

// ruvLLM suggests:
// 1. Zod schema for request validation
// 2. JWT user extraction from middleware
// 3. Task aggregate creation with invariants
// 4. Domain event emission
// 5. Redis pub/sub broadcast
// 6. Proper error handling
```

### Step 3: Frontend Implementation with HeroUI

**NLP Prompt**:
```
Implement the frontend React application using:
- HeroUI component library
- Tailwind CSS for styling
- Framer Motion for animations
- React Query for data fetching
- Zustand for state management
- WebSocket client for real-time updates

Create components:
1. TaskBoard - main container
2. Column - task list
3. TaskCard - draggable task
4. PresenceIndicator - user avatars
5. AuthModal - login

Store all code in src/frontend/
```

**Generated Frontend Structure**:

```typescript
// src/frontend/components/TaskBoard.tsx
import { Card, CardBody } from '@heroui/react';
import { motion, AnimatePresence } from 'framer-motion';
import { useTaskBoard } from '@/hooks/useTaskBoard';
import { useWebSocket } from '@/hooks/useWebSocket';
import { Column } from './Column';
import { PresenceIndicator } from './PresenceIndicator';

export function TaskBoard({ boardId }: { boardId: string }) {
  const { tasks, columns, isLoading } = useTaskBoard(boardId);
  const { connected, presences } = useWebSocket(boardId);

  if (isLoading) {
    return <div className="flex justify-center p-8">
      <Spinner size="lg" />
    </div>;
  }

  return (
    <div className="h-screen bg-background">
      {/* Header */}
      <header className="border-b px-6 py-4">
        <div className="flex items-center justify-between">
          <h1 className="text-2xl font-bold">Task Board</h1>
          <PresenceIndicator users={presences} />
        </div>
        <ConnectionStatus connected={connected} />
      </header>

      {/* Board */}
      <main className="flex gap-4 p-6 overflow-x-auto">
        <AnimatePresence mode="popLayout">
          {columns.map((column) => (
            <motion.div
              key={column.id}
              layout
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: 20 }}
              transition={{ duration: 0.2 }}
            >
              <Column
                columnId={column.id}
                title={column.title}
                tasks={tasks.filter(t => t.columnId === column.id)}
              />
            </motion.div>
          ))}
        </AnimatePresence>
      </main>
    </div>
  );
}

// src/frontend/components/TaskCard.tsx
import { Card, CardBody, Chip, User } from '@heroui/react';
import { motion } from 'framer-motion';
import { useDrag } from '@dnd-kit/core';

export function TaskCard({ task, draggable = true }: TaskCardProps) {
  const { attributes, listeners, setNodeRef, isDragging } = useDrag({
    id: task.id,
    disabled: !draggable,
    data: { task },
  });

  return (
    <motion.div
      ref={setNodeRef}
      layout
      initial={{ opacity: 0, scale: 0.95 }}
      animate={{ opacity: 1, scale: 1 }}
      exit={{ opacity: 0, scale: 0.95 }}
      whileHover={{ scale: 1.02 }}
      whileDrag={{ scale: 1.05, rotate: 2 }}
      transition={{ duration: 0.2 }}
      className="mb-2"
    >
      <Card
        isPressable
        className={isDragging ? 'shadow-lg' : ''}
        {...attributes}
        {...listeners}
      >
        <CardBody className="p-4">
          <h3 className="font-semibold mb-2">{task.title}</h3>
          {task.description && (
            <p className="text-sm text-foreground-600 mb-3">
              {task.description}
            </p>
          )}
          {task.tags.length > 0 && (
            <div className="flex gap-1 mb-3 flex-wrap">
              {task.tags.map(tag => (
                <Chip key={tag} size="sm" variant="flat">
                  {tag}
                </Chip>
              ))}
            </div>
          )}
          {task.assignee && (
            <User
              avatarProps={{
                src: task.assignee.avatar,
                size: 'sm',
              }}
              name={task.assignee.name}
              className="text-sm"
            />
          )}
        </CardBody>
      </Card>
    </motion.div>
  );
}

// src/frontend/components/PresenceIndicator.tsx
import { Avatar, AvatarGroup } from '@heroui/react';
import { motion } from 'framer-motion';

export function PresenceIndicator({ users, maxVisible = 5 }: PresenceIndicatorProps) {
  const visible = users.slice(0, maxVisible);
  const overflow = users.length - maxVisible;

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="flex items-center gap-2"
    >
      <AvatarGroup max={maxVisible}>
        {visible.map((user) => (
          <motion.div
            key={user.id}
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            exit={{ scale: 0 }}
            transition={{ type: 'spring', stiffness: 500, damping: 30 }}
          >
            <Avatar
              src={user.avatar}
              name={user.name}
              isBordered
              color="success"
              size="sm"
            />
          </motion.div>
        ))}
      </AvatarGroup>
      {overflow > 0 && (
        <span className="text-sm text-foreground-600">+{overflow}</span>
      )}
    </motion.div>
  );
}

// src/frontend/hooks/useWebSocket.ts
import { useEffect, useState } from 'react';
import { useTaskBoardStore } from '@/stores/taskBoard';

export function useWebSocket(boardId: string) {
  const [connected, setConnected] = useState(false);
  const [presences, setPresences] = useState<User[]>([]);
  const updateTask = useTaskBoardStore(s => s.updateTask);
  const addTask = useTaskBoardStore(s => s.addTask);
  const deleteTask = useTaskBoardStore(s => s.deleteTask);

  useEffect(() => {
    const token = localStorage.getItem('accessToken');
    const ws = new WebSocket(`ws://localhost:3000/ws?token=${token}`);

    ws.onopen = () => setConnected(true);
    ws.onclose = () => setConnected(false);

    ws.onmessage = (event) => {
      const message = JSON.parse(event.data);

      switch (message.type) {
        case 'TASK_CREATED':
          addTask(message.task);
          break;
        case 'TASK_UPDATED':
          updateTask(message.task);
          break;
        case 'TASK_MOVED':
          updateTask(message.task);
          break;
        case 'TASK_DELETED':
          deleteTask(message.taskId);
          break;
        case 'USER_JOINED':
        case 'USER_LEFT':
        case 'PRESENCE_UPDATE':
          setPresences(prev => {
            const exists = prev.find(u => u.id === message.userId);
            if (message.type === 'USER_JOINED' && !exists) {
              return [...prev, message.user];
            } else if (message.type === 'USER_LEFT') {
              return prev.filter(u => u.id !== message.userId);
            }
            return prev;
          });
          break;
      }
    };

    return () => ws.close();
  }, [boardId]);

  return { connected, presences };
}
```

### Step 4: QE Pipeline - Implementation Validation

**NLP Prompt**:
```
Run QE pipeline to validate implementation:
1. Check code follows ADR decisions
2. Verify DDD invariants are enforced
3. Validate security patterns implemented
4. Check API matches OpenAPI spec
5. Verify component specs implemented
6. Run linter and type checker
7. Generate implementation coverage report
```

**Bash Commands**:
```bash
# Generate tests with Agentic QE
npx -y agentic-qe generate --coverage 80 --target src/

# Run quality gate
npx -y agentic-qe gate --report

# Expected output:
# ┌─────────────────────────────────────┐
# │ Quality Gate Report                 │
# ├─────────────────────────────────────┤
# │ Build Status:        ✅ PASS        │
# │ Type Errors:         0              │
# │ Linting:             ✅ PASS        │
# │ Test Coverage:       82% (target: 80%)│
# │ Critical Vulns:      0              │
# │ API Spec Compliance: ✅ PASS        │
# │ ADR Compliance:      ✅ PASS        │
# │ DDD Invariants:      ✅ ENFORCED    │
# └─────────────────────────────────────┘
```

---

## Phase 4: QE Verification

**Duration**: 30-45 minutes

### Step 1: Generate Comprehensive Test Suite

**NLP Prompt**:
```
Generate comprehensive tests using Agentic QE's 19 testing agents:

Unit Tests (Vitest):
- Task aggregate invariant tests
- JWT token generation/validation
- WebSocket connection manager
- Repository CRUD operations
- Domain event dispatching

Integration Tests (Supertest):
- API endpoint contracts
- WebSocket message flow
- Database transactions
- Redis pub/sub propagation
- Authentication flows

E2E Tests (Playwright):
- Complete user workflows
- Multi-user collaboration scenarios
- Drag-and-drop interactions
- Real-time updates
- Error handling

Store tests in tests/
```

**Generated Test Structure**:

```typescript
// tests/unit/task.aggregate.test.ts
import { describe, it, expect } from 'vitest';
import { Task } from '@/src/backend/aggregates/Task';

describe('Task Aggregate', () => {
  describe('Invariants', () => {
    it('should require title (1-200 chars)', () => {
      expect(() => Task.create({ title: '' })).toThrow();
      expect(() => Task.create({ title: 'a'.repeat(201) })).toThrow();
      expect(() => Task.create({ title: 'Valid Title' })).not.toThrow();
    });

    it('should enforce max 100 tasks per board', () => {
      const boardId = 'test-board';
      const tasks = Array.from({ length: 100 }, () =>
        Task.create({ boardId, title: `Task ${Math.random()}` })
      );
      expect(() =>
        Task.create({ boardId, title: 'Task 101' })
      ).toThrow('MAX_TASKS_EXCEEDED');
    });

    it('should enforce position uniqueness within column', () => {
      const columnId = 'col-1';
      Task.create({ columnId, position: 1, title: 'Task 1' });
      expect(() =>
        Task.create({ columnId, position: 1, title: 'Task 2' })
      ).toThrow('POSITION_NOT_UNIQUE');
    });
  });

  describe('Domain Events', () => {
    it('should emit TaskCreated event on creation', () => {
      const task = Task.create({ title: 'New Task' });
      expect(task.getUncommittedEvents()).toHaveLength(1);
      expect(task.getUncommittedEvents()[0].type).toBe('TASK_CREATED');
    });

    it('should emit TaskMoved event on move', () => {
      const task = Task.create({ title: 'Task', columnId: 'col-1' });
      task.moveTo('col-2', 5);
      const events = task.getUncommittedEvents();
      expect(events.some(e => e.type === 'TASK_MOVED')).toBe(true);
    });
  });
});

// tests/integration/api/tasks.test.ts
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import request from 'supertest';
import { app } from '@/src/backend/server';

describe('POST /api/tasks', () => {
  let authToken: string;

  beforeAll(async () => {
    const response = await request(app)
      .post('/api/auth/login')
      .send({ email: 'test@example.com', password: 'password123' });
    authToken = response.body.accessToken;
  });

  it('should create task with valid data', async () => {
    const response = await request(app)
      .post('/api/tasks')
      .set('Authorization', `Bearer ${authToken}`)
      .send({
        title: 'Test Task',
        description: 'Test Description',
        columnId: 'col-1',
        position: 1,
      })
      .expect(201);

    expect(response.body).toMatchObject({
      id: expect.any(String),
      title: 'Test Task',
      description: 'Test Description',
      columnId: 'col-1',
      position: 1,
    });
  });

  it('should reject without auth token', async () => {
    await request(app)
      .post('/api/tasks')
      .send({ title: 'Test' })
      .expect(401);
  });

  it('should validate title length', async () => {
    await request(app)
      .post('/api/tasks')
      .set('Authorization', `Bearer ${authToken}`)
      .send({ title: '', columnId: 'col-1' })
      .expect(400);
  });
});

// tests/e2e/collaboration.spec.ts
import { test, expect } from '@playwright/test';

test.describe('Multi-user Collaboration', () => {
  test('should show real-time updates when user moves task', async ({ browser }) => {
    // Create two browser contexts (two users)
    const context1 = await browser.newContext();
    const context2 = await browser.newContext();

    const page1 = await context1.newPage();
    const page2 = await context2.newPage();

    // Login both users
    await loginAs(page1, 'user1@example.com');
    await loginAs(page2, 'user2@example.com');

    // Both navigate to board
    await page1.goto('http://localhost:3000/board/test-board');
    await page2.goto('http://localhost:3000/board/test-board');

    // User1 moves a task
    await page1.dragAndDrop(
      '[data-task-id="task-1"]',
      '[data-column-id="col-2"]'
    );

    // User2 should see the update in real-time
    await expect(page2.locator('[data-task-id="task-1"]'))
      .toBeAttachedTo('[data-column-id="col-2"]', { timeout: 2000 });
  });

  test('should show presence indicators', async ({ page }) => {
    await page.goto('http://localhost:3000/board/test-board');

    // Should show presence indicator
    await expect(page.locator('[data-testid="presence-indicator"]'))
      .toBeVisible();

    // Should show user avatars
    await expect(page.locator('[data-testid="user-avatar"]'))
      .toHaveCount(await getPresenceCount());
  });
});

// Helper functions
async function loginAs(page: Page, email: string) {
  await page.goto('http://localhost:3000/login');
  await page.fill('[name="email"]', email);
  await page.fill('[name="password"]', 'password123');
  await page.click('[type="submit"]');
  await page.waitForURL('http://localhost:3000/dashboard');
}
```

### Step 2: Run Quality Gate

**Bash Commands**:
```bash
# Run all tests
npm test

# Run with coverage
npm run test:coverage

# Run quality gate
aqe-gate --report

# Expected output:
# ┌──────────────────────────────────────────┐
# │ Quality Gate Results                     │
# ├──────────────────────────────────────────┤
# │ Unit Tests:           142/142 PASS 100%   │
# │ Integration Tests:    48/48 PASS 100%     │
# │ E2E Tests:            23/23 PASS 100%     │
# │ Coverage:             82.3% (target: 80%) │
# │ Critical Paths:       100% covered       │
# │ Performance:          <100ms p95          │
# └──────────────────────────────────────────┘
```

---

## Phase 5: Integration Testing

**Duration**: 45-60 minutes

### Step 1: WebSocket Integration Test

**NLP Prompt**:
```
Test WebSocket integration with ruvbrowswer:

1. Connect multiple clients (10 concurrent)
2. Test message broadcasting
3. Test presence updates
4. Test reconnection handling
5. Test heartbeat mechanism
6. Measure message latency

Create integration test suite in tests/integration/websocket/
```

**Generated WebSocket Test**:

```typescript
// tests/integration/websocket/multi-client.test.ts
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { WebSocket } from 'ws';
import jwt from 'jsonwebtoken';

describe('WebSocket Multi-Client Integration', () => {
  const clients: WebSocket[] = [];
  const messages: any[] = [];

  beforeAll(() => {
    // Create 10 concurrent clients
    for (let i = 0; i < 10; i++) {
      const token = jwt.sign(
        { sub: `user-${i}` },
        process.env.JWT_SECRET,
        { expiresIn: '15m' }
      );

      const ws = new WebSocket(`ws://localhost:3000/ws?token=${token}`);

      ws.on('message', (data) => {
        messages.push(JSON.parse(data.toString()));
      });

      clients.push(ws);
    }

    // Wait for all connections
    return Promise.all(clients.map(ws =>
      new Promise(resolve => ws.on('open', resolve))
    ));
  });

  afterAll(() => {
    clients.forEach(ws => ws.close());
  });

  it('should broadcast messages to all clients', async () => {
    const client = clients[0];
    client.send(JSON.stringify({
      type: 'TASK_CREATED',
      task: { id: 'task-1', title: 'Test Task' },
    }));

    // Wait for broadcast
    await new Promise(resolve => setTimeout(resolve, 100));

    // All 10 clients should receive the message
    const received = messages.filter(m => m.type === 'TASK_CREATED');
    expect(received).toHaveLength(10);
  });

  it('should handle presence updates', async () => {
    // Check initial presence
    const joinMessages = messages.filter(m => m.type === 'USER_JOINED');
    expect(joinMessages).toHaveLength(10);
  });

  it('should maintain connection with heartbeat', async () => {
    // Wait for heartbeat interval
    await new Promise(resolve => setTimeout(resolve, 35000));

    // All clients should still be connected
    clients.forEach(ws => {
      expect(ws.readyState).toBe(WebSocket.OPEN);
    });
  });
});
```

### Step 2: Database Integration Test

**NLP Prompt**:
```
Test database integration:
1. Transaction rollback on error
2. Concurrent modification handling
3. Audit trail creation
4. Soft delete behavior
5. Aggregate consistency

Create tests in tests/integration/database/
```

### Step 3: Redis Integration Test

```typescript
// tests/integration/redis/pubsub.test.ts
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import Redis from 'ioredis';

describe('Redis Pub/Sub Integration', () => {
  const publishers: Redis[] = [];
  const subscribers: Redis[] = [];

  beforeAll(() => {
    // Create 3 publishers and 3 subscribers
    for (let i = 0; i < 3; i++) {
      publishers.push(new Redis(process.env.REDIS_URL));
      const sub = new Redis(process.env.REDIS_URL);
      await sub.subscribe('task-events');
      subscribers.push(sub);
    }
  });

  afterAll(async () => {
    await Promise.all([
      ...publishers.map(p => p.quit()),
      ...subscribers.map(s => s.quit()),
    ]);
  });

  it('should broadcast to all subscribers', async () => {
    const event = { type: 'TASK_CREATED', task: { id: 'task-1' } };
    const received: any[] = [];

    subscribers.forEach(sub => {
      sub.on('message', (channel, message) => {
        received.push(JSON.parse(message));
      });
    });

    // Publish from first publisher
    await publishers[0].publish('task-events', JSON.stringify(event));

    // Wait for propagation
    await new Promise(resolve => setTimeout(resolve, 100));

    // All 3 subscribers should receive
    expect(received).toHaveLength(3);
    received.forEach(r => {
      expect(r.task.id).toBe('task-1');
    });
  });
});
```

### Step 4: QE Pipeline - Integration Validation

**Bash Commands**:
```bash
# Run integration tests
npm run test:integration

# QE validation
npx -y agentic-qe validate --mode integration

# Expected output:
# ┌─────────────────────────────────────┐
# │ Integration Test Results            │
# ├─────────────────────────────────────┤
# │ WebSocket:        ✅ 10/10 PASS     │
# │ Database:         ✅ 15/15 PASS     │
# │ Redis:            ✅ 8/8 PASS       │
# │ API Contracts:    ✅ 12/12 PASS     │
# │ Message Latency:  ✅ <50ms avg      │
# └─────────────────────────────────────┘
```

---

## Phase 6: Load Testing (100 Users)

**Duration**: 60-90 minutes

### Step 1: Prepare Load Test Scripts

**NLP Prompt**:
```
Create load test using ruvbrowswer to simulate 100 concurrent users:

Test Scenarios:
1. 100 users connect simultaneously
2. 50 users create tasks concurrently
3. 30 users drag-drop tasks simultaneously
4. Measure WebSocket message latency under load
5. Test reconnection behavior under load
6. Monitor memory and CPU usage

Create scripts in tests/load/
```

**Generated Load Test Script**:

```typescript
// tests/load/100-users.simulation.ts
import { chromium, Browser, BrowserContext, Page } from 'playwright';
import { performance } from 'perf_hooks';

interface LoadTestConfig {
  users: number;
  baseUrl: string;
  duration: number; // seconds
}

interface LoadTestMetrics {
  connectTime: number[];
  messageLatency: number[];
  operations: {
    creates: number;
    moves: number;
    updates: number;
  };
  errors: {
    connections: number;
    operations: number;
  };
}

export async function run100UserSimulation(
  config: LoadTestConfig
): Promise<LoadTestMetrics> {
  const browser = await chromium.connect(config.baseUrl);
  const contexts: BrowserContext[] = [];
  const pages: Page[] = [];
  const metrics: LoadTestMetrics = {
    connectTime: [],
    messageLatency: [],
    operations: { creates: 0, moves: 0, updates: 0 },
    errors: { connections: 0, operations: 0 },
  };

  // Phase 1: Connect 100 users
  console.log('Phase 1: Connecting 100 users...');
  const connectPromises: Promise<void>[] = [];

  for (let i = 0; i < config.users; i++) {
    connectPromises.push((async (userId: number) => {
      try {
        const start = performance.now();

        const context = await browser.newContext({
          storageState: {
            cookies: [{
              name: 'auth_token',
              value: `test-token-${userId}`,
              domain: 'localhost',
              path: '/',
            }],
          },
        });

        const page = await context.newPage();
        await page.goto(`${config.baseUrl}/board/test-board`);

        const connectTime = performance.now() - start;
        metrics.connectTime.push(connectTime);

        contexts.push(context);
        pages.push(page);

        // Setup message listener for latency measurement
        await page.evaluate(() => {
          window.messageLatencies = [];
          window.addEventListener('ws-message', (e) => {
            const latency = Date.now() - e.detail.timestamp;
            window.messageLatencies.push(latency);
          });
        });

      } catch (err) {
        metrics.errors.connections++;
      }
    })(i));
  }

  await Promise.all(connectPromises);

  console.log(`Connected: ${pages.length} users`);
  console.log(`Avg connect time: ${avg(metrics.connectTime).toFixed(2)}ms`);

  // Phase 2: Concurrent task creation (50 users)
  console.log('Phase 2: 50 users creating tasks...');
  const createPromises: Promise<void>[] = [];

  for (let i = 0; i < 50; i++) {
    createPromises.push((async (userId: number) => {
      try {
        const page = pages[userId];
        await page.click('[data-testid="add-task-button"]');
        await page.fill('[data-testid="task-title"]', `Load Test Task ${userId}`);
        await page.click('[data-testid="save-task"]');

        // Wait for confirmation
        await page.waitForSelector('[data-testid="task-created-toast"]');
        metrics.operations.creates++;

      } catch (err) {
        metrics.errors.operations++;
      }
    })(i));
  }

  await Promise.all(createPromises);
  console.log(`Created: ${metrics.operations.creates} tasks`);

  // Phase 3: Concurrent drag-drop (30 users)
  console.log('Phase 3: 30 users moving tasks...');
  const movePromises: Promise<void>[] = [];

  for (let i = 0; i < 30; i++) {
    movePromises.push((async (userId: number) => {
      try {
        const page = pages[userId];
        const task = pages[userId].locator('[data-task-id]').first();
        const targetColumn = pages[userId].locator('[data-column-id="col-2"]');

        await task.dragTo(targetColumn);
        metrics.operations.moves++;

      } catch (err) {
        metrics.errors.operations++;
      }
    })(i));
  }

  await Promise.all(movePromises);
  console.log(`Moved: ${metrics.operations.moves} tasks`);

  // Phase 4: Collect message latencies
  console.log('Phase 4: Collecting metrics...');
  for (const page of pages) {
    const latencies = await page.evaluate(() => window.messageLatencies || []);
    metrics.messageLatency.push(...latencies);
  }

  // Cleanup
  for (const context of contexts) {
    await context.close();
  }

  return metrics;
}

// Helper functions
function avg(arr: number[]): number {
  return arr.reduce((a, b) => a + b, 0) / arr.length;
}

function p95(arr: number[]): number {
  const sorted = arr.sort((a, b) => a - b);
  return sorted[Math.floor(sorted.length * 0.95)];
}

function p99(arr: number[]): number {
  const sorted = arr.sort((a, b) => a - b);
  return sorted[Math.floor(sorted.length * 0.99)];
}

// Run and report
async function main() {
  console.log('Starting 100-user load simulation...');

  const metrics = await run100UserSimulation({
    users: 100,
    baseUrl: 'http://localhost:3000',
    duration: 300,
  });

  console.log('\n┌─────────────────────────────────────────────┐');
  console.log('│ Load Test Results                           │');
  console.log('├─────────────────────────────────────────────┤');
  console.log(`│ Connections:     ${metrics.connectTime.length}/100    │`);
  console.log(`│ Errors:          ${metrics.errors.connections} connections, ${metrics.errors.operations} operations │`);
  console.log(`├─────────────────────────────────────────────┤`);
  console.log(`│ Connect Time:                                    │`);
  console.log(`│   Avg:    ${avg(metrics.connectTime).toFixed(2).padStart(10)}ms                       │`);
  console.log(`│   P95:    ${p95(metrics.connectTime).toFixed(2).padStart(10)}ms                       │`);
  console.log(`│   P99:    ${p99(metrics.connectTime).toFixed(2).padStart(10)}ms                       │`);
  console.log(`├─────────────────────────────────────────────┤`);
  console.log(`│ Message Latency:                                 │`);
  console.log(`│   Avg:    ${avg(metrics.messageLatency).toFixed(2).padStart(10)}ms                       │`);
  console.log(`│   P95:    ${p95(metrics.messageLatency).toFixed(2).padStart(10)}ms                       │`);
  console.log(`│   P99:    ${p99(metrics.messageLatency).toFixed(2).padStart(10)}ms                       │`);
  console.log(`├─────────────────────────────────────────────┤`);
  console.log(`│ Operations:                                      │`);
  console.log(`│   Creates: ${metrics.operations.creates.toString().padStart(5)}                        │`);
  console.log(`│   Moves:   ${metrics.operations.moves.toString().padStart(5)}                        │`);
  console.log(`└─────────────────────────────────────────────┘`);

  // Validate against NFRs
  const targetLatency = 100; // ms
  const actualP95 = p95(metrics.messageLatency);

  if (actualP95 <= targetLatency) {
    console.log(`\n✅ PASS: P95 latency (${actualP95.toFixed(2)}ms) meets target (${targetLatency}ms)`);
  } else {
    console.log(`\n❌ FAIL: P95 latency (${actualP95.toFixed(2)}ms) exceeds target (${targetLatency}ms)`);
  }
}

// Run if executed directly
if (require.main === module) {
  main().catch(console.error);
}
```

### Step 2: ruvbrowswer Load Testing

**Alternative Approach using ruvbrowswer**:

```bash
# Use ruvbrowswer for distributed load testing
ab-open "http://localhost:3000/board/test-board" \
  --users 100 \
  --duration 300 \
  --scenario load-test \
  --metrics-file tests/load/results.json

# The load test scenario file: tests/load/scenario.js
```

**Load Test Scenario**:
```javascript
// tests/load/scenario.js
export default {
  name: '100-user concurrent access',
  users: 100,
  duration: 300, // 5 minutes
  rampUp: 30, // 30 seconds to full load

  actions: [
    {
      weight: 0.5,
      action: async (page) => {
        // Navigate to board
        await page.goto('http://localhost:3000/board/test-board');
        await page.waitForSelector('[data-testid="task-board"]');
      }
    },
    {
      weight: 0.3,
      action: async (page) => {
        // Create task
        await page.click('[data-testid="add-task"]');
        await page.fill('[data-testid="title"]', `Task ${Date.now()}`);
        await page.click('[data-testid="save"]');
      }
    },
    {
      weight: 0.15,
      action: async (page) => {
        // Move task
        const task = page.locator('[data-task-id]').first();
        const column = page.locator('[data-column-id="col-2"]');
        await task.dragTo(column);
      }
    },
    {
      weight: 0.05,
      action: async (page) => {
        // Update presence
        await page.hover('[data-testid="presence-indicator"]');
      }
    }
  ],

  metrics: {
    p95Latency: 100, // ms target
    errorRate: 0.01, // 1% max
    throughput: 1000, // ops/min target
  }
};
```

### Step 3: QE Pipeline - Load Test Validation

**Bash Commands**:
```bash
# Run load test
npm run test:load

# QE validation
npx -y agentic-qe validate --mode load \
  --results-file tests/load/results.json

# Expected output:
# ┌─────────────────────────────────────────────┐
# │ Load Test Validation                        │
# ├─────────────────────────────────────────────┤
# │ Concurrent Users:  100/100        ✅       │
# │ P95 Latency:       87ms/100ms     ✅       │
# │ P99 Latency:       124ms           PASS    │
# │ Error Rate:        0.23%/1%        ✅       │
# │ Throughput:        1245 ops/min    ✅       │
# │ Memory Usage:      512MB           OK      │
# │ CPU Usage:         45%             OK      │
# └─────────────────────────────────────────────┘
```

---

## Phase 7: Security Audit

**Duration**: 30-45 minutes

### Step 1: Run Security Analyzer

**Bash Commands**:
```bash
# Run comprehensive security scan
cf-security

# Or using security-analyzer skill
/security-analyzer scan \
  --path src/ \
  --output docs/security/scan-report.md \
  --format detailed

# CVE scan
npm audit
npx -y snyk test
```

**Security Scan Output**:
```
┌─────────────────────────────────────────────┐
│ Security Audit Report                       │
├─────────────────────────────────────────────┤
│ CVE Scan:              0 vulnerabilities   │
│ OWASP Top 10:          0 issues            │
│ Secrets Detected:      0                   │
│ Dependency Audit:      0 critical          │
│                        0 high              │
│                        2 moderate          │
│ Code Analysis:         PASS                │
│ Auth Implementation:   PASS                │
│ Input Validation:      PASS                │
│ SQL Injection:         PASS                │
│ XSS Prevention:        PASS                │
│ CSRF Protection:       PASS                │
│ Rate Limiting:         PASS                │
└─────────────────────────────────────────────┘
```

### Step 2: Manual Security Review

**NLP Prompt**:
```
Perform manual security review:

1. Authentication flows
2. Authorization checks
3. Input validation
4. Output encoding
5. Session management
6. Error handling (no information leakage)
7. Logging and monitoring
8. Secure headers

Document findings in docs/security/review.md
```

### Step 3: Penetration Testing

```bash
# Run automated penetration tests
npx -y zap-cli quick-scan \
  --self-contained \
  --start-options '-config api.disablekey=true' \
  http://localhost:3000

# Expected output: No high/critical vulnerabilities
```

---

## Phase 8: Documentation

**Duration**: 30 minutes

### Step 1: Generate Documentation with prd2build

**Bash Commands**:
```bash
# Generate complete documentation
/prd2build plans/research/task-board-pr.md

# Or via command line
npx -y claude-flow@v3alpha docs generate \
  --input plans/research/task-board-pr.md \
  --output docs/ \
  --format all
```

**Generated Documentation Structure**:

```
docs/
├── specification/
│   ├── requirements.md        # From Spec-Kit
│   ├── user-stories.md        # Generated from PR
│   └── api-contracts.md       # From OpenSpec
├── ddd/
│   ├── bounded-contexts.md    # DDD model
│   ├── aggregates.md
│   └── entities.md
├── adr/
│   ├── ADR-001.md            # Architecture decisions
│   ├── ADR-002.md
│   └── ...
│   ├── ADR-SEC-001.md        # Security decisions
│   └── ...
├── implementation/
│   └── INDEX.md              # Traceability matrix
├── security/
│   ├── scan-report.md        # Security scan results
│   └── review.md             # Manual security review
└── api/
    └── reference.md          # API reference
```

### Step 2: Traceability Matrix

**Generated INDEX.md**:

```markdown
# Implementation Traceability Matrix

## Requirements → Implementation → Tests

| FR | Requirement | ADR | Implementation | Test | Status |
|----|-------------|-----|----------------|------|--------|
| FR-001 | User Authentication | ADR-002 | `src/backend/auth/` | `tests/integration/auth/` | ✅ |
| FR-002 | WebSocket | ADR-001 | `src/backend/websocket/` | `tests/integration/websocket/` | ✅ |
| FR-003 | Task CRUD | ADR-003 | `src/backend/routes/tasks.ts` | `tests/integration/api/tasks/` | ✅ |
| FR-004 | Drag-Drop UI | - | `src/frontend/components/TaskCard.tsx` | `tests/e2e/drag-drop.spec.ts` | ✅ |
| FR-005 | Presence | ADR-001 | `src/backend/presence/` | `tests/integration/presence/` | ✅ |
| FR-006 | Audit Log | ADR-005 | `src/backend/audit/` | `tests/unit/audit.test.ts` | ✅ |
| NFR-001 | 100 Users | ADR-006 | Load balancer config | `tests/load/100-users.simulation.ts` | ✅ |
| NFR-002 | <100ms Latency | ADR-001 | Redis pub/sub | `tests/load/` | ✅ |

## Coverage Summary

- **Requirements Coverage**: 100% (8/8)
- **ADR Coverage**: 100% (6 ADRs implemented)
- **Test Coverage**: 82.3% (target: 80%)
- **Critical Paths**: 100% covered
```

### Step 3: API Documentation

```bash
# Generate API documentation
npx -y openspec generate \
  --input openspec.yaml \
  --output docs/api/reference.md \
  --format markdown
```

---

## Phase 9: Deployment

**Duration**: 45-60 minutes

### Step 1: Pre-Deployment Checklist

**NLP Prompt**:
```
Verify pre-deployment checklist:

1. ✅ All quality gates passed
2. ✅ Security scan clean
3. ✅ Load test passed (100 users, <100ms)
4. ✅ Documentation complete
5. ✅ Environment variables configured
6. ✅ Database migrations ready
7. ✅ Rollback plan documented
8. ✅ Monitoring configured

Generate deployment checklist in docs/deployment/checklist.md
```

**Generated Checklist**:

```markdown
# Deployment Checklist

## Pre-Deployment

- [ ] Quality gate passed (82.3% coverage)
- [ ] Security scan clean (0 vulnerabilities)
- [ ] Load test passed (100 users, 87ms P95)
- [ ] Documentation complete
- [ ] Environment variables set
- [ ] Database migrations prepared
- [ ] Secrets configured in vault
- [ ] Monitoring dashboards ready

## Deployment Steps

1. Create deployment branch
2. Run database migrations
3. Deploy to staging
4. Run smoke tests
5. Deploy to production (blue-green)
6. Verify health checks
7. Monitor for 15 minutes
8. Mark deployment complete

## Rollback Plan

If any critical issues detected:
1. Route traffic back to previous version
2. Investigate logs
3. Apply hotfix
4. Redeploy

## Post-Deployment

- [ ] Health checks passing
- [ ] Error rates < 1%
- [ ] Latency within SLA
- [ ] Monitor alerts configured
- [ ] Run book updated
```

### Step 2: Deploy to Staging

**Bash Commands**:
```bash
# Build Docker image
docker build -t task-board:latest .

# Tag for staging
docker tag task-board:latest registry.example.com/task-board:staging

# Push to registry
docker push registry.example.com/task-board:staging

# Deploy to staging
kubectl apply -f k8s/staging/
kubectl rollout status deployment/task-board-staging

# Run smoke tests
npm run test:smoke -- --env staging
```

### Step 3: Deploy to Production

**Bash Commands**:
```bash
# Blue-green deployment
kubectl apply -f k8s/production/blue/
kubectl wait --for=condition=ready pod -l app=task-board,env=blue

# Switch traffic
kubectl apply -f k8s/production/service-switch.yaml

# Monitor
kubectl logs -f deployment/task-board -n production

# Rollback if needed
kubectl rollout undo deployment/task-board
```

### Step 4: Post-Deployment Monitoring

**NLP Prompt**:
```
Monitor production deployment:
1. Check error rates
2. Monitor latency metrics
3. Verify WebSocket connections
4. Check database performance
5. Monitor Redis operations
6. Review security logs

Create monitoring dashboard in docs/deployment/monitoring.md
```

---

## NLP Prompt Reference

Complete reference of all NLP prompts used throughout the workflow:

### Phase 0: PR Creation
```
"Create a comprehensive Product Requirement document for a real-time
collaborative task board application with executive summary, problem
statement, target users, functional/non-functional requirements,
technical constraints, and success metrics."
```

### Phase 1: Architecture
```
"Create comprehensive Architecture Decision Records for WebSocket vs SSE,
JWT authentication, PostgreSQL design, Redis pub/sub, conflict resolution,
and scalability patterns with context, alternatives, decisions, and consequences."
```

### Phase 2: Specification
```
"Generate OpenAPI 3.0 specifications for task board API including
authentication, task CRUD, WebSocket, presence, and audit endpoints
with request/response schemas and error handling."
```

### Phase 3: Implementation
```
"Implement backend using ruvLLM for intelligent code generation:
TypeScript interfaces from OpenAPI, JWT middleware, WebSocket server,
task CRUD endpoints, Redis pub/sub, PostgreSQL repository, and domain events."
```

### Phase 4: QE Verification
```
"Generate comprehensive tests using Agentic QE: unit tests for
aggregates and invariants, integration tests for API and WebSocket,
E2E tests for user workflows and multi-user collaboration."
```

### Phase 5: Integration Testing
```
"Test WebSocket integration with 10 concurrent clients, message
broadcasting, presence updates, reconnection handling, heartbeat,
and message latency measurement."
```

### Phase 6: Load Testing
```
"Create load test using ruvbrowswer to simulate 100 concurrent users
connecting simultaneously, creating tasks, drag-drop operations,
measuring WebSocket latency under load, and testing reconnection."
```

### Phase 7: Security Audit
```
"Perform manual security review of authentication, authorization,
input validation, output encoding, session management, error handling,
logging, and secure headers."
```

### Phase 8: Documentation
```
"Generate complete documentation from PR including specification,
user stories, API contracts, DDD models, ADRs, traceability matrix,
and implementation index."
```

### Phase 9: Deployment
```
"Verify pre-deployment checklist including quality gates, security
scan, load test, documentation, environment configuration, migrations,
rollback plan, and monitoring setup."
```

---

## Summary

### Complete Workflow Timeline

| Phase | Duration | Key Outputs |
|-------|----------|-------------|
| Phase 0: PR Creation | 30 min | PR document, requirements in Spec-Kit |
| Phase 1: Architecture | 60-90 min | ADRs, DDD models, domain events |
| Phase 2: Design | 45-60 min | OpenAPI spec, component design, test plan |
| Phase 3: Implementation | 2-4 hrs | Backend API, frontend components, WebSocket |
| Phase 4: QE Verification | 30-45 min | Test suite (unit, integration, E2E) |
| Phase 5: Integration Testing | 45-60 min | WebSocket, database, Redis tests |
| Phase 6: Load Testing | 60-90 min | 100-user simulation, performance metrics |
| Phase 7: Security Audit | 30-45 min | Security scan, penetration test results |
| Phase 8: Documentation | 30 min | Complete docs with traceability |
| Phase 9: Deployment | 45-60 min | Staging and production deployment |

**Total Time**: 8-12 hours for complete feature development

### Tools Used Summary

| Tool | Purpose | Commands |
|------|---------|----------|
| **Spec-Kit** | Requirements | `sk-here`, `specify add/list/check` |
| **Claude Flow V3** | Swarm coordination | `cf-init`, `cf-swarm`, `cf-agent` |
| **RuVector** | Neural learning | `ruv-init`, `ruv-remember`, `ruv-recall`, `ruv-stats` |
| **ruvLLM** | Code generation | `ruvllm complete --context ...` |
| **Agentic QE** | Testing | `aqe-generate`, `aqe-gate` |
| **ruvbrowswer** | Load testing | `ab-open --users 100 --duration 300` |
| **Security Analyzer** | Security | `/security-analyzer scan` |
| **OpenSpec** | API specs | `os-init`, `openspec generate` |

### Success Metrics

All non-functional requirements met:
- ✅ **100 concurrent users** supported
- ✅ **87ms P95 latency** (target: <100ms)
- ✅ **0.23% error rate** (target: <1%)
- ✅ **82.3% test coverage** (target: ≥80%)
- ✅ **0 critical vulnerabilities**
- ✅ **100% requirements traceability**

---

**Version:** 2.0.2
**Last Updated:** 2026-01-22
**Generated by:** Turbo Flow with Claude Flow V3 Integration
