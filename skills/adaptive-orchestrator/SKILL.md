---
name: adaptive-orchestrator
description: Meta-skill que descobre capacidades, seleciona dinamicamente as skills necessárias, mantém foco no objetivo e reconfigura o workflow conforme o estado muda. Use no início de toda tarefa complexa e sempre que o plano precisar mudar de estratégia.
---

# Adaptive Skill Orchestrator

> Baseado no mecanismo de obrigatoriedade/roteamento do `obra/superpowers:using-superpowers` e no `addyosmani/agent-skills:using-agent-skills`.

## Regra de ativação

Antes de qualquer ação substancial:

1. descubra as skills disponíveis no repositório e nos plugins;
2. determine quais delas realmente se aplicam ao estado atual;
3. carregue primeiro skills de processo, depois skills de domínio/execução;
4. use o menor conjunto suficiente;
5. reavalie a seleção quando o estado mudar.

Não dependa de uma sequência fixa escrita antecipadamente.

## Modelo operacional

Mantenha internamente um snapshot curto:

- objetivo atual;
- fase atual;
- resultado esperado;
- evidência já disponível;
- lacunas decisórias;
- orçamento de scripts restante;
- skills ativas;
- ferramentas/conectores disponíveis;
- riscos/limites que afetam a ação.

Esse snapshot é estado de decisão, não uma taxonomia permanente.

## Seleção de skill

Pergunte:

### A tarefa precisa ser decomposta ou reestruturada?
Ative `planner`.

### Depende de conhecimento externo atual?
Ative `deep-investigator`.

### Precisa gerar/transportar um script e receber resultado?
Ative `phase-executor`.

### Produziu conhecimento que deve sobreviver?
Ative `memory-manager` e, quando relações importarem, `knowledge-linker`.

### Precisa escolher/alterar schema Markdown?
Ative `template-engineer`.

### Está prestes a avançar fase ou declarar sucesso?
Ative `verifier`.

Outras skills instaladas podem substituir ou complementar estas quando forem mais específicas.

## Prioridade

1. instrução explícita do usuário;
2. segurança e restrições reais;
3. skill de processo que define o método;
4. skill especializada no domínio;
5. defaults do agente.

## Foco no resultado

A cada fronteira de decisão escolha a ação com maior valor esperado:

- resolver diretamente, se a evidência já é suficiente;
- pesquisar, se falta conhecimento externo;
- coletar localmente, se falta evidência que só o ambiente pode fornecer;
- replanejar, se o nível de abstração está errado;
- verificar, se a solução já foi aplicada.

Não execute coleta apenas porque “é bom ter mais dados”.

## Anti-deriva

Sinais de que o agente está perdendo foco:

- abriu novas buscas que não alteram a decisão;
- gerou mais de 3 scripts na mesma fase;
- criou vários arquivos de memória sobre o mesmo conceito;
- adicionou verificações locais para sintomas que compartilham uma causa estrutural;
- continua repetindo a mesma estratégia com pequenas variações;
- está escrevendo mais explicação do que ação.

Quando qualquer sinal aparecer:
1. pare;
2. recupere objetivo e critério da fase;
3. reavalie skills e nível de abstração;
4. escolha caminho mais curto sustentado pela evidência.

## Re-routing dinâmico

Exemplo abstrato:

```text
Planner
  ↓
Deep Research
  ↓
Phase Executor
  ↓
resultado revela mudança estrutural
  ↓
Orchestrator reavalia
  ↓
Planner redefine fase
  ↓
Deep Research focado no novo nível
```

A mudança de skill é comportamento normal. Não force o problema a caber no fluxo inicial.

## Saída

O usuário não precisa ver o roteamento interno.

Mostre apenas o que importa para a próxima ação:
- plano/decisão quando necessário;
- comando atual;
- resultado;
- próxima fase.
