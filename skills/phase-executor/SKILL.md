---
name: phase-executor
description: Converte uma fase pesquisada em scripts autocontidos de coleta, solução e validação, publica no GitHub, recebe resultados estruturados e respeita o orçamento máximo de 2–3 scripts por fase.
---

# Evidence-to-Solution Phase Executor

> Adaptação dos princípios de `superpowers:executing-plans`, `addyosmani:incremental-implementation` e `planning-with-files` para execução humana remota via scripts persistidos no GitHub.

## Pré-condições

Não gere script até que:

- a fase esteja definida;
- o objetivo e o critério de sucesso estejam claros;
- a pesquisa necessária para o próximo script esteja concluída;
- a skill de investigação tenha produzido uma Collection Specification ou Resolution Specification.

## Orçamento da fase

Máximo: **3 scripts executados pelo usuário**.

Fluxo preferido:

1. coleta;
2. solução;
3. validação/recuperação somente se necessário.

Se a coleta não for necessária, comece diretamente pela solução.

## Script de coleta

Um script de coleta deve ser **amplo dentro do escopo da fase**.

Ele deve:

- obter todas as informações decisórias identificadas na pesquisa;
- evitar múltiplos comandos manuais;
- normalizar o resultado;
- incluir contexto suficiente para interpretação posterior;
- registrar versões/estado relevantes quando isso muda a leitura;
- não alterar o sistema além do necessário para observar;
- produzir resultado estruturado e log legível;
- retornar os artefatos ao repositório quando o transporte estiver disponível.

Não produza “Script 1 só para descobrir uma coisa, Script 2 para descobrir outra” se ambas podem ser coletadas juntas.

## Script de solução

Só gere depois de pesquisar o resultado de coleta.

O script de solução deve:

- implementar a estratégia escolhida de forma completa;
- incluir pré-condições;
- aplicar todas as mudanças necessárias daquela fase em ordem correta;
- evitar “tente isto e veja”;
- ser idempotente quando possível;
- registrar antes/depois;
- fazer verificações locais úteis;
- abortar com erro claro em pré-condição não atendida;
- criar backup/checkpoint/rollback quando a ação for de risco relevante;
- nunca coletar ou gravar segredos desnecessários.

## Terceiro script

Use apenas para:

- validação independente;
- rollback;
- uma correção final claramente sustentada pela falha do script de solução.

Não use como nova rodada exploratória.

## Publicação no GitHub

O executor deve persistir:

- script;
- metadados da execução;
- resultado estruturado;
- log;
- referência ao plano/fase;
- hash/versão do script executado.

O local exato é decidido pelo contexto do projeto e pela skill de template. Não imponha árvore global.

### Transporte preferido

1. detectar se existe clone autenticado, Git ou GitHub CLI;
2. usar o transporte já configurado;
3. criar um comando simples para o usuário executar;
4. fazer o próprio script gravar o resultado e realizar commit/push quando autorizado e tecnicamente disponível;
5. nunca embutir token ou credencial no script.

Se o transporte automático não existir, estabeleça-o uma vez em vez de pedir ao usuário para copiar saídas enormes no chat.

## Identidade da execução

Cada execução precisa ser rastreável.

Preserve:
- ID da fase;
- ID da execução;
- versão/hash do script;
- timestamp;
- ambiente relevante;
- status;
- arquivos de saída.

O schema exato é escolhido pela skill de template.

## Resultado retornado

Quando o resultado chegar:

1. confira integridade e versão do script;
2. carregue o resultado inteiro;
3. entregue ao `deep-investigator` em modo Resolution;
4. atualize memória canônica apenas após interpretação;
5. gere o próximo script somente quando a pesquisa produziu decisão.

## Falhas

Se o script falha por erro de transporte/execução:
- corrija o executor, não consuma o orçamento lógico da fase se nenhuma ação/evidência da fase ocorreu.

Se o script executou e a estratégia falhou:
- registre como evidência;
- use o orçamento restante;
- se o limite for atingido, replaneje.

## UX para o usuário

Durante a execução, apresente preferencialmente:

1. uma frase dizendo o objetivo do script;
2. **um único comando** para executar;
3. o que esperar ao terminar.

Não despeje o raciocínio interno salvo se solicitado.
