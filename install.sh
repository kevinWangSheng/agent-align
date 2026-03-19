#!/usr/bin/env bash
# agent-align installer
# Detects installed coding agents and symlinks skills into each agent's skills directory.
# After install, `git pull` inside the repo keeps everything up to date automatically.
#
# Supported agents and their global skills paths:
#   Claude Code  → ~/.claude/skills/
#   OpenCode     → ~/.claude/skills/  (reads Claude's dir natively)
#   Cursor       → ~/.claude/skills/  (reads Claude's dir natively)
#   Qoder        → ~/.claude/skills/  (reads Claude's dir natively)
#   Codex        → ~/.codex/skills/   and ~/.agents/skills/
#   Gemini CLI   → ~/.gemini/skills/

set -e

REPO_URL="https://github.com/kevinWangSheng/agent-align.git"
INSTALL_DIR="${AGENT_ALIGN_DIR:-$HOME/.agent-align}"

# ── Clone or update ──────────────────────────────────────────────────────────
if [ -d "$INSTALL_DIR/.git" ]; then
  echo "Updating $INSTALL_DIR ..."
  git -C "$INSTALL_DIR" pull --ff-only
else
  echo "Cloning into $INSTALL_DIR ..."
  git clone --depth 1 "$REPO_URL" "$INSTALL_DIR"
fi

# ── Helpers ───────────────────────────────────────────────────────────────────
link_skills() {
  local target_dir="$1"
  local agent_name="$2"
  local linked=0

  mkdir -p "$target_dir"

  for skill_dir in "$INSTALL_DIR"/*/; do
    [ -f "$skill_dir/SKILL.md" ] || continue
    local skill_name
    skill_name="$(basename "$skill_dir")"
    local target="$target_dir/$skill_name"

    if [ -L "$target" ]; then
      ln -sfn "$skill_dir" "$target"
    elif [ -d "$target" ]; then
      echo "  warning [$agent_name]: $target is a real directory — skipping (remove it manually)"
      continue
    else
      ln -s "$skill_dir" "$target"
    fi
    linked=$((linked + 1))
  done

  if [ $linked -gt 0 ]; then
    echo "  ✓ $agent_name → $target_dir ($linked skills)"
  fi
}

is_installed() {
  command -v "$1" &>/dev/null
}

# ── Detect agents and link ─────────────────────────────────────────────────────
echo ""
echo "Linking skills ..."

# Claude Code / OpenCode / Cursor / Qoder — all read ~/.claude/skills/
if is_installed claude || is_installed opencode || is_installed cursor || is_installed qoder; then
  link_skills "$HOME/.claude/skills" "Claude Code / OpenCode / Cursor / Qoder"
elif [ -d "$HOME/.claude" ]; then
  link_skills "$HOME/.claude/skills" "Claude Code"
fi

# Codex — reads ~/.codex/skills/ (primary) and ~/.agents/skills/ (modern shared)
if is_installed codex || [ -d "$HOME/.codex" ]; then
  link_skills "$HOME/.codex/skills" "Codex"
  link_skills "$HOME/.agents/skills" "Codex (shared agents path)"
fi

# Gemini CLI — reads ~/.gemini/skills/
if is_installed gemini || [ -d "$HOME/.gemini" ]; then
  link_skills "$HOME/.gemini/skills" "Gemini CLI"
fi

# ── Summary ───────────────────────────────────────────────────────────────────
echo ""
echo "Skills available:"
for skill_dir in "$INSTALL_DIR"/*/; do
  [ -f "$skill_dir/SKILL.md" ] || continue
  echo "  /$(basename "$skill_dir")"
done
echo ""
echo "To update skills later:"
echo "  git -C $INSTALL_DIR pull"
echo ""
echo "OpenCode remote discovery (alternative, no git needed):"
echo "  opencode skill add https://raw.githubusercontent.com/kevinWangSheng/agent-align/main/"
