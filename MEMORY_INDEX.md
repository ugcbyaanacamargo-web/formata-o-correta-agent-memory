# Memory Routing Index

Este arquivo é o **roteador L0 do projeto**: aponta para contexto de alto valor sem obrigar o agente a carregar todo o repositório.

Arquitetura: [ENGINE.md](./ENGINE.md).

## Entrada rápida

| Pergunta | Leia |
|---|---|
| Qual é o objetivo/fase atual? | [memory/active_context.md](./memory/active_context.md) |
| Quais decisões não devem ser rediscutidas sem nova evidência? | [memory/decisions.md](./memory/decisions.md) |
| Como os componentes se relacionam? | [memory/system_model.md](./memory/system_model.md) |
| Qual é o plano atual? | [tasks/plan.md](./tasks/plan.md) |
| Quais gates precisam passar? | [tasks/verification.md](./tasks/verification.md) |
| Que descobertas já existem? | [research/findings.md](./research/findings.md) |
| Quais fontes sustentam isso? | [research/source_ledger.md](./research/source_ledger.md) |
| Quais relações ajudam a expandir o contexto? | [research/knowledge_graph.md](./research/knowledge_graph.md) |
| O que já falhou? | [memory/failed_attempts.md](./memory/failed_attempts.md) |
| Que padrões reutilizáveis aprendemos? | [memory/lessons.md](./memory/lessons.md) |
| Que skill usar? | [skills/](./skills/) |

## Ordem de recuperação

1. Localize a entidade/decisão diretamente mencionada.
2. Leia a nota canônica.
3. Expanda pelo [knowledge graph](./research/knowledge_graph.md) somente quando a relação puder mudar a decisão.
4. Abra fonte/L2 detalhado apenas quando necessário.
5. Pare antes de carregar vizinhança irrelevante.

## Separação de contextos

- [memory/](./memory/) = conhecimento técnico versionado do projeto.
- [research/](./research/) = evidência externa, descobertas e proveniência.
- [tasks/](./tasks/) = estado operacional e gates.
- [skills/](./skills/) = capacidades.
- [upstream/](./upstream/) = referências preservadas, não estado ativo.
- `memories/` e `sessions/` = runtime privado Hermes; não entram no GitHub.

## Autoridade em caso de conflito

1. estado observado atual;
2. fonte primária/específica aplicável;
3. decisão canônica do GitHub;
4. memória de runtime/sessão como pista contextual.

Memória lembrada não altera automaticamente a verdade versionada. Mudança de decisão exige evidência e atualização explícita.

## Política

- prefira atualizar ponteiro existente;
- remova ponteiros obsoletos;
- preserve aliases quando houver reorganização;
- não liste todo arquivo do repositório;
- não crie taxonomia nova sem ganho real de retrieval;
- quando OpenViking estiver ativo, use recuperação L0/L1/L2 em vez de replicar resumos manualmente.
