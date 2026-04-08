# API Reference

Code Buddy is a CLI tool. All interaction is through shell commands.

## Commands

### code-buddy scan
Full portfolio scan. Generates MANIFEST.md and RECENT-ACTIVITY.md in the portfolio root.

### code-buddy pulse
Quick activity report for the last N days (default 7). Stdout only.
Override: `CODEBUDDY_DAYS=30 code-buddy pulse`

### code-buddy status
One-line portfolio health summary. Shows counts per stage and warns if ACTIVE exceeds cap.

### code-buddy move <repo> <stage>
Move a repo between stages. Enforces ACTIVE cap. Validates repo name (no path traversal).
Stages: icebox, workbench, active, queue, shipped, other

### code-buddy ready
Score each QUEUE repo on a 5-point readiness checklist: README, tests, CLAUDE.md, LICENSE, git.

### code-buddy triage
List all ACTIVE repos with numbering for weekly review.

### code-buddy config set <key> <value>
Set a config value. Keys: portfolio_dir, active_cap, pulse_days.

### code-buddy config show
Print current config as formatted JSON.

### code-buddy hook install
Install the Claude Code session hook at ~/.code-buddy/session-hook.sh.

## Environment Variables

- `CODEBUDDY_PORTFOLIO`: Override portfolio directory (used by portfolio-pulse.sh)
- `CODEBUDDY_DAYS`: Override activity window in days
