# Knowledge Synthesis Guide

Rules for combining web search results into actionable knowledge that an agent can use during development.

## Goal

Produce knowledge that directly answers: "When I'm implementing X, what should I do and what should I avoid?"

NOT academic summaries. NOT exhaustive surveys. Actionable, opinionated, current guidance.

## Deduplication

- Multiple sources say the same thing → one entry, multiple attributions, higher confidence
- Use the most specific/concrete formulation

## Conflict Resolution

1. Higher weight source wins (see source-registry.md)
2. Equal weight → newer source wins
3. Equal weight + same date → mark `contested`, present both with context
4. Always record conflicts even when resolved

## Confidence Levels (per claim)

| Level | Criteria |
|-------|----------|
| `verified` | 2+ sources with weight ≥ 4 agree, OR 1 weight=5 source explicitly states |
| `emerging` | Single source, or only low-weight sources, or described as experimental |
| `contested` | Sources disagree |

## Overall Confidence

| Level | Criteria |
|-------|----------|
| HIGH | 4+ sources, no major conflicts, ≥ 2 high-weight sources |
| MEDIUM | 2-3 sources, or minor conflicts |
| LOW | Single source, or major unresolved contradictions |

## Incremental Merge (when updating existing knowledge)

1. Never discard existing claims unless a newer higher-weight source explicitly contradicts
2. Upgrade confidence when new sources confirm existing claims
3. Downgrade (don't delete) when contradicted
4. Update Timeline with changes
