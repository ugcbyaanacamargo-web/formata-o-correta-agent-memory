---
name: planner
description: Planeja fases resolvíveis com pesquisa, dependências e critérios.
version: 1.1.0
related_skills:
  - knowledge-retrieval
  - deep-investigator
  - phase-executor
  - verifier
---

# Resolution-First Planner

O plano existe para **encurtar o caminho até o resultado**, não para produzir mais investigação.

## Antes de planejar

1. use `knowledge-retrieval` se contexto anterior puder mudar a estratégia;
2. descubra skills/ferramentas realmente disponíveis;
3. use `deep-investigator` quando a decisão depender de fatos externos;
4. defina objetivo final e prova de conclusão;
5. só então desenhe fases.

Não use uma lista genérica de verificações. O plano nasce do conhecimento recuperado e pesquisado.

## Como formar as fases

Uma fase deve:

- produzir resultado observável;
- possuir fronteira clara;
- agrupar causas/ações no nível de abstração correto;
- terminar em estado verificável;
- evitar trabalho que não altera decisão seguinte.

Se vários sintomas apontam para a mesma camada/causa estrutural, resolva a classe de problema em vez de criar uma fase por sintoma.

## Orçamento padrão de execução

Para fases que exigem scripts executados pelo usuário, use **2–3 scripts como orçamento padrão de eficiência**, não como lei universal.

Fluxo preferido:

1. pesquisa suficiente para especificar a coleta;
2. script de coleta amplo, se necessário;
3. pesquisa de solução usando o resultado real;
4. script completo de solução;
5. verificação/recuperação adicional somente quando justificada.

### Quando exceder 3 scripts

Uma execução adicional só é permitida quando:

- as tentativas anteriores produziram progresso real;
- a próxima ação é materialmente diferente, não variação cosmética;
- existe evidência de que ela é o caminho mais curto para concluir;
- replanejar para uma abordagem estrutural não seria melhor;
- a justificativa fica registrada no estado da fase.

Se isso não for verdade, replaneje em vez de adicionar Script 4, 5, 6 por inércia.

## Estrutura lógica da fase

Cada fase precisa carregar semanticamente:

- objetivo;
- resultado final esperado;
- dependências;
- contexto/pesquisa que sustenta a estratégia;
- lacunas decisórias reais;
- especificação de coleta, se necessária;
- regra de decisão após coleta;
- estratégia de solução;
- critério de sucesso;
- orçamento de execução usado/restante;
- condição de replanejamento;
- memória/fontes relevantes.

O formato Markdown é escolhido por `template-engineer`; não adicione campos decorativos.

## Planejamento adaptativo

Após resultado importante:

1. atualize o estado;
2. incorpore novo conhecimento;
3. remova passos invalidados;
4. preserve evidência/decisões ainda válidas;
5. redesenhe somente o que mudou;
6. use retrieval novamente se o resultado criou novas entidades/relações relevantes.

Não recomece do zero quando a memória já preserva trabalho válido.

## Eficiência da coleta

Antes de autorizar coleta, pergunte:

- este dado muda a solução?
- já existe em memória/fonte/ferramenta?
- todas as variáveis decisórias podem ser coletadas juntas?
- existe verificação de nível superior que elimina várias hipóteses de uma vez?

Se não muda decisão, não colete.

## Gate do plano

Antes de executar:

- [ ] objetivo/acceptance são observáveis;
- [ ] dependências estão ordenadas;
- [ ] contexto anterior relevante foi recuperado;
- [ ] primeira ação tem justificativa baseada em evidência/pesquisa;
- [ ] coleta é suficientemente ampla;
- [ ] orçamento padrão foi definido;
- [ ] existe condição clara de replanejamento;
- [ ] não há microtarefas que só aumentam trabalho sem mudar decisão.

A fase entra em execução somente quando o plano consegue explicar **por que a próxima ação é a forma mais eficiente de chegar ao resultado**.
