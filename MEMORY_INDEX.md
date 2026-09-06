# Memory Routing Index

Este arquivo é um **cache de roteamento**, não uma taxonomia obrigatória.

## Regra

A estrutura real do vault pode mudar conforme o agente aprende e conforme os padrões de recuperação evoluem.

Antes de usar este índice como verdade:
1. descubra a estrutura atual do repositório;
2. valide os caminhos;
3. use `memory-manager` para localizar notas canônicas;
4. atualize este arquivo somente se um ponteiro estável realmente reduzir o custo de retrieval.

## O que deve aparecer aqui

Somente ponteiros de alto valor, por exemplo:
- estado ativo atual;
- plano ativo;
- notas canônicas muito reutilizadas;
- índices semânticos/relacionais disponíveis;
- aliases de áreas reorganizadas.

Não liste todo arquivo do repositório.

## Política de manutenção

- prefira atualizar ponteiro existente;
- remova ponteiros obsoletos;
- preserve aliases após reorganização;
- não crie seções por domínio só porque um domínio apareceu uma vez;
- deixe a taxonomia emergir do uso.

## Bootstrap atual

A estrutura anterior em `memory/`, `research/` e `tasks/` pode conter material útil, mas é **legado**, não contrato permanente.

Use as skills adaptativas em `skills/` para decidir como reutilizar, consolidar ou reorganizar esse conteúdo.
