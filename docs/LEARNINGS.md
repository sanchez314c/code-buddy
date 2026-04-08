# Learnings

## Why This Exists

Built by Jason Paul Michaels after accumulating 59+ AI-assisted projects and losing track of what was done, what was in progress, and what to work on next. The core insight: the problem isn't building, it's finishing. A hard cap on ACTIVE repos forces focus.

## Design Decisions

- **Bash over Node/Python**: Zero install friction. If you have git, you have bash.
- **File-based output**: MANIFEST.md and RECENT-ACTIVITY.md are readable by both humans and AI agents.
- **Folder-based workflow**: Moving directories is atomic, visible, and doesn't require a database.
- **Hard cap enforcement**: Soft limits don't work. The `move` command refuses to add to ACTIVE when full.
- **7-day default**: Anything untouched for a week in ACTIVE isn't really active.
