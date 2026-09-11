---
name: knowledge-linker
description: Resolve entidades e relações úteis para retrieval e decisão.
version: 1.1.0
related_skills:
  - knowledge-retrieval
  - memory-manager
  - template-engineer
---

# Adaptive Knowledge Linker

Transforme informação isolada em **conhecimento navegável** sem criar um grafo ornamental ou uma ontologia rígida. Relações existem para melhorar retrieval, planejamento, explicação causal e validação.

## 1. Resolver identidade antes de criar nós

Para cada entidade:

1. normalize o nome;
2. busque aliases, nomes antigos, IDs e variantes;
3. procure nota canônica existente;
4. compare escopo/versão;
5. reutilize identidade existente quando for a mesma entidade;
6. crie nova entidade apenas quando semanticamente distinta.

Evite nós duplicados por diferença de grafia.

## 2. Relações tipadas

O tipo nasce do domínio e da evidência. Exemplos abstratos:

- depende-de;
- controla;
- configura;
- implementa;
- causa/pode-causar;
- evidencia;
- valida;
- contradiz;
- substitui;
- equivalente-a;
- derivado-de;
- relacionado-a.

Não limite o sistema a essa lista.

## 3. Força da relação

Toda relação usada para retrieval deve ter força/qualidade implícita ou explícita.

### Strong
Use quando a relação é sustentada por:
- documentação/fonte direta;
- resultado verificável;
- dependência estrutural clara;
- decisão canônica;
- vínculo explícito entre artefatos.

Pode expandir contexto automaticamente quando muda a decisão.

### Medium
Use quando a relação é útil, mas depende de contexto/versão ou possui evidência indireta.

Pode ser expandida quando existe lacuna específica.

### Weak
Coocorrência, similaridade vaga ou associação ainda não comprovada.

Não carregue automaticamente contexto por essa relação. Use-a como pista de pesquisa, se necessário.

Não transforme a escala em burocracia: o importante é impedir que qualquer backlink tenha o mesmo peso.

## 4. Retrieval value

Antes de criar uma relação, pergunte:

- isso ajuda a encontrar conhecimento depois?
- isso explica dependência/causa/validação?
- isso reduz ambiguidade de identidade?
- isso muda qual contexto deve ser carregado?

Se não, não crie o link.

## 5. Proveniência

Toda relação decisiva deve poder responder:

- qual fonte/execução/decisão a sustenta;
- escopo/versão;
- quando foi verificada, se temporalmente relevante;
- qual nota contém a explicação completa.

O link não substitui a evidência.

## 6. Backlinks e aliases

Quando o formato suporta backlinks:

- mantenha coerência após renomear/mesclar;
- preserve aliases;
- redirecione links para a unidade canônica;
- não mantenha duplicatas só para evitar corrigir backlinks.

## 7. Integração com `knowledge-retrieval`

O linker não deve carregar o grafo inteiro.

Ao servir retrieval:

1. entregue relações fortes primeiro;
2. relações médias somente quando fecham uma lacuna;
3. relações fracas como pistas, não contexto automático;
4. expanda um salto por padrão;
5. segundo salto apenas quando justificado pelo problema.

## 8. Grafo como detector de lacunas

Quando uma decisão depende de uma relação ausente/incerta:

1. registre a lacuna;
2. formule pergunta de pesquisa/teste;
3. use `deep-investigator` ou execução apropriada;
4. só promova a relação quando houver evidência.

O grafo deve mostrar também o que **ainda não sabemos**, sem preencher lacunas por inferência silenciosa.

## 9. Consolidação

Se nós/relações duplicam conhecimento:

- canonize;
- mescle;
- preserve provenance;
- atualize aliases/backlinks;
- archive redundância após verificação.

## 10. Markdown / Obsidian-style links

Quando útil, use `[[nota-canônica]]`, links relativos ou metadata estruturada para navegação. A sintaxe escolhida deve ser compreendida pelas ferramentas atuais ou continuar legível por busca textual.

Não declare que backlinks criam busca semântica real.

## Verification

Antes de salvar relação importante:

- [ ] entidade foi resolvida/canonizada;
- [ ] relação tem significado operacional;
- [ ] strength/retrieval value está claro;
- [ ] provenance existe quando a relação é decisiva;
- [ ] não é apenas coocorrência;
- [ ] aliases/backlinks continuam válidos;
- [ ] retrieval não passará a carregar contexto irrelevante por causa deste link.
