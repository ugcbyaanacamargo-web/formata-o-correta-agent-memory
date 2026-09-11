---
name: phase-executor
description: Gera scripts completos e rastreáveis para fases orientadas a resultado.
version: 1.1.0
related_skills:
  - planner
  - deep-investigator
  - verifier
  - knowledge-retrieval
---

# Evidence-to-Solution Phase Executor

Converta uma fase suficientemente pesquisada em scripts autocontidos, rastreáveis e focados em resolver. O objetivo é reduzir interações manuais, não multiplicar diagnósticos.

## Pré-condições

Não gere script até que:

- a fase esteja definida;
- objetivo e critério de sucesso estejam claros;
- `knowledge-retrieval` tenha recuperado contexto anterior relevante, quando houver;
- a pesquisa necessária esteja concluída;
- exista Collection Specification ou Resolution Specification suficiente.

## Orçamento padrão

Use **2–3 scripts como orçamento padrão de eficiência**:

1. coleta ampla, se necessária;
2. solução completa;
3. verificação/recuperação, quando necessária.

Se coleta não for necessária, comece pela solução.

Não trate o número 3 como lei universal. Uma execução adicional só pode ocorrer após reavaliação explícita e evidência de que:

- há progresso real;
- a próxima ação é materialmente diferente;
- ela é mais curta/segura que replanejar a fase inteira;
- a justificativa foi registrada.

## Script de coleta

Uma coleta deve ser ampla **dentro do escopo da fase**.

Ela deve:

- obter todas as evidências decisórias identificadas pela pesquisa;
- evitar múltiplos comandos manuais fragmentados;
- normalizar/estruturar resultado;
- registrar contexto de versão/estado que altera interpretação;
- evitar mudanças desnecessárias no sistema;
- produzir log legível + output estruturado;
- ser idempotente/segura quando possível;
- persistir resultado no GitHub quando o fluxo realmente dispõe desse transporte.

Não faça Script 1 para um dado e Script 2 para outro quando ambos podem ser coletados juntos com segurança.

## Script de solução

Só gere quando a Resolution Specification escolheu uma estratégia.

O script deve:

- implementar a solução inteira daquela fase;
- verificar pré-condições;
- ordenar mudanças corretamente;
- registrar estado antes/depois quando isso ajuda a prova;
- evitar "tente isto e veja";
- ser idempotente quando possível;
- criar backup/checkpoint/rollback quando o risco exige;
- abortar com erro claro em pré-condição não atendida;
- não coletar/gravar segredos desnecessários;
- incluir verificações locais que não substituem o `verifier` independente.

## Transporte e GitHub

Não assuma ambiente local específico.

Antes de prometer upload automático:

1. descubra se existe mecanismo de transporte realmente disponível;
2. se o usuário já possui clone/Git/GitHub CLI adequado e autorizado, adapte o script;
3. nunca embuta token/credencial;
4. se transporte automático não existe, escolha a forma mais simples de devolver o resultado sem fingir automação inexistente.

O ChatGPT Web pode ler/escrever o repositório via conector, mas isso não significa que um script executado no computador do usuário consiga fazer push sozinho.

## Identidade da execução

Preserve quando material:

- phase ID;
- run ID;
- versão/hash do script;
- timestamp;
- ambiente/versão relevante;
- status;
- arquivos de saída;
- referência à Collection/Resolution Specification.

O schema exato é decidido por `template-engineer`.

## Depois do retorno

1. confira integridade/identidade do resultado;
2. leia o output completo necessário;
3. use `knowledge-retrieval` para conectar o novo resultado ao conhecimento anterior;
4. entregue ao `deep-investigator` em modo Resolution se ainda falta decidir solução;
5. atualize memória somente após interpretação;
6. invoque `verifier` quando a ação de solução foi executada;
7. gere outra execução somente se existe decisão clara e valor incremental.

## Falhas de transporte

Erro de transporte/execução que não produz evidência da fase não deve ser confundido com falha lógica da solução.

Corrija o mecanismo e preserve o orçamento lógico quando nenhuma ação relevante ocorreu.

## Falha de estratégia

Se o script executou e a solução falhou:

- registre a evidência;
- verifique se houve progresso;
- use o orçamento restante quando a próxima ação é claramente determinada;
- se a estratégia começou a repetir-se, replaneje;
- exceda o orçamento padrão somente com justificativa explícita e verificável.

## UX

Por padrão, mostre ao usuário:

1. objetivo do script em uma frase;
2. **um único comando** para executar;
3. o que ele deve esperar no final;
4. depois do retorno, resultado + próxima ação.

Não despeje raciocínio interno se isso não muda a execução.

## Verification

Antes de entregar um script:

- [ ] ele deriva de Collection/Resolution Specification;
- [ ] coleta tudo que muda a decisão, sem fragmentação desnecessária;
- [ ] solução é completa para a fase;
- [ ] pré-condições/erros são tratados;
- [ ] não pressupõe transporte/credencial inexistente;
- [ ] resultado é rastreável;
- [ ] próxima decisão é clara;
- [ ] orçamento padrão/justificativa de exceção está explícito no estado da fase.
