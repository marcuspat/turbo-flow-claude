# SPARC Methodology: Employee Attendance & Fleet Management Platform

## Project Overview
A web platform for managing employee attendance tracking and company vehicle usage with administrative reporting capabilities.

---

## Phase 1: Specification (Requirements Analysis)

### 1.1 Functional Requirements

#### Employee Attendance Module
- **User Stories:**
  - As an employee, I can clock in/out to record my work hours
  - As an employee, I can view my attendance history
  - As an administrator, I can view all employee attendance records
  - As an administrator, I can generate attendance reports

- **Features:**
  - Real-time clock in/out system
  - Automatic timestamp recording
  - Attendance history per employee
  - Late arrival/early departure detection
  - Break time tracking (optional)

#### Fleet Management Module
- **User Stories:**
  - As an employee, I can log vehicle usage (start/end)
  - As an employee, I can record mileage and project assignments
  - As an employee, I can log fuel refills
  - As an administrator, I can track all vehicle usage
  - As an administrator, I can monitor vehicle maintenance needs

- **Features:**
  - Vehicle check-out/check-in system
  - Mileage tracking
  - Project assignment per trip
  - Fuel consumption logging
  - Vehicle history per license plate
  - Maintenance alerts based on mileage

#### Reporting & Analytics Module
- **User Stories:**
  - As an administrator, I can generate attendance reports (daily/weekly/monthly)
  - As an administrator, I can export reports to CSV/PDF
  - As an administrator, I can view fleet utilization statistics
  - As an administrator, I can analyze fuel consumption trends

- **Features:**
  - Customizable date range reports
  - Export functionality (CSV, PDF, Excel)
  - Dashboard with key metrics
  - Visual charts and graphs
  - Search and filter capabilities

### 1.2 Technical Requirements

#### Architecture
- **Frontend:** Modern SPA framework (React/Vue/Angular)
- **Backend:** RESTful API (Node.js/Express or Python/Django)
- **Database:** Relational DB (PostgreSQL/MySQL)
- **Authentication:** JWT-based auth system
- **Deployment:** Docker containers + CI/CD pipeline

#### Non-Functional Requirements
- **Performance:** Page load < 2 seconds
- **Security:** Role-based access control (RBAC)
- **Scalability:** Support 100+ concurrent users
- **Availability:** 99.5% uptime
- **Data Backup:** Daily automated backups

### 1.3 SPARC Command
```bash
npx claude-flow sparc run spec-pseudocode "Employee Attendance & Fleet Management Platform"
```

---

## Phase 2: Pseudocode (Algorithm Design)

### 2.1 Attendance System Logic

```
FUNCTION clock_in(employee_id):
    current_time = get_current_timestamp()
    check IF employee already clocked in today:
        RETURN error "Already clocked in"

    CREATE attendance_record:
        employee_id = employee_id
        clock_in_time = current_time
        status = "active"

    SAVE to database
    RETURN success with record_id

FUNCTION clock_out(employee_id):
    current_time = get_current_timestamp()
    attendance_record = FIND active record for employee_id

    IF NOT found:
        RETURN error "No active clock-in found"

    UPDATE attendance_record:
        clock_out_time = current_time
        total_hours = calculate_hours(clock_in_time, current_time)
        status = "completed"

    SAVE to database
    RETURN success with total_hours

FUNCTION get_attendance_report(start_date, end_date, employee_id):
    records = QUERY attendance WHERE:
        date BETWEEN start_date AND end_date
        AND (employee_id = employee_id OR employee_id IS NULL)

    FOR EACH record:
        calculate_statistics(record)

    RETURN formatted_report
```

### 2.2 Fleet Management Logic

```
FUNCTION checkout_vehicle(employee_id, license_plate, project_id):
    current_time = get_current_timestamp()
    vehicle = FIND vehicle BY license_plate

    check IF vehicle is available:
        IF NOT available:
            RETURN error "Vehicle already in use"

    current_mileage = prompt_user_for_mileage()

    CREATE vehicle_usage_record:
        employee_id = employee_id
        license_plate = license_plate
        project_id = project_id
        checkout_time = current_time
        starting_mileage = current_mileage
        status = "in_use"

    UPDATE vehicle SET available = FALSE
    SAVE to database
    RETURN success with usage_id

FUNCTION checkin_vehicle(usage_id, ending_mileage):
    current_time = get_current_timestamp()
    usage_record = FIND usage_record BY usage_id

    IF NOT found OR status != "in_use":
        RETURN error "Invalid usage record"

    UPDATE usage_record:
        checkin_time = current_time
        ending_mileage = ending_mileage
        total_distance = ending_mileage - starting_mileage
        status = "completed"

    UPDATE vehicle SET available = TRUE
    SAVE to database
    RETURN success with total_distance

FUNCTION log_refueling(usage_id, fuel_amount, fuel_cost):
    refuel_record = CREATE refueling_entry:
        usage_id = usage_id
        fuel_amount = fuel_amount
        fuel_cost = fuel_cost
        timestamp = get_current_timestamp()

    SAVE to database
    RETURN success
```

