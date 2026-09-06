---
name: planner
description: Planeja objetivos complexos em fases resolvíveis, com pesquisa prévia, dependências explícitas, orçamento de execução limitado e critérios de conclusão verificáveis. Use antes de qualquer trabalho multi-etapa ou quando uma fase precisar ser redesenhada.
---

# Resolution-First Planner

> Adaptação preservando os mecanismos centrais de `obra/superpowers:writing-plans`, `addyosmani/agent-skills:planning-and-task-breakdown` e `OthmanAdi/planning-with-files`.

## Princípio central

O plano existe para **encurtar o caminho até o resultado**, não para produzir mais investigação.

Cada fase deve representar um resultado útil que possa ser concluído e comprovado. Não decomponha o trabalho em dezenas de microdiagnósticos quando uma ação em nível mais alto pode resolver com segurança uma classe inteira de causas.

## Antes de planejar

1. Carregue apenas o contexto e a memória relevantes.
2. Descubra as skills e ferramentas disponíveis.
3. Use a skill de pesquisa profunda para entender:
   - o comportamento/estado esperado;
   - quais dependências realmente importam;
   - quais informações são decisivas para escolher a solução;
   - quais abordagens são sustentadas por fontes primárias;
   - quais ações possuem efeitos colaterais, pré-requisitos ou necessidade de reversão.
4. Só então desenhe as fases.

Não use uma lista genérica de “coisas para verificar”. O plano deve nascer do conhecimento obtido.

## Como formar as fases

Uma fase deve:

- ter um objetivo observável;
- possuir fronteira clara com as outras fases;
- agrupar causas e ações pelo nível de abstração correto;
- terminar em um estado verificável;
- evitar trabalho que não alterará a decisão seguinte.

Prefira fases **verticais e resolutivas**. Se vários sintomas apontam para uma mesma camada, fronteira ou configuração estrutural, planeje a resolução dessa camada em vez de criar uma fase por sintoma.

## Contrato de execução por fase

Cada fase recebe um orçamento de **no máximo 2 a 3 scripts executados pelo usuário**.

O fluxo normal é:

1. **Pesquisa para especificar a coleta**  
   Determine antecipadamente tudo que precisa ser coletado para tomar a decisão de solução. A coleta deve ser ampla o suficiente para evitar comandos pingados e retornos incompletos.

2. **Script de coleta — normalmente 1**  
   Gere um script autocontido que obtenha, em uma única execução, todas as evidências decisórias daquela fase que não podem ser obtidas pela Web, pela memória ou pelas ferramentas já conectadas.

3. **Pesquisa de solução com o resultado real**  
   Depois que o resultado retornar, compare-o com fontes primárias, documentação atual, memória relevante e relações já conhecidas. Essa pesquisa deve produzir uma solução escolhida, não uma lista vaga de possibilidades.

4. **Script de solução — normalmente 1**  
   Gere um script completo que execute a correção/transformação necessária para concluir a fase, incluindo pré-requisitos e verificações locais necessárias.

5. **Terceiro script — somente quando necessário**  
   Reservado para validação independente, recuperação/rollback, ou uma correção final claramente derivada da evidência. Não transforme o terceiro script em início de uma sequência infinita.

### Limite rígido

Se a fase não puder ser concluída dentro de 2–3 scripts:

- não acrescente Script 4, 5, 6 por inércia;
- revise se a fase foi formulada no nível errado;
- suba o nível de abstração quando a evidência mostrar um problema estrutural;
- replaneje a fase com base no que já foi aprendido;
- preserve os resultados úteis e descarte o caminho ineficiente.

Esse limite existe para impedir “caça à agulha no palheiro”.

## Estrutura lógica obrigatória de uma fase

O formato Markdown pode variar e deve ser escolhido pela skill de template, mas cada fase precisa carregar semanticamente:

- objetivo;
- resultado final esperado;
- dependências;
- pesquisa que sustenta a estratégia;
- lacunas de informação realmente decisivas;
- especificação do script de coleta, se necessário;
- regra de decisão após a coleta;
- estratégia de solução;
- critério de sucesso;
- orçamento de scripts usado/restante;
- arquivos de memória que precisam ser consultados ou atualizados;
- condição de replanejamento.

Não crie campos decorativos que não serão usados pela execução.

## Planejamento adaptativo

O plano é persistente, mas não imutável.

Após cada retorno importante:

1. atualize o estado da fase;
2. incorpore o novo conhecimento;
3. remova passos invalidados;
4. preserve decisões e evidências ainda válidas;
5. redesenhe somente o que a nova evidência realmente mudou.

Nunca recomece do zero se a memória já contém trabalho válido.

## Eficiência da coleta

Antes de autorizar um script de coleta, responda:

- Essa informação muda qual solução será escolhida?
- Já existe na memória, em uma fonte confiável ou em uma ferramenta conectada?
- Podemos coletar todas as variáveis relacionadas no mesmo script?
- Existe uma verificação de nível mais alto que elimina várias hipóteses de uma vez?

Se não muda decisão, não colete.

## Gate do plano

Antes de iniciar a execução, revise o plano contra:

- cobertura do objetivo;
- dependências;
- ordem das fases;
- ausência de placeholders;
- orçamento de scripts por fase;
- critérios verificáveis;
- existência de pesquisa suficiente para justificar a primeira coleta;
- ausência de microtarefas que não contribuem para solução.

A fase só entra em execução quando o plano consegue explicar **por que a coleta proposta é suficiente para decidir a solução seguinte**.
