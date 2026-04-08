# Troubleshooting

## "Portfolio directory not set"
Run: `code-buddy config set portfolio_dir /path/to/your/repos`

## Pulse shows no results
Your repos may not have git history or changelogs within the pulse window. Try: `CODEBUDDY_DAYS=30 code-buddy pulse`

## Symlink issues after moving the repo
If you move the code-buddy directory, update the symlinks:
```bash
ln -sf /new/path/code-buddy ~/bin/code-buddy
ln -sf /new/path/portfolio-pulse.sh ~/bin/portfolio-pulse.sh
```

## "Permission denied" on scripts
```bash
chmod +x code-buddy portfolio-pulse.sh install.sh
```

## Dates show incorrectly on macOS
macOS uses BSD date. The scripts fall back to `date -v` syntax. If dates still break, install GNU coreutils: `brew install coreutils`
