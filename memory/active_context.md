# Active Context — Lenovo 320-15IKB Type 80YH

Objetivo: reconstrução limpa **sem repetir erro de agosto** e resolução dos problemas reais atuais. Regras: 1 coleta total + 1 ação fundamentada por fase; não recomeçar manutenções já feitas; sem flash/reset por ritual; não escrever segredos em GitHub público.

## Estado mais recente, 23/09/2026 22:23–22:26 (-03), Desktop Commander
- Windows 10 Home Single Language `10.0.19045`, instalação registrada `22/08/2026 01:08:50`, boot atual `23/09 16:38:55`, terminal elevado.
- BIOS/EC `4WCN47WW/1.47`; Secure Boot CA 2023 `Updated`, TPM/PTT 2.0 pronto; configurações profundas da BIOS ainda precisam de confirmação visual.
- WD Green 1 TB SATA GPT, firmware `42077100`, health Healthy; SMART curto/estendido PASS pelo Dashboard; firmware atualizado.
- Intel SATA `DEV_9D03`, `iaStorAC 17.8.1.1066 / oem54.inf` RUNNING Boot; `iaStorA.sys 15.9.1.1018` presente/parado/manual e `iaahcic.inf 15.9.1.1018 / oem51.inf` staged. WHEA históricos eram STORPORT/storahci; janela anterior no 15.9 sem WHEA novo, **mas agora evento 129 em 23/09 21:46:19.910 em 17.8**.
- AppXSvc SCM 7000/7009 às 21:46:20 (somente coincidência temporal comprovada); ScreenClippingHost x12 e SearchApp x2 crashes desde boot até consulta; AppX Client.CBS re-registro 0x80073D02/0x8007042B. Não repetir em sessão ativa.
- Event 37 voltou no boot às 16:40:12, duração 71s, PccChanges 1; firmware/energia sem correção comprovada.
- DISM `/Online /Cleanup-Image /ScanHealth` **em curso** desde 22:21:45 em sessão já existente; não interromper, iniciar DISM paralelo, reiniciar ou trocar driver de boot agora.
- Disco externo/USB **não observado** na listagem do momento. Nenhum Sanitize executado.

## Próximo passo
Após fim do ScanHealth, executar rollback de RST SOMENTE com mecanismo de recuperação/backup validado e plano pós-boot. Preparar Windows/drivers offline, manter Secure Boot 2023. Provas e fontes: `research/findings.md`, `research/source_ledger.md`, `tasks/progress.md`; plano em `tasks/plan.md`. 

## Execução real adicional (23/09 ~22:30 -03)
- DISM ScanHealth da sessão pré-existente finalizou 22:28:05, sem pedido de reboot; CheckHealth independente retorna sem corrupção, exit 0.
- PnPUtil exportou com sucesso os 3 drivers do controlador para `Desktop/KIT_STORAGE_RST_20260923` e gerou hashes SHA256 (16 arquivos). **Localização no mesmo SSD: preservar externamente antes de apagá-lo.** Driver iaStorAC 17.8 continuou Boot/Running; não ocorreu rollback/reboot.
