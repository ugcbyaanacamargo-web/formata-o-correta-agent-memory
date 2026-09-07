# Source Ledger

Registro estruturado de fontes usadas em investigações.

## Hierarquia preferencial

1. fabricante/autor oficial;
2. documentação oficial;
3. especificação/padrão primário;
4. repositório oficial;
5. documentação técnica reconhecida;
6. fontes secundárias confiáveis;
7. fóruns/comunidade como evidência complementar.

## Fontes do motor

### SRC-0001 — NousResearch/hermes-agent
**URL:** https://github.com/NousResearch/hermes-agent  
**Autor/organização:** Nous Research  
**Data consultada:** 2026-09-06  
**Assunto:** runtime do agente.  
**Sustenta:** existência do runtime, profiles, tools, skills, memory, delegation e integração extensível.

### SRC-0002 — Hermes Profile Distributions
**URL:** https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/profile-distributions.md  
**Autor/organização:** Nous Research  
**Data consultada:** 2026-09-06  
**Assunto:** distribuição de um agente completo via Git.  
**Sustenta:** `distribution.yaml`, SOUL/config/skills/MCP, instalação via `hermes profile install`, distribuição-owned vs user-owned e exclusões de segredos/runtime.

### SRC-0003 — Hermes Persistent Memory
**URL:** https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/memory.md  
**Autor/organização:** Nous Research  
**Data consultada:** 2026-09-06  
**Assunto:** MEMORY/USER/session search.  
**Sustenta:** memória curada limitada versus recuperação de sessões sob demanda.

### SRC-0004 — OpenViking: integração Hermes
**URL:** https://github.com/volcengine/OpenViking/blob/main/docs/en/agent-integrations/05-hermes.md  
**Autor/organização:** Volcengine/OpenViking  
**Data consultada:** 2026-09-06  
**Assunto:** provider de memória.  
**Sustenta:** Hermes possui provider OpenViking first-class; conexão HTTP; ambientes Python separados; `hermes memory setup openviking`.

### SRC-0005 — OpenViking Context Types
**URL:** https://github.com/volcengine/OpenViking/blob/main/docs/en/concepts/02-context-types.md  
**Autor/organização:** Volcengine/OpenViking  
**Data consultada:** 2026-09-06  
**Assunto:** Resource / Memory / Skill.  
**Sustenta:** separação conceitual do contexto.

### SRC-0006 — OpenViking Context Layers
**URL:** https://github.com/volcengine/OpenViking/blob/main/docs/en/concepts/03-context-layers.md  
**Autor/organização:** Volcengine/OpenViking  
**Data consultada:** 2026-09-06  
**Assunto:** L0/L1/L2.  
**Sustenta:** carregamento progressivo e sidecars semânticos gerados pelo sistema.

### SRC-0007 — OpenViking Session Management
**URL:** https://github.com/volcengine/OpenViking/blob/main/docs/en/concepts/08-session.md  
**Autor/organização:** Volcengine/OpenViking  
**Data consultada:** 2026-09-06  
**Assunto:** session commit e memory extraction.  
**Sustenta:** archive, summaries, dedup/merge/delete e `memory_diff.json`.

### SRC-0008 — OpenViking Architecture / Retrieval
**URL:** https://github.com/volcengine/OpenViking/blob/main/docs/en/concepts/01-architecture.md  
**Autor/organização:** Volcengine/OpenViking  
**Data consultada:** 2026-09-06  
**Assunto:** arquitetura de contexto.  
**Sustenta:** parse → semantic processing → index; intent → hierarchical retrieval → rerank.
