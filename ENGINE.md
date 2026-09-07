# Engine Architecture — FORMATAÇÃO CORRETA

Este documento define como o projeto usa **motores existentes** em vez de criar um agente do zero.

## Arquitetura escolhida

```text
Usuário
  ↓
Agente/runtime
  ├─ ChatGPT + GitHub Connector (ambiente atual)
  └─ Hermes Agent profile (runtime portátil)
        ↓
Contrato + skills + conhecimento versionado
        ↓
GitHub: formata-o-correta-agent-memory
        ↓
Memória/contexto semântico opcional
        ↓
OpenViking (provider nativo do Hermes)
        ↓
Pesquisa / coleta / execução / verificação
        ↓
Equipamento real
```

### 1. Hermes Agent = runtime

O projeto adota o **NousResearch/hermes-agent** como referência de runtime portátil. Não copiamos seu código.

Mecanismos reutilizados:
- Profile Distribution por repositório Git;
- `SOUL.md` para identidade/instruções;
- skills carregadas sob demanda;
- ferramentas/toolsets e MCP;
- memória persistente;
- busca de sessões;
- delegação para subagentes;
- checkpoints/rollback;
- compressão de contexto;
- profiles isolados.

Este repositório é preparado para ser instalado futuramente como uma distribuição:

```bash
hermes profile install github.com/ugcbyaanacamargo-web/formata-o-correta-agent-memory --alias
```

Isso é um **passo de runtime**, não requisito para o ChatGPT atual usar o mesmo contrato via GitHub.

### 2. OpenViking = contexto/memória semântica

O **volcengine/OpenViking** é a camada escolhida para memória/contexto hierárquico quando o runtime Hermes estiver ativo.

Hermes possui provider OpenViking de primeira classe. A integração oficial usa HTTP e mantém os ambientes Python separados:

```bash
hermes memory setup openviking
hermes memory status
```

Não configuramos servidor, chave ou URL neste repositório. Credenciais e endpoints de runtime ficam fora do Git.

### 3. GitHub = plano de controle e memória técnica versionada

O GitHub guarda aquilo que precisa ser:
- auditável;
- comparável por diff;
- reutilizável entre sessões;
- revisável antes de virar verdade operacional.

O repositório **não** deve guardar:
- API keys/tokens;
- sessões privadas;
- `state.db`;
- runtime `memories/`;
- cookies;
- códigos de recuperação;
- logs com segredos.

## Mapeamento dos Markdown

| Caminho | Papel | Equivalência funcional |
|---|---|---|
| [SOUL.md](./SOUL.md) | identidade e princípios duráveis | Hermes SOUL |
| [AGENTS.md](./AGENTS.md) | contrato operacional | context file / operating contract |
| [MEMORY_INDEX.md](./MEMORY_INDEX.md) | roteamento rápido | L0-like routing cache |
| [memory/active_context.md](./memory/active_context.md) | estado ativo atual | memória de trabalho persistida |
| [memory/decisions.md](./memory/decisions.md) | decisões canônicas | events/decisions |
| [memory/system_model.md](./memory/system_model.md) | modelo interligado do sistema | entity/system memory |
| [memory/lessons.md](./memory/lessons.md) | aprendizado reutilizável | experiences |
| [memory/failed_attempts.md](./memory/failed_attempts.md) | caminhos que não devem ser repetidos | cases/negative experience |
| [research/findings.md](./research/findings.md) | descobertas ainda rastreáveis | resource-derived findings |
| [research/source_ledger.md](./research/source_ledger.md) | proveniência | source registry |
| [research/knowledge_graph.md](./research/knowledge_graph.md) | relações tipadas | relationship navigation |
| [tasks/plan.md](./tasks/plan.md) | plano ativo | execution state |
| [tasks/progress.md](./tasks/progress.md) | progresso | execution journal |
| [tasks/verification.md](./tasks/verification.md) | gates | verifier contract |
| [skills/](./skills/) | capacidades declarativas | Hermes/OpenViking Skill |
| [upstream/](./upstream/) | snapshots/referências de origem | resources/provenance |

### Importante: `memory/` ≠ Hermes `memories/`

A pasta versionada **`memory/`** deste repositório contém conhecimento técnico do projeto e pode ser distribuída.

A pasta de runtime Hermes **`memories/`** contém memória de usuário/sessão do agente e deve permanecer local. Ela está bloqueada no [.gitignore](./.gitignore).

## Autoridade e promoção da memória

Existem três níveis de autoridade:

```text
memória de sessão / recall OpenViking
        ↓ contexto candidato
evidência atual + fontes + resultado real
        ↓ verificação
GitHub canônico
```

