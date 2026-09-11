# Formatação Correta — ChatGPT Web Agent Memory

Persistent knowledge, reusable skills, provenance, and execution history for the **FORMATAÇÃO CORRETA** project.

## What this repository is

This repository is **not another agent runtime**.

- **ChatGPT Web** is the agent.
- **GitHub** is the canonical, versioned store for skills, memory, knowledge, provenance, plans, and execution artifacts.
- Professional projects in `upstream/` are references for mechanisms we adapt; they are not installed runtimes.

## Core capabilities

The active skill layer is intentionally small and composable:

- `adaptive-orchestrator` — selects the capabilities/tools actually needed;
- `knowledge-retrieval` — retrieves minimal prior context progressively;
- `planner` — plans result-oriented phases;
- `deep-investigator` — researches until a decision specification is possible;
- `phase-executor` — packages user-executed scripts when needed;
- `verifier` — requires claim→evidence proof before success;
- `memory-manager` — updates/merges/links/compacts canonical memory;
- `template-engineer` — evolves Markdown schemas for retrieval/auditability;
- `knowledge-linker` — maintains durable relations between knowledge;
- `skill-improver` — turns validated reusable learning into reviewed skill proposals.

These are capabilities, **not a fixed pipeline**.

## Progressive retrieval

The repository adapts an L0/L1/L2 context model:

- **L0 — Abstract:** quick relevance signal.
- **L1 — Overview:** enough context for planning/navigation.
- **L2 — Detail:** full evidence/content loaded only when it can change the decision.

The layers are logical. They do not force `.abstract.md`/`.overview.md` files for every note.

GitHub search/fetch is the baseline retrieval mechanism. Semantic/vector retrieval is optional only if a connected ChatGPT tool actually exposes it.

## Memory behavior

The agent retrieves existing knowledge before writing.

Preferred lifecycle operations:

`UPDATE / MERGE / LINK / SPLIT / PROMOTE / COMPACT / ARCHIVE / CREATE / DISCARD`

Creating a new file is exceptional when an existing canonical artifact can be updated or linked.

## Skill learning

A successful run does not silently rewrite the agent's skills.

Reusable learning follows:

```text
validated experience
      ↓
classify learning
      ↓
find existing skill
      ↓
propose minimal change
      ↓
isolated branch / diff
      ↓
verification
      ↓
review / promotion
```

Case-specific findings stay in memory. Only generalizable, sufficiently evidenced procedure changes become skill-improvement proposals.

## Research and execution

Research exists to produce a decision:

- **Collection Specification** — defines what evidence must be collected.
- **Resolution Specification** — defines the selected solution and proof of success.

For local scripts, 2–3 executions per phase is the default efficiency budget, not an absolute ceiling. Additional execution requires evidence that it is the shortest validated route; otherwise the phase is replanned.

## Repository organization

The exact memory/knowledge layout may evolve as retrieval patterns evolve.

Important stable entry points:

- `AGENTS.md` — operating contract;
- `MEMORY_INDEX.md` — routing cache, not a full filesystem map;
- `skills/` — active adapted capabilities;
- `upstream/` — preserved/reference material from professional projects;
- `docs/superpowers/` — architecture specs and implementation plans.

Existing `memory/`, `research/`, and `tasks/` content may still contain useful project state, but these directories are not a permanent taxonomy contract.

## Upstream mechanisms

The project currently draws from professional work including:

- Superpowers;
- addyosmani/agent-skills;
- GitHub Awesome Copilot;
- planning-with-files;
- DeerFlow;
- GPT Researcher;
- Mem0/LlamaIndex concepts;
- Hermes Agent learning/skill evolution;
- OpenViking progressive context/retrieval concepts.

See `skills/PROVENANCE.md` and each `upstream/*/REFERENCE.md` for scope and origin.

## Runtime boundary

The active architecture does **not** require or assume:

- Hermes runtime;
- OpenViking server;
- LangGraph runtime;
- local autonomous agent;
- vector database;
- local subagents;
- background learning daemon.

Those capabilities exist only if ChatGPT Web exposes a connected tool providing them in the future.
