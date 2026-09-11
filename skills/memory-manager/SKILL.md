---
name: memory-manager
description: Mantém memória canônica recuperável, compacta e auditável.
version: 1.1.0
related_skills:
  - knowledge-retrieval
  - knowledge-linker
  - template-engineer
  - skill-improver
---

# Adaptive Persistent Memory

Mantenha uma memória que **reduz o custo da próxima decisão**. A memória não é um arquivo gigante nem uma árvore fixa: é um conjunto canônico de conhecimento, relações e evidências organizadas para retrieval eficiente no ChatGPT Web + GitHub.

## Regra central

Antes de escrever, **recupere o que já existe** com `knowledge-retrieval`.

A sequência normal é:

```text
novo resultado/conhecimento
        ↓
knowledge-retrieval
        ↓
identidade canônica + contexto existente
        ↓
classificar valor/durabilidade
        ↓
UPDATE / MERGE / LINK / SPLIT / PROMOTE / COMPACT / ARCHIVE / CREATE / DISCARD
```

`CREATE` é exceção. `UPDATE`, `MERGE` e `LINK` são o caminho preferido quando já existe uma unidade canônica adequada.

## Operações

### UPDATE
Enriquece uma nota canônica existente sem duplicar conteúdo.

### MERGE
Consolida duas ou mais notas que representam a mesma unidade de conhecimento.

### LINK
Cria relação útil sem copiar o mesmo conteúdo em vários lugares.

### SPLIT
Separa uma nota que cresceu a ponto de conter unidades independentes recuperáveis por si só.

### PROMOTE
Eleva uma observação/resultado para conhecimento durável depois de evidência suficiente.

### COMPACT
Remove repetição narrativa, preservando fatos decisivos, exceções, relações e links para evidência.

### ARCHIVE
Retira do contexto ativo sem destruir histórico/proveniência.

### CREATE
Cria nova unidade canônica quando nenhuma existente representa corretamente o conhecimento.

### DISCARD
Não persiste ruído, duplicata, estado transitório irrelevante ou informação sem valor futuro.

## 1. Recuperar antes de escrever

Use `knowledge-retrieval` para descobrir:

- nota canônica provável;
- aliases;
- duplicatas;
- relações fortes;
- estado/frescor;
- fontes/resultados anteriores;
- conhecimento contraditório;
- skill associada, quando houver.

Não assuma que `MEMORY_INDEX.md` contém tudo. Ele é cache de roteamento.

## 2. Classifique o novo conteúdo

Antes de persistir, determine se é:

- **raw evidence** — log, resultado, saída, fonte bruta;
- **case state** — estado específico de uma execução/sistema/caso;
- **durable fact** — conhecimento factual reutilizável;
- **decision** — escolha e justificativa ainda relevantes;
- **relation** — ligação entre entidades/conhecimentos;
- **lesson candidate** — padrão possivelmente reutilizável;
- **procedure candidate** — aprendizado que pode melhorar uma skill;
- **transient noise** — não merece persistência.

Não misture todos esses tipos num mesmo parágrafo só porque vieram da mesma execução.

## 3. Progressive Context: L0 / L1 / L2

Adapte o princípio do OpenViking sem depender de OpenViking real.

### L0 — Abstract

Sinal mínimo de relevância.

Deve permitir responder rapidamente:

> "Vale abrir isto para a tarefa atual?"

Pode viver em:
- frontmatter;
- entrada de índice;
- primeira seção curta;
- descrição canônica.

Não crie `.abstract.md` separado por hábito.

### L1 — Overview

Resumo navegável para planejamento/decisão:

- escopo;
- estado atual;
- fatos centrais;
- relações importantes;
- fontes principais;
- links para detalhe;
- última verificação quando relevante.

Pode ser seção do mesmo arquivo ou overview de um conjunto, conforme `template-engineer` decidir.

### L2 — Detail

Conteúdo completo:

- evidência bruta;
- procedimento detalhado;
- histórico necessário;
- logs/resultados;
- fontes extensas;
- notas técnicas completas.

Carregue L2 somente quando puder alterar a decisão ou sustentar uma afirmação decisiva.

## 4. Freshness

Resumo desatualizado é pior que ausência de resumo.

Quando L2 muda de forma material:

