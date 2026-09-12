# Skill and Engine Provenance

As skills em [skills/](./) são adaptações para o objetivo deste repositório. Os snapshots já existentes em [upstream/](../upstream/) permanecem referências e **não devem ser editados para adaptar comportamento**.

## Skills adaptadas

| Skill adaptada | Principais fontes preservadas |
|---|---|
| `adaptive-orchestrator` | obra/superpowers `using-superpowers`; addyosmani/agent-skills `using-agent-skills` |
| `planner` | obra/superpowers `writing-plans`; addyosmani `planning-and-task-breakdown`; planning-with-files |
| `deep-investigator` | ByteDance DeerFlow `deep-research`; addyosmani `source-driven-development`; GPT Researcher breadth/depth |
| `phase-executor` | Superpowers `executing-plans`; addyosmani `incremental-implementation`; planning-with-files |
| `memory-manager` | awesome-copilot remember/memory-merger; addyosmani context-engineering; Mem0/LlamaIndex concepts |
| `template-engineer` | planning-with-files; awesome-copilot; Mem0/LlamaIndex retrieval principles |
| `knowledge-linker` | Mem0 graph concepts; LlamaIndex property graph; Markdown links |
| `verifier` | Superpowers verification-before-completion; awesome-copilot agentic-eval; addyosmani doubt-driven patterns |

## Motores externos adotados

### NousResearch/hermes-agent
Usado como **runtime de referência**, não copiado para este repositório.

Mecanismos adotados:
- Profile Distribution Git;
- SOUL/context files;
- skills sob demanda;
- tools/MCP;
- profiles;
- persistent memory + session search;
- delegation;
- checkpoints/rollback;
- context compression.

### volcengine/OpenViking
Usado como **context database/memory provider** quando habilitado.

Mecanismos adotados:
- Resource / Memory / Skill;
- L0 Abstract / L1 Overview / L2 Detail;
- hierarchical retrieval;
- session commit;
- memory extraction/deduplication;
- retrieval observability.

Hermes possui integração OpenViking de primeira classe.

## Regras de adaptação

Não copiar o runtime inteiro. Adaptar somente:
- contrato do perfil;
- estrutura de contexto;
- skills do domínio;
- roteamento;
- persistência/versionamento;
- integração com ferramentas disponíveis.

Não simplificar:
- gates;
- critérios de verificação;
- pesquisa multi-fonte;
- deduplicação;
- rastreabilidade;
- limites de retry;
- separação entre estado versionado e runtime privado.

## Licenças/proveniência

Toda reutilização substancial deve respeitar a licença do projeto de origem. Para o runtime, este repositório referencia documentação/arquitetura e cria conteúdo próprio, em vez de copiar árvores inteiras.

As fontes arquiteturais consultadas estão registradas em [research/source_ledger.md](../research/source_ledger.md).