Regras:
1. Memória de runtime ajuda a **lembrar**, não substitui prova.
2. Uma lembrança antiga não sobrescreve silenciosamente uma decisão em [memory/decisions.md](./memory/decisions.md).
3. Nova evidência pode invalidar uma decisão antiga, mas a mudança deve ser explícita e versionada.
4. Conhecimento novo só é promovido ao GitHub depois de interpretação/deduplicação pelo agente principal.
5. Em conflito, use:
   - evidência recente e específica;
   - fonte de maior autoridade;
   - estado observado do equipamento;
   - decisão canônica versionada enquanto não houver prova que a substitua.

## Retrieval em três níveis

Aplicamos o princípio do OpenViking sem fingir que seu servidor já está ativo.

### Nível 0 — roteamento
Leia primeiro:
- [SOUL.md](./SOUL.md)
- [AGENTS.md](./AGENTS.md)
- [MEMORY_INDEX.md](./MEMORY_INDEX.md)

Objetivo: decidir **onde** está o contexto relevante.

### Nível 1 — visão do domínio/estado
Carregue apenas os canônicos relevantes:
- active context;
- system model;
- decisions;
- plan;
- findings/knowledge graph.

Objetivo: compreender relações e fronteira de decisão.

### Nível 2 — detalhe
Somente então abra:
- fonte específica;
- auditoria;
- script;
- log;
- documentação técnica;
- arquivo detalhado.

Objetivo: obter a evidência exata necessária para a decisão atual.

Quando OpenViking estiver ativo, ele próprio gerará/gerenciará seus sidecars L0/L1 e fará busca hierárquica. **Não manter manualmente `.abstract.md` ou `.overview.md` neste GitHub**, porque isso criaria resumos duplicados e potencialmente obsoletos.

## Ciclo operacional

```text
REQUEST
  ↓
BOOTSTRAP
SOUL → AGENTS → MEMORY_INDEX
  ↓
RETRIEVE
carregar somente contexto que muda a decisão
  ↓
ORCHESTRATE
adaptive-orchestrator escolhe skills/ferramentas
  ↓
PLAN
fase + critério de sucesso + orçamento
  ↓
RESEARCH
Collection Specification ou Resolution Specification
  ↓
EXECUTE
ação/script autocontido
  ↓
VERIFY
evidência independente → PASS / FAIL / REPLAN
  ↓
PERSIST
UPDATE / MERGE / LINK / PROMOTE
  ↓
GIT REVIEW
branch → diff → PR → merge
```

## Delegação

Subagentes podem ser usados para ramos independentes de pesquisa/revisão, mas:
- não devem decidir silenciosamente ações destrutivas;
- não devem gravar memória canônica compartilhada sem consolidação do agente principal;
- resultados paralelos precisam voltar ao orquestrador para deduplicação e conflito.

## GitHub como ferramenta do agente

### Host atual — ChatGPT
O conector GitHub do ChatGPT está ativo e é usado diretamente para leitura, branches, commits, PRs e revisão.

### Runtime Hermes futuro
O GitHub possui servidor MCP oficial (`github/github-mcp-server`) e o Hermes suporta MCP remoto/stdio.

A autenticação será escolhida **no runtime**, não no repositório:
- servidor remoto GitHub + credencial local quando necessário;
- ou servidor local oficial GitHub MCP com fluxo próprio de autenticação;
- OAuth remoto somente quando o host tiver a configuração de cliente exigida pelo GitHub.

Não publicamos PAT, token OAuth ou header Authorization. Por isso este profile **não força um `mcp.json`/GitHub auth agora**. Isso é uma decisão de segurança e portabilidade, não ausência de integração.

## GitHub como gate

Para mudanças estruturais:
1. ler antes de escrever;
2. criar branch dedicada;
3. fazer mudanças cirúrgicas;
4. comparar com a base;
5. revisar escopo e links;
6. manter PR em draft quando depender de pesquisa ainda aberta;
7. só então promover para a branch principal.

## Estado do runtime

| Capacidade | Agora |
|---|---|
| GitHub como memória/versionamento | ATIVO |
| Skills locais | ATIVAS pelo contrato do projeto |
| gstack Workflows | DISPONÍVEL no ambiente ChatGPT atual |
| Hermes instalado/rodando localmente | NÃO assumido |
| Profile Distribution Hermes | PREPARADA por este repositório |
| OpenViking server | NÃO configurado |
| Hermes ↔ OpenViking | SUPORTADO oficialmente; configuração futura |
| GitHub MCP dentro do Hermes | NÃO configurado; credenciais não entram no repositório |

## Fontes arquiteturais

- NousResearch/hermes-agent — Features, Persistent Memory, Profiles e Profile Distributions.
- volcengine/OpenViking — Architecture, Context Types, L0/L1/L2, Retrieval, Session e integração Hermes.
- [research/source_ledger.md](./research/source_ledger.md) mantém a rastreabilidade usada pelo projeto.
