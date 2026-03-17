#!/usr/bin/env bash
# link-claude.sh
# Links PeveWave assets into ~/.claude for Claude Code

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${GREEN}[link]${NC} $1"; }
warn()    { echo -e "${YELLOW}[skip]${NC} $1"; }
error()   { echo -e "${RED}[error]${NC} $1"; }

# link_item <source> <target>
# Creates a symlink at <target> pointing to <source>.
# Skips if target is already the correct symlink.
# Backs up if target exists and is not a symlink.
link_item() {
  local src="$1"
  local target="$2"

  if [ ! -e "$src" ]; then
    error "Source not found: $src"
    return 1
  fi

  if [ -L "$target" ]; then
    local existing_src
    existing_src="$(readlink "$target")"
    if [ "$existing_src" = "$src" ]; then
      warn "Already linked: $target -> $src"
      return 0
    else
      warn "Replacing existing symlink: $target (was -> $existing_src)"
      rm "$target"
    fi
  elif [ -e "$target" ]; then
    local backup="${target}.bkp"
    warn "Backing up existing: $target -> $backup"
    mv "$target" "$backup"
  fi

  ln -s "$src" "$target"
  info "$target -> $src"
}

echo ""
echo "PeveWave → Claude Code"
echo "Project: $PROJECT_DIR"
echo "Target:  $CLAUDE_DIR"
echo ""

# wave/ subdirectories
link_item "$PROJECT_DIR/wave/agents"   "$CLAUDE_DIR/agents"
link_item "$PROJECT_DIR/wave/commands" "$CLAUDE_DIR/commands"
link_item "$PROJECT_DIR/wave/skills"   "$CLAUDE_DIR/skills"

# Root-level files
link_item "$PROJECT_DIR/AGENT.md"      "$CLAUDE_DIR/CLAUDE.md"
link_item "$PROJECT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
link_item "$PROJECT_DIR/statusline.sh" "$CLAUDE_DIR/statusline.sh"

echo ""
echo "Done."
