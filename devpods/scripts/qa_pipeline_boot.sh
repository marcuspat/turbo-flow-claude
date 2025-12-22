#!/bin/bash

# Agentic QE Full Quality Pipeline Script
# This script installs necessary tools and runs the complete QE pipeline

set -e  # Exit on any error

echo "=========================================="
echo "Agentic QE Pipeline Setup and Execution"
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_info() {
    echo -e "${YELLOW}[i]${NC} $1"
}

# Step 1: Install claude-code globally
print_info "Step 1: Installing @anthropic-ai/claude-code globally..."
if npm install -g @anthropic-ai/claude-code; then
    print_status "claude-code installed successfully"
else
    print_error "Failed to install claude-code"
    exit 1
fi
echo ""

# Step 2: Install agentic-qe globally
print_info "Step 2: Installing agentic-qe globally..."
if npm install -g agentic-qe; then
    print_status "agentic-qe installed successfully"
else
    print_error "Failed to install agentic-qe"
    exit 1
fi
echo ""

# Step 3: Add agentic-qe MCP to claude
print_info "Step 3: Adding agentic-qe MCP to claude..."
if claude mcp add agentic-qe npx aqe-mcp; then
    print_status "agentic-qe MCP added successfully"
else
    print_error "Failed to add agentic-qe MCP"
    exit 1
fi
echo ""

# Step 4: Run the full AQE quality pipeline
print_info "Step 4: Running the full AQE quality pipeline..."
print_info "This will execute Claude once with the complete pipeline..."
echo ""

# Run claude with the pipeline command (this should only execute once)
claude --dangerously-skip-permissions "Run the full AQE quality pipeline:
1. qe-requirements-validator - validate requirements are testable
2. qe-test-generator - generate comprehensive test suite
3. qe-test-executor - run tests with parallel execution
4. qe-coverage-analyzer - analyze gaps using O(log n) algorithms
5. qe-flaky-test-hunter - detect flaky tests with 100% ML accuracy
6. qe-security-scanner - run SAST/DAST scans
7. qe-performance-tester - load test critical paths
8. qe-quality-gate - validate all quality criteria met
9. qe-deployment-readiness - assess deployment risk"

# Check if the command succeeded
if [ $? -eq 0 ]; then
    print_status "AQE quality pipeline completed successfully"
else
    print_error "AQE quality pipeline failed"
    exit 1
fi
echo ""

# Step 5: Generate QA Pipeline Report
print_info "Step 5: Generating QA pipeline report..."
echo ""

# Run claude to generate the report and save it to a file
claude --dangerously-skip-permissions "Based on the AQE quality pipeline that just ran, create a comprehensive QA Pipeline Report in markdown format. Include:
- Executive Summary
- Requirements Validation Results
- Test Generation Summary
- Test Execution Results
- Coverage Analysis
- Flaky Test Detection Results
- Security Scan Findings
- Performance Test Results
- Quality Gate Status
- Deployment Readiness Assessment
- Recommendations

Save this report to a file named qa_pipeline_report.md in the current directory."

# Check if the report generation succeeded
if [ $? -eq 0 ]; then
    print_status "QA pipeline report generated successfully"
    if [ -f "qa_pipeline_report.md" ]; then
        print_status "Report saved to: $(pwd)/qa_pipeline_report.md"
    else
        print_info "Report should be available in the current directory"
    fi
else
    print_error "Failed to generate QA pipeline report"
    exit 1
fi
echo ""

echo "=========================================="
echo "Pipeline execution completed!"
echo "=========================================="
