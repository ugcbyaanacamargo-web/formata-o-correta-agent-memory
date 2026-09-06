# Skill Adaptation Provenance

As skills em `skills/` são adaptações para o objetivo deste repositório. Os originais licenciados usados como base ficam preservados em `upstream/`.

## Mapeamento

| Skill adaptada | Principais fontes preservadas |
|---|---|
| `adaptive-orchestrator` | obra/superpowers `using-superpowers`; addyosmani/agent-skills `using-agent-skills` |
| `planner` | obra/superpowers `writing-plans`; addyosmani `planning-and-task-breakdown`; OthmanAdi `planning-with-files` |
| `deep-investigator` | ByteDance DeerFlow `deep-research`; addyosmani `source-driven-development`; GPT Researcher breadth/depth |
| `phase-executor` | Superpowers `executing-plans`; addyosmani `incremental-implementation`; planning-with-files execution state |
| `memory-manager` | awesome-copilot `remember` + `memory-merger`; addyosmani `context-engineering`; Mem0 retrieval/dedup/graph concepts; LlamaIndex indexing concepts |
| `template-engineer` | planning-with-files templates; awesome-copilot memory structures; Mem0/LlamaIndex retrieval principles |
| `knowledge-linker` | Mem0 graph memory concepts; LlamaIndex property graph concepts; Markdown/Obsidian-style links |
| `verifier` | Superpowers `verification-before-completion`; awesome-copilot `agentic-eval`; addyosmani doubt-driven patterns |

## Preservação dos originais

Não editar arquivos dentro de `upstream/` para “melhorá-los”. Eles são snapshots de referência.

As adaptações devem alterar somente:
- integração com o runtime disponível;
- nomenclatura de ferramentas;
- persistência/transportes;
- regras específicas do objetivo deste projeto.

Não simplificar:
- gates;
- critérios de verificação;
- anti-rationalization;
- context engineering;
- pesquisa multi-fonte;
- deduplicação de memória;
- loops de avaliação limitados;
- rastreabilidade.

## Licenças

Cada subtree em `upstream/` mantém o arquivo de licença copiado do projeto de origem quando o repositório fornece licença explícita. Não copiar substancialmente código/conteúdo de repositórios sem licença clara para a área adaptada.
