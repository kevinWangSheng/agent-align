#!/usr/bin/env bash
# agent-align installer
# Clones (or updates) the repo and symlinks skills into ~/.claude/skills/.
# After install, `git pull` inside the repo keeps skills up to date automatically.

set -e

REPO_URL="https://github.com/kevinWangSheng/agent-align.git"
INSTALL_DIR="${AGENT_ALIGN_DIR:-$HOME/.agent-align}"
SKILLS_DIR="$HOME/.claude/skills"

# ── Clone or update ──────────────────────────────────────────────────────────
if [ -d "$INSTALL_DIR/.git" ]; then
  echo "Updating $INSTALL_DIR ..."
  git -C "$INSTALL_DIR" pull --ff-only
else
  echo "Cloning into $INSTALL_DIR ..."
  git clone --depth 1 "$REPO_URL" "$INSTALL_DIR"
fi

# ── Symlink skills ────────────────────────────────────────────────────────────
mkdir -p "$SKILLS_DIR"

for skill_dir in "$INSTALL_DIR"/*/; do
  skill_name="$(basename "$skill_dir")"
  # skip non-skill dirs
  [ -f "$skill_dir/SKILL.md" ] || continue

  target="$SKILLS_DIR/$skill_name"
  if [ -L "$target" ]; then
    # already a symlink — update if pointing elsewhere
    current="$(readlink "$target")"
    if [ "$current" != "$skill_dir" ]; then
      ln -sfn "$skill_dir" "$target"
      echo "  updated symlink: $target"
    fi
  elif [ -d "$target" ]; then
    echo "  warning: $target exists as a real directory, skipping (remove it manually to use the symlink)"
  else
    ln -s "$skill_dir" "$target"
    echo "  linked: $target -> $skill_dir"
  fi
done

# ── Done ─────────────────────────────────────────────────────────────────────
echo ""
echo "Done. Skills active:"
for skill_dir in "$INSTALL_DIR"/*/; do
  [ -f "$skill_dir/SKILL.md" ] || continue
  echo "  /$( basename "$skill_dir" )"
done
echo ""
echo "Agents supported (read ~/.claude/skills/ natively):"
echo "  Claude Code · OpenCode · Qoder"
echo ""
echo "To update skills later:"
echo "  git -C $INSTALL_DIR pull"
echo ""
echo "OpenCode remote discovery (alternative, no git needed):"
echo "  opencode skill add https://raw.githubusercontent.com/kevinWangSheng/agent-align/main/"
