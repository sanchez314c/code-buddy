#!/bin/bash
# ═══════════════════════════════════════════════════════════════
#  PORTFOLIO PULSE — Recent activity across all repos
#  Part of code-buddy. Run manually or via Claude Code hook.
#
#  Usage:
#    portfolio-pulse.sh              — full scan, write RECENT-ACTIVITY.md
#    portfolio-pulse.sh --quick      — last 7 days only, stdout
#    portfolio-pulse.sh --json       — machine-readable output
# ═══════════════════════════════════════════════════════════════

CONFIG_FILE="${HOME}/.code-buddy/config.json"
if [ -f "$CONFIG_FILE" ]; then
  PORTFOLIO="${CODEBUDDY_PORTFOLIO:-$(python3 -c "import json; print(json.load(open('$CONFIG_FILE')).get('portfolio_dir',''))" 2>/dev/null)}"
else
  PORTFOLIO="${CODEBUDDY_PORTFOLIO:-}"
fi
if [ -z "$PORTFOLIO" ] || [ ! -d "$PORTFOLIO" ]; then
  echo "Error: Portfolio directory not configured. Run: code-buddy config set portfolio_dir /path" >&2
  exit 1
fi
OUTPUT="$PORTFOLIO/RECENT-ACTIVITY.md"
DAYS="${CODEBUDDY_DAYS:-7}"
MODE="${1:---full}"

C='\033[0;36m' G='\033[0;32m' Y='\033[0;33m' N='\033[0m'

scan_repo() {
  local dir="$1"
  local name
  name=$(basename "$dir")
  local folder
  folder=$(basename "$(dirname "$dir")")
  local last_commit_msg=""
  local last_commit_date=""
  local changelog_date=""
  local changelog_entry=""

  # Git last commit
  if [ -d "$dir/.git" ]; then
    last_commit_date=$(git -C "$dir" log -1 --format="%ci" 2>/dev/null | cut -c1-16)
    last_commit_msg=$(git -C "$dir" log -1 --format="%s" 2>/dev/null | head -c 80)
    local dirty
    dirty=$(git -C "$dir" status --porcelain 2>/dev/null | wc -l)
    if [ "$dirty" -gt 0 ]; then
      last_commit_msg="$last_commit_msg [${dirty} uncommitted]"
    fi
  fi

  # Changelog last entry
  local cl=""
  for f in "$dir/changelog.md" "$dir/CHANGELOG.md" "$dir/Changelog.md"; do
    [ -f "$f" ] && cl="$f" && break
  done
  if [ -n "$cl" ]; then
    changelog_date=$(grep -oP '^\d{4}-\d{2}-\d{2}' "$cl" 2>/dev/null | head -1)
    changelog_entry=$(grep -A1 "^## \|^### \|^\d{4}-\d{2}-\d{2}" "$cl" 2>/dev/null | head -2 | tail -1 | head -c 80)
  fi

  # Most recent file modification (source files only)
  local newest_file
  newest_file=$(find "$dir" -maxdepth 3 \( -name "*.ts" -o -name "*.js" -o -name "*.py" -o -name "*.tsx" -o -name "*.jsx" \) -not -path "*/node_modules/*" -not -path "*/.git/*" -printf "%T+ %p\n" 2>/dev/null | sort -r | head -1)
  local newest_date
  newest_date=$(echo "$newest_file" | cut -c1-16 | tr 'T' ' ' 2>/dev/null)
  local newest_path
  newest_path=$(echo "$newest_file" | awk '{print $2}' | sed "s|$dir/||" 2>/dev/null)

  # Pick the most recent date from all sources
  local best_date=""
  for d in "$last_commit_date" "$changelog_date" "$newest_date"; do
    if [ -n "$d" ] && [[ "$d" > "$best_date" ]]; then
      best_date="$d"
    fi
  done

  echo "$best_date|$folder|$name|$last_commit_msg|$changelog_entry|$newest_path"
}

