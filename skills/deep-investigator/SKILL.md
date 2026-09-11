---
name: deep-investigator
description: Pesquisa para produzir decisão sustentada por fontes e evidência.
version: 1.1.0
related_skills:
  - knowledge-retrieval
  - planner
  - phase-executor
  - verifier
---

# Decision-Oriented Deep Investigator

> Adapta `ByteDance/deer-flow:deep-research`, `addyosmani/agent-skills:source-driven-development` e breadth/depth do GPT Researcher para ChatGPT Web.

## Missão

Pesquisa não é o objetivo. **Decisão é o objetivo.**

A investigação deve convergir para um destes resultados:

1. uma **Collection Specification** que define exatamente o que falta observar; ou
2. uma **Resolution Specification** que define exatamente a ação/solução escolhida e como verificar.

## 1. Retrieval before repeat research

Antes de abrir nova pesquisa externa, use `knowledge-retrieval` quando o repositório pode conter trabalho anterior relevante.

Recupere:
- fontes já consultadas;
- decisões anteriores;
- resultados de execuções;
- aliases/relações;
- tentativas já descartadas;
- versões/escopos conhecidos.

Não pesquise novamente o que a memória canônica já resolve, a menos que a informação possa ter mudado ou precise ser revalidada.

## 2. Modo A — Research for Collection

Use quando falta evidência que só o ambiente/caso real pode fornecer.

Processo:

1. recupere memória relevante;
2. pesquise comportamento esperado, dependências, versões e pré-condições;
3. determine quais observações realmente discriminam entre caminhos de solução;
4. agrupe essas observações para uma coleta ampla e eficiente;
5. elimine coleta redundante/cosmética;
6. produza a Collection Specification.

A Collection Specification deve conter semanticamente:

- fatos necessários;
- por que cada fato muda a decisão;
- origem esperada do dado;
- formato/normalização útil;
- relações a preservar;
- resultados que mudam a estratégia;
- critérios para saber que a coleta foi suficiente.

## 3. Modo B — Research for Resolution

Use depois que existe resultado real ou quando as fontes já são suficientes para decidir.

Processo:

1. leia o resultado completo;
2. use `knowledge-retrieval` para recuperar contexto ligado às entidades encontradas;
3. pesquise somente os pontos que ainda mudam a decisão;
4. compare estado observado com fontes primárias/especificações atuais;
5. resolva contradições por autoridade, versão, escopo e data;
6. escolha a solução **completa e proporcional** ao nível real do problema;
7. produza Resolution Specification pronta para execução/verificação.

Não entregue uma lista de alternativas quando a evidência permite escolher.

## 4. Breadth — cobertura

Abra ramos independentes apenas quando cada um pode alterar a decisão.

Possíveis ângulos abstratos:
- especificação/autoria oficial;
- documentação do fornecedor;
- dependências/pré-requisitos;
- implementação/código oficial;
- comportamento observado;
- validação/reversão;
- incompatibilidades de versão.

Não use número fixo de buscas como ritual.

## 5. Depth — aprofundamento

Aprofunde quando:
- fonte primária aponta para outra especificação decisiva;
- surgiu termo/componente que muda a solução;
- comportamento varia por versão;
- fontes relevantes contradizem;
- falta dado indispensável para Collection/Resolution Specification.

Pare quando o aprofundamento deixa de mudar a decisão.

## 6. Hierarquia de evidência

Prefira:

1. especificação/autor/fabricante oficial;
2. documentação oficial atual;
3. repositório/código-fonte oficial;
4. documentação técnica reconhecida;
5. teste reproduzível/material de engenharia;
6. comunidade/fóruns como pista ou confirmação secundária.

Fonte secundária não substitui primária quando a primária responde diretamente à questão.

## 7. Leitura decisiva

Não decida por snippet quando contexto importa.

Para fontes decisivas, confirme:
- versão;
- escopo;
- pré-condições;
- exceções;
- efeitos colaterais;
- procedimento correto;
- mecanismo de verificação.

## 8. Contradições

Quando duas fontes divergem:

1. determine se falam do mesmo escopo/versão;
2. compare autoridade e data;
3. procure fonte primária que resolva a divergência;
4. use evidência real do caso quando disponível;
5. registre o conflito se continuar sem resolução.

Não force consenso artificial.

## 9. Eficiência

Pergunte após cada ramo:

- descobri algo que muda a estratégia?
- a próxima busca pode mudar a Collection/Resolution Specification?
- a documentação já define o comportamento necessário?
- existe agora uma ação/verificação mais direta que nova pesquisa?

Pare quando novas fontes forem redundantes.

## 10. Integração com memória

Depois da pesquisa:
- encaminhe novas fontes/descobertas úteis ao `memory-manager`;
- preserve claim → source/evidence;
- não copie a mesma informação em múltiplos lugares;
- atualize relações apenas quando sustentadas;
- se surgir procedimento geral validado, encaminhe como candidato ao `skill-improver`, nunca edite skill diretamente.

## 11. Critério de suficiência

### Collection Specification pronta
Você sabe exatamente o que precisa ser observado para escolher a solução.

### Resolution Specification pronta
Você sabe exatamente:
- o que fazer;
- por que essa ação foi escolhida;
- pré-requisitos;
- risco/rollback quando necessário;
- efeito esperado;
- como provar sucesso.

Se nenhuma das duas está pronta, pesquise **somente a lacuna que impede a decisão**.

## 12. Anti-loop

Se a pesquisa não converge:

- verifique se o problema foi formulado no nível de abstração errado;
- reavalie a fase com `planner`;
- não acumule buscas que apenas repetem incerteza.

## Verification

Antes de entregar pesquisa como base para ação:

- [ ] contexto anterior relevante foi recuperado;
- [ ] fontes decisivas foram lidas no contexto necessário;
- [ ] contradições materiais foram resolvidas ou explicitadas;
- [ ] pesquisa parou por suficiência, não por cansaço;
- [ ] Collection/Resolution Specification não contém lacuna decisória escondida;
- [ ] não inventei capability, comando, API ou comportamento ausente das fontes/evidências.
