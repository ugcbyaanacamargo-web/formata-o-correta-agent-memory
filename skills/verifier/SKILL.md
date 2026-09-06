---
name: verifier
description: Aplica gates de evidência antes de avançar fases ou declarar conclusão, com avaliação estruturada e retries limitados para evitar loops infinitos. Use após qualquer script de solução, antes de mudar de fase e antes da conclusão global.
---

# Bounded Evidence Gate

> Adaptação de `obra/superpowers:verification-before-completion`, `github/awesome-copilot:agentic-eval` e padrões de dúvida/avaliação do `addyosmani/agent-skills`.

## Lei principal

**Nenhuma afirmação de sucesso sem evidência nova que prove o critério definido no plano.**

Confiança do agente não é evidência.

## Gate de fase

Antes de marcar uma fase como concluída:

1. **IDENTIFY** — recupere o critério de sucesso da fase;
2. **OBSERVE** — leia o resultado completo da execução/validação;
3. **COMPARE** — compare observado vs esperado;
4. **CROSS-CHECK** — quando necessário, compare com fonte primária ou uma segunda evidência independente;
5. **DECIDE** — PASS ou FAIL com justificativa estruturada;
6. **RECORD** — atualize o estado da fase e a memória relevante;
7. **ONLY THEN** — avance para a próxima fase.

## Avaliação estruturada

Use uma saída interna parseável, por exemplo:

```json
{
  "phase": "id",
  "success_criteria": [],
  "observed": [],
  "passed": true,
  "unmet": [],
  "evidence_refs": [],
  "next_action": "advance"
}
```

O schema pode ser adaptado pela skill de template, mas a decisão precisa ser mecanicamente verificável.

## Iteração limitada

O evaluator não pode criar loop infinito.

### Depois do script de solução

- PASS → conclua a fase.
- FAIL e existe uma correção final claramente determinada → use o terceiro script permitido.
- FAIL porque a estratégia ou fronteira da fase está errada → devolva ao planner para replanejamento em nível adequado.
- FAIL com orçamento de 3 scripts já consumido → **não execute um quarto script**; replaneje.

O objetivo do retry é convergir, não acumular tentativas.

## Convergence Check

Depois de cada falha, pergunte:

- a nova execução produziu informação nova?
- a próxima ação é substancialmente diferente?
- existe evidência de que ela resolverá a causa da falha?
- ainda estamos dentro do orçamento da fase?

Se a resposta for não, interrompa o ciclo e replaneje.

## Independência da verificação

Sempre que viável, a prova final deve usar um sinal que não seja apenas “o script declarou sucesso”.

Prefira:

- estado observado depois da mudança;
- comando/verificação independente;
- comparação com fonte primária;
- resultado funcional;
- invariantes do sistema;
- diferença antes/depois.

## Gate global

O plano só está concluído quando:

- todas as fases necessárias estão PASS;
- não existem dependências abertas que invalidem a conclusão;
- o estado final atende ao objetivo do usuário;
- a memória foi consolidada para permitir retomada futura;
- a prova final é recente.

## Comunicação ao usuário

Não entregue um relatório longo por padrão.

Após cada execução, responda de forma operacional:

- resultado da fase;
- prova principal;
- próximo comando/script quando houver;
- bloqueio real, se existir.

Evite despejar hipóteses e contexto que não mudam a próxima ação.
