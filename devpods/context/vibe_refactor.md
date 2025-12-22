VIBE REFACTOR OPERATIONS

Step 1: Refactor Orchestration & Planning
Goal: Improve code quality, maintainability, and performance through phased refactoring.
🔴 CRITICAL REQUIREMENTS
* Read CLAUDE.md for current architecture
* Analyze actual codebase for issues
* ⚠️ WAIT FOR APPROVAL - No code changes before user confirms
* Each phase must be independently testable
Refactor Planning
1. Analyze Current Codebase
* Store context in /memory/refactor_context.json
* Identify issues:
    * Code organization problems
    * Readability challenges
    * Maintainability issues
    * Performance bottlenecks
    * Technical debt
    * Error handling gaps
* Record in /memory/code_analysis.json
2. Create Phase-Based Refactor Plan
For each phase specify:
* What will be refactored (files, modules, layers)
* Improvements and their rationale
* Complexity rating (Low/Medium/High/Critical)
* Dependencies on other phases
* Completion criteria (programmatically verifiable)
* Expected benefits (metrics)
* Potential risks
3. Get User Approval
* Present plan with clear explanations
* ⚠️ STOP HERE - Wait for phase selection
* No modifications until confirmed
Phase Execution (After Approval)
1. Initialization
* Write phase to /memory/current_refactor_phase.json
* Create snapshot: git tag pre-refactor-phase-{N}
* Launch needed agents only
* Create doc update strategy in /memory/refactor_doc_strategy.json
2. Parallel Refactoring
* Assign microtasks to agents
* Log to /memory/refactor_task_assignments.json
* Run baseline tests before changes
* Coordinate file access
3. Maintain Functionality
* Run tests after each change
* If tests fail: fix or revert immediately
* Store results in /memory/refactor_test_results.json
* Maintain >80% coverage
4. Update Documentation
* Reflect refactored architecture
* Update setup/config if changed
* Document API changes
* Be specific about changes and impact
Completion Criteria
✅ Phase complete when:
* All refactoring goals achieved
* All tests passing (with before/after proof)
* Documentation updated
* No functionality degraded
* End-to-end demo successful
* No TODOs or partial refactors
Output
* /memory/phase_{N}_completion_report.md

Step 2: Continue Refactoring
Goal: Execute remaining refactoring for production-ready quality.
Process
1. Review Progress
* Check /memory/current_refactor_phase.json
* Review /memory/refactor_test_results.json
* Analyze /memory/code_analysis.json
2. Prioritize Remaining Work
* Focus on high-impact improvements
* Store in /memory/remaining_refactor_tasks.json
* Specify what, why, criteria, measurement
3. Execute Tasks
* Use skills before slash commands
* Ensure refactoring improves (not complicates)
* Validate every change with tests
* Reference CLAUDE.md for design principles

Step 3: Refactor Validation
Goal: Verify refactored code maintains identical functionality with improved quality.
🔴 CRITICAL REQUIREMENTS
* Compare behavior before and after refactor
* Every feature that worked must still work
* Document all differences (improvements or regressions)
Validation Process
1. Deploy Validation Agents
* Functional testing (features work)
* Regression testing (nothing broken)
* Performance testing (improved or maintained)
* Integration testing (components work together)
* Security testing (no new vulnerabilities)
2. Execute Comprehensive Tests
* Test all commands, parameters, edge cases
* Record exact inputs and outputs
* Compare to baseline (pre-refactor)
* Flag differences in /memory/refactor_discrepancies.json
3. Benchmark Comparison
Measure and compare:
* Execution times
* Resource usage (CPU, memory, DB queries)
* Performance metrics (latency, throughput)
* Error rates
* Store in /memory/refactor_benchmarks.json
Validation Report
Create /memory/refactor_validation_report.md with:
Executive Summary:
* Success status
* Tests executed and passed
* Critical issues (if any)
* Recommendation (merge, fix, or revert)
Detailed Sections:
* Functional validation
* Regression testing
* Performance comparison (specific metrics)
* Code quality improvements
* Issues discovered

Step 4: Continue Refactoring (If Needed)
Goal: Address any issues discovered during validation.
Process
1. Review Validation Results
* Check /memory/refactor_validation_report.md
* Review /memory/refactor_discrepancies.json
2. Prioritize Issues
* Critical: Break core functionality (fix immediately)
* Major: Degrade UX (prompt attention)
* Minor: Actually improvements (document)
3. Create Remediation Plan
* Store in /memory/refactor_remediation_plan.json
* Root cause, fix approach, effort, dependencies
4. Execute Fixes
* Address critical and major issues
* Understand WHY regressions occurred
* Validate with comprehensive tests