### 2.3 Reporting Logic

```
FUNCTION generate_attendance_report(filters):
    data = QUERY attendance_records WITH filters

    statistics = CALCULATE:
        total_employees = COUNT DISTINCT employees
        total_work_hours = SUM(total_hours)
        average_hours_per_employee = total_work_hours / total_employees
        late_arrivals = COUNT WHERE clock_in > scheduled_time
        early_departures = COUNT WHERE clock_out < scheduled_time

    format_report(data, statistics)
    RETURN report

FUNCTION generate_fleet_report(filters):
    data = QUERY vehicle_usage WITH filters
    fuel_data = QUERY refueling_records WITH filters

    statistics = CALCULATE:
        total_trips = COUNT(data)
        total_distance = SUM(total_distance)
        total_fuel_cost = SUM(fuel_cost)
        average_fuel_efficiency = total_distance / SUM(fuel_amount)
        most_used_vehicles = GROUP BY license_plate ORDER BY COUNT DESC
        cost_per_project = GROUP BY project_id SUM fuel_cost

    format_report(data, statistics)
    RETURN report
```

### 2.4 SPARC Command
```bash
npx claude-flow sparc run spec-pseudocode "Design algorithms for attendance tracking, fleet management, and reporting"
```

---

## Phase 3: Architecture (System Design)

### 3.1 System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Client Layer                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Employee   │  │    Admin     │  │   Mobile     │      │
│  │   Dashboard  │  │   Dashboard  │  │     App      │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ↓ HTTPS
┌─────────────────────────────────────────────────────────────┐
│                     API Gateway / Load Balancer              │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                      Application Layer                       │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              Backend API (Node.js/Express)           │   │
│  │  ┌──────────┐  ┌──────────┐  ┌────────────────┐    │   │
│  │  │   Auth   │  │Attendance│  │ Fleet Manager  │    │   │
│  │  │ Service  │  │  Service │  │    Service     │    │   │
│  │  └──────────┘  └──────────┘  └────────────────┘    │   │
│  │  ┌──────────┐  ┌──────────┐  ┌────────────────┐    │   │
│  │  │ Reports  │  │   User   │  │   Notification │    │   │
│  │  │ Service  │  │ Service  │  │    Service     │    │   │
│  │  └──────────┘  └──────────┘  └────────────────┘    │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                       Data Layer                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  PostgreSQL  │  │    Redis     │  │   Storage    │      │
│  │   Database   │  │    Cache     │  │  (S3/Local)  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

### 3.2 Database Schema

#### Users Table
```sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL, -- 'employee', 'admin'
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Attendance Table
```sql
CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    clock_in_time TIMESTAMP NOT NULL,
    clock_out_time TIMESTAMP,
    total_hours DECIMAL(5,2),
    status VARCHAR(50) DEFAULT 'active', -- 'active', 'completed'
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Vehicles Table
```sql
CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    license_plate VARCHAR(20) UNIQUE NOT NULL,
    make VARCHAR(100),
    model VARCHAR(100),
    year INTEGER,
    current_mileage INTEGER,
    is_available BOOLEAN DEFAULT TRUE,
    last_maintenance_mileage INTEGER,
    maintenance_interval INTEGER DEFAULT 5000,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Projects Table
```sql
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL,
    project_code VARCHAR(50) UNIQUE,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Vehicle Usage Table
