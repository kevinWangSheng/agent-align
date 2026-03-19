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

| Agent | Support | How |
|-------|---------|-----|
| [Claude Code](https://claude.ai/code) | Native | reads `~/.claude/skills/` |
| [OpenCode](https://opencode.ai) | Native + Discovery | reads `~/.claude/skills/`, also supports remote pull |
| [Qoder](https://qoder.dev) | Native | reads `~/.claude/skills/` |

## Install

```bash
git clone https://github.com/kevinWangSheng/agent-align.git
cd agent-align
bash install.sh
```

Or manually copy the skill directories into `~/.claude/skills/`.

### OpenCode Remote Discovery

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
