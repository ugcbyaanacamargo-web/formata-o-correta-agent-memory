---
name: adaptive-orchestrator
description: Seleciona dinamicamente skills e ferramentas reais do ChatGPT Web.
version: 1.1.0
related_skills:
  - knowledge-retrieval
  - planner
  - deep-investigator
  - phase-executor
  - memory-manager
  - verifier
  - skill-improver
---

# Adaptive Skill Orchestrator

Coordene capacidades sem transformar o problema em um pipeline rígido. O agente é o **ChatGPT Web**; GitHub é memória/biblioteca/base canônica. Descubra ferramentas reais antes de planejar qualquer uso delas.

## Regra de ativação

Use no início de toda tarefa complexa e sempre que:

- o estado muda materialmente;
- uma ferramenta falha;
- uma nova capability se torna necessária;
- o plano começa a derivar;
- uma fase precisa ser redefinida;
- surge aprendizado potencialmente reutilizável.

## 1. Self-model operacional

Antes de agir, mantenha um snapshot curto e atualizado:

```yaml
objective: "resultado que o usuário quer"
current_state: "onde estamos"
acceptance: "o que prova conclusão"
known_evidence: []
open_decisions: []
available_tools: []
active_skills: []
relevant_memory_loaded: []
constraints: []
next_best_action: "..."
```

Esse snapshot é interno e mutável. Não precisa virar arquivo permanente.

## 2. Descubra capabilities reais

Não assuma que existe:

- vector DB;
- Hermes/OpenViking/LangGraph runtime;
- subagente local;
- shell local;
- execução em background;
- acesso a um plugin não conectado;
- permissão de escrita GitHub;
- semantic search.

Descubra o que o ChatGPT Web realmente expõe na sessão:

- GitHub search/fetch/write/branch/diff;
- Web/pesquisa profunda;
- plugins/conectores instalados;
- ferramentas de arquivo;
- outras capabilities disponíveis.

Se uma capability não existe, escolha fallback realista.

## 3. Retrieval antes de trabalho repetido

Se o repositório pode conter contexto que altere a tarefa, use `knowledge-retrieval` **antes** de:

- repetir pesquisa;
- reconstruir plano já existente;
- criar memória;
- criar/alterar skill;
- interpretar resultado ligado a trabalho anterior.

Não use retrieval por ritual quando toda a informação necessária já está na conversa atual.

## 4. Seleção dinâmica de skills

Escolha apenas as skills que mudam o próximo passo.

### `knowledge-retrieval`
Use para recuperar contexto anterior mínimo relevante.

### `planner`
Use quando o objetivo precisa de decomposição, dependências ou reestruturação.

### `deep-investigator`
Use quando uma decisão depende de fatos externos/atuais ou múltiplas fontes.

### `phase-executor`
Use quando a tarefa requer que o usuário execute um script/ação no próprio ambiente e retorne resultado.

### `memory-manager`
Use quando novo conhecimento merece persistência/organização.

### `template-engineer`
Use quando schema/representação impede retrieval, atualização ou auditabilidade.

### `knowledge-linker`
Use quando novas relações entre entidades alteram navegação/decisão.

### `verifier`
Use antes de afirmar sucesso ou avançar uma fase decisiva.

### `skill-improver`
Use somente quando:
- o usuário pede explicitamente aprendizado/melhoria; ou
- existe aprendizado reutilizável **já validado**.

Não route `skill-improver` para uma simples ocorrência local.

## 5. Prioridade

1. instrução explícita do usuário;
2. segurança/restrições reais;
3. objetivo/critério de sucesso;
4. contexto canônico recuperado;
5. skill de processo relevante;
6. skill especializada;
7. ferramenta disponível.

Ferramenta não define estratégia. A estratégia escolhe a ferramenta.

## 6. Foco no resultado

Em cada fronteira de decisão, escolha a ação de maior valor esperado:

- resolver diretamente se evidência já basta;
- recuperar memória se trabalho anterior pode mudar a decisão;
- pesquisar se falta conhecimento externo;
- coletar localmente apenas se falta evidência que só o ambiente do usuário fornece;
- replanejar quando o nível de abstração está errado;
- verificar quando a solução já foi aplicada;
- consolidar memória somente depois que há aprendizado útil.

Não colete dados apenas porque "pode ser útil".

## 7. Anti-deriva

Sinais de perda de foco:

- pesquisas novas não mudam nenhuma decisão;
- contexto cresce sem aumentar clareza;
- vários scripts produzem a mesma classe de resultado;
- a resposta virou relatório em vez de ação;
- surgem vários arquivos sobre o mesmo conceito;
- o agente começa a resolver sintomas individualmente quando a evidência aponta uma causa/estrutura comum;
- tenta usar capability inexistente;
- reabre perguntas já resolvidas pela memória canônica.

Quando detectar deriva:

1. recupere objetivo e acceptance criteria;
2. descarte contexto sem valor decisório;
3. reavalie skills ativas;
4. suba/desça o nível de abstração conforme evidência;
5. escolha o menor próximo passo que realmente move o estado.

## 8. Budget adaptativo de execução

Para fases que dependem de scripts executados pelo usuário:

- **2–3 scripts é o orçamento padrão de eficiência**, não teto universal;
- prefira coleta ampla → solução completa → verificação, quando aplicável;
- se a terceira execução ainda não converge, replaneje antes de continuar;
- uma execução adicional só é justificável se a evidência mostra claramente que é o caminho mais curto e diferente das tentativas anteriores;
- registre a justificativa da exceção.

Não crie loops de tentativa por pequenas variações.

## 9. Re-routing

Mudança de skill durante a tarefa é comportamento normal.

Exemplo abstrato:

```text
retrieval
  ↓
planner
  ↓
research
  ↓
execução
  ↓
resultado muda o modelo
  ↓
retrieval novamente
  ↓
planner redefine a fase
```

Isso é exemplo, não sequência obrigatória.

## 10. Aprendizado pós-resultado

Depois de resultado validado:

1. determine se existe aprendizado durável;
2. use `memory-manager` para conhecimento/caso;
3. use `skill-improver` somente para procedimento generalizável;
4. não promova autoaperfeiçoamento direto à branch canônica;
5. preserve provenance.

## 11. Comunicação

O usuário não precisa receber narrativa da orquestração.

Por padrão, mostre somente:

- decisão relevante;
- resultado;
- comando/ação atual, quando houver;
- próxima fase ou conclusão.

Explique arquitetura/raciocínio operacional em detalhe apenas quando o usuário pedir ou quando for necessário para consentimento/segurança.

## Verification

Antes de uma ação substancial, confirme:

- [ ] objetivo/acceptance estão claros;
- [ ] as tools usadas realmente existem;
- [ ] prior context foi recuperado se podia alterar a decisão;
- [ ] somente skills necessárias foram ativadas;
- [ ] próxima ação reduz incerteza ou aproxima diretamente da solução;
- [ ] não estou simulando runtime externo inexistente;
- [ ] não estou entrando em loop de pesquisa/execução.
