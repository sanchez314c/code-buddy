# Product Requirements Document — Code Buddy

## Overview

**Code Buddy** is a CLI-based portfolio management tool for developers who use AI coding assistants (Claude Code, Cursor, Copilot) and build many projects simultaneously. It provides persistent session awareness, activity tracking, and a structured workflow to prevent project sprawl.

## Problem Statement

Developers using AI coding tools tend to start many projects and lose track of them. There's no standard way to:
- Know what you're working on across sessions
- Track which projects are done vs in-progress vs abandoned
- Enforce focus by limiting active work
- Give new AI sessions context about current priorities
- Know what changed recently across a large portfolio

## Target User

Solo developers and indie hackers who build 10-100+ projects using AI-assisted development and struggle with project management, prioritization, and finishing what they start.

## Technical Architecture

**Stack:** Pure Bash CLI (portable, no dependencies beyond bash 4+, git, Python 3.8+)
**Config:** `~/.code-buddy/config.json`
**Output:** Markdown files in portfolio root (`MANIFEST.md`, `RECENT-ACTIVITY.md`)

### Components

| File | Purpose | LOC |
|------|---------|-----|
| `code-buddy` | Main CLI entry point, all commands | 309 |
| `portfolio-pulse.sh` | Activity scanner, git/changelog parser | 162 |
| `install.sh` | One-command setup and configuration | 69 |

### Folder Workflow

```
ICEBOX → WORKBENCH → ACTIVE (capped) → QUEUE → SHIPPED
```

Each stage maps to a folder in the portfolio directory. The ACTIVE folder has a configurable hard cap (default: 7).

## Commands

| Command | Function |
|---------|----------|
| `scan` | Full portfolio scan, generates MANIFEST.md + RECENT-ACTIVITY.md |
| `pulse` | Quick: what changed in the last N days |
| `status` | One-line portfolio health summary with cap warnings |
| `move` | Move a repo between stages with cap enforcement |
| `ready` | Score QUEUE repos on pipeline readiness (5-point checklist) |
| `triage` | List ACTIVE repos for weekly review |
| `config` | Set/show configuration |
| `hook` | Install Claude Code session hook |

## Integration Points

- **Claude Code:** Session hook fires on start, loads portfolio context
- **Cursor:** Settings integration (planned)
- **CLAUDE.md:** Portfolio manifest referenced in global directives
- **Git:** Activity detection via commit history
- **Changelog:** Activity detection via changelog.md parsing

## Success Metrics

- User can answer "what should I work on today?" in under 5 seconds
- Every AI session starts with portfolio context
- ACTIVE folder stays at or below cap
- Stale projects get flagged automatically

## Constraints

- No external services or APIs
- No database (file-based only)
- Must work on Linux and macOS
- Must be publishable as a standalone repo anyone can clone

## Version

1.0.0 — Initial release
