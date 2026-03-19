# Source Registry

## Weight Scale

- **5** — First-party official (vendor docs, API reference, original authors)
- **4** — Recognized domain expert (established researchers, core contributors)
- **3** — Quality secondary (well-researched technical blogs)
- **2** — Community (tutorials, forums, discussions)
- **1** — Unknown (default for unlisted domains)

Conflict resolution: higher weight wins. Equal weight → newer wins. Still tied → mark "contested".

## AI Agents Domain

| Source | Domain | Weight | Topics |
|--------|--------|--------|--------|
| Anthropic Docs & Blog | anthropic.com, docs.anthropic.com | 5 | agent, context-engineering, claude, mcp, tool-use |
| OpenAI Docs & Blog | openai.com, platform.openai.com | 5 | agent, function-calling, tool-use |
| Lilian Weng Blog | lilianweng.github.io | 5 | agent, memory, planning, rag |
| LangChain/LangGraph | blog.langchain.com, python.langchain.com | 4 | agent, rag, memory, langgraph, tool-use |
| Simon Willison Blog | simonwillison.net | 4 | llm, agent, tools, mcp |
| arXiv | arxiv.org | 4 | agent, research, memory, planning |
| Google DeepMind | deepmind.google | 4 | research, agent, reasoning |
| HuggingFace | huggingface.co | 4 | model, tools, agent |
| Chip Huyen | huyenchip.com | 4 | agent, mlops, evaluation |
| CrewAI / AutoGen Docs | docs.crewai.com, microsoft.github.io/autogen | 3 | multi-agent, orchestration |
