# OpenViking Retrieval Reference

Source repository: `volcengine/OpenViking`
License: GNU AGPL-3.0-or-later in the upstream repository.

This project does **not** install or execute OpenViking. It uses selected design concepts as references for ChatGPT Web + GitHub Markdown.

Primary upstream references:

- `docs/en/concepts/03-context-layers.md` — L0/L1/L2 context layers.
- `docs/en/api/06-retrieval.md` — retrieval filters and targeting concepts.
- `docs/en/concepts/07-retrieval.md` — observable/progressive retrieval behavior.
- `README.md` — sessions-to-memory and observable retrieval overview.

Mechanisms adapted here:

- **L0 Abstract**: shortest relevance signal; in this repository it can be a concise abstract/frontmatter/index entry rather than a mandatory sidecar file.
- **L1 Overview**: planning/navigation context for a canonical note, skill, or knowledge area.
- **L2 Detail**: full canonical content, raw evidence, source material, or execution result loaded only when it can affect the decision.
- **Progressive retrieval**: search broadly at low cost, rank, then deepen only for the strongest candidates.
- **Freshness awareness**: summaries must not silently outlive the detail they describe.
- **Observable retrieval**: keep enough trace to explain why a piece of context was selected.

Do not copy OpenViking runtime assumptions into active skills. There is no OpenViking server, vector store, `viking://` filesystem, or semantic service in the active ChatGPT Web architecture unless a future connected tool explicitly provides one.
