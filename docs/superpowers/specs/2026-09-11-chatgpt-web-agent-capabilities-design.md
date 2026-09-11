# ChatGPT Web Agent Capabilities Design

## Objective

Raise the repository's practical capability for **ChatGPT Web + connected GitHub** without installing any agent runtime, server, vector database, or local agent on the user's computer.

The repository is not the agent runtime. ChatGPT Web remains the agent. GitHub provides persistent skills, memory, knowledge, provenance, and reusable procedures.

## Design Principles

1. **Professional mechanisms before custom invention.** Adapt proven mechanisms from preserved upstream projects instead of replacing them with simplified prompts.
2. **Capability routing, not a fixed pipeline.** The agent discovers relevant skills and selects only the capabilities needed for the current state.
3. **Retrieval before loading.** Do not read the whole vault. Retrieve minimal relevant context, expand by strong relations, and load detail only when required.
4. **Layered context.** Adapt OpenViking's L0/L1/L2 idea to Markdown/GitHub: short abstract for fast relevance, overview for planning/navigation, detail for full evidence.
5. **Learn by updating, not accumulating.** Adapt Hermes `/learn`: inspect existing skills/memory first; extend or merge when possible; create only when no suitable canonical artifact exists.
6. **Skills can improve.** Repeated successful procedures may be generalized into an existing skill or a new one after evidence that the pattern is reusable.
7. **Evidence-gated completion.** Use verification before claiming success. Do not substitute confidence for evidence.
8. **Resolution efficiency.** Research and collection exist to make a decision. Stop research when additional sources no longer change the decision.
9. **No fake runtime claims.** Markdown instructions must not claim actual vector search, background execution, subagents, or autonomous local execution unless the connected ChatGPT environment actually provides those capabilities.
10. **GitHub remains auditable.** All persistent changes have provenance and are reviewable through commit history.

## Source Mechanisms to Preserve

### Hermes Agent

Use as reference for skill learning and evolution:
- inspect all sources/requirements before authoring;
- search for an existing skill first;
- extend an existing skill instead of creating a duplicate;
- use a lean `SKILL.md` plus on-demand `references/` for large knowledge sources;
- preserve a learning graph connecting learned skills and memory;
- allow skill/memory edit and archive semantics rather than uncontrolled duplication.

### OpenViking

Use as reference for retrieval-efficient context:
- **L0 Abstract**: very short relevance signal;
- **L1 Overview**: planning/navigation summary;
- **L2 Detail**: full source or canonical knowledge loaded on demand;
- retrieval should start small and deepen only when relevance is established;
- freshness/provenance metadata must distinguish current summaries from underlying detail.

### Superpowers / addyosmani / planning-with-files / awesome-copilot / DeerFlow / GPT Researcher

Preserve existing mechanisms already vendored in `upstream/` for:
- skill routing;
- planning;
- context engineering;
- source-driven research;
- systematic debugging;
- verification before completion;
- memory merge/remember;
- deep research breadth/depth;
- persistent task state.

## Capability Set

The active capability layer should remain small and composable:

- `adaptive-orchestrator`: selects capabilities and tools dynamically.
- `planner`: creates and revises result-oriented plans.
- `deep-investigator`: performs decision-oriented multi-source research.
- `knowledge-retrieval`: retrieves minimal relevant memory/knowledge before planning or writing.
- `memory-manager`: decides update/merge/link/split/promote/compact/archive/create/discard.
- `template-engineer`: chooses or evolves Markdown schemas for retrieval and auditability.
- `knowledge-linker`: resolves entities and durable relations.
- `skill-improver`: learns reusable procedures and improves existing skills without duplication.
- `phase-executor`: packages user-executed scripts when the task genuinely requires local execution.
- `verifier`: evidence gate for phase and task completion.

These are capabilities, not a required sequential pipeline.

## Retrieval Model for GitHub Markdown

Because GitHub-connected ChatGPT does not provide a guaranteed external vector store, retrieval must degrade gracefully:

1. Search by task terms, entities, aliases, IDs, filenames, and summaries.
2. Read **L0** abstracts or equivalent frontmatter summaries first.
3. Rank candidate notes by direct task relevance, recency/freshness, canonical status, provenance, and strong graph relations.
4. Read **L1** overview for top candidates.
5. Load **L2** detail only when it can change the plan or decision.
6. Expand one or two hops through high-value relations only when needed.
7. If semantic search becomes available through a connected tool in the future, use it as an additional candidate generator, not as a replacement for provenance and canonical notes.

## Memory Lifecycle

For every persistent learning:

1. Retrieve existing canonical artifacts first.
2. Decide whether the new information is transient or reusable.
3. Choose one operation: UPDATE, MERGE, LINK, SPLIT, PROMOTE, COMPACT, ARCHIVE, CREATE, DISCARD.
4. Maintain retrieval metadata: stable identity, aliases, short abstract, overview/navigation, provenance, freshness, relations.
5. Keep raw execution/source evidence separate from consolidated knowledge.
6. Periodically consolidate overlapping notes and preserve aliases/backlinks.

## Skill Learning Lifecycle

When a workflow or solution pattern proves reusable:

1. Inspect existing skills and related references.
2. Compare the new learning against current procedure and verification rules.
3. If an existing skill covers the domain, patch/extend it.
4. Create a new skill only when the capability is materially distinct.
5. For a large knowledge body, use a lean `SKILL.md` and topic-specific `references/` files loaded on demand.
6. Record provenance and why the change was promoted.
7. Verify the updated skill is internally consistent and still routes correctly from its description.
8. Archive or merge stale duplicates instead of accumulating them.

## Web-Only Constraints

The system must not pretend that ChatGPT Web has:
- a local background daemon;
- a persistent vector DB unless a connected tool explicitly provides it;
- autonomous execution on the user's computer;
- local subagent processes;
- continuous background learning without an active ChatGPT action.

Within these constraints, the repository should maximize planning, research, retrieval, memory quality, skill evolution, verification, and tool selection.

## Success Criteria

The upgrade is complete when:

1. The repository contains professional upstream references for Hermes learning and OpenViking context layers.
2. `knowledge-retrieval` exists and uses L0/L1/L2-style progressive loading with graceful fallback to GitHub search.
3. `skill-improver` exists and follows inspect-before-create, fold-in-not-duplicate, provenance, and verification rules.
4. `memory-manager` explicitly supports layered summaries/freshness and delegates retrieval to `knowledge-retrieval`.
5. `template-engineer` supports L0/L1/L2-compatible Markdown schemas without forcing one universal template.
6. `adaptive-orchestrator` routes retrieval and skill improvement when appropriate.
7. `AGENTS.md`, `README.md`, `MEMORY_INDEX.md`, and `skills/PROVENANCE.md` describe the same web-only architecture without contradiction.
8. No file claims unavailable runtime capabilities.
9. Existing upstream snapshots remain unchanged.
10. A final repository audit finds no duplicated new capability or broken cross-reference introduced by this upgrade.
