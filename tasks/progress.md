# Progress Log

## 2026-09-06 — adaptação do motor

- Repositório GitHub conectado e permissões confirmadas.
- Conversa “Implementar Skills Autônomas” recuperada como contexto de intenção.
- Decisão confirmada: usar motor existente, não desenvolver agente do zero.
- Hermes Agent oficial estudado:
  - profiles;
  - Profile Distribution;
  - SOUL;
  - skills/toolsets;
  - memória + session search;
  - delegation;
  - checkpoints;
  - MCP.
- OpenViking oficial estudado:
  - Resource / Memory / Skill;
  - L0/L1/L2;
  - hierarchical retrieval;
  - session commit;
  - memory extraction/dedup;
  - integração Hermes first-class.
- Branch criada: `chatgpt/hermes-openviking-profile-20260906`.
- Criados:
  - `distribution.yaml`;
  - `SOUL.md`;
  - `ENGINE.md`;
  - `.gitignore`.
- Atualizados:
  - README;
  - AGENTS;
  - MEMORY_INDEX;
  - provenance;
  - active context;
  - decisions;
  - plan;
  - findings;
  - source ledger;
  - knowledge graph.
- Estrutura verificada na branch; diretórios e arquivos canônicos existem.
- `distribution_owned` validado contra o mecanismo oficial do Hermes; custom paths são suportados.
- Fronteira de memória formalizada:
  - runtime/OpenViking = recall/contexto;
  - evidência + verifier = promoção;
  - GitHub = canônico.
- PR da formatação existente permanece separado/draft.

## Próximo gate

- comparar diff final;
- revisar arquivos alterados e escopo;
- criar draft PR da adaptação do motor;
- linkar PR da formatação como dependente.

- Draft PR #2 criado: adaptação Hermes + OpenViking.
- Diff revisado: 16 arquivos, todos dentro do escopo esperado.
- PR #1 da reconstrução limpa foi formalmente marcado como dependente do PR #2.
- Nenhuma instalação local de Hermes/OpenViking foi alegada; runtime permanece etapa separada.
