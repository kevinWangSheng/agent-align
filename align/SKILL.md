---
name: align
description: "Search the web for a topic's latest practices, synthesize into actionable knowledge, and persist to ~/.claude/knowledge/. Use before development tasks involving fast-moving domains where training data may be outdated."
allowed-tools: WebSearch, WebFetch, Read, Write, Grep, Glob, Bash
argument-hint: <topic>
disable-model-invocation: true
---

# /align — Knowledge Alignment

Research `$ARGUMENTS` and produce actionable, implementation-ready knowledge. This knowledge will be used by the agent during development — optimize for "what to do and what to avoid", not academic completeness.

---

## Step 1: Normalize Topic

1. `$ARGUMENTS` → slug: lowercase, hyphens, no articles. E.g. "Context Engineering" → `context-engineering`
2. Alias dedup: Grep `~/.claude/knowledge/` for `aliases:` lines matching the topic. If found, reuse that slug.
3. **If topic is too broad** (e.g. "artificial intelligence", "programming"): list 3-5 sub-topics, ask user to pick. Stop.

## Step 2: Check Existing Knowledge

1. Glob for `~/.claude/knowledge/<slug>/latest.md`.
2. If exists: read it, extract `last_full_align` date.
   - Within 7 days: tell user "Aligned N days ago. Proceeding with full refresh." Note existing Open Questions for targeted search.
3. If not exists: new topic.

## Step 3: Search

Read `~/.claude/skills/align/references/source-registry.md`. Identify relevant high-weight domains.

**Limits: max 5 WebSearch, max 6 WebFetch.**

### Searches (3-5 calls):
1. `"<topic> best practices 2025 2026"`
2. `"<topic> architecture implementation guide"`
3. `"<topic>" site:<high-weight-domain-1> OR site:<high-weight-domain-2>` (pick from registry)
4. `"<topic> new developments 2025 2026"`
5. (If existing knowledge has Open Questions) Search the most important one.

### URL Selection:
Score: `registry_weight × recency × relevance`. Take top 4-6. Prefer source diversity.

### WebFetch:
For each URL, extract:
- Concrete implementation guidance (do this, don't do that)
- Code patterns and API usage
- Architecture decisions and tradeoffs
- What's new/changed recently

**If all searches fail**: keep existing knowledge (update `last_verified`) or report failure. Do NOT create empty files.
**If a WebFetch fails**: skip it, log in sources.md.

## Step 4: Synthesize

Read `~/.claude/skills/align/references/synthesis-guide.md` and follow its rules.

Focus on producing **actionable guidance**:
- "When building X, use Y because Z"
- "Don't do X, it causes Y — use Z instead"
- "The current standard API/pattern for X is Y"

NOT: "Various approaches exist for X, including..."

Assign confidence per claim. Compute overall confidence.

## Step 5: Persist

### Write `~/.claude/knowledge/<slug>/latest.md`:

```markdown
---
topic: <Topic Name>
slug: <slug>
aliases: [<common alternative names>]
domain: <domain>
created: <YYYY-MM-DD, preserve if updating>
last_verified: <today>
last_full_align: <today>
confidence: <high/medium/low>
source_count: <N>
---

# <Topic Name>

> Last aligned: <today> | Confidence: <LEVEL> | Sources: <N>

## TL;DR
[2-3 sentences: the most important things to know RIGHT NOW]

## Do This
[Numbered list of current best practices with source attribution and confidence]
1. **[Practice]** — [why / how] — [source] — [confidence]

## Don't Do This
[Anti-patterns with reasoning]
1. **[Anti-pattern]** — [why it's bad] — [what to do instead] — [source]

## Key Implementation Patterns
### [Pattern Name]
- **When**: [when to use]
- **How**: [concrete implementation guidance, APIs, code patterns]
- **Source**: [attribution]

## Current APIs & Tools
[If applicable: current SDK versions, API endpoints, tool names that the agent should use]

## Contested / Evolving
[Claims where sources disagree or things are actively changing]
- [Claim] — [Source A says X, Source B says Y]

## Open Questions
[Unresolved topics — useful for future /align-check]

## Timeline
- **YYYY-MM**: [change] — [source]

## Recent Updates
<!-- /align-check appends here -->
```

Skip empty sections except TL;DR and Do This (always required).

### Write `~/.claude/knowledge/<slug>/sources.md`:

```markdown
# Sources: <Topic Name>

Updated: <today>

| # | URL | Domain | Weight | Status | Claims |
|---|-----|--------|--------|--------|--------|
| 1 | url | domain | weight | ✅/❌ | N |

## Searches
1. `<query>` — N results
```

### Update `~/.claude/knowledge/_index.md`:
Add or update the topic row. Status = `FRESH`.

## Step 6: Report

Brief output to user:

```
✅ Aligned: <Topic> | Confidence: <LEVEL> | Sources: <N>
Top takeaways:
1. [most important actionable finding]
2. [second]
3. [third]
📁 ~/.claude/knowledge/<slug>/
```
