# ChatGPT Web Agent Capabilities Design

## Objective

Raise the repository's practical capability for **ChatGPT Web + connected GitHub** without installing any agent runtime, server, vector database, or local agent on the user's computer.

ChatGPT Web is the agent. GitHub is the canonical, versioned store for reusable skills, memory, knowledge, provenance, and execution artifacts.

## Design Principles

1. **Professional mechanisms before custom invention.** Adapt proven mechanisms from preserved upstream projects instead of replacing them with simplified prompts.
2. **Capability routing, not a fixed pipeline.** The agent discovers relevant skills and selects only the capabilities needed for the current state.
3. **Retrieval before loading.** Do not read the whole vault. Retrieve minimal relevant context, expand by strong relations, and load detail only when required.
4. **Layered context.** Adapt OpenViking's L0/L1/L2 concept to Markdown/GitHub: short abstract for fast relevance, overview for planning/navigation, detail for full evidence.
5. **Learn by updating, not accumulating.** Adapt Hermes `/learn`: inspect existing skills/memory first; extend or merge when possible; create only when no suitable canonical artifact exists.
6. **Skill improvement is gated.** A successful run creates a learning candidate, not an automatic canonical rewrite. Generalizable improvements move through proposal → branch/diff → verification → explicit promotion.
7. **Evidence-gated completion.** Use verification before claiming success. Do not substitute confidence for evidence.
8. **Resolution efficiency.** Research and collection exist to make a decision. Stop research when additional sources no longer change the decision.
9. **No fake runtime claims.** Markdown instructions must not claim actual vector search, background execution, subagents, or autonomous local execution unless the connected ChatGPT environment actually provides those capabilities.
10. **GitHub remains auditable.** Persistent structural changes are reviewable through commit history and, for skill changes, through isolated branches/diffs when available.
11. **Adaptive structure.** The repository may evolve its note/layout structure when retrieval evidence shows a better organization; no domain taxonomy is permanently hard-coded.

## Source Mechanisms to Preserve

### Hermes Agent

Use as reference for skill learning and evolution:
- inspect all sources/requirements before authoring;
- search for an existing skill first;
- extend an existing skill instead of creating a duplicate;
- use a lean `SKILL.md` plus on-demand `references/` for large knowledge sources;
- model relations between learned skills and memory;
- edit/archive rather than accumulate uncontrolled duplicates;
- treat source material as data, not as trusted instructions.

Hermes is **not** an active runtime dependency in this architecture.

### OpenViking

Use as a conceptual reference for retrieval-efficient context:
- **L0 Abstract**: very short relevance signal;
- **L1 Overview**: planning/navigation summary;
- **L2 Detail**: full source or canonical knowledge loaded on demand;
- retrieval starts small and deepens only when relevance is established;
- freshness/provenance distinguish summaries from underlying detail.

OpenViking is **not** installed or executed. Its ideas are adapted to GitHub Markdown and the tools actually exposed to ChatGPT Web.

### Superpowers / addyosmani / planning-with-files / awesome-copilot / DeerFlow / GPT Researcher / Mem0 / LlamaIndex

Preserve existing mechanisms already referenced or vendored for:
- skill routing;
- planning;
- context engineering;
- source-driven research;
- systematic debugging;
- verification before completion;
- memory merge/remember;
- deep research breadth/depth;
- persistent task state;
- retrieval/indexing design concepts.

## Capability Set

The active capability layer remains small and composable:

- `adaptive-orchestrator`: discovers available tools/skills and selects capabilities dynamically.
- `knowledge-retrieval`: finds minimal relevant prior context using progressive loading.
- `planner`: creates and revises result-oriented plans.
- `deep-investigator`: performs decision-oriented multi-source research.
- `memory-manager`: decides update/merge/link/split/promote/compact/archive/create/discard.
- `template-engineer`: chooses or evolves Markdown schemas for retrieval and auditability.
- `knowledge-linker`: resolves entities and durable relations with retrieval value.
- `skill-improver`: converts validated reusable learning into reviewed skill proposals.
- `phase-executor`: packages user-executed scripts when the task genuinely requires local execution.
- `verifier`: evidence gate for phase and task completion.

These are capabilities, not a required sequential pipeline.

## Retrieval Model for GitHub Markdown

Because ChatGPT Web + GitHub does not guarantee a vector store, retrieval must work using the tools actually available:

