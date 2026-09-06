# Current Plan

## Objetivo
Transformar este repositório em memória operacional persistente para o agente do projeto FORMATAÇÃO CORRETA.

## Etapas

- [x] Criar repositório de memória.
- [x] Criar índice de memória.
- [x] Criar arquivos-base de contexto, relações, fontes, lições e falhas.
- [x] Criar skills locais para gerenciamento da memória e investigação.
- [ ] Alimentar a memória com o estado real do projeto FORMATAÇÃO CORRETA.
- [ ] Validar em uma tarefa real se o agente consulta, atualiza e reutiliza a memória corretamente.
- [ ] Ajustar a estrutura após o primeiro ciclo real.

## Critério de conclusão
O sistema só é considerado funcional quando, em uma nova tarefa, o agente:
1. recupera memória relevante;
2. usa essa memória no plano;
3. pesquisa o que falta;
4. registra nova descoberta;
5. atualiza relações;
6. valida a solução;
7. deixa o repositório pronto para a próxima sessão.
