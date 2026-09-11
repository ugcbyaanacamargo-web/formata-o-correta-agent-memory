---
name: verifier
description: Exige prova fresca antes de avançar ou declarar sucesso.
version: 1.1.0
related_skills:
  - planner
  - phase-executor
  - knowledge-retrieval
---

# Evidence Gate

**Nenhuma afirmação decisiva de sucesso sem evidência recente que prove o critério correspondente.** Confiança do agente não é evidência.

## Gate de fase

1. **IDENTIFY** — recupere critério de sucesso;
2. **OBSERVE** — leia resultado real;
3. **COMPARE** — esperado vs observado;
4. **CROSS-CHECK** — quando necessário, use evidência independente/fonte primária;
5. **TRACE** — associe cada claim decisivo à evidência que o prova;
6. **DECIDE** — PASS / FAIL / BLOCKED;
7. **RECORD** — atualize estado/memória;
8. **ADVANCE** somente depois do gate.

## Claim → Evidence Trace

Mantenha internamente algo equivalente a:

```yaml
claims:
  - claim: "resultado X foi atingido"
    evidence:
      - ref: "run-or-source"
        observed: "fato concreto"
    verdict: proven
```

Uma claim sem evidência suficiente não pode aparecer como conclusão factual.

## Retry adaptativo

O objetivo é convergir, não cumprir ritual numérico.

Após falha:

- se existe correção claramente determinada e ainda há valor incremental, execute;
- se a estratégia/fase está errada, replaneje;
- se o orçamento padrão de 2–3 scripts foi consumido, **replaneje por padrão**;
- permita execução adicional somente se houver evidência de que ela é materialmente diferente e o caminho mais curto;
- registre a justificativa da exceção.

Não há loop ilimitado nem teto universal cego.

## Convergence Check

Depois de falha, confirme:

- surgiu informação nova?
- próxima ação é diferente das anteriores?
- existe evidência de que ela pode resolver?
- continuar é mais eficiente que replanejar?

Se não, interrompa a sequência e replaneje.

## Independência da prova

Sempre que possível, não aceite apenas "o script disse sucesso".

Prefira:
- estado observado após mudança;
- comando/verificação independente;
- resultado funcional;
- invariantes;
- comparação before/after;
- fonte primária que define o estado esperado.

## Gate global

Conclua somente quando:

- fases necessárias estão comprovadas;
- dependências abertas não invalidam o resultado;
- estado final satisfaz objetivo do usuário;
- claim→evidence trace cobre as conclusões importantes;
- prova é recente para o escopo atual;
- memória útil foi consolidada sem inventar novos fatos.

## Comunicação

Por padrão mostre:
- resultado;
- prova principal;
- próxima ação ou conclusão;
- bloqueio objetivo, se houver.

Evite relatório longo quando não ajuda a decisão.

## Verification

- [ ] critérios foram recuperados antes de julgar;
- [ ] claims decisivas têm evidência;
- [ ] evidência é recente/adequada ao escopo;
- [ ] falha não gerou retry automático sem valor incremental;
- [ ] nenhuma capability inexistente foi usada como prova;
- [ ] PASS significa objetivo realmente demonstrado, não apenas ausência de erro.
