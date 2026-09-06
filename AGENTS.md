# Agent Operating Contract

Este arquivo define como o agente deve trabalhar neste repositório.

## Regra central

A tarefa não termina quando existe uma resposta plausível. Ela termina quando existe um resultado verificável ou um bloqueio externo objetivo.

## Ciclo obrigatório para tarefas complexas

1. Ler `MEMORY_INDEX.md`.
2. Carregar apenas a memória relevante para o problema atual.
3. Ler `memory/active_context.md` e `tasks/plan.md`.
4. Atualizar o plano antes de agir quando a tarefa tiver múltiplas etapas.
5. Identificar o que ainda precisa ser descoberto.
6. Pesquisar em múltiplas fontes quando a resposta depender de informação externa.
7. Cruzar novas informações com o modelo já registrado em `memory/system_model.md`.
8. Executar a próxima ação que mais reduz a incerteza ou aproxima da solução.
9. Validar o resultado com evidência concreta.
10. Se falhar, registrar o que foi aprendido e continuar o ciclo.
11. Se funcionar, fazer uma verificação final antes de concluir.
12. Consolidar aprendizados duráveis na memória.

## Comportamento esperado

- Ter iniciativa para resolver.
- Não repetir investigação já concluída sem motivo.
- Não tratar memória antiga como verdade se novas evidências a contradisserem.
- Não parar na primeira hipótese.
- Não fazer uma única busca quando o problema exigir investigação profunda.
- Seguir novas pistas relevantes descobertas durante a pesquisa.
- Preferir fontes primárias/oficiais para fatos técnicos.
- Separar dados temporários de conhecimento durável.
- Registrar falhas úteis para não repetir tentativas improdutivas.
- Atualizar relações entre componentes quando uma descoberta muda o entendimento do sistema.
- Verificar antes de declarar sucesso.

## Escrita de memória

Não despejar transcrições. Transformar informação em conhecimento reutilizável.

Cada nova memória deve responder, quando aplicável:
- O que aprendemos?
- Por que isso importa?
- A que componentes/arquivos/decisões isso se relaciona?
- Qual fonte ou teste sustenta isso?
- Em que situações futuras isso deve ser recuperado?

## Segurança

Nunca gravar no repositório:
- senhas;
- tokens;
- cookies;
- chaves privadas;
- códigos de recuperação;
- dados pessoais desnecessários;
- segredos de API.

Se o repositório for público, tratar TODO o conteúdo como público.
