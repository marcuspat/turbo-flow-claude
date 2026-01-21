VIBE BUILD OPERATIONS

Step 1: Orchestration & Phase Planning
Goal: Execute project phases in parallel with comprehensive planning, testing, and documentation.
🔴 CRITICAL REQUIREMENTS
* Read CLAUDE.md and PLANS.md completely
* ⚠️ WAIT FOR APPROVAL - Do NOT begin implementation without user confirmation
* Each phase must be independently buildable
* No partial work - complete all requirements or mark as failed
Phase Planning Process
1. Create Phase Plan
* Store context in /memory/project_context.json
* Break project into logical phases (Phase 1, 2, 3...)
* For each phase define:
    * Features and components included
    * Complexity rating (Low/Medium/High/Critical)
    * Dependencies on other phases
    * Concrete completion criteria
    * Expected deliverables with file paths
2. Get User Approval
* Present complete phase plan to user
* ⚠️ STOP HERE - Wait for explicit phase selection
* Do not proceed until user confirms
Phase Execution (After Approval)
1. Initialization
* Write selected phase to /memory/current_phase.json
* Launch only agents needed for this phase
* Create doc strategy in /memory/doc_strategy.json
* Break phase into parallelizable microtasks
2. Parallel Execution
* Assign tasks to appropriate agents
* Log assignments to /memory/task_assignments.json
* Coordinate to avoid file conflicts
* Provide status updates every 30 minutes
3. Continuous Testing
* Frontend: Playwright tests for all UI flows
* Backend: Unit, integration, and API tests
* Coverage: Minimum 80% required
* Log results to /memory/test_results.json
4. Documentation
* Update README (architecture, setup, troubleshooting)
* Use specific details, no vague placeholders
* Store updates in version control immediately
Completion Criteria
✅ Phase complete when ALL are true:
* All phase requirements implemented
* All tests passing (>80% coverage)
* Documentation updated and accurate
* End-to-end demo successful
* No TODOs or placeholders
If Errors Occur
* Log to /memory/errors.log
* Fix immediately - stop other work until resolved
* Escalate to user if unrecoverable
* Never mark complete with failing tests
Output Requirements
* /memory/project_context.json
* /memory/current_phase.json
* /memory/task_assignments.json
* /memory/test_results.json
* Updated README sections

Step 2: Testing & Validation
Goal: Prove application works through comprehensive testing and documentation.
🔴 CRITICAL REQUIREMENTS
* Check /memory/current_phase.json for scope
* If missing critical requirements (API keys, env vars, DB), halt and report in /memory/missing_requirements.json
* Tests must run successfully before proceeding
Testing Infrastructure Setup
1. Install Testing Tools
* Playwright + Chrome MCP for frontend
* Jest/pytest for backend (based on stack)
* Configure for coverage reports
2. Deploy Testing Agents
* Frontend: Test full app workflow (auth, navigation, forms, UI)
* Backend: Test logic, APIs, database, business rules
* Integration: Test component interactions and data flow
Testing Execution
Test Coverage Areas:
* Happy path (valid inputs)
* Error handling (invalid inputs)
* Boundary conditions (edge cases)
* Authentication/authorization
* Concurrent operations
* Integration with external services
Requirements:
* Over 80% code coverage
* Coverage reports to /memory/coverage_reports/
* All tests passing (no TODOs, no skips)
* Fix failures immediately
Documentation Overhaul
README Must Include:
* Architecture diagram (accurate, not aspirational)
* Prerequisites with specific version numbers
* Installation steps (exact commands)
* Configuration docs (every env var, option)
* Running instructions (dev, prod, testing)
* Testing instructions (how to run, interpret)
* Troubleshooting (actual issues encountered)
* Performance characteristics (measured, not assumed)
Demo Script
Create /demo/run_demo.sh that:
* Starts application
* Executes representative workflow
* Captures outputs/logs
* Verifies success
* Measures performance
* Shuts down cleanly
Completion Criteria
✅ Complete when:
* All tests run successfully 3+ times
* Zero test failures, flakes, or skips
* Coverage >80%
* README can be followed blindly
* Demo script proves functionality
Output Requirements
* /memory/test_execution_summary.json
* Complete coverage report
* Updated README
* Working demo script

Step 3: Continue Development
Goal: Bring application to production readiness.
Process
1. Review Current State
* Check /memory/current_phase.json
* Review /memory/test_results.json
* Analyze /memory/agent_actions.log
2. Create Production Readiness Plan
* Identify gaps in: code quality, security, performance, scalability
* Prioritize by impact
* Store in /memory/production_readiness_tasks.json
3. Execute Tasks
* Use skills before slash commands
* Apply critical thinking
* Reference CLAUDE.md for standards
Completion Criteria
✅ Ready for production when:
* All production readiness tasks completed
* Security requirements met
* Performance acceptable
* Documentation complete

