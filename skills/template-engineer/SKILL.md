---
name: template-engineer
description: Projeta e evolui schemas/templates Markdown orientados a retrieval para plano, memória, resultados, fontes e conhecimento, escolhendo quando reutilizar, editar, mesclar ou criar estruturas sem impor uma taxonomia fixa.
---

# Adaptive Template Engineer

> Inspirado nos templates e lifecycle contracts do `planning-with-files`, na estrutura de memória do `awesome-copilot`, em context engineering e nos princípios de retrieval/graph memory de Mem0/LlamaIndex.

## Missão

Não fornecer “um template universal”.

Fornecer a capacidade de **escolher ou construir o template certo para o tipo de informação e para a forma como ela precisará ser recuperada depois**.

## Regra 1 — Inspect Before Invent

Antes de criar um schema:

1. descubra templates existentes;
2. leia arquivos do mesmo tipo;
3. identifique quais campos realmente são usados por retrieval, execução ou validação;
4. reutilize o schema existente se ele já serve;
5. adapte o schema existente se falta um requisito recorrente;
6. crie template novo somente quando o tipo de artefato é semanticamente diferente.

## Regra 2 — Retrieval First

O template deve ser desenhado a partir das perguntas futuras.

Pergunte:

- Como o agente vai localizar isto?
- Por quais nomes/aliases?
- Que relação precisa levá-lo até esta nota?
- Que resumo deve ser indexado?
- Que campo será usado para filtrar?
- Que evidência precisa ser rastreada?
- O que envelhece e precisa de data/versão?
- O que deve ser legível por máquina?

Se um campo não melhora recuperação, execução ou auditoria, provavelmente não precisa existir.

## Primitivas de schema

Não imponha os mesmos nomes de campos, mas garanta equivalentes para o que o artefato exige.

### Identidade
- ID estável;
- tipo;
- aliases;
- versão/schema quando relevante.

### Retrieval
- resumo semântico curto;
- termos-chave;
- entidades;
- links/backlinks;
- relações tipadas.

### Proveniência
- fontes;
- execução que originou o dado;
- hash/versão do artefato;
- data/escopo quando relevante.

### Estado
- status;
- fase;
- dependências;
- próximo ponto de decisão.

### Conteúdo
- conhecimento consolidado;
- evidência;
- decisão;
- saída estruturada.

Use apenas as primitivas necessárias ao tipo de artefato.

## Escolha de granularidade

Crie uma nota separada quando:

- representa conceito estável e reutilizável;
- possui ciclo de vida próprio;
- é referenciada por vários contextos;
- separar melhora retrieval.

Mantenha dentro de nota existente quando:

- é apenas detalhe de um conceito;
- não será recuperada isoladamente;
- criaria fragmentação;
- repete estrutura já canônica.

## Markdown profissional

Quando adequado:

- frontmatter YAML para metadados;
- headings previsíveis;
- tabelas apenas para dados tabulares;
- blocos JSON/YAML para resultados que precisam ser parseados;
- links relativos ou wikilinks quando o vault os suporta;
- IDs estáveis em vez de nomes frágeis;
- seções pequenas e escaneáveis;
- conteúdo bruto separado de resumo/decisão.

## Templates adaptativos por artefato

O sistema pode precisar de templates diferentes para:

- plano;
- fase;
- execução;
- resultado;
- fonte;
- nota de conhecimento;
- decisão;
- lição;
- índice;
- skill.

Não pré-crie todos. Crie quando a demanda surgir e houver padrão suficiente.

## Evolução de schema

Quando um template deixa de servir:

1. prove o problema de retrieval/execução;
2. desenhe a mudança mínima;
3. versione o schema se necessário;
4. migre notas afetadas de forma controlada;
5. mantenha aliases/backlinks;
6. valide que o novo formato melhora busca;
7. evite coexistência indefinida de variantes equivalentes.

## Compactação

Templates devem facilitar compactação:

- resumo separado de evidência bruta;
- referências para detalhes;
- campos consistentes para deduplicação;
- relações explícitas;
- histórico separável do estado atual.

## Gate

Um template só é bom se:

- reduz tempo de recuperação;
- evita duplicidade;
- mantém proveniência;
- preserva relações;
- pode ser atualizado sem criar arquivos descartáveis;
- é compreensível pelo agente e por ferramentas;
- não obriga informação a caber em categorias artificiais.
