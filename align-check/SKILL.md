---
name: align-check
description: "Quick check if stored knowledge on a topic is still current. Lighter than /align — searches for recent changes and compares against existing knowledge."
allowed-tools: WebSearch, WebFetch, Read, Write, Grep, Glob, Bash
argument-hint: <topic>
disable-model-invocation: true
---

# /align-check — Knowledge Freshness Check

Quick check whether stored knowledge on `$ARGUMENTS` is still current.

---

## Step 1: Find Existing Knowledge

1. Normalize `$ARGUMENTS` to slug (strip `--force` flag if present).
2. Search `~/.claude/knowledge/_index.md` and Grep aliases.
3. **Not found**: report `❌ No knowledge for "<topic>". Run /align <topic> first.` Stop.

## Step 2: Assess Freshness

1. Read `~/.claude/knowledge/<slug>/latest.md`.
2. Extract `last_verified`, `last_full_align`, `confidence`.
3. Freshness:
   - **< 3 days since last_verified**: report "Still fresh (verified N days ago)." Stop. Unless `--force` was in `$ARGUMENTS`.
   - **3-30 days**: proceed.
   - **> 30 days**: warn "Significantly outdated — consider `/align <topic>` instead." Still proceed.
4. Note key claims and Open Questions for comparison.

## Step 3: Lightweight Search

**Limits: max 3 WebSearch, max 3 WebFetch.**

Read source-registry from `~/.claude/skills/align/references/source-registry.md`.

1. `"<topic> new developments 2025 2026"`
2. `"<topic> best practices changes latest"`
3. (Optional) Search top Open Question from existing knowledge.

Select top 2-3 URLs (prefer last 3 months, high registry weight). WebFetch each.

Focus extraction on: **what changed** since `last_verified`, new patterns/tools, contradictions to existing claims.

## Step 4: Compare

Classify overall status:

- **CURRENT ✅**: no significant new info, existing claims still hold
- **UPDATES 🔄**: new supplementary info, no contradictions
- **OUTDATED ⚠️**: existing claims contradicted by newer authoritative sources

## Step 5: Persist & Report

### Always:
- Update `last_verified` in latest.md frontmatter
- Update `Last Verified` and `Status` in _index.md

### If UPDATES:
Append to `## Recent Updates` in latest.md:
```markdown
### Update: <today>
- [finding] — [source] — [confidence]
```

### If OUTDATED:
Append warning to Recent Updates. Do NOT rewrite main content. Recommend `/align <topic>`.

### Report:

**CURRENT**:
```
✅ <Topic> — knowledge is current (checked <N> sources)
```

**UPDATES**:
```
🔄 <Topic> — updates found:
1. [new finding]
2. [new finding]
Appended to ~/.claude/knowledge/<slug>/latest.md
```

**OUTDATED**:
```
⚠️ <Topic> — knowledge outdated:
1. [what changed]
Run /align <topic> to rebuild.
```
