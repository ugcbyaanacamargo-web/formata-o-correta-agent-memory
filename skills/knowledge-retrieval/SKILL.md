---
name: knowledge-retrieval
description: Recupera contexto mínimo relevante antes de decidir.
version: 1.0.0
related_skills:
  - adaptive-orchestrator
  - memory-manager
  - knowledge-linker
  - deep-investigator
  - planner
---

# Progressive Knowledge Retrieval

Recupere o **menor conjunto de contexto capaz de mudar a decisão atual**. Esta skill adapta context engineering, progressive disclosure e o modelo L0/L1/L2 para ChatGPT Web + GitHub sem assumir vector database, OpenViking, Mem0 ou outro runtime externo.

## Quando usar

Use antes de:

- planejar uma tarefa quando o repositório pode conter contexto relevante;
- repetir uma investigação já realizada anteriormente;
- responder sobre algo que o usuário espera que o projeto "lembre";
- atualizar memória canônica;
- melhorar uma skill;
- interpretar um novo resultado que possa se relacionar com execuções, fontes ou decisões anteriores;
- pesquisar na Web quando memória anterior pode restringir ou direcionar a pesquisa.

Não use para perguntas simples cuja resposta está completamente presente na conversa atual e não depende do repositório.

## Contrato de realidade

Primeiro descubra quais ferramentas estão realmente disponíveis.

No ambiente ChatGPT Web, o caminho garantido deste projeto é normalmente:

- busca de arquivos/código no GitHub conectado;
- leitura direcionada de arquivos GitHub;
- histórico/versionamento Git;
- busca Web quando necessária.

Se existir busca semântica por ferramenta conectada, ela pode gerar candidatos adicionais. **Nunca declare que existe busca vetorial/semântica real sem verificar a ferramenta.**

## Objetivo operacional

Dado um pedido, produzir um **Context Packet** enxuto contendo:

- objetivo resolvido da consulta;
- entidades/identificadores relevantes;
- artefatos selecionados;
- nível carregado de cada artefato (L0/L1/L2 ou equivalente);
- por que cada artefato foi selecionado;
- relações fortes seguidas;
- conflitos/frescor relevantes;
- lacunas que ainda impedem decisão.

O Context Packet serve ao planner, investigador, memory-manager ou skill-improver. Ele não precisa virar arquivo permanente por padrão.

## 1. Formular a consulta

Transforme o pedido atual em uma consulta de retrieval antes de buscar.

Extraia apenas o que ajuda a localizar conhecimento:

- **intent** — o que precisa ser decidido/resolvido;
- **entities** — produtos, componentes, projetos, erros, ferramentas, documentos, versões;
- **identifiers** — IDs, códigos, nomes exatos, mensagens de erro, nomes de arquivos;
- **aliases** — abreviações, nomes antigos, sinônimos técnicos e variações relevantes;
- **relations sought** — depende-de, causa, evidencia, substitui, configura, contradiz, valida ou outra relação exigida pelo problema;
- **temporal scope** — versão/data somente quando pode alterar a validade;
- **artifact types** — skill, memória, fonte, decisão, resultado, plano, log, evidência.

Não transforme a consulta em uma lista enorme de palavras genéricas.

## 2. Candidate Generation

Gere candidatos do mais barato para o mais caro.

### 2.1 L0 — sinais rápidos

Procure primeiro por:

- `MEMORY_INDEX.md` e outros índices canônicos;
- frontmatter/resumos curtos;
- nomes de arquivos;
- IDs estáveis;
- aliases;
- títulos/headings;
- descrições das skills;
- snippets retornados pela busca GitHub;
- backlinks/relations explícitas.

L0 responde somente:

> "Isto provavelmente merece ser aberto?"

Não use L0 sozinho para uma conclusão técnica importante quando o detalhe pode mudar o significado.

### 2.2 L1 — visão para decisão

Para os melhores candidatos, carregue a seção/resumo que permita entender:

- escopo;
- estado atual;
- regras principais;
- relações importantes;
- fontes/proveniência;
- onde está o detalhe.

L1 deve ser suficiente para decidir **se** o L2 precisa ser aberto.

### 2.3 L2 — detalhe sob demanda

Abra conteúdo completo somente quando ele pode:

- mudar o plano;
- confirmar/refutar uma hipótese;
- fornecer comando, parâmetro ou procedimento exato;
- resolver contradição;
- sustentar uma afirmação decisiva;
- fornecer resultado bruto necessário para interpretação.

L2 pode ser nota canônica completa, log, resultado de execução, fonte original ou arquivo upstream.

## 3. Ranking de candidatos

Não ordene candidatos apenas por correspondência textual.

Priorize nesta ordem lógica, ajustando ao problema:

1. correspondência direta com o objetivo/entidade;
2. identidade canônica em vez de duplicata;
3. evidência/proveniência clara;
4. validade de versão/tempo;
5. relação forte com algo já selecionado;
6. informação capaz de alterar a decisão;
7. estado atual sobre histórico obsoleto, quando ambos descrevem o mesmo escopo.

Penalize:

- duplicatas;
- notas arquivadas sem relevância histórica explícita;
- resultados antigos contraditos por evidência mais nova;
- snippets vagos;
- coocorrência sem relação explicável;
- arquivos upstream quando existe uma adaptação canônica ativa para o mesmo mecanismo.

## 4. Expansão por relações

Depois de selecionar um artefato canônico:

1. leia as relações fortes declaradas;
2. expanda **um salto** quando a relação puder mudar a decisão;
3. faça um segundo salto somente para fechar uma lacuna explícita;
4. não percorra o grafo inteiro.

Relação forte é aquela que tem significado operacional/proveniência, por exemplo dependência, validação, causa, implementação, decisão ou evidência.

Coocorrência textual não é relação forte.

## 5. Resolução de aliases e identidade

Antes de considerar dois arquivos como conhecimento diferente:

- compare IDs estáveis;
- aliases;
- escopo;
- versão;
- entidade central;
- relações/proveniência.

Se representam a mesma unidade de conhecimento, prefira a nota canônica e trate as outras como aliases, histórico ou duplicatas candidatas a merge.

## 6. Freshness e contradições

Quando duas fontes/memórias divergem:

1. identifique se descrevem versões/escopos diferentes;
2. confira data e última verificação quando relevantes;
3. prefira estado canônico atual para o escopo atual;
4. preserve histórico se ele ainda explicar uma transição;
5. carregue L2 das evidências necessárias para resolver a contradição;
6. sinalize ao consumidor do Context Packet se o conflito ainda não pode ser resolvido.

Nunca silencie uma contradição apenas escolhendo o arquivo mais recente.

## 7. Retrieval Budget

O orçamento é determinado por **valor marginal**, não por número fixo de arquivos.

Depois de cada candidato carregado, pergunte:

- Isso mudou o modelo do problema?
- Mudou a próxima decisão?
- Fechou uma lacuna?
- Criou uma nova lacuna relevante?

Pare quando duas condições forem verdadeiras:

1. os artefatos restantes são redundantes ou de baixo impacto; e
2. o contexto atual já permite ao consumidor planejar/pesquisar/decidir com segurança adequada.

## 8. Fallback quando o índice falha

Se `MEMORY_INDEX.md` estiver incompleto ou desatualizado:

1. não conclua que a memória não existe;
2. busque diretamente por entidades, aliases e identificadores no repositório;
3. descubra a nota canônica real;
4. continue a tarefa;
5. depois encaminhe ao `memory-manager` a oportunidade de reparar o índice se isso reduzir retrieval futuro.

O índice é cache de roteamento, não fonte absoluta da verdade.

## 9. Context Packet

Mantenha internamente uma estrutura equivalente a:

```yaml
retrieval:
  intent: "decisão que precisa ser tomada"
  entities:
    - id-ou-nome
  tools_used:
    - github-search
    - github-fetch
  selected:
    - ref: "path-ou-id"
      level: L1
      canonical: true
      reason: "muda a decisão porque..."
      evidence_refs: []
  relations_followed:
    - from: "A"
      relation: "depende-de"
      to: "B"
      reason: "relevante porque..."
  unresolved_gaps: []
  stop_reason: "contexto suficiente para ..."
```

O schema é lógico, não obrigação de persistir YAML em toda execução.

## 10. Entrega para outras skills

### Para `planner`
Entregue:
- estado atual conhecido;
- dependências relevantes;
- decisões anteriores ainda válidas;
- limitações;
- lacunas reais.

### Para `deep-investigator`
Entregue:
- o que já foi pesquisado;
- fontes anteriores decisivas;
- contradições;
- o que ainda precisa de informação externa atual.

### Para `memory-manager`
Entregue:
- nota canônica provável;
- duplicatas/aliases encontrados;
- relações relevantes;
- frescor;
- operação de memória que parece necessária, sem executá-la automaticamente.

### Para `skill-improver`
Entregue:
- skill existente mais próxima;
- referências relacionadas;
- histórico/proveniência útil;
- possíveis duplicatas.

## 11. Anti-padrões

Não:

- leia o repositório inteiro "para garantir";
- abra L2 de todos os candidatos;
- use `upstream/` como contexto operacional padrão;
- trate filename match como prova de relevância;
- trate recência como sinônimo de verdade;
- invente relação sem evidência;
- alegue vector search inexistente;
- crie nova memória só porque a busca foi difícil.

## Verification

Antes de entregar o Context Packet, confirme:

- [ ] a consulta representa o objetivo real;
- [ ] candidatos foram buscados antes de carregar detalhes;
- [ ] notas canônicas foram preferidas a duplicatas;
- [ ] L2 foi carregado somente quando tinha valor decisório;
- [ ] relações expandidas têm justificativa;
- [ ] frescor/proveniência foram considerados quando materiais;
- [ ] nenhuma capacidade de retrieval inexistente foi alegada;
- [ ] há uma razão explícita para parar a busca.
