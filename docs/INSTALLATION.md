# Installation

## Quick Install

```bash
git clone https://github.com/sanchez314c/code-buddy.git
cd code-buddy
./install.sh
```

## Manual Install

```bash
chmod +x code-buddy portfolio-pulse.sh
ln -sf "$(pwd)/code-buddy" ~/bin/code-buddy
ln -sf "$(pwd)/portfolio-pulse.sh" ~/bin/portfolio-pulse.sh
```

Create config:
```bash
mkdir -p ~/.code-buddy
echo '{"portfolio_dir":"/path/to/your/repos","active_cap":7,"pulse_days":7}' > ~/.code-buddy/config.json
```

## Requirements

- bash 4+
- git
- Python 3.8+
- jq (optional)
- Linux or macOS
