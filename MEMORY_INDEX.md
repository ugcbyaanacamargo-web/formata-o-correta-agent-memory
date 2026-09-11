# Memory Routing Index

This file is a **routing cache**, not a mandatory taxonomy and not a complete repository map.

## Runtime boundary

ChatGPT Web is the agent. GitHub stores canonical knowledge, skills, provenance, and execution history.

Do not route operational work to Hermes/OpenViking/LangGraph/Mem0/LlamaIndex runtimes. References under `upstream/` are mechanism sources only.

## Retrieval rule

Before relying on this index:

1. interpret the current goal;
2. use `skills/knowledge-retrieval/SKILL.md`;
3. validate pointers with GitHub search/fetch;
4. load progressively;
5. repair this index only when a stable pointer will reduce future retrieval cost.

## Progressive layers

Pointers may expose logical context layers:

- **L0** — short abstract/relevance signal;
- **L1** — planning/navigation overview;
- **L2** — full canonical detail/evidence.

These layers do not require separate files. `template-engineer` chooses the representation.

## What belongs here

Only high-value routing pointers, such as:

- current active state when it is reused frequently;
- active plan entry point;
- canonical knowledge hubs;
- frequently reused aliases;
- stable overview/index documents;
- important skill entry points;
- migration redirects after reorganization.

Do **not** enumerate every file.

## Canonical skill entry points

- `skills/adaptive-orchestrator/SKILL.md`
- `skills/knowledge-retrieval/SKILL.md`
- `skills/planner/SKILL.md`
- `skills/deep-investigator/SKILL.md`
- `skills/phase-executor/SKILL.md`
- `skills/verifier/SKILL.md`
- `skills/memory-manager/SKILL.md`
- `skills/template-engineer/SKILL.md`
- `skills/knowledge-linker/SKILL.md`
- `skills/skill-improver/SKILL.md`

## Maintenance policy

- update existing pointer before adding duplicate;
- remove obsolete pointer after verifying redirects/aliases;
- preserve aliases after reorganization;
- do not create domain sections because a topic appeared once;
- let taxonomy emerge from stable retrieval patterns;
- keep L0/L1 summaries synchronized with canonical detail when material changes occur.

## Legacy content

Existing `memory/`, `research/`, and `tasks/` directories may contain useful project history/state. They are **legacy content locations, not permanent architecture constraints**.

Use retrieval to discover whether their content remains canonical before creating new structures.
