# Formatação Correta — Agent Memory

Memória persistente, habilidades e estado operacional do agente do projeto **FORMATAÇÃO CORRETA**.

## Finalidade

Este repositório funciona como memória externa estruturada para o agente:

- retomar o contexto sem recomeçar do zero;
- manter um modelo do sistema e das relações entre componentes;
- planejar antes de executar tarefas complexas;
- pesquisar em múltiplas fontes quando faltarem dados;
- registrar descobertas, fontes e decisões;
- validar as próprias ações;
- aprender com tentativas que falharam;
- continuar a investigação até chegar a uma solução verificável.

## Fluxo

```text
PEDIDO
  ↓
carregar contexto + memória relevante
  ↓
montar/atualizar plano
  ↓
identificar lacunas de conhecimento
  ↓
pesquisar + cruzar fontes
  ↓
atualizar relações do sistema
  ↓
executar próxima ação
  ↓
validar
  ↓
falhou? registrar aprendizado → atualizar plano → continuar
  ↓
funcionou? verificar novamente → consolidar memória → concluir
```

## Estrutura

- `AGENTS.md` — contrato operacional do agente.
- `MEMORY_INDEX.md` — mapa de toda a memória persistente.
- `memory/` — conhecimento durável e contexto ativo.
- `research/` — pesquisas, fontes e relações descobertas.
- `tasks/` — plano e progresso.
- `skills/` — habilidades para usar e manter a memória.

## Inspiração

A arquitetura combina padrões públicos de:

- `github/awesome-copilot` — Memory Bank, Remember e self-review.
- `addyosmani/agent-skills` — planning, context engineering, source-driven development e debugging.
- `obra/superpowers` — planejamento, debugging sistemático e verificação antes de concluir.
- `garrytan/gstack` — investigação e execução orientada a resultado.

Os arquivos aqui são adaptações próprias para o projeto, não cópias integrais desses repositórios.
