# Current Plan — Engine Adaptation

## Objetivo

Preparar o GitHub do projeto FORMATAÇÃO CORRETA como uma **Hermes Profile Distribution** especializada, com estrutura de contexto compatível com OpenViking, antes de prosseguir para a formatação do equipamento.

## Fase E0 — Inspecionar o que já existe
**Status:** PASS.

- [x] Repositório e permissões verificados.
- [x] AGENTS/MEMORY_INDEX/skills/memory/research/tasks lidos.
- [x] PR da formatação identificado e mantido separado.

## Fase E1 — Escolher motores existentes
**Status:** PASS.

- [x] Hermes Agent oficial localizado e estudado.
- [x] Profile Distribution confirmado como mecanismo Git nativo.
- [x] OpenViking oficial localizado e estudado.
- [x] Integração Hermes ↔ OpenViking confirmada como first-class.
- [x] Decisão: não criar runtime/context DB próprios.

## Fase E2 — Transformar o repositório em distribuição
**Status:** PASS.

- [x] criar [distribution.yaml](../distribution.yaml);
- [x] criar [SOUL.md](../SOUL.md);
- [x] criar [ENGINE.md](../ENGINE.md);
- [x] criar [.gitignore](../.gitignore) com fronteira de segredos/runtime;
- [x] ligar [README.md](../README.md), [AGENTS.md](../AGENTS.md) e [MEMORY_INDEX.md](../MEMORY_INDEX.md);
- [x] separar `memory/` técnico de `memories/` privado;
- [x] revisar links e caminhos principais;
- [x] comparar branch contra `main`.

## Fase E3 — Validar o contrato da distribuição
**Status:** PASS para a estrutura GitHub; validação do runtime local fica separada.

Critérios:
- [x] apenas arquivos intencionais alterados;
- [x] nenhum segredo/configuração privada;
- [x] `distribution.yaml` inclui somente paths que devem viajar com o agente;
- [x] documentos canônicos têm links relativos principais válidos;
- [x] nenhuma afirmação diz que Hermes/OpenViking estão rodando quando apenas estão preparados;
- [x] provenance/source ledger sustentam a arquitetura;
- [x] branch pronta para draft PR.

## Fase E4 — Promoção
**Status:** EM REVIEW — draft PR #2 criado.

- [x] abrir draft PR do motor (#2);
- [x] review estrutural do diff;
- [x] linkar PR #1 como dependente;
- [ ] validação opcional em runtime Hermes real;
- [ ] somente depois marcar ready/merge quando autorizado.

## Fase seguinte — Reconstrução limpa

Após E4:
1. rebasear/atualizar a branch da formatação sobre a arquitetura aprovada;
2. recuperar contexto via índice/grafo;
3. executar pesquisa da Fase 1 da reconstrução limpa;
4. persistir fontes/decisões no formato canônico;
5. só então chegar às ações destrutivas no equipamento.