Step 5: Repository Analysis
Goal: Document refactored codebase and improvements made.
Analysis Focus
1. Compare Before/After
* Create structure comparison in /memory/structure_comparison.txt
* Note organizational improvements
2. Examine Refactored Files
* Summarize what changed and why
* Identify improved functions/classes
* Note changed dependencies
* Highlight logic improvements
* Compare quality metrics
3. Document Architecture Improvements
* Updated dependencies (reduced coupling)
* Improved data flow
* Refactored execution flow
* New shared utilities
Technical Report
Create /memory/refactor_analysis_report.md with:
Executive Summary:
* High-level improvements overview
* What was improved and why it matters
Architecture Overview:
* How codebase is now organized
* What changed from original
* Improvements in modularity and patterns
File-by-File Documentation:
* What changed in implementation
* Why change was improvement
* How it affects system
* Specific metrics (complexity reduction, coverage increase)
* Why unchanged files didn't need refactoring
Validation
* Reference CLAUDE.md for original intentions
* Compare to original specs
* Honest assessment of successes and areas needing improvement

Step 5.5: Validation Pass #2 if Needed

Step 6: Post-Refactor Cleanup
Goal: Remove refactoring artifacts and update documentation.
🔴 CRITICAL REQUIREMENTS
* Remove deprecated files from refactoring
* Update .gitignore for new file types
* Fix all outdated documentation
* Clean up refactoring-related comments
Cleanup Process
1. Remove Refactor Artifacts
* Deprecated files (replaced by refactored versions)
* Legacy/deprecated pre-refactor files
* Temporary refactor files (TODO_REFACTOR.md, notes)
* Backup files (.bak, .orig, ~)
* Standard artifacts (node_modules, .env, build, logs, etc.)
* List in /memory/refactor_cleanup_removed_files.txt
2. Update .gitignore
* Add patterns for new file types from refactoring
* Include new build tool outputs
* Add new testing framework artifacts
* Organize with clear sections and comments
3. Review ALL Documentation
Fix outdated info about:
* Pre-refactor architecture
* Old code structure
* Outdated setup instructions
* Incorrect import statements
* Old architecture diagrams
* Changed performance characteristics
* Deprecated coding patterns
4. Review Code Comments
* Update references to renamed items
* Update explanations if logic simplified
* Remove obvious comments after refactoring
* Add comments for new patterns
5. Clean docs/ Directory
* Update API documentation
* Fix architecture decision records
* Update or remove design documents
* Consolidate redundant info
Completion Criteria
✅ Clean when:
* No deprecated code remains
* Documentation reflects refactored codebase
* .gitignore prevents new artifacts
* Professional quality
Output
* /memory/refactor_cleanup_summary.md with metrics

Step 7: Refactored Release Preparation
Goal: Prepare refactored repository for GitHub release.
🔴 CRITICAL REQUIREMENTS
* Release notes must explain refactoring improvements
* Update security policy if needed
* Version number reflects refactor scope
* Commit messages explain changes
Release Process
1. Verify/Update LICENSE
* Check complete text exists
* Update copyright year if needed
* Add new contributors if applicable
2. Verify/Update SECURITY.md
* Update if refactoring changed:
    * Supported versions
    * Vulnerability reporting
    * Security update policy
* Note security improvements from refactoring
3. Review Commit History
* Ensure clear, descriptive messages
* Consider squashing WIP commits
* Create final commit: "Major refactor: [brief description]"
4. Create Tagged Release
Version Selection:
* Minor increment (1.1.0 → 1.2.0): Non-breaking refactor
* Major increment (1.5.0 → 2.0.0): Breaking refactor
* Pre-release (2.0.0-beta.1): Needs more testing
Create tag: git tag -a v{version} -m "{message}"
Release Notes Structure:
High-Level Summary:
* What was refactored and why
Refactoring Improvements:
* Codebase complexity reduced by X%
* Test coverage improved from X% to Y%
* Specific improvements (authentication, module organization)
Performance Gains:
* API response times reduced by X%
* Memory usage decreased by Y%
* Startup time improved
Architecture Changes:
* Major structural improvements
Breaking Changes (if any):
* Clear migration guidance
Backward Compatibility:
* If maintained, reassure users
Acknowledgments:
* Contributors to refactoring effort
5. Push to GitHub
git push origin main
git push origin v{version}
Verification
* Check refactored code visible
* Release tag appears
* Release notes display correctly
Output
* /memory/refactor_release_summary.md with version, changelog, metrics, URL, post-release actions
