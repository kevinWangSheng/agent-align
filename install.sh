#!/usr/bin/env bash
# agent-align installer
# Installs /align and /align-check skills for Claude Code, OpenCode, and Qoder.
# All three agents natively read skills from ~/.claude/skills/.

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"

echo "Installing agent-align skills to $SKILLS_DIR ..."

# align
mkdir -p "$SKILLS_DIR/align/references"
cp "$REPO_DIR/align/SKILL.md" "$SKILLS_DIR/align/SKILL.md"
cp "$REPO_DIR/align/references/source-registry.md" "$SKILLS_DIR/align/references/source-registry.md"
cp "$REPO_DIR/align/references/synthesis-guide.md" "$SKILLS_DIR/align/references/synthesis-guide.md"

# align-check
mkdir -p "$SKILLS_DIR/align-check"
cp "$REPO_DIR/align-check/SKILL.md" "$SKILLS_DIR/align-check/SKILL.md"

echo ""
echo "Done. Skills installed:"
echo "  ~/.claude/skills/align/"
echo "  ~/.claude/skills/align-check/"
echo ""
echo "Supported agents (read ~/.claude/skills/ natively):"
echo "  Claude Code  — use /align <topic>"
echo "  OpenCode     — use /align <topic>"
echo "  Qoder        — use /align <topic>"
echo ""
echo "OpenCode remote discovery (alternative):"
echo "  opencode skill add https://raw.githubusercontent.com/kevinWangSheng/agent-align/main/"
