# agent-align

Knowledge alignment skills for AI coding agents. Keeps agent knowledge current by searching the web for latest practices and synthesizing actionable guidance into a local knowledge base.

## Why

AI coding agents have training cutoffs. Fast-moving domains (MCP, agent architecture, new frameworks) go stale quickly. Run `/align <topic>` before working in these areas to sync the agent's knowledge with what's current.

## Skills

### `/align <topic>`
Full knowledge alignment. Searches the web, synthesizes findings into opinionated, implementation-ready guidance, and persists to `~/.claude/knowledge/<topic>/`.

```
/align mcp-tools
/align context-engineering
/align agent-memory
```

### `/align-check <topic>`
Lightweight freshness check. Scans for recent changes and updates existing knowledge without a full rebuild.

```
/align-check mcp-tools
```

## Supported Agents

All agents use the same `SKILL.md` format — only the install path differs.

| Agent | Skills Path | Install |
|-------|-------------|---------|
| [Claude Code](https://claude.ai/code) | `~/.claude/skills/` | auto |
| [OpenCode](https://opencode.ai) | `~/.claude/skills/` | auto (+ remote discovery) |
| [Cursor](https://cursor.com) | `~/.claude/skills/` | auto |
| [Qoder](https://qoder.dev) | `~/.claude/skills/` | auto |
| [Codex](https://github.com/openai/codex) | `~/.codex/skills/` + `~/.agents/skills/` | auto |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | `~/.gemini/skills/` | auto |

`install.sh` detects which agents are present and symlinks to each agent's directory automatically.

## Install

**One command — clone + symlink, auto-updates with `git pull`:**

```bash
curl -fsSL https://raw.githubusercontent.com/kevinWangSheng/agent-align/main/install.sh | bash
```

The script clones the repo to `~/.agent-align/` and creates symlinks in `~/.claude/skills/`. All three agents read that directory natively — no further setup needed.

**Update skills later:**

```bash
git -C ~/.agent-align pull
```

### OpenCode Remote Discovery (no git needed)

```bash
opencode skill add https://raw.githubusercontent.com/kevinWangSheng/agent-align/main/
```

## Knowledge Storage

Knowledge files are stored in `~/.claude/knowledge/<slug>/`:

```
~/.claude/knowledge/
├── _index.md              # topic index with freshness status
├── mcp-tools/
│   ├── latest.md          # synthesized knowledge
│   └── sources.md         # source attribution
└── agent-memory/
    ├── latest.md
    └── sources.md
```

Knowledge files are local to your machine and not committed to this repo.

## Source Registry

`align/references/source-registry.md` defines trusted sources with weights (1–5). Higher-weight sources win conflicts. You can extend the registry with domain-specific sources.

## License

MIT
