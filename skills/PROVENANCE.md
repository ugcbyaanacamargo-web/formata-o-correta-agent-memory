# Skill Adaptation Provenance

Active skills under `skills/` are adaptations for **ChatGPT Web + GitHub**. Upstream projects are references for mechanisms, not active runtimes unless a connected tool explicitly provides them.

## Mapping

| Active skill | Primary mechanism sources |
|---|---|
| `adaptive-orchestrator` | obra/superpowers `using-superpowers`; addyosmani `using-agent-skills`; capability-discovery constraints from current ChatGPT Web tools |
| `knowledge-retrieval` | OpenViking L0/L1/L2 + observable/progressive retrieval concepts; addyosmani context engineering; Mem0/LlamaIndex retrieval concepts |
| `planner` | Superpowers `writing-plans`; addyosmani `planning-and-task-breakdown`; planning-with-files persistent plans |
| `deep-investigator` | DeerFlow `deep-research`; addyosmani `source-driven-development`; GPT Researcher breadth/depth |
| `phase-executor` | Superpowers `executing-plans`; addyosmani `incremental-implementation`; planning-with-files execution state |
| `verifier` | Superpowers `verification-before-completion`; awesome-copilot `agentic-eval`; addyosmani doubt-driven patterns |
| `memory-manager` | awesome-copilot `remember` + `memory-merger`; addyosmani context engineering; OpenViking layered context; Mem0/LlamaIndex concepts |
| `template-engineer` | planning-with-files templates; awesome-copilot memory structures; OpenViking context layers; retrieval-oriented Markdown design |
| `knowledge-linker` | Hermes learning graph concepts; Mem0 graph concepts; LlamaIndex property graph concepts; Markdown/Obsidian-style links |
| `skill-improver` | Hermes `learn_prompt.py` inspect-before-create/fold-in behavior; Hermes learning mutations; Superpowers verification/review discipline |

## Preserved upstream references

Current important reference areas include:

- `upstream/superpowers/` / `upstream/obra-superpowers/`
- `upstream/addyosmani-agent-skills/`
- `upstream/awesome-copilot/`
- `upstream/planning-with-files/`
- `upstream/deer-flow/`
- `upstream/gpt-researcher/`
- `upstream/mem0/`
- `upstream/llama-index/`
- `upstream/hermes-agent/`
- `upstream/openviking/REFERENCE.md`

## Hermes scope

Vendored Hermes files are MIT-licensed reference snapshots. They demonstrate:

- learn from all named sources/requirements;
- inspect existing skills before creating;
- fold new knowledge into an existing skill when scope overlaps;
- use lean `SKILL.md` + `references/` for large sources;
- represent learned skills/memory as connected nodes;
- edit/archive rather than accumulate uncontrolled duplicates.

The active project does **not** run Hermes.

## OpenViking scope

OpenViking is referenced for:

- L0 Abstract;
- L1 Overview;
- L2 Detail;
- progressive retrieval;
- freshness awareness;
- observable retrieval paths.

The active project does **not** copy/require the OpenViking runtime, server, `viking://` filesystem, or vector service. See `upstream/openviking/REFERENCE.md` for exact source paths.

## Adaptation rules

Do not edit upstream snapshots to customize this project.

Adapt only what is transferable to the active ChatGPT Web environment:

- skill routing;
- retrieval procedure;
- memory lifecycle;
- planning/research/verification discipline;
- schema concepts;
- provenance/review rules.

Do **not** claim runtime-specific capabilities unless the current ChatGPT session actually exposes them.

## Skill improvement rule

Self-improvement is guarded:

1. validated learning candidate;
2. retrieve existing skill;
3. propose minimal change;
4. isolated branch/diff when GitHub supports it;
5. verification;
6. review/promotion.

A single local success normally becomes memory/candidate, not an automatic canonical skill rewrite.

## Licensing

- Preserve copied upstream license files with substantial vendored source snapshots.
- Do not copy substantial material from repositories without a clear license.
- For copyleft/runtime projects used only as conceptual references, prefer original synthesis plus exact source-path attribution instead of unnecessary code/runtime copying.