1. verifique se L0/L1 ainda representam o conteúdo;
2. atualize resumo/overview se necessário;
3. preserve `last_verified`, versão, escopo ou outra metadata temporal quando isso muda validade;
4. se o resumo pode estar defasado e não puder ser regenerado agora, marque a defasagem explicitamente.

Não use timestamp como prova automática de verdade; use-o para decidir se precisa revalidar.

## 5. Unidade canônica

Uma unidade canônica deve:

- possuir identidade estável;
- representar um conceito/estado/procedimento recuperável por si só;
- ter resumo curto suficiente para retrieval;
- expor aliases úteis;
- apontar para relações/proveniência quando materiais;
- separar estado atual de histórico quando isso melhora entendimento.

A forma exata é escolhida por `template-engineer`.

## 6. Deduplicação

Quando encontrar sobreposição:

1. identifique a nota canônica;
2. inventarie afirmações exclusivas;
3. resolva contradições por escopo/versão/evidência;
4. mescle conteúdo válido;
5. preserve aliases/backlinks;
6. archive a duplicata depois de verificar que nenhum link útil foi perdido.

Nunca copie o mesmo fato para múltiplas notas apenas para "facilitar" busca; melhore o índice/aliases/links.

## 7. Compactação semântica

Uma boa compactação:

- preserva fatos que mudam decisões;
- preserva exceções/condições;
- mantém links para detalhe/evidência;
- gera L0/L1 melhor;
- remove narrativa repetitiva;
- não apaga provenance.

Se o arquivo está grande porque contém conceitos independentes, use `SPLIT`, não um resumo destrutivo.

## 8. Contradições

Quando nova evidência contradiz memória antiga:

1. recupere ambas;
2. compare escopo, versão, data, origem e força da evidência;
3. determine se são realmente incompatíveis ou válidas em contextos diferentes;
4. atualize a regra canônica;
5. preserve histórico útil para explicar a mudança;
6. sinalize qualquer incerteza residual.

Nunca sobrescreva silenciosamente uma regra anterior sem entender a causa da divergência.

## 9. Relações

Quando o valor do novo conhecimento está na ligação com outro conhecimento, delegue a relação para `knowledge-linker`.

Não crie backlinks decorativos. Links existem para:

- retrieval;
- dependência;
- evidência;
- validação;
- navegação causal/estrutural;
- descoberta de lacunas.

## 10. Aprendizado e skills

Nem todo aprendizado deve alterar uma skill.

### Caso específico
Persistir como memória/caso.

### Padrão potencial, mas ainda fraco
Persistir como lesson/procedure candidate.

### Procedimento reutilizável com evidência suficiente
Encaminhar para `skill-improver`.

**Nunca edite uma skill canônica diretamente a partir do memory-manager.**

O `skill-improver` decide se existe evidência suficiente, busca a skill atual, propõe alteração isolada, verifica diff e só promove após review apropriado.

## 11. Auto-organização

A taxonomia pode evoluir quando isso produz ganho observável em:

- precisão de retrieval;
- redução de duplicidade;
- navegação por relações;
- velocidade de recuperação;
- clareza entre estado atual e histórico.

Não reorganize por estética ou porque um novo assunto apareceu uma vez.

## 12. Atualização do índice

`MEMORY_INDEX.md` contém somente rotas de alto valor.

Atualize-o quando:

- surgiu uma nota canônica muito reutilizada;
- uma área foi reorganizada;
- um alias de alto valor precisa apontar para nova localização;
- um overview passou a ser o melhor ponto de entrada.

Não liste cada arquivo do repositório.

## 13. Gate de qualidade

Antes de concluir uma atualização de memória:

- [ ] usei `knowledge-retrieval` antes de escrever;
- [ ] identifiquei se já existia unidade canônica;
- [ ] escolhi deliberadamente a operação de memória;
- [ ] evitei duplicação;
- [ ] preservei provenance;
- [ ] L0/L1 continuam coerentes com L2 quando existem;
- [ ] freshness/versão foram considerados quando relevantes;
- [ ] relações úteis foram mantidas;
- [ ] ruído transitório não foi promovido;
- [ ] procedimento candidato foi encaminhado ao `skill-improver` em vez de autoeditar skill;
- [ ] a próxima recuperação ficou mais rápida ou mais precisa.
