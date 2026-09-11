# Hermes Agent Reference Snapshot

Source repository: `NousResearch/hermes-agent`
License: MIT (see `LICENSE` in this directory)

Reference mechanisms used by this project:

- `agent/learn_prompt.py` — inspect all sources and requirements, search for an existing skill first, extend rather than duplicate, and use lean `SKILL.md` + on-demand `references/` for large knowledge bodies.
- `agent/learning_graph.py` — represent learned skills and memory as linked graph nodes and use declared/derived relations to make learning navigable.
- `agent/learning_mutations.py` — edit/archive learned skills and update/delete memory instead of uncontrolled accumulation.

These upstream files are reference snapshots only. Do not edit them to customize this project. Adaptations belong under the active `skills/` tree and must record provenance in `skills/PROVENANCE.md`.
