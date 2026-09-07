# Decisions

Registro de decisões que devem sobreviver entre sessões.

## Decisões atuais

### DEC-20260906-01 — GitHub como memória viva
**Contexto:** arquivos mutáveis não devem existir em cópias concorrentes sem sincronização.  
**Decisão:** GitHub é a fonte versionada para memória técnica, decisões, pesquisa e estado operacional.  
**Consequência:** consultar a versão atual antes de usar memória operacional.

### DEC-20260906-02 — Não criar motor próprio
**Contexto:** o objetivo é aumentar autonomia/capacidade antes da formatação sem desenvolver um framework do zero.  
**Decisão:** usar **NousResearch/hermes-agent** como runtime portátil de referência.  
**Consequência:** este repositório será preparado como Hermes Profile Distribution.

### DEC-20260906-03 — OpenViking como contexto semântico
**Contexto:** o projeto possui grande volume de Markdown, pesquisas, relações e histórico.  
**Decisão:** usar **volcengine/OpenViking** como provider de memória/contexto quando o runtime for habilitado.  
**Por quê:** Hermes possui integração OpenViking de primeira classe e OpenViking separa Resource/Memory/Skill com carregamento L0/L1/L2.  
**Consequência:** não inventar mecanismo vetorial próprio.

### DEC-20260906-04 — Separar memória versionada de memória privada
**Decisão:** `memory/` é conhecimento técnico versionado do projeto. `memories/`, `sessions/`, bancos de estado, credenciais e logs são runtime privado e não entram no GitHub.  
**Consequência:** o repositório pode ser distribuído sem carregar automaticamente histórico privado do agente.

### DEC-20260906-05 — Não manter L0/L1 artificiais
**Contexto:** OpenViking gera sidecars semânticos `.abstract.md` e `.overview.md`.  
**Decisão:** enquanto OpenViking não estiver ativo, usar [MEMORY_INDEX.md](../MEMORY_INDEX.md) como roteamento enxuto e notas canônicas como L1 conceitual; não criar sidecars falsos/manualizados.  
**Consequência:** evita resumos duplicados e obsoletos.

### DEC-20260906-06 — GitHub é gate de promoção
**Decisão:** mudanças estruturais entram por branch → compare → review → PR; a `main` não recebe arquitetura não revisada.  
**Consequência:** a formatação pode evoluir sem perder rastreabilidade.

### DEC-20260906-07 — Motor antes da formatação
**Decisão:** concluir a adaptação Hermes/OpenViking/GitHub antes de avançar a pesquisa operacional da reconstrução limpa.  
**Consequência:** o PR da formatação permanece draft/dependente dessa base.
