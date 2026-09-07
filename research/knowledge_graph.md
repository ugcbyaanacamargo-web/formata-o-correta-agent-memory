# Knowledge Graph

Mapa legível de relações que alteram retrieval, planejamento ou execução.

## Grafo do motor

```text
[FORMATAÇÃO CORRETA] --usa-runtime--> [Hermes Agent]
[FORMATAÇÃO CORRETA] --usa-context-db--> [OpenViking]
[FORMATAÇÃO CORRETA] --usa-plano-de-controle--> [GitHub]

[GitHub] --versiona--> [SOUL.md]
[GitHub] --versiona--> [AGENTS.md]
[GitHub] --versiona--> [skills/]
[GitHub] --versiona--> [memory/]
[GitHub] --versiona--> [research/]
[GitHub] --versiona--> [tasks/]

[Hermes Profile Distribution] --instala-de--> [GitHub]
[Hermes Profile Distribution] --carrega--> [SOUL.md]
[Hermes Profile Distribution] --carrega--> [skills/]
[Hermes Profile Distribution] --preserva-local--> [memories/]
[Hermes Profile Distribution] --preserva-local--> [sessions/]
[Hermes Profile Distribution] --preserva-local--> [credenciais]

[Hermes Agent] --tem-provider-first-class--> [OpenViking]
[OpenViking] --organiza--> [Resource]
[OpenViking] --organiza--> [Memory]
[OpenViking] --organiza--> [Skill]

[OpenViking] --recupera-via--> [L0 Abstract]
[L0 Abstract] --expande-para--> [L1 Overview]
[L1 Overview] --expande-para--> [L2 Detail]

[research/] --mapeia-principalmente-para--> [Resource]
[memory/] --mapeia-principalmente-para--> [Memory técnica versionada]
[skills/] --mapeia-para--> [Skill]
[tasks/] --representa--> [Execution State]

[MEMORY_INDEX.md] --roteia-para--> [Notas canônicas]
[Knowledge Graph] --expande--> [Contexto relacionado]
[Source Ledger] --evidencia--> [Findings]
[Findings] --altera--> [Decisions]
[Decisions] --altera--> [Plan]

[Adaptive Orchestrator] --seleciona--> [Skills]
[Deep Investigator] --produz--> [Collection Specification]
[Deep Investigator] --produz--> [Resolution Specification]
[Phase Executor] --executa--> [Fase]
[Verifier] --gates--> [Fase]

[Git Branch] --contém--> [Mudança proposta]
[Review] --avalia--> [Git Branch]
[Pull Request] --promove-se-aprovado--> [Main]
```

## Regra

Criar relação somente quando ela melhora navegação ou decisão. O grafo aponta para explicações completas; não as substitui.