# Scan all folders
scan_all() {
  for folder in 00-ACTIVE 00-WORKBENCH 00-QUEUE 00-ICEBOX 00-OTHER; do
    local base="$PORTFOLIO/$folder"
    [ ! -d "$base" ] && continue
    for repo in "$base"/*/; do
      [ ! -d "$repo" ] && continue
      # Skip node_modules and non-repo dirs
      [ "$(basename "$repo")" = "node_modules" ] && continue
      [ "$(basename "$repo")" = "fitness-test-artifacts" ] && continue
      [ "$(basename "$repo")" = "stale-reports" ] && continue
      scan_repo "$repo"
    done
  done

  # GITHUB has subcategories
  for category in "$PORTFOLIO"/00-GITHUB/*/; do
    [ ! -d "$category" ] && continue
    for repo in "$category"/*/; do
      [ ! -d "$repo" ] && continue
      scan_repo "$repo"
    done
  done
}

generate_report() {
  local cutoff
  cutoff=$(date -d "$DAYS days ago" +%Y-%m-%d 2>/dev/null || date -v-"${DAYS}"d +%Y-%m-%d 2>/dev/null)
  local all_data
  all_data=$(scan_all | sort -r)
  local now
  now=$(date "+%Y-%m-%d %H:%M")

  {
    echo "# RECENT ACTIVITY"
    echo "### Generated: $now | Last $DAYS days"
    echo ""
    echo "---"
    echo ""

    # Active work (last 7 days)
    echo "## This Week"
    echo ""
    echo "| When | Folder | Repo | Last Change |"
    echo "|------|--------|------|-------------|"

    echo "$all_data" | while IFS='|' read -r date folder name commit changelog newest; do
      [ -z "$date" ] && continue
      local short_date
      short_date=$(echo "$date" | cut -c1-10)
      [ -z "$short_date" ] && continue
      if [[ "$short_date" > "$cutoff" ]] || [[ "$short_date" == "$cutoff" ]]; then
        local detail="$commit"
        [ -z "$detail" ] && detail="$changelog"
        [ -z "$detail" ] && detail="file: $newest"
        echo "| $short_date | $folder | **$name** | $detail |"
      fi
    done

    echo ""
    echo "## Stale (no activity in $DAYS+ days)"
    echo ""

    local stale_count=0
    echo "$all_data" | while IFS='|' read -r date folder name commit changelog newest; do
      [ -z "$date" ] && continue
      local short_date
      short_date=$(echo "$date" | cut -c1-10)
      if [[ -n "$short_date" ]] && [[ "$short_date" < "$cutoff" ]]; then
        if [ "$folder" = "00-ACTIVE" ] || [ "$folder" = "00-WORKBENCH" ]; then
          echo "- **$name** ($folder) — last activity: $short_date"
          stale_count=$((stale_count + 1))
        fi
      fi
    done

    echo ""
    echo "---"
    echo "*Run \`portfolio-pulse.sh\` to regenerate. Auto-runs on session start via code-buddy hook.*"
  } > "$OUTPUT"

  echo -e "${G}Report written to $OUTPUT${N}"
}

quick_report() {
  local cutoff
  cutoff=$(date -d "$DAYS days ago" +%Y-%m-%d 2>/dev/null || date -v-"${DAYS}"d +%Y-%m-%d 2>/dev/null)
  scan_all | sort -r | while IFS='|' read -r date folder name commit changelog newest; do
    [ -z "$date" ] && continue
    local short_date
    short_date=$(echo "$date" | cut -c1-10)
    if [[ "$short_date" > "$cutoff" ]] || [[ "$short_date" == "$cutoff" ]]; then
      local detail="$commit"
      [ -z "$detail" ] && detail="$changelog"
      [ -z "$detail" ] && detail="$newest"
      echo -e "${G}$short_date${N} ${C}$folder${N}/${Y}$name${N} — $detail"
    fi
  done
}

case "$MODE" in
  --quick) quick_report ;;
  --json)  scan_all | sort -r | awk -F'|' '{printf "{\"date\":\"%s\",\"folder\":\"%s\",\"repo\":\"%s\",\"commit\":\"%s\",\"changelog\":\"%s\",\"file\":\"%s\"}\n",$1,$2,$3,$4,$5,$6}' ;;
  *)       generate_report ;;
esac
