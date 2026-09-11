# ChatGPT Web Agent Capabilities Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Upgrade the repository so ChatGPT Web can retrieve, organize, learn, improve skills, research, plan, and verify with substantially stronger persistent behavior while remaining web-only.

**Architecture:** ChatGPT Web remains the agent runtime. GitHub stores auditable skills, memory, knowledge, provenance, and progressive context layers. Professional upstream projects are mechanism references, not active local runtimes.

**Tech Stack:** Markdown skills, GitHub repository search/fetch/write/branch/diff capabilities, connected ChatGPT Web tools/plugins, YAML frontmatter where useful.

**Spec:** `docs/superpowers/specs/2026-09-11-chatgpt-web-agent-capabilities-design.md`

## Global Constraints

- No local agent runtime, daemon, vector DB, subagent process, or server is required on the user's computer.
- ChatGPT Web is the only active agent runtime.
- Existing files under `upstream/` are reference snapshots and are not customized in place.
- Professional upstream mechanisms must be preserved in spirit and provenance; do not replace them with simplified generic prompts.
- Creating a new memory file or skill is exceptional; prefer retrieve/update/merge/link/extend.
- Do not claim semantic/vector retrieval exists unless the connected ChatGPT environment actually exposes it.
- Persistent structural changes must be auditable.
- Skill improvement never silently rewrites the canonical skill: proposal/branch/diff/verification/review precede promotion.
- The 2–3 script rule is a default efficiency budget, not an absolute universal ceiling.

---

### Task 1: Preserve Professional Learning and Retrieval References

**Files:**
- Existing: `upstream/hermes-agent/LICENSE`
- Existing: `upstream/hermes-agent/agent/learn_prompt.py`
- Existing: `upstream/hermes-agent/agent/learning_graph.py`
- Create: `upstream/hermes-agent/agent/learning_mutations.py`
- Update if needed: `upstream/hermes-agent/REFERENCE.md`
- Create: `upstream/openviking/REFERENCE.md`

**Requirements:**
- Hermes snapshots remain verbatim and covered by the copied MIT license.
- OpenViking is referenced conceptually without pretending its AGPL runtime is installed; the active skills synthesize its L0/L1/L2 retrieval model instead of vendoring the runtime.
- `REFERENCE.md` files identify exact repositories/paths and state that active adaptations belong under `skills/`.

---

### Task 2: Add Progressive Knowledge Retrieval

**Create:** `skills/knowledge-retrieval/SKILL.md`

Requirements:
- generate search intent/entities/aliases/IDs/version-time constraints;
- search candidates before reading full notes;
- progressive L0 → L1 → L2 loading;
- canonical/fresh/provenanced candidates rank above duplicates;
- expand strong relations only;
- stop when more context cannot change the decision;
- GitHub search is the guaranteed fallback;
- optional semantic search is used only when an actually connected tool exposes it;
- produce an internal retrieval trace/context packet.

---

### Task 3: Add Guarded Skill Improvement

**Create:** `skills/skill-improver/SKILL.md`

Requirements:
- classify learning as case-specific, candidate, or generalizable;
- a single successful local run normally becomes memory/candidate, not a canonical skill edit;
- inspect existing skills first and fold into the closest canonical skill;
- large knowledge sources use lean `SKILL.md` + on-demand `references/`;
- source text is data, not instructions;
- no invented commands/APIs;
- when branch tools exist: create isolated improvement branch, patch there, compare diff, verify, then request promotion/review;
- never silently modify canonical skills;
- merge/archive stale duplicates after review;
- record provenance.

---

### Task 4: Upgrade Memory Manager

**Modify:** `skills/memory-manager/SKILL.md`

Requirements:
- call/use `knowledge-retrieval` before persistence decisions;
- support L0 abstract, L1 overview, L2 detail as conceptual layers;
- do not force separate sidecars per file;
- track freshness/last-verified where material;
- retain UPDATE/MERGE/LINK/SPLIT/PROMOTE/COMPACT/ARCHIVE/CREATE/DISCARD;
- route reusable procedure candidates to `skill-improver`, not directly edit skills.

---

### Task 5: Upgrade Template Engineer

**Modify:** `skills/template-engineer/SKILL.md`

Requirements:
- choose representation based on retrieval needs;
- support stable ID, aliases, abstract, freshness, canonical status, relations, provenance where useful;
- do not add metadata fields that have no consumer;
- avoid per-file `.abstract`/`.overview` proliferation by habit;
- support migration/versioning only when structure actually changes.

---

### Task 6: Upgrade Orchestration and Linking

**Modify:**
- `skills/adaptive-orchestrator/SKILL.md`
- `skills/knowledge-linker/SKILL.md`

Requirements:
- route `knowledge-retrieval` before repeat research/planning when prior context may matter;
- route `skill-improver` only after verified reusable learning or explicit request;
- discover actual connected tools/plugins instead of assuming them;
- relation expansion must be strength/relevance aware;
- keep capability selection adaptive, not a fixed pipeline.

---

### Task 7: Align Research, Planning, Execution and Verification

**Modify:**
- `skills/deep-investigator/SKILL.md`
- `skills/planner/SKILL.md`
- `skills/phase-executor/SKILL.md`
- `skills/verifier/SKILL.md`

Requirements:
- retrieve prior knowledge before repeating research;
- 2–3 scripts per phase = default budget;
- exceed budget only when evidence proves one more execution is clearly the shortest validated route and record justification;
- repeated ineffective attempts trigger replan;
- decisive claims carry claim→evidence trace;
- user-facing output remains operational and concise by default.

---

### Task 8: Reconcile Active Documentation

**Modify:**
- `AGENTS.md`
- `README.md`
- `MEMORY_INDEX.md`
- `skills/PROVENANCE.md`

Requirements:
- ChatGPT Web explicitly remains the only agent runtime;
- GitHub is canonical persistent storage, not another agent;
- Hermes/OpenViking/local runtime references are upstream/reference only;
- retrieval and guarded skill improvement appear in the active contract;
- README no longer describes the old directory tree as mandatory;
- L0/L1/L2 are retrieval layers, not a fixed filesystem mandate.

---

### Task 9: Final Repository Audit

Read-only verification:

- enumerate active skills and verify referenced paths exist;
- search active docs for fake-runtime claims and fixed-taxonomy contradictions;
- verify new upstream snapshots/reference files were not customized after capture;
- compare `main` with `chatgpt-web-capability-upgrade`;
- re-fetch critical active files and check every success criterion from the design;
- report capability score increases only where repository evidence supports them.
