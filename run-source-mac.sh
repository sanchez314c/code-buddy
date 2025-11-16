#!/bin/bash
# Run Code Buddy from source (macOS)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$SCRIPT_DIR/code-buddy" "$@"
