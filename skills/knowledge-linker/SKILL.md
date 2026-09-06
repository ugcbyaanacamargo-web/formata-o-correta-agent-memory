---
name: knowledge-linker
description: Resolve entidades, cria relações tipadas e usa o grafo de conhecimento para retrieval e planejamento, evitando links redundantes e ontologias rígidas. Use quando novas evidências alterarem relações entre conceitos.
---

# Adaptive Knowledge Linker

## Objetivo

Transformar informação isolada em **conhecimento navegável**.

O grafo não é um diagrama decorativo. Ele deve permitir que uma investigação encontre rapidamente:

- o que depende de quê;
- o que foi observado junto;
- qual evidência sustenta uma relação;
- que nota é canônica;
- que caminho conecta o problema atual ao conhecimento já acumulado.

## 1. Resolver entidades antes de criar

Para cada entidade nova:

1. normalize o nome;
2. pesquise aliases e nomes anteriores;
3. procure nota canônica existente;
4. reutilize o identificador existente quando for a mesma entidade;
5. crie entidade nova apenas quando semanticamente distinta.

Evite nós duplicados por variação de nome.

## 2. Relações tipadas e úteis

Crie uma relação somente quando ela melhora navegação ou decisão.

O tipo da relação deve nascer do domínio e do conhecimento, não de uma lista fixa. Exemplos abstratos de intenção:

- dependência;
- controle;
- origem;
- consequência;
- evidência;
- implementação;
- equivalência;
- substituição;
- conflito;
- validação.

Não crie link apenas porque duas palavras apareceram no mesmo resultado.

## 3. Proveniência da relação

Toda relação importante deve poder responder:

- de onde veio;
- em qual execução/fonte foi observada;
- se é regra geral ou dependente de versão/estado;
- qual nota contém a explicação completa.

O grafo aponta para conhecimento; não substitui a explicação.

## 4. Backlinks

Quando o formato usado suportar links bidirecionais ou backlinks:

- mantenha os dois lados coerentes;
- preserve aliases após renomeações;
- não quebre links ao consolidar notas;
- atualize referências durante MERGE/SPLIT.

## 5. Retrieval orientado por grafo

Ao recuperar memória para uma tarefa:

1. localize as entidades diretamente mencionadas ou semanticamente relacionadas;
2. carregue suas notas canônicas;
3. expanda relações fortes que possam mudar a decisão;
4. pare antes de trazer vizinhança irrelevante.

Use o grafo como **expansor de contexto**, não como motivo para carregar todo o vault.

## 6. Grafo como gerador de pesquisa

Quando uma relação essencial está ausente:

- transforme a lacuna em pergunta de pesquisa;
- use a skill de investigação profunda;
- registre o resultado e feche a relação se a evidência sustentar.

Assim o grafo ajuda o agente a saber **o que ainda precisa aprender**.

## 7. Consolidação

Se múltiplas relações ou nós passam a dizer a mesma coisa:

- canonize;
- mescle;
- preserve proveniência;
- redirecione backlinks;
- remova redundância.

## 8. Compatibilidade com Markdown/Obsidian

Quando o vault usar Markdown compatível com Obsidian:

- use links estáveis como `[[nota-canônica]]` quando isso melhorar navegação;
- use aliases para manter referências antigas;
- use frontmatter apenas para metadata que será realmente consultada;
- mantenha um resumo semântico curto para futura indexação vetorial.

Não dependa de sintaxe Obsidian se o runtime atual não a entende; preserve o conceito de ligação usando o mecanismo disponível.
