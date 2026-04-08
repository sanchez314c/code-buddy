# Workflow

## Daily
1. Open a Claude Code session (hook shows portfolio context automatically)
2. Run `code-buddy pulse` to see what was touched recently
3. Pick a repo from ACTIVE and work on it

## Weekly
1. Run `code-buddy triage` to review your ACTIVE repos
2. Move anything you haven't touched in 7+ days to WORKBENCH
3. Pull something from WORKBENCH or QUEUE into ACTIVE if under cap
4. Run `code-buddy ready` to see which QUEUE repos can ship

## Pipeline Day
1. Pick a QUEUE repo with a high readiness score
2. Run /repopipeline on it
3. Push to GitHub
4. Run `code-buddy move <repo> shipped`

## Adding New Projects
Don't. Finish what's in ACTIVE and QUEUE first. If you must, add to ICEBOX and come back to it later.
