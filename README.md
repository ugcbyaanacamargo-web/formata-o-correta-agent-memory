# FORMATAÇÃO CORRETA — Agent Distribution + Project Memory

Este repositório é o **plano de controle versionado** do agente especializado no projeto **FORMATAÇÃO CORRETA**.

Ele não implementa um motor de agente do zero. A arquitetura reutiliza:

- **Hermes Agent** como runtime portátil de agente;
- **OpenViking** como provider de memória/contexto semântico quando habilitado;
- **GitHub** como fonte auditável de contrato, skills, decisões, pesquisas e estado operacional.

A arquitetura completa está em [ENGINE.md](./ENGINE.md).

## Bootstrap

A leitura inicial é curta e deliberada:

1. [SOUL.md](./SOUL.md) — identidade e princípios.
2. [AGENTS.md](./AGENTS.md) — contrato operacional.
3. [MEMORY_INDEX.md](./MEMORY_INDEX.md) — ponteiros para o contexto relevante.
4. Só então carregar arquivos detalhados necessários para a decisão atual.

## Navegação canônica

| Necessidade | Arquivo |
|---|---|
| Arquitetura do motor | [ENGINE.md](./ENGINE.md) |
| Estado ativo | [memory/active_context.md](./memory/active_context.md) |
| Decisões | [memory/decisions.md](./memory/decisions.md) |
| Modelo técnico do sistema | [memory/system_model.md](./memory/system_model.md) |
| Lições | [memory/lessons.md](./memory/lessons.md) |
| Tentativas falhas | [memory/failed_attempts.md](./memory/failed_attempts.md) |
| Plano atual | [tasks/plan.md](./tasks/plan.md) |
| Progresso | [tasks/progress.md](./tasks/progress.md) |
| Gates | [tasks/verification.md](./tasks/verification.md) |
| Descobertas | [research/findings.md](./research/findings.md) |
| Fontes | [research/source_ledger.md](./research/source_ledger.md) |
| Relações | [research/knowledge_graph.md](./research/knowledge_graph.md) |
| Skills | [skills/](./skills/) |
| Proveniência das skills | [skills/PROVENANCE.md](./skills/PROVENANCE.md) |

## Hermes Profile Distribution

O repositório contém [distribution.yaml](./distribution.yaml) e [SOUL.md](./SOUL.md), seguindo o mecanismo oficial de **Hermes Profile Distribution**.

Quando o runtime Hermes for instalado/configurado, a distribuição poderá ser instalada por Git:

```bash
hermes profile install github.com/ugcbyaanacamargo-web/formata-o-correta-agent-memory --alias
```

Isso transporta o contrato e o conhecimento técnico versionado. **Memórias de sessão, credenciais e bancos de estado do runtime permanecem locais.**

## Memória: duas coisas diferentes

### `memory/` — memória técnica do projeto
Versionada no GitHub:
- decisões;
- estado ativo;
- modelo do sistema;
- lições;
- falhas reutilizáveis.

### `memories/` — memória privada do runtime Hermes
Não é versionada. Está bloqueada em [.gitignore](./.gitignore), assim como:
- sessões;
- tokens;
- `.env`;
- bancos de estado;
- logs;
- caches.

## OpenViking

OpenViking é preparado como memória/contexto semântico, não simulado manualmente.

Quando habilitado no Hermes:

```bash
hermes memory setup openviking
hermes memory status
```

O OpenViking fará a organização progressiva em **L0/L1/L2**, recuperação hierárquica e extração/deduplicação de memórias. Este repositório não mantém sidecars artificiais `.abstract.md`/`.overview.md` enquanto o serviço não estiver ativo.

## Fluxo operacional

```text
pedido
  ↓
bootstrap + retrieval
  ↓
orquestração de skills/ferramentas
  ↓
plano da fase
  ↓
pesquisa suficiente para decidir
  ↓
coleta/execução
  ↓
verificação
  ↓
consolidação da memória
  ↓
branch → review → PR
```

O objetivo é reduzir investigação redundante sem sacrificar evidência, rastreabilidade ou segurança.
