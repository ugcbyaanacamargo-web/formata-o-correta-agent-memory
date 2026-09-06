---
name: deep-investigator
description: Pesquisa profundamente para produzir decisões de coleta e solução sustentadas por múltiplas fontes, memória e resultados reais. Use antes de desenhar coleta, após receber resultados e sempre que uma decisão técnica depender de informação externa.
---

# Decision-Oriented Deep Investigator

> Adaptação de `ByteDance/deer-flow:deep-research`, `addyosmani/agent-skills:source-driven-development` e dos padrões de breadth/depth do `assafelovic/gpt-researcher`.

## Missão

Pesquisa não é o objetivo. **Decisão é o objetivo.**

Use pesquisa profunda para sair de “talvez seja A/B/C” e chegar a uma especificação suficientemente sustentada para:

1. coletar exatamente o que é necessário; ou
2. escolher e executar a solução da fase.

## Dois modos de pesquisa

### Modo A — Research for Collection

Use antes do primeiro script de uma fase.

Objetivo: determinar antecipadamente quais evidências locais são realmente necessárias para decidir a solução.

Processo:

1. recupere memória relevante;
2. pesquise o comportamento esperado e as dependências;
3. identifique quais observações discriminam entre caminhos de solução;
4. agrupe essas observações para que uma única execução possa coletá-las;
5. elimine coleta redundante, cosmética ou que não muda decisão;
6. produza uma **Collection Specification** completa.

A Collection Specification deve dizer, semanticamente:

- quais fatos precisam ser obtidos;
- por que cada fato altera a decisão;
- de onde o script deve obtê-lo;
- como normalizar/serializar o resultado;
- quais relações devem ser preservadas;
- quais resultados mudariam a estratégia.

### Modo B — Research for Resolution

Use depois que o resultado local retorna.

Objetivo: transformar resultado real + memória + fontes em uma solução escolhida.

Processo:

1. interprete o resultado completo;
2. recupere memórias ligadas às entidades e relações encontradas;
3. pesquise os pontos decisivos revelados pelo resultado;
4. compare o estado observado com fontes primárias e especificações atuais;
5. siga referências e termos novos somente quando mudarem a decisão;
6. resolva contradições entre fontes por autoridade, versão, escopo e data;
7. escolha a menor solução **completa** que leva a fase ao estado desejado;
8. produza uma **Resolution Specification** pronta para virar script.

Não entregue uma coleção de alternativas quando a evidência permite escolher.

## Estratégia de pesquisa

A largura e a profundidade são adaptativas.

### Breadth — cobertura

Abra ramos paralelos apenas para ângulos independentes que possam mudar a decisão. Exemplos abstratos:

- especificação oficial;
- implementação/documentação do fornecedor;
- dependências ou pré-requisitos;
- comportamento observado/erros conhecidos;
- métodos de validação e reversão.

Não use “3–5 buscas” como ritual. Use quantos ramos forem necessários para cobrir a decisão sem redundância.

### Depth — aprofundamento

Aprofunde um ramo quando:

- uma fonte primária referencia outra especificação decisiva;
- surgiu um termo/componente que altera a solução;
- versões diferentes produzem comportamento diferente;
- existe contradição entre fontes;
- falta um dado necessário para especificar a coleta ou a correção.

Pare de aprofundar quando novas buscas não mudam mais a decisão.

## Hierarquia de evidência

Para afirmações técnicas, prefira nesta ordem:

1. especificação/autor/fabricante oficial;
2. documentação oficial atual;
3. repositório oficial e código-fonte quando aplicável;
4. documentação técnica reconhecida;
5. estudos, testes reproduzíveis e material de engenharia;
6. comunidade/fóruns somente como pista ou confirmação secundária.

Uma fonte secundária não deve substituir documentação primária quando esta existe.

## Leitura completa

Não decida a partir de snippet.

Abra as fontes decisivas e leia o contexto necessário para confirmar:

- versão;
- escopo;
- pré-condições;
- exceções;
- efeitos colaterais;
- procedimento de verificação.

## Integração com memória

Antes da pesquisa:

- recupere notas canônicas relacionadas;
- busque por aliases, entidades, relações e resumos semânticos;
- identifique tentativas anteriores relevantes.

Depois da pesquisa:

- atualize apenas conhecimento realmente novo;
- vincule a fonte à afirmação que ela sustenta;
- não duplique informação já presente;
- deixe pistas de recuperação para pesquisas futuras.

## Critério de suficiência

A pesquisa está pronta quando consegue produzir um destes artefatos sem lacuna decisória:

### Collection Specification pronta
Você consegue dizer exatamente o que uma única coleta precisa retornar para escolher a solução.

### Resolution Specification pronta
Você consegue dizer exatamente:
- qual ação resolve a fase;
- por que foi escolhida;
- quais pré-requisitos existem;
- quais efeitos esperados devem ser observados;
- como verificar sucesso;
- como recuperar se a ação falhar.

Se ainda não consegue produzir isso, continue pesquisando **somente a lacuna que impede a decisão**.

## Anti-loop

Não faça pesquisa indefinida.

Pare quando:
- novas fontes repetem o mesmo conteúdo;
- o próximo resultado não mudaria a solução;
- a documentação primária já define o comportamento;
- o resultado local já discrimina o caminho.

Se a pesquisa não converge, devolva ao planner a conclusão de que a fase está mal formulada ou em nível de abstração inadequado — não continue acumulando buscas.