```sql
CREATE TABLE vehicle_usage (
    usage_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    vehicle_id INTEGER REFERENCES vehicles(vehicle_id),
    project_id INTEGER REFERENCES projects(project_id),
    checkout_time TIMESTAMP NOT NULL,
    checkin_time TIMESTAMP,
    starting_mileage INTEGER NOT NULL,
    ending_mileage INTEGER,
    total_distance INTEGER,
    status VARCHAR(50) DEFAULT 'in_use', -- 'in_use', 'completed'
    purpose TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Refueling Table
```sql
CREATE TABLE refueling (
    refuel_id SERIAL PRIMARY KEY,
    usage_id INTEGER REFERENCES vehicle_usage(usage_id),
    fuel_amount DECIMAL(10,2) NOT NULL, -- liters
    fuel_cost DECIMAL(10,2) NOT NULL,
    fuel_type VARCHAR(50),
    station_name VARCHAR(255),
    refuel_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    receipt_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 3.3 API Endpoints

#### Authentication
```
POST   /api/auth/register         - Register new user
POST   /api/auth/login            - Login user
POST   /api/auth/logout           - Logout user
POST   /api/auth/refresh-token    - Refresh JWT token
GET    /api/auth/verify           - Verify token
```

#### Attendance
```
POST   /api/attendance/clock-in   - Clock in employee
POST   /api/attendance/clock-out  - Clock out employee
GET    /api/attendance/status     - Get current attendance status
GET    /api/attendance/history    - Get attendance history
GET    /api/attendance/report     - Generate attendance report (admin)
```

#### Fleet Management
```
GET    /api/vehicles              - List all vehicles
GET    /api/vehicles/:id          - Get vehicle details
POST   /api/vehicles              - Add new vehicle (admin)
PUT    /api/vehicles/:id          - Update vehicle (admin)
DELETE /api/vehicles/:id          - Remove vehicle (admin)

POST   /api/fleet/checkout        - Check out vehicle
POST   /api/fleet/checkin         - Check in vehicle
GET    /api/fleet/active          - Get active vehicle usages
GET    /api/fleet/history         - Get usage history
POST   /api/fleet/refuel          - Log refueling
```

#### Projects
```
GET    /api/projects              - List all projects
POST   /api/projects              - Create project (admin)
PUT    /api/projects/:id          - Update project (admin)
DELETE /api/projects/:id          - Delete project (admin)
```

#### Reports
```
GET    /api/reports/attendance    - Attendance reports
GET    /api/reports/fleet         - Fleet usage reports
GET    /api/reports/fuel          - Fuel consumption reports
GET    /api/reports/dashboard     - Dashboard statistics
POST   /api/reports/export        - Export report (CSV/PDF)
```

### 3.4 SPARC Command
```bash
npx claude-flow sparc run architect "Design system architecture, database schema, and API structure for attendance and fleet platform"
```

---

## Phase 4: Refinement (TDD Implementation)

### 4.1 Test-Driven Development Setup

#### Test Structure
```
/tests
  /unit
    /services
      - attendance.service.test.js
      - fleet.service.test.js
      - auth.service.test.js
      - report.service.test.js
    /controllers
      - attendance.controller.test.js
      - fleet.controller.test.js
    /utils
      - date.utils.test.js
      - validation.utils.test.js
  /integration
    - attendance.api.test.js
    - fleet.api.test.js
    - auth.api.test.js
  /e2e
    - attendance-workflow.test.js
    - fleet-workflow.test.js
```

#### Sample Test Cases

**Attendance Tests:**
```javascript
describe('Attendance Service', () => {
  test('should allow employee to clock in', async () => {
    const result = await attendanceService.clockIn(employeeId);
    expect(result.success).toBe(true);
    expect(result.recordId).toBeDefined();
  });

  test('should prevent duplicate clock-in on same day', async () => {
    await attendanceService.clockIn(employeeId);
    await expect(attendanceService.clockIn(employeeId))
      .rejects.toThrow('Already clocked in');
  });

  test('should calculate total hours correctly', async () => {
    const clockInTime = new Date('2025-10-16T09:00:00');
    const clockOutTime = new Date('2025-10-16T17:30:00');
    const hours = calculateHours(clockInTime, clockOutTime);
    expect(hours).toBe(8.5);
  });
});
```

**Fleet Management Tests:**
```javascript
describe('Fleet Service', () => {
  test('should check out available vehicle', async () => {
    const result = await fleetService.checkoutVehicle({
      employeeId,
      licensePlate: 'ABC-123',
      projectId: 1,
      startingMileage: 50000
    });
    expect(result.success).toBe(true);
  });

  test('should prevent checkout of unavailable vehicle', async () => {
    await fleetService.checkoutVehicle(vehicleData);
    await expect(fleetService.checkoutVehicle(vehicleData))
      .rejects.toThrow('Vehicle already in use');
  });

  test('should calculate trip distance correctly', async () => {
    const startMileage = 50000;
    const endMileage = 50150;
    const distance = endMileage - startMileage;
    expect(distance).toBe(150);
  });
});
```

### 4.2 Implementation Order

**Sprint 1: Foundation (Week 1-2)**
1. Setup project structure
2. Configure database
3. Implement authentication system
4. Create user management

**Sprint 2: Attendance Module (Week 3-4)**
1. Implement clock-in/out logic
2. Create attendance history
3. Build employee dashboard
4. Add validation and error handling

**Sprint 3: Fleet Management (Week 5-6)**
1. Implement vehicle CRUD operations
2. Create checkout/checkin system
3. Add mileage tracking
4. Implement refueling logs

**Sprint 4: Reporting (Week 7-8)**
1. Create report generation service
2. Implement export functionality
3. Build admin dashboard
4. Add charts and visualizations

**Sprint 5: Polish & Deploy (Week 9-10)**
1. UI/UX improvements
2. Performance optimization
3. Security hardening
4. Deployment and monitoring

### 4.3 SPARC Commands

#### Run Complete TDD Workflow
```bash
npx claude-flow sparc tdd "Employee Attendance & Fleet Management Platform"
```

#### Run Individual Phases
```bash
# Specification + Pseudocode
npx claude-flow sparc run spec-pseudocode "Attendance tracking feature"

# Architecture
npx claude-flow sparc run architect "Design fleet management system"

# Refinement (TDD)
npx claude-flow sparc tdd "Implement attendance clock-in/out"

# Integration
npx claude-flow sparc run integration "Integrate attendance and fleet modules"
```

---

## Phase 5: Completion (Integration & Deployment)

### 5.1 Technology Stack

#### Frontend
```json
{
  "framework": "React 18",
  "state": "Redux Toolkit",
  "ui": "Material-UI or Tailwind CSS",
  "routing": "React Router v6",
  "http": "Axios",
  "charts": "Chart.js or Recharts",
  "forms": "React Hook Form + Yup"
}
```

#### Backend
```json
{
  "runtime": "Node.js 20 LTS",
  "framework": "Express.js",
  "orm": "Sequelize or Prisma",
  "auth": "jsonwebtoken + bcrypt",
  "validation": "Joi or Yup",
  "testing": "Jest + Supertest",
  "docs": "Swagger/OpenAPI"
}
```

#### Database
```json
{
  "primary": "PostgreSQL 15",
  "cache": "Redis",
  "migrations": "Sequelize-CLI or Prisma Migrate"
}
```

#### DevOps
```json
{
  "containers": "Docker + Docker Compose",
  "ci-cd": "GitHub Actions or GitLab CI",
  "monitoring": "PM2 + Winston",
  "proxy": "Nginx",
  "ssl": "Let's Encrypt"
}
```

### 5.2 Project Setup Commands

#### Initialize Project
```bash
# Create project structure
mkdir attendance-fleet-platform
cd attendance-fleet-platform

# Initialize backend
mkdir backend
cd backend
npm init -y
npm install express sequelize pg pg-hstore jsonwebtoken bcrypt dotenv cors helmet
npm install -D jest supertest nodemon eslint prettier

# Initialize frontend
cd ..
npx create-react-app frontend
cd frontend
npm install @reduxjs/toolkit react-redux react-router-dom axios @mui/material chart.js react-chartjs-2

# Return to root
cd ..
```

#### Database Setup
```bash
# Create PostgreSQL database
createdb attendance_fleet_db

# Run migrations
cd backend
npx sequelize-cli db:migrate

# Seed initial data
npx sequelize-cli db:seed:all
```

#### Docker Setup
```bash
# Build containers
docker-compose build

# Start services
docker-compose up -d

# View logs
docker-compose logs -f
```

### 5.3 Environment Configuration

**Backend .env:**
```env
NODE_ENV=production
PORT=5000
DATABASE_URL=postgresql://user:password@localhost:5432/attendance_fleet_db
JWT_SECRET=your-super-secret-jwt-key-here
JWT_EXPIRE=7d
REDIS_URL=redis://localhost:6379
CORS_ORIGIN=https://yourdomain.com
```

**Frontend .env:**
```env
REACT_APP_API_URL=https://api.yourdomain.com
REACT_APP_ENV=production
```

### 5.4 Build & Deployment Commands

#### Build for Production
```bash
# Build backend
cd backend
npm run build

# Build frontend
cd ../frontend
npm run build

# Build Docker images
docker-compose -f docker-compose.prod.yml build
```

#### Deploy
```bash
# Push to container registry
docker tag attendance-platform:latest registry.example.com/attendance-platform:latest
docker push registry.example.com/attendance-platform:latest

# Deploy to server
ssh user@server
docker pull registry.example.com/attendance-platform:latest
docker-compose -f docker-compose.prod.yml up -d
```

### 5.5 Testing Commands

```bash
# Run all tests
npm test

# Run with coverage
npm run test:coverage

# Run specific test suites
npm test -- attendance.test.js
npm test -- fleet.test.js

# Run integration tests
npm run test:integration

# Run e2e tests
npm run test:e2e

# Linting
npm run lint
npm run lint:fix

# Type checking
npm run typecheck
```

### 5.6 Monitoring & Maintenance

```bash
# View application logs
pm2 logs attendance-api

# Monitor resources
pm2 monit

# Restart application
pm2 restart attendance-api

# Database backup
pg_dump attendance_fleet_db > backup_$(date +%Y%m%d).sql

# Check application health
curl https://api.yourdomain.com/health
```

### 5.7 SPARC Integration Command
```bash
npx claude-flow sparc run integration "Complete integration and deployment of attendance and fleet platform"
```

---

## Complete SPARC Pipeline Execution

### Run Entire Pipeline
```bash
# Execute all phases sequentially
npx claude-flow sparc pipeline "Employee Attendance & Fleet Management Platform"
```

### Batch Execution (Parallel Processing)
```bash
# Run multiple modes in parallel
npx claude-flow sparc batch spec-pseudocode,architect "Attendance and Fleet Platform"
```

### Mode Information
```bash
# List all available SPARC modes
npx claude-flow sparc modes

# Get detailed info about specific mode
npx claude-flow sparc info spec-pseudocode
npx claude-flow sparc info architect
npx claude-flow sparc info tdd
```

---

## Development Workflow Summary

### Daily Development Cycle
```bash
# 1. Start development environment
docker-compose up -d

# 2. Run tests in watch mode
npm run test:watch

# 3. Start backend dev server
cd backend && npm run dev

# 4. Start frontend dev server
cd frontend && npm start

# 5. Before committing
npm run lint
npm run test
npm run build
```

### Sprint Planning with SPARC
```bash
# Week 1: Specification & Architecture
npx claude-flow sparc run spec-pseudocode "Sprint 1 features"
npx claude-flow sparc run architect "Sprint 1 architecture"

# Week 2-3: Implementation with TDD
npx claude-flow sparc tdd "Feature A"
npx claude-flow sparc tdd "Feature B"

# Week 4: Integration & Testing
npx claude-flow sparc run integration "Sprint 1 complete"
npm run test:e2e

# End of Sprint: Deploy
npm run deploy:staging
npm run deploy:production
```

---

## Key Deliverables

### Phase 1 - Specification
- [ ] Requirements document
- [ ] User stories
- [ ] Technical specifications
- [ ] Success criteria

### Phase 2 - Pseudocode
- [ ] Algorithm designs
- [ ] Logic flowcharts
- [ ] Edge case handling
- [ ] Performance considerations

### Phase 3 - Architecture
- [ ] System architecture diagram
- [ ] Database schema
- [ ] API documentation
- [ ] Security model
- [ ] Deployment architecture

### Phase 4 - Refinement (TDD)
- [ ] Unit tests (90%+ coverage)
- [ ] Integration tests
- [ ] E2E tests
- [ ] Working implementation
- [ ] Code review completed

### Phase 5 - Completion
- [ ] Production deployment
- [ ] User documentation
- [ ] Admin documentation
- [ ] Monitoring setup
- [ ] Backup procedures
- [ ] Support procedures

---

## Success Metrics

### Technical Metrics
- Test coverage: > 90%
- API response time: < 200ms (95th percentile)
- Page load time: < 2 seconds
- Uptime: > 99.5%
- Zero critical security vulnerabilities

### Business Metrics
- User adoption: 100% of employees within 2 weeks
- Data accuracy: > 99%
- Report generation: < 5 seconds
- User satisfaction: > 4.5/5
- Support tickets: < 5 per week

---

## Additional Resources

### Documentation
- [SPARC Methodology Guide](https://github.com/ruvnet/claude-flow)
- [API Documentation](./API_DOCS.md)
- [User Manual](./USER_MANUAL.md)
- [Admin Guide](./ADMIN_GUIDE.md)

### Support
- Technical Issues: support@company.com
- Feature Requests: features@company.com
- Security Issues: security@company.com

---

**Document Version:** 1.0
**Last Updated:** 2025-10-16
**Project Status:** Planning Phase
**Estimated Timeline:** 10 weeks
**Team Size:** 3-5 developers
