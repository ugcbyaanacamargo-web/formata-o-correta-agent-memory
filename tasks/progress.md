# Progress Log — FORMATAÇÃO CORRETA

## 2026-09-17 — Fase 1, coleta consolidada
- `execution/phase-01/01-coleta-plataforma-persistente.ps1`; ZIP da fase 1 com 117/117 hashes válidos, BIOS/EC/UEFI/Secure Boot/PTT/SATA/MEI coletados.
- Secure Boot 2023 = Updated; Event 37 atual; WHEA/ACPI 13/15 históricos. BIOS `Lenovo_BiosSetting` indisponível.
- Fase 1 **parcial**, ainda não marcar PASS global até verificar configuração da BIOS sem assumir valores antigos.

## 2026-09-18 — SSD validado pelo usuário
- SanDisk Dashboard: diagnóstico S.M.A.R.T. curto e estendido aprovados, sem erros; consulta de firmware informou `42077100` atualizado. SMART/CHKDSK/health anteriores sem falha reportada.
- **Sanitize NÃO executado.** Windows/pendrive de recuperação/drivers não estavam comprovadamente preparados.

## 2026-09-23 — Investigação remota ao vivo
- Desktop Commander no computador autorizado, sessão elevada, inicialização Windows `16:38:55`.
- Novo `iaStorAC 129` às `21:46:19.910`, controlador `DEV_9D03` em `17.8.1.1066 / oem54.inf`; `15.9.1.1018 / oem51.inf` permanece instalado mas NÃO carregado. Um reset 129 em 30 dias na consulta.
- AppXSvc SCM 7000/7009 às 21:46:20; correlação temporal com 129 não é conclusão causal.
- 12 ScreenClippingHost + 2 SearchApp Event 1000 desde boot até consulta; AppX re-registros Client.CBS/Search falharam (0x80073D02 e 0x8007042B).
- Event 37 atual às 16:40:12, PccChanges=1; DISM ScanHealth ativo desde 22:21:45. NÃO interromper scan ou mexer em driver BOOT enquanto ativo.
- Fonte/limitações detalhadas em `research/findings.md` e `research/source_ledger.md`.

## Próximo ato resolutivo — não gerar novos diagnósticos dispersos
1. Aguardar término e ler resultado do ScanHealth em andamento (não lançar segundo DISM).
2. Preparar recuperação e rollback seguro do SATA atual para baseline 15.9 com hardware/INF/teste já validados; nenhum reboot/forçar driver durante servicing.
3. Somente depois do armazenamento estável, tratar Shell/AppX pela camada adequada e confirmar por teste de uso; não mais tentar Client.CBS ativo à força.
4. Montar e validar Windows+driver kit offline/backup; nenhum Sanitize antes dos gates.
