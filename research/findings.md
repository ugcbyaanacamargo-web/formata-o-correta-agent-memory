# Findings

Descobertas obtidas durante pesquisas e testes. Relações permanentes devem ser refletidas também no modelo/grafo apropriado.

### FND-0001 — Hermes distribui agentes inteiros por Git
**Descoberta:** Profile Distribution empacota SOUL, config, skills, cron e MCP como repositório Git; instalação e updates preservam memória/sessões/credenciais locais.  
**Fonte:** SRC-0001 / SRC-0002.  
**Impacto:** este GitHub pode ser o pacote versionado do agente FORMATAÇÃO CORRETA sem criar runtime próprio.

### FND-0002 — Hermes possui memória curta + busca de sessões
**Descoberta:** memória built-in é curada e limitada, enquanto o histórico pode ser recuperado por session search; isso evita colocar toda a conversa no prompt.  
**Fonte:** SRC-0003.  
**Impacto:** decisões canônicas ficam enxutas e histórico detalhado é recuperado sob demanda.

### FND-0003 — OpenViking é provider nativo do Hermes
**Descoberta:** a integração oficial exige apenas apontar Hermes para um servidor OpenViking por HTTP; ambientes devem permanecer separados.  
**Fonte:** SRC-0004.  
**Impacto:** não precisamos construir bridge própria.

### FND-0004 — OpenViking separa Resource / Memory / Skill
**Descoberta:** conhecimento objetivo, memória aprendida e capacidade operacional possuem papéis/lifecycles distintos.  
**Fonte:** SRC-0005.  
**Impacto:** `research/`, `memory/` e `skills/` deixam de ser pastas genéricas e passam a ter papéis claros.

### FND-0005 — L0/L1/L2 resolve o excesso de Markdown
**Descoberta:** OpenViking usa L0 Abstract, L1 Overview e L2 Detail para carregar contexto progressivamente.  
**Fonte:** SRC-0006.  
**Impacto:** o projeto deve rotear primeiro por índice/resumo e abrir detalhes só quando necessários.

### FND-0006 — Sessões podem virar experiência auditável
**Descoberta:** commit de sessão gera resumo, extrai/deduplica memória e registra `memory_diff.json`.  
**Fonte:** SRC-0007.  
**Impacto:** quando OpenViking estiver ativo, aprendizados de execução podem ser promovidos com trilha de mudança em vez de simples acúmulo de texto.

### FND-0007 — GitHub MCP deve ser autenticado no host
**Descoberta:** o GitHub mantém o servidor oficial `github/github-mcp-server`, com opções remota e local. A documentação alerta que OAuth remoto depende da configuração do host; PAT pode ser fornecido localmente.  
**Fonte:** SRC-0009 / SRC-0010.  
**Impacto:** não embutir credencial nem afirmar OAuth portátil no profile. O conector atual do ChatGPT continua sendo a ferramenta GitHub ativa; Hermes será configurado no runtime.

### FND-0008 — AGENTS.md não é global só por estar no profile
**Descoberta:** Hermes injeta `SOUL.md` exclusivamente de `HERMES_HOME`, enquanto `AGENTS.md` é descoberto a partir do CWD/projeto.  
**Fonte:** SRC-0011.  
**Impacto:** a distribuição não pode depender de `AGENTS.md` ser auto-carregado quando o runtime está em outra pasta. O bootstrap foi movido para `SOUL.md`, que manda recuperar os canônicos do profile e carregar o orchestrator.
