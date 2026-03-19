# Source Registry

## Weight Scale

- **5** — First-party official (vendor docs, API reference, original authors)
- **4** — Recognized domain expert (established researchers, core contributors)
- **3** — Quality secondary (well-researched technical blogs, active community hubs)
- **2** — Community (tutorials, forums, discussions)
- **1** — Unknown (default for unlisted domains)

Conflict resolution: higher weight wins. Equal weight → newer wins. Still tied → mark "contested".

## Update Frequency Guide

Use this to prioritize sources by how fast the topic moves:

| Frequency | Best Sources |
|-----------|-------------|
| Real-time (days) | GitHub releases/changelog, X/Twitter authors, Discord announcements |
| Fast (weeks) | Official blogs, HN top threads, project README changes |
| Moderate (months) | Technical deep-dives, benchmark posts, architecture guides |
| Slow (quarters+) | arXiv papers, Lilian Weng, academic surveys |

For fast-moving topics (agent frameworks, MCP, tool-use APIs): prioritize real-time + fast sources even if weight is lower.

---

## AI Agents — Official / First-Party (Weight 5)

| Source | Domain | Weight | Topics |
|--------|--------|--------|--------|
| Anthropic Docs & Blog | anthropic.com, docs.anthropic.com | 5 | agent, context-engineering, claude, mcp, tool-use |
| OpenAI Docs & Blog | openai.com, platform.openai.com | 5 | agent, function-calling, tool-use, responses-api |
| Google AI / Gemini Docs | ai.google.dev, cloud.google.com/vertex-ai | 5 | gemini, agent, tool-use, adk |
| MCP Specification | modelcontextprotocol.io, spec.modelcontextprotocol.io | 5 | mcp, tool-use, protocol |
| LangChain / LangGraph Docs | python.langchain.com, langchain-ai.github.io/langgraph | 5 | langgraph, agent, memory, tool-use |
| Microsoft AutoGen Docs | microsoft.github.io/autogen, autogen-ai.github.io | 5 | multi-agent, orchestration, autogen |
| CrewAI Docs | docs.crewai.com | 5 | multi-agent, orchestration, crewai |
| Pydantic AI Docs | ai.pydantic.dev | 5 | agent, structured-output, tool-use |
| OpenCode Docs | opencode.ai | 5 | coding-agent, opencode |
| Codex / OpenAI Codex Docs | platform.openai.com/docs/codex | 5 | coding-agent, codex |

## AI Agents — Expert Researchers / Core Contributors (Weight 4)

| Source | Domain | Weight | Topics |
|--------|--------|--------|--------|
| Lilian Weng Blog | lilianweng.github.io | 4 | agent, memory, planning, rag — slow cadence, high depth |
| Simon Willison Blog | simonwillison.net | 4 | llm, agent, tools, mcp — frequent, practitioner-focused |
| Chip Huyen | huyenchip.com | 4 | agent, mlops, evaluation |
| Swyx / Latent Space | latent.space, swyx.io | 4 | agent, llm-ops, coding-agent, industry-trends |
| Eugene Yan | eugeneyan.com | 4 | agent, evaluation, rag, production |
| Hamel Husain | hamel.dev | 4 | agent, evaluation, fine-tuning |
| Josh Tobin | joshtobin.com | 4 | agent, evaluation, evals |
| arXiv | arxiv.org | 4 | agent, research, memory, planning — slow cadence, high credibility |
| Google DeepMind Blog | deepmind.google | 4 | research, agent, reasoning |
| HuggingFace Blog | huggingface.co/blog | 4 | model, tools, agent, evals |

## AI Agents — Real-Time / High-Frequency Sources (Weight 3)

| Source | Domain | Weight | Topics |
|--------|--------|--------|--------|
| GitHub Releases & Changelogs | github.com/*/releases | 3 | any framework/tool — most up-to-date changelog |
| Hacker News (top threads) | news.ycombinator.com | 3 | agent, llm, tools — community signal on what's relevant now |
| Reddit r/LocalLLaMA | reddit.com/r/LocalLLaMA | 3 | agent, model, tool-use, local-inference |
| Reddit r/MachineLearning | reddit.com/r/MachineLearning | 3 | research, agent, evals |
| LangChain Blog | blog.langchain.com | 3 | langgraph, agent, memory, tool-use |
| Towards Data Science | towardsdatascience.com | 3 | agent, rag, evaluation — moderate quality, frequent |
| The Gradient | thegradient.pub | 3 | research, agent, deep analysis |
| Interconnects (Nathan Lambert) | interconnects.ai | 3 | llm, rlhf, agent alignment |

## AI Agents — X/Twitter Key Authors (Weight 3, Real-Time)

Search via `site:x.com` or by name. Treat as signal, verify with primary sources.

| Author | Handle | Topics |
|--------|--------|--------|
| Harrison Chase | @hwchase17 | langchain, langgraph, agent |
| Yohei Nakajima | @yoheinakajima | agent, babyagi, task-planning |
| Karpathy | @karpathy | llm, agent, software-2.0 |
| swyx | @swyx | coding-agent, llm-ops, industry |
| Greg Kamradt | @GregKamradt | context-window, rag, chunking |
| Jason Liu | @jxnlco | rag, structured-output, evaluation |

## Coding Agents — Specific (Weight 4–5)

| Source | Domain | Weight | Topics |
|--------|--------|--------|--------|
| Claude Code Docs | docs.anthropic.com/claude-code | 5 | claude-code, hooks, mcp, skills |
| Cursor Docs | docs.cursor.com | 5 | cursor, rules, agent-mode |
| Windsurf Docs | docs.windsurf.com | 5 | windsurf, cascade, agent-mode |
| Aider Docs & Blog | aider.chat | 5 | aider, coding-agent, benchmarks |
| Aider Leaderboard | aider.chat/docs/leaderboards | 5 | coding-agent, evals, benchmarks — SWE-bench scores |
| SWE-bench | swe-bench.github.io | 5 | coding-agent, evals, benchmarks |

## Evaluation & Benchmarks (Weight 4–5)

| Source | Domain | Weight | Topics |
|--------|--------|--------|--------|
| METR (ARC Evals) | metr.org | 5 | agent-evals, safety, task-automation |
| Holistic Evaluation (HELM) | crfm.stanford.edu/helm | 5 | llm-evals, benchmarks |
| BenchHub / LiveBench | livebench.ai | 4 | llm-evals, real-time benchmarks |
| OpenCompass | opencompass.org.cn | 4 | llm-evals, coding, agent |

## MCP Ecosystem (Weight 4–5)

| Source | Domain | Weight | Topics |
|--------|--------|--------|--------|
| MCP Spec | modelcontextprotocol.io | 5 | mcp, protocol, tool-use |
| Awesome MCP Servers | github.com/punkpeye/awesome-mcp-servers | 3 | mcp, server-list, ecosystem |
| MCP GitHub org | github.com/modelcontextprotocol | 5 | mcp, sdk, reference-impl |
