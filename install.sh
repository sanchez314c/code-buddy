#!/bin/bash
# Code Buddy Installer

C='\033[0;36m' G='\033[0;32m' Y='\033[0;33m' N='\033[0m'
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${C}Installing Code Buddy...${N}"

# Make scripts executable
chmod +x "$SCRIPT_DIR/code-buddy"
chmod +x "$SCRIPT_DIR/portfolio-pulse.sh"

# Symlink to ~/bin or /usr/local/bin
if [ -d "$HOME/bin" ]; then
  ln -sf "$SCRIPT_DIR/code-buddy" "$HOME/bin/code-buddy"
  ln -sf "$SCRIPT_DIR/portfolio-pulse.sh" "$HOME/bin/portfolio-pulse"
  echo -e "${G}Linked to ~/bin/code-buddy${N}"
elif [ -w "/usr/local/bin" ]; then
  ln -sf "$SCRIPT_DIR/code-buddy" "/usr/local/bin/code-buddy"
  ln -sf "$SCRIPT_DIR/portfolio-pulse.sh" "/usr/local/bin/portfolio-pulse"
  echo -e "${G}Linked to /usr/local/bin/code-buddy${N}"
else
  echo -e "${Y}Add $SCRIPT_DIR to your PATH, or symlink manually.${N}"
fi

# Ask for portfolio directory
echo ""
read -rp "Portfolio directory (e.g. /path/to/your/repos): " portfolio_dir

if [ -n "$portfolio_dir" ] && [ -d "$portfolio_dir" ]; then
  mkdir -p "$HOME/.code-buddy"
  cat > "$HOME/.code-buddy/config.json" << EOF
{
  "portfolio_dir": "$portfolio_dir",
  "active_cap": 7,
  "pulse_days": 7,
  "folders": {
    "icebox": "00-ICEBOX",
    "workbench": "00-WORKBENCH",
    "active": "00-ACTIVE",
    "queue": "00-QUEUE",
    "shipped": "00-GITHUB",
    "other": "00-OTHER"
  }
}
EOF
  echo -e "${G}Config saved.${N}"

  # Create folders if they don't exist
  for folder in 00-ACTIVE 00-WORKBENCH 00-QUEUE 00-ICEBOX 00-GITHUB 00-OTHER; do
    mkdir -p "$portfolio_dir/$folder"
  done
  echo -e "${G}Folder structure created.${N}"

  # Initial scan
  echo ""
  echo -e "${C}Running initial scan...${N}"
  "$SCRIPT_DIR/code-buddy" scan
else
  echo -e "${Y}Skipped portfolio setup. Run 'code-buddy config set portfolio_dir /path' later.${N}"
fi

# Install hook
"$SCRIPT_DIR/code-buddy" hook install

echo ""
echo -e "${G}Code Buddy installed.${N}"
echo "Run 'code-buddy status' to see your portfolio."
echo "Run 'code-buddy triage' to pick your ACTIVE repos."
