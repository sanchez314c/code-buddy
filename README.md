# Code Buddy

Your AI coding session's persistent memory. Point it at a folder full of repos and it tracks what you're working on, what's ready to ship, what's stale, and what you should focus on next.

Built for developers using AI coding assistants (Claude Code, Cursor, Copilot) who build a lot of things and lose track of all of them.

## The Problem

You build 50 apps. You can't remember which ones are done, which ones are half-finished, which ones need tests, and which ones you should actually be working on. You open a new AI session and it has no idea what your priorities are. You start another new project instead of finishing the 12 you already have.

## What Code Buddy Does

- **Scans** your portfolio directory and inventories every repo
- **Scores** each repo on documentation, tests, git status, and pipeline readiness
- **Generates a manifest** that any AI coding session can read on startup
- **Tracks activity** so you know what's been touched recently and what's gone stale
- **Enforces a workflow** with folder-based stages: ICEBOX, WORKBENCH, ACTIVE (capped), QUEUE, SHIPPED
- **Integrates with Claude Code** via hooks so every session starts with full context

## Quick Start

```bash
git clone https://github.com/sanchez314c/code-buddy.git
cd code-buddy
./install.sh
```

The installer will:
1. Scan your portfolio directory
2. Generate `MANIFEST.md` (your single source of truth)
3. Generate `RECENT-ACTIVITY.md` (what changed lately)
4. Install the session hook (Claude Code, Cursor, or standalone)
5. Create the folder structure if it doesn't exist

## Folder Workflow

```
ICEBOX          Parked. Not thinking about it. Someday maybe.
  |
  v
WORKBENCH       Started, in progress, but not this week's focus.
  |
  v
ACTIVE          THIS WEEK. Hard cap (default: 7). One per day.
  |              To add one, move one out first.
  v
QUEUE           Done building. Needs pipeline (docs, tests, lint, polish).
  |
  v
SHIPPED         Published. On GitHub. Done.
```

## Commands

```bash
# Full portfolio scan — generates MANIFEST.md + RECENT-ACTIVITY.md
code-buddy scan

# Quick pulse — what changed in the last 7 days
code-buddy pulse

# Triage — interactive: pick your ACTIVE repos for the week
code-buddy triage

# Status — one-line summary of your portfolio health
code-buddy status

# Move a repo between stages
code-buddy move <repo-name> <stage>
# e.g. code-buddy move my-app active

# Pipeline check — which QUEUE repos are ready to ship
code-buddy ready
```

## Claude Code Integration

```bash
# Add the session hook
code-buddy hook install
```

This adds a hook to `~/.claude/settings.json` that runs on session start. Your AI will know:
- What you're working on (ACTIVE repos)
- What's priority (MANIFEST.md)
- What changed recently (RECENT-ACTIVITY.md)
- That it should NOT start new projects

## Configuration

```bash
# Set your portfolio directory
code-buddy config set portfolio_dir /path/to/your/repos

# Set ACTIVE cap (default: 7)
code-buddy config set active_cap 7

# Set activity window for pulse reports (default: 7 days)
code-buddy config set pulse_days 7
```

Config lives in `~/.code-buddy/config.json`.

## What Gets Generated

**MANIFEST.md** — Full inventory of every repo with status, stack, LOC, priority tier, and pipeline readiness. This is your single source of truth.

**RECENT-ACTIVITY.md** — Rolling report of what's been touched. Sorted by date. Flags stale ACTIVE repos that haven't been touched in 7+ days.

## Requirements

- bash 4+
- git
- Python 3.8+ (for repo scanning)
- jq (optional, for JSON output)

## Works With

- Claude Code (hook integration)
- Cursor (settings integration)
- Any AI coding tool that reads project files
- Standalone CLI for non-AI workflows

## License

MIT
