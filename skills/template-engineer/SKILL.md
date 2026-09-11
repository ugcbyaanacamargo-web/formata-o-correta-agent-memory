---
name: template-engineer
description: Projeta schemas Markdown orientados a retrieval e auditoria.
version: 1.1.0
related_skills:
  - knowledge-retrieval
  - memory-manager
  - knowledge-linker
---

# Adaptive Template Engineer

Projete a representação que torna um artefato **fácil de encontrar, entender, atualizar e auditar**. Não existe template universal. O schema nasce do uso de retrieval, decisão e manutenção.

## Regra central

**Inspect before invent. Retrieval before decoration.**

Antes de criar ou alterar um template:

1. descubra schemas/templates existentes;
2. leia exemplos do mesmo tipo de artefato;
3. veja como `knowledge-retrieval` realmente localiza esse conteúdo;
4. identifique quais campos têm consumidor real;
5. reutilize o schema atual se ele já atende;
6. adapte minimamente quando uma lacuna é recorrente;
7. crie novo template apenas para um tipo de artefato realmente distinto.

## 1. Perguntas de design

Antes de definir campos, responda:

- Como esse artefato será localizado daqui a semanas/meses?
- Qual frase curta permite decidir se vale abrir o conteúdo?
- Qual overview permite planejar sem ler o detalhe inteiro?
- Quais aliases/IDs evitam falha de busca?
- Quais relações precisam ser navegáveis?
- Qual provenance precisa sobreviver?
- O que pode envelhecer?
- Qual parte precisa ser legível por máquina?
- O conteúdo bruto precisa ficar separado do consolidado?

Se um campo não melhora retrieval, execução, atualização ou auditoria, provavelmente ele não pertence ao schema.

## 2. Camadas L0 / L1 / L2

Adapte o conceito de OpenViking sem obrigar uma estrutura de arquivos específica.

### L0 — Abstract

Sinal de relevância curto.

Pode ser:
- `abstract` no frontmatter;
- uma linha de resumo;
- descrição no índice;
- heading + primeira frase.

Objetivo: decidir rapidamente se o artefato merece aprofundamento.

### L1 — Overview

Contexto suficiente para navegação/planejamento:

- escopo;
- estado atual;
- pontos decisivos;
- links para detalhe;
- relações principais;
- provenance resumida;
- freshness quando relevante.

Pode ser seção no próprio arquivo ou overview de um conjunto.

### L2 — Detail

Detalhe integral necessário para execução/prova:

- evidência;
- logs/resultados;
- procedimento completo;
- histórico;
- fonte técnica extensa.

Não duplique L2 dentro de L1.

## 3. Anti-fragmentação

Não crie automaticamente:

- um `.abstract.md` por arquivo;
- um `.overview.md` por arquivo;
- um Markdown novo por resultado;
- um arquivo novo para cada entidade citada.

Crie uma unidade separada somente quando ela possui valor de retrieval próprio ou ciclo de vida independente.

Se resumo e detalhe cabem bem na mesma nota canônica, mantenha-os juntos.

## 4. Primitivas de schema

Use somente quando aplicáveis.

### Identidade
- ID estável;
- tipo;
- aliases;
- canonical/alias status.

### Retrieval
- abstract L0;
- overview L1;
- termos-chave somente quando melhoram busca;
- entidades;
- relações/backlinks;
- hints de quando carregar L2.

### Proveniência
- fontes;
- execução que originou o dado;
- commit/hash quando material;
- escopo/versão/data.

### Freshness
- `last_verified` quando validade temporal importa;
- indicação de resumo possivelmente defasado;
- versão/scope atual.

### Estado
- status;
- fase;
- dependências;
- decisão atual;
- próximo ponto de decisão.

### Conteúdo
- conhecimento consolidado;
- evidência;
- ação/procedimento;
- output estruturado.

## 5. Frontmatter

Use YAML frontmatter quando ele melhora:

- busca;
- identificação;
- routing;
- deduplicação;
- relações;
- freshness;
- automação futura.

Não use frontmatter como depósito de campos vazios.

Exemplo lógico mínimo quando útil:

```yaml
---
id: stable-id
abstract: "Resumo curto para relevância."
aliases: ["alias-a", "alias-b"]
canonical: true
last_verified: 2026-09-11
related:
  - target: another-id
    relation: depends-on
sources:
  - ref: SRC-001
---
```

O exemplo é uma opção, não um template obrigatório.

## 6. Resultados de execução

Quando um resultado precisa ser parseado pelo agente, prefira:

- JSON/YAML estruturado para dados;
- Markdown curto para explicação humana;
- artefato bruto separado quando muito grande.

Preserve:
- ID da execução;
- versão/hash do script quando material;
- timestamp;
- status;
- ambiente relevante;
- arquivos/evidências produzidos.

Não faça o usuário copiar blocos gigantes se o fluxo GitHub puder persistir o resultado.

## 7. Templates por função

Podem surgir schemas distintos para:

- plano;
- fase;
- execução;
- resultado;
- fonte;
- nota canônica;
- decisão;
- lição;
- índice;
- skill;
- proposta de melhoria.

Não pré-crie todos. Um template nasce quando existe uso real recorrente.

## 8. Evolução de schema

Altere um schema quando houver problema observável:

- busca perde resultados relevantes;
- duplicação cresce;
- relações não podem ser reconstruídas;
- provenance se perde;
- o agente precisa abrir detalhe demais para decidir relevância;
- múltiplas variantes do mesmo tipo criam ambiguidade.

Procedimento:

1. prove o problema;
2. proponha mudança mínima;
3. versione somente se migração for necessária;
4. migre artefatos afetados de forma controlada;
5. preserve aliases/backlinks;
6. verifique retrieval depois da migração;
7. elimine coexistência indefinida de variantes equivalentes.

## 9. Compactação

O schema deve permitir separar:

- resumo de relevância;
- overview de decisão;
- detalhe/evidência;
- histórico;
- provenance.

Isso permite compactar sem apagar informação importante.

## 10. Gate de qualidade

Um template só é aprovado quando:

- [ ] reduz custo de retrieval;
- [ ] não cria arquivos desnecessários;
- [ ] diferencia resumo de detalhe;
- [ ] preserva provenance;
- [ ] mantém relações úteis;
- [ ] freshness é representável quando necessária;
- [ ] campos possuem consumidor real;
- [ ] pode evoluir sem quebrar identidade/backlinks;
- [ ] não assume runtime externo inexistente;
- [ ] o agente e uma pessoa conseguem entender o artefato sem conhecer sua implementação interna.