Step 4: Comprehensive Validation
Goal: Validate every feature works as end users would experience it.
🔴 CRITICAL REQUIREMENTS
* Read project context, phase info, CLAUDE.md
* Test systematically, not randomly
* Log ALL findings to /memory/validation_results/
Validation Process
1. Deploy Validation Agents
* API testing
* UI testing
* Performance testing
* Security testing
* Integration testing
2. Execute Test Matrix
* Valid inputs (happy path)
* Invalid inputs (error handling)
* Boundary values (edge cases)
* Null/empty inputs (robustness)
* Large inputs (performance)
* Special characters (security)
* Concurrent requests (thread safety)
3. Document Benchmarks
* Execution times
* Resource usage (CPU, memory, I/O)
* Performance metrics (latency, throughput)
* Errors by severity (critical, major, minor)
Validation Report
Create /memory/validation_report.md with:
* Executive summary (pass/fail, success rate, critical issues)
* Detailed sections per testing domain
* Evidence of thorough coverage
* Production readiness assessment
If Discrepancies Found
* Log to /memory/validation_discrepancies.json
* Compare to CLAUDE.md specs
* Flag as documentation issue or implementation bug

Step 5: Continue Development (If Needed)
Goal: Fix all issues found during validation.
Process
1. Review Validation Results
* Check /memory/validation_report.md
* Review /memory/validation_errors/
2. Prioritize Issues
* Critical: Prevent core functionality
* Major: Significantly degrade UX
* Minor: Improvements and polish
3. Create Remediation Plan
* Store in /memory/remediation_plan.json
* Root cause, fix approach, effort, dependencies
4. Execute Fixes
* Address critical and major issues
* Validate every fix with new tests
* No superficial patches
Completion Criteria
✅ Ready when:
* All critical issues resolved
* All major issues resolved
* New tests prevent regressions

Step 6: Repository Analysis
Goal: Create comprehensive technical documentation of the codebase.
Analysis Process
1. Explore Repository Structure
* Map directory structure to /memory/repo_structure.txt
* Identify source, test, config, docs directories
2. Analyze Each Source File
* What it does (high-level purpose)
* Key functions/classes
* Dependencies and imports
* Important logic and algorithms
* Configuration affecting behavior
* Store in /memory/file_analysis/
3. Map System Architecture
* Dependencies between files
* Data flow between components
* Entry points and execution flow
* Shared utilities
Technical Report
Create /memory/repository_analysis_report.md with:
Executive Summary:
* What the app does
* Problem it solves
* Target users
* Main features
* Maturity level
Architecture Overview:
* Directory structure
* Architectural pattern
* Major components
* External dependencies
* Data storage approach
* Deployment model
File-by-File Documentation:
* Purpose and functionality
* Key exports and usage
* Implementation details
* Design decisions
* Technical debt
Validation
* Compare to CLAUDE.md specs
* Note intentional vs accidental differences
* Apply critical thinking to understand WHY

Step 6.5: Comphrehensive Validaton Pass #2 (If Needed)

Step 7: Repository Cleanup
Goal: Professional-quality repo ready for public release.
🔴 CRITICAL REQUIREMENTS
* Do NOT remove essential files
* List all removals in /memory/removed_files.txt first
* Update .gitignore comprehensively
Cleanup Process
1. Remove Unnecessary Files
* node_modules/, vendor/, target/
* .env, .env.local, .env.development
* build/, dist/, compiled outputs
* IDE folders (.vscode/, .idea/, .vs/)
* OS files (.DS_Store, Thumbs.db)
* Log files, temp files, cache dirs
* Coverage reports
2. Update .gitignore
Categories to include:
* Dependency directories
* Build outputs
* IDE files
* OS files
* Environment files
* Log files
* Temporary files
* Test coverage
* Project-specific (.claude, memory/, etc.)
Add comments explaining each section.
3. Clean Documentation
Remove/Fix:
* Placeholder text, lorem ipsum
* Incomplete sentences
* Outdated information
* Contradictory statements
* Vague descriptions
* Marketing fluff
* Internal-only content
4. Consolidate Docs
* Remove redundant documentation
* Create single authoritative sources
* Update code comments for accuracy
Completion Criteria
✅ Clean repo when:
* Only essential files remain
* .gitignore prevents future clutter
* Documentation accurate and useful
* No confusing artifacts
Output
* /memory/cleanup_summary.md with metrics and changes

Step 8: Release Preparation
Goal: Prepare repository for public GitHub release.
🔴 CRITICAL REQUIREMENTS
* Complete LICENSE (no placeholders)
* Real SECURITY.md with contact info
* Clean commit history
* Valid semantic version
Release Process
1. Create/Verify LICENSE
* Use complete MIT License text (or other OSI-approved)
* Include current year (2025)
* Use real copyright holder name (no placeholders)
* Store as LICENSE in root
2. Create/Verify SECURITY.md
Must include:
* Supported versions (which receive updates)
* Vulnerability reporting (email, response time, process)
* Security update policy (how patches released)
3. Review Commit History
* Ensure descriptive commit messages
* Commit any uncommitted changes
* Optional: Clean up messy history with interactive rebase
4. Create Tagged Release
Version Selection:
* v1.0.0 - Production-ready, stable APIs
* v0.1.0 - Early-stage, active development
* Increment minor for non-breaking changes
* Increment major for breaking changes
Create tag: git tag -a v{version} -m "{message}"
Release Notes:
* Key features/changes summary
* Performance gains (specific metrics)
* Architecture changes
* Breaking changes + migration guide
* Known limitations
* Contributor acknowledgments
5. Push to GitHub
git push origin main
git push origin v{version}
Verification
* Check repo on GitHub
* Confirm files visible
* Verify release tag appears
* Review release notes display
Output
* /memory/release_summary.md with version, changelog, URL, post-release actions