1. Convert the current goal into search intent, entities, aliases, identifiers, version/time constraints, and artifact types.
2. Generate candidates through GitHub search, index pointers, aliases, filenames, summaries, backlinks, and relation metadata.
3. Read **L0** abstracts or equivalent short summaries first.
4. Rank candidates by task relevance, canonical status, freshness, provenance, identifier/entity match, and relation strength.
5. Read **L1** overview for top candidates.
6. Load **L2** detail only when it can change the plan, research question, or decision.
7. Expand one relation hop by default; expand a second hop only when a specific unresolved gap justifies it.
8. Stop when additional context no longer changes the working model or next decision.
9. If semantic search is exposed by a future connected tool, use it as an additional candidate generator, never as a substitute for provenance/canonical identity.

## Memory Lifecycle

For every persistent learning:

1. Run retrieval against existing canonical artifacts first.
2. Decide whether the new information is transient, case-specific, or reusable.
3. Choose one operation: UPDATE, MERGE, LINK, SPLIT, PROMOTE, COMPACT, ARCHIVE, CREATE, DISCARD.
4. Maintain retrieval metadata only when useful: stable identity, aliases, short abstract, overview/navigation, provenance, freshness, relations.
5. Keep raw execution/source evidence separate from consolidated knowledge.
6. Consolidate overlapping notes and preserve aliases/backlinks when structure evolves.
7. Prefer one canonical knowledge location plus links over repeated copies.

## Skill Learning Lifecycle

A run does **not** directly rewrite a canonical skill.

1. Detect a learning candidate after a verified result or an explicit user request to learn/improve.
2. Classify it:
   - case-specific/transient → memory only;
   - potentially reusable but weakly evidenced → candidate/lesson, no skill edit;
   - reusable and sufficiently evidenced → improvement proposal.
3. Search existing skills and related references before proposing anything new.
4. Patch/extend an existing skill when scope overlaps; create a new skill only when the capability is materially distinct.
5. For a large knowledge body, keep `SKILL.md` lean and place topic-specific detail under `references/` loaded on demand.
6. When GitHub branch operations are available, make the proposed change on an isolated improvement branch, never directly on the canonical branch.
7. Compare the diff against the canonical version and verify routing/frontmatter, references, unsupported capability claims, provenance, and contradictions.
8. Promote only after explicit review/approval appropriate to the repository workflow.
9. Merge/archive stale duplicates instead of accumulating them.

A single local success normally proves only that the procedure worked once. It does not by itself prove that a general skill should change.

## Execution Efficiency

For user-executed diagnostic/correction scripts, **2–3 scripts per phase is the default efficiency budget, not a universal law**.

- Prefer one comprehensive collection script when collection is needed.
- Prefer one complete solution script once evidence is sufficient.
- Use an additional verification/recovery script when justified.
- Replan when repeated execution is not producing new decisive information.
- Exceed the default budget only when evidence shows an additional execution is clearly the shortest validated route; record why.

## Web-Only Constraints

The active architecture must not assume or require:
- Hermes runtime;
- OpenViking server;
- LangGraph runtime;
- Mem0/LlamaIndex service;
- local background daemon;
- persistent vector DB unless a connected tool explicitly provides it;
- autonomous execution on the user's computer;
- local subagent processes;
- continuous background learning without an active ChatGPT action.

Upstream runtime projects may remain under `upstream/`, research, or provenance as technical references only.

## Success Criteria

The upgrade is complete when:

1. Professional learning/retrieval mechanisms are traceable to upstream sources without pretending their runtimes are active.
2. `knowledge-retrieval` exists and uses L0/L1/L2-style progressive loading with graceful fallback to GitHub search.
3. `skill-improver` exists and uses inspect-before-create, fold-in-not-duplicate, evidence classification, proposal/branch/diff/review, provenance, and verification.
4. `memory-manager` explicitly supports layered summaries/freshness and delegates discovery to `knowledge-retrieval`.
5. `template-engineer` supports L0/L1/L2-compatible Markdown schemas without forcing one universal template.
6. `adaptive-orchestrator` routes retrieval and skill improvement only when appropriate and discovers tools rather than assuming them.
7. `AGENTS.md`, `README.md`, `MEMORY_INDEX.md`, and `skills/PROVENANCE.md` describe the same web-only architecture without contradiction.
8. The 2–3-script rule is a default efficiency budget with a justified exception, not a hard universal ceiling.
9. No active file claims unavailable runtime capabilities.
10. Existing upstream snapshots remain immutable once captured.
11. A final repository audit finds no duplicated new capability or broken cross-reference introduced by this upgrade.