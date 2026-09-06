---
name: memory-manager
description: Mantém um vault persistente auto-organizado: recupera contexto relevante, decide editar/mesclar/criar, compacta conhecimento e preserva relações e proveniência sem impor uma taxonomia fixa. Use em toda mudança significativa de conhecimento ou estado.
---

# Adaptive Persistent Memory

> Adaptação dos mecanismos de `github/awesome-copilot:remember`, `memory-merger`, `addyosmani/agent-skills:context-engineering`, Mem0 e princípios de retrieval/indexação do LlamaIndex.

## Princípio central

A memória deve **aumentar a capacidade de decisão**. Se crescer sem melhorar recuperação, virou lixo.

Não imponha uma árvore fixa de diretórios nem crie um arquivo para cada fato. A organização deve emergir do uso e pode ser reorganizada quando padrões de recuperação aparecerem.

## Operações permitidas

Para qualquer informação nova, escolha uma operação deliberada:

- **UPDATE** — enriquecer a nota canônica existente;
- **MERGE** — consolidar notas sobre o mesmo conceito;
- **LINK** — adicionar relação útil sem duplicar conteúdo;
- **SPLIT** — separar uma nota que passou a conter conceitos independentes;
- **PROMOTE** — transformar aprendizado recorrente em conhecimento/instrução durável;
- **COMPACT** — resumir material maduro preservando detalhes recuperáveis;
- **ARCHIVE** — remover do contexto ativo sem perder histórico;
- **CREATE** — criar nota nova somente quando representa uma unidade estável e distinta;
- **DISCARD** — não persistir ruído, saída transitória ou duplicação.

`CREATE` é exceção. `UPDATE/MERGE/LINK` são o caminho normal.

## Recuperar antes de escrever

Antes de persistir algo:

1. descubra as notas e domínios existentes;
2. busque por:
   - identificadores;
   - aliases/sinônimos;
   - entidades;
   - tags;
   - backlinks;
   - relações;
   - frases-resumo;
   - busca semântica, se disponível;
3. leia as melhores candidatas;
4. decida se a informação pertence a uma nota canônica existente;
5. só então escreva.

Nunca crie `resultado-final-2.md`, `novo-teste.md`, `anotacao3.md` por conveniência.

## Unidade canônica de conhecimento

Uma nota canônica deve representar uma unidade que faça sentido recuperar sozinha.

O formato exato é decidido pela skill de template, mas toda nota durável precisa expor de forma recuperável:

- identidade estável;
- descrição/resumo semântico curto;
- aliases e termos de busca importantes;
- relações com outras notas;
- proveniência/fontes ou execuções que sustentam o conteúdo;
- estado temporal quando a informação pode envelhecer;
- conteúdo consolidado;
- pistas de quando recuperar aquela nota.

Não force os mesmos nomes de campos em todos os domínios se outro schema for claramente melhor.

## Memória de trabalho vs conhecimento durável

Resultados de uma execução não viram automaticamente conhecimento permanente.

Fluxo:

1. resultado bruto entra no espaço de trabalho da tarefa;
2. o agente interpreta;
3. identifica informação reutilizável;
4. resolve duplicações/conflitos;
5. promove apenas o conhecimento que melhora decisões futuras;
6. o restante permanece histórico ou é descartado.

## Consolidação

Quando várias notas começam a se sobrepor:

1. identifique a nota que deve ser canônica;
2. faça inventário das afirmações, relações e fontes;
3. mescle sem perda de informação;
4. elimine duplicação;
5. preserve aliases dos arquivos antigos;
6. atualize backlinks;
7. archive/remova as notas redundantes somente depois da verificação.

A meta é a mesma do `memory-merger`: **zero perda de conhecimento, mínima redundância, máxima recuperabilidade**.

## Compactação semântica

Compactar não é apagar detalhes indiscriminadamente.

Uma compactação boa:

- preserva fatos que mudam decisões;
- preserva exceções e condições;
- mantém links para evidência bruta;
- produz resumo curto para retrieval;
- remove repetição narrativa;
- separa estado atual de histórico.

Se a nota continua grande porque contém múltiplos conceitos independentes, faça `SPLIT` em vez de resumir demais.

## Conflitos e atualização temporal

Quando informação nova contradiz memória antiga:

- não sobrescreva silenciosamente;
- identifique escopo, versão e data;
- preserve a evidência anterior se ainda for válida em outro contexto;
- atualize a nota canônica para representar a regra correta e suas condições;
- mantenha histórico suficiente para explicar a mudança.

## Auto-organização

A taxonomia pode evoluir.

Crie ou altere agrupamentos quando isso melhora:

- precisão de retrieval;
- redução de duplicidade;
- navegação por relações;
- isolamento entre contextos;
- velocidade para encontrar notas relevantes.

Não reorganize por estética. Reorganize por ganho de recuperação.

## Recuperação para uma nova tarefa

Não carregue o vault inteiro.

1. transforme o objetivo atual em uma consulta de memória;
2. recupere notas diretamente relacionadas;
3. expanda um ou dois saltos por relações fortes quando necessário;
4. priorize memórias recentes e canônicas;
5. traga somente o contexto que pode alterar o plano ou a decisão.

Isso segue o princípio de context engineering: **informação certa, no momento certo**.

## Aprendizado e auto-melhoria externa

Quando um padrão de solução, falha ou workflow se repete:

1. generalize o aprendizado;
2. valide que ele é reutilizável;
3. promova para memória/instrução durável;
4. se houver skill relacionada, proponha ou aplique melhoria nela sem destruir o mecanismo original;
5. registre proveniência da melhoria.

A auto-melhoria ocorre no sistema externo de skills/memória, não por suposta alteração dos pesos do modelo.

## Gate de qualidade da memória

Antes de terminar uma atualização:

- [ ] procurei conteúdo existente antes de criar;
- [ ] escolhi deliberadamente UPDATE/MERGE/LINK/etc.;
- [ ] removi redundância;
- [ ] preservei proveniência;
- [ ] adicionei relações úteis;
- [ ] deixei resumo/pistas de retrieval;
- [ ] não promovi ruído transitório;
- [ ] a mudança deixa a próxima recuperação mais rápida, não mais lenta.
