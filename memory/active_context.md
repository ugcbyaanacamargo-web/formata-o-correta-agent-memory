# Active Context

## Objetivo atual
Executar uma **reconstrução limpa da plataforma** do Lenovo IdeaPad 320-15IKB Type 80YH, e não apenas reinstalar o Windows.

## Resultado final esperado
O primeiro Windows utilizável só deve existir depois que todas as camadas persistentes ou fisicamente remanescentes tiverem sido classificadas e tratadas como necessário: resetar/limpar, atualizar/regravar oficialmente, testar/aprovar, preservar ou substituir se defeituosas.

## Estado atual
- GitHub conectado ao ChatGPT.
- Repositório de memória ativo: `ugcbyaanacamargo-web/formata-o-correta-agent-memory`.
- Superpowers aplicado ao planejamento arquitetural.
- Design operacional reduzido de muitas fases para **5 etapas resolutivas**.
- Especificação escrita e commitada em:
  - `docs/superpowers/specs/2026-09-11-formatacao-limpa-5-etapas-design.md`
- `tasks/plan.md` atualizado para refletir as 5 etapas.
- O Script 01 ainda **não foi implementado**, respeitando o gate de revisão escrita do Superpowers.
- Modelo-base do equipamento permanece:
  - Lenovo IdeaPad 320-15IKB;
  - Type 80YH;
  - BIOS de referência usada no projeto: `4WCN47WW`;
  - EC de referência usado no projeto: `1.47`;
  - Intel Core i7-7500U;
  - 16 GB RAM;
  - Intel HD Graphics 620;
  - NVIDIA GeForce 940MX;
  - SSD WD Green 2.5" 1 TB.
- Secure Boot deve ser tratado como atualmente ligado, conforme instrução do usuário.

## Plano operacional aprovado conceitualmente
1. **Raio-X total pré-formatação** — Script 01 somente leitura → análise → Script 02 de preparação/normalização.
2. **Plataforma, firmware e segurança** — normalizar/aprovar tudo que existe antes do Windows.
3. **SSD, mídia e instalação limpa** — sanitização quando aplicável + mídia oficial + instalação offline.
4. **Primeiro boot OFFLINE** — construir baseline de drivers antes do Windows Update.
5. **Internet controlada + auditoria final** — manutenção oficial e prova final `COMO DEVERIA ESTAR × COMO FICOU`.

## Princípios de trabalho
> Se um componente continua fisicamente no notebook depois que o SSD é apagado, ele entra na análise pré-formatação.

> “Funciona” não significa “está correto”. O estado final deve ser o correto para este modelo/hardware, sustentado por documentação, identificação real e teste.

> Nenhuma camada crítica pode ficar implícita atrás de frases genéricas como “configurar a BIOS” ou “instalar os drivers”.

> Cada etapa usa no máximo 2–3 scripts. Se não convergir, replanejar; não criar Script 4.

## Próxima ação
O usuário deve revisar/confirmar a especificação escrita. Após essa confirmação:
1. invocar `superpowers:writing-plans`;
2. gerar o plano de implementação;
3. criar `execution/phase-01/01-coleta-total-pre-formatacao.ps1`;
4. revisar o script antes de fornecer o comando único de execução.

## Regra de atualização
Atualizar este arquivo sempre que mudar:
- objetivo;
- fase atual;
- bloqueio;
- próxima ação;
- decisão operacional relevante.
