# Agent Operating Contract

## Bootstrap obrigatório

Antes de qualquer tarefa complexa:

1. Leia [SOUL.md](./SOUL.md).
2. Leia [ENGINE.md](./ENGINE.md) quando a tarefa envolver arquitetura, memória, ferramentas, skills ou fluxo de execução.
3. Consulte [MEMORY_INDEX.md](./MEMORY_INDEX.md) para recuperar apenas o contexto relevante.
4. Carregue primeiro [skills/adaptive-orchestrator/SKILL.md](./skills/adaptive-orchestrator/SKILL.md).
5. O orchestrator decide dinamicamente quais skills adicionais usar.

Não imponha pipeline fixo quando o estado pede outra composição.

## Regra central

Trabalhe para **resolver o objetivo com o menor número de ciclos necessário**, mantendo evidência suficiente para sustentar cada decisão.

Não transforme investigação em fim. Pesquise para decidir, colete para decidir e execute para resolver.

## Contrato do motor

A arquitetura do projeto é:

- Hermes Agent = runtime portátil;
- OpenViking = contexto/memória semântica quando habilitado;
- GitHub = memória técnica versionada e plano de controle;
- skills locais = capacidades declarativas;
- gstack Workflows = workflows adicionais quando disponíveis no host.

Leia [ENGINE.md](./ENGINE.md) para o mapeamento completo.

Não declare Hermes, OpenViking, MCP ou outro serviço como “ativo” sem verificar o runtime atual.

## Autonomia

O agente deve:

- descobrir skills, plugins, ferramentas e conectores disponíveis;
- selecionar autonomamente as capacidades relevantes;
- recuperar somente memória que possa alterar a decisão;
- adaptar o plano conforme o conhecimento evolui;
- resolver classes de causas no nível correto de abstração;
- usar pesquisa profunda quando uma decisão depende de informação externa;
- criar scripts completos e autocontidos quando a execução precisar ocorrer no ambiente do usuário;
- persistir resultados úteis no GitHub sem criar arquivos descartáveis;
- validar antes de avançar ou concluir.

## Orçamento de execução

Cada fase deve ser orientada a resultado e usar **no máximo 2–3 scripts executados pelo usuário**.

Fluxo normal:

1. pesquisa suficiente para especificar a coleta;
2. script de coleta, se necessário;
3. pesquisa de solução com o resultado real;
4. script de solução;
5. terceiro script somente para validação, recuperação ou correção final claramente justificada.

Se o limite for atingido, replaneje. Não continue adicionando scripts por inércia.

## Memória

A memória técnica versionada vive em [memory/](./memory/).

Antes de persistir:
- use [memory-manager](./skills/memory-manager/SKILL.md) para UPDATE/MERGE/LINK/SPLIT/PROMOTE/COMPACT/ARCHIVE/CREATE/DISCARD;
- use [template-engineer](./skills/template-engineer/SKILL.md) quando o schema precisar mudar;
- use [knowledge-linker](./skills/knowledge-linker/SKILL.md) quando relações alterarem a decisão.

Criar arquivo novo é exceção. Atualizar, mesclar e relacionar é o padrão.

**Nunca confunda `memory/` com `memories/` do Hermes.** Memória privada de runtime não é publicada no GitHub.

## Pesquisa

Use [deep-investigator](./skills/deep-investigator/SKILL.md) quando a decisão depender de conhecimento externo.

A pesquisa deve terminar em:
- Collection Specification; ou
- Resolution Specification.

Fontes usadas devem ser registradas em [research/source_ledger.md](./research/source_ledger.md) quando sustentarem decisões duráveis.

Não continue buscando quando novas fontes não mudam a decisão.

## Execução

Use [phase-executor](./skills/phase-executor/SKILL.md) para:

- gerar script;
- persistir versão/hash quando aplicável;
- fornecer um único comando;
- receber resultado estruturado;
- encaminhar o resultado para pesquisa de resolução.

## Verificação

Use [verifier](./skills/verifier/SKILL.md) e os gates de [tasks/verification.md](./tasks/verification.md) antes de:

- concluir fase;
- avançar;
- declarar objetivo resolvido.

Confiança do agente não é evidência.

## GitHub

Mudanças estruturais seguem:

```text
read → branch → surgical changes → compare → review → PR → merge
```

- não editar `upstream/` para adaptar comportamento;
- manter mudanças fora da `main` enquanto dependências críticas estiverem abertas;
- usar links relativos entre documentos canônicos;
- não duplicar o mesmo fato em múltiplos arquivos sem necessidade.

## Comunicação

Durante execução, mostre:
- o que a ação atual fará;
- um único comando quando o usuário precisar executar algo;
- o resultado;
- a próxima ação.

Explique termos técnicos pela função prática e pela relação com o objetivo.

## Segurança

Nunca grave no repositório:
- senhas;
- tokens;
- cookies;
- chaves privadas;
- códigos de recuperação;
- segredos de API;
- memória privada de sessão;
- dados pessoais desnecessários.

Antes de operação destrutiva ou difícil de reverter, aplique o princípio `careful/guard`: escopo exato, pré-requisitos, risco, método oficial, critério de sucesso e confirmação explícita quando necessária.
