# Agent Dispatch Guide

## Overview
Code Buddy is a small bash project (540 LOC). Most work can be done in the main session. Sub-agents are only needed for:

## When to Use Sub-Agents
- **Testing across platforms**: Dispatch agents to test on Linux vs macOS
- **Adding new scan sources**: New data source integration (e.g., GitHub API, Jira)
- **Documentation updates**: Bulk doc generation for README examples

## Agent Tasks

### Add a New Command
- Files: `code-buddy` (add case), `README.md` (add to docs)
- Verify: `shellcheck code-buddy && ./code-buddy <new-command>`

### Add a New Scan Source
- Files: `portfolio-pulse.sh` (add to `scan_repo()`)
- Verify: `./portfolio-pulse.sh --quick`

### Update Documentation
- Files: `README.md`, `CONTRIBUTING.md`, `VERSION_MAP.md`
- Verify: Read for accuracy, no broken links
