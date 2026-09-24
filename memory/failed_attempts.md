# Failed Attempts — FORMATAÇÃO CORRETA

## FA-20260923-01 — Re-registrar Client.CBS/Search em desktop ativo
**Problema:** ScreenClippingHost 0xc000027b / SearchApp 0xc000027b.  
**Ação realizada:** diversas tentativas de `Add-AppxPackage -Register` / reset do Client.CBS e Search, além de reinstalar ScreenSketch e reiniciar Explorer.  
**Resultado observado:** AppX 401/404/419 `0x80073D02` (pacote em uso), posteriores `0x8007042B`. Original ScreenClippingHost continua gerando Event 1000 no boot 23/09.  
**Por que não resolveu:** app Windows Shell está em execução; operação conflita com seus recursos, e reinstalação do aplicativo separado não substitui o componente Client.CBS. O `0x8007042B` não foi reduzido a causa única.  
**Aprendizado:** **não repetir** re-registros em sessão ativa nem alterar ACLs do pacote por tentativa. Verificar procedimento suportado e teste funcional posterior; usar instalação limpa controlada se corrupção do sistema persistir.  
**Relacionado a:** `research/findings.md`; docs Microsoft MSIX.

## FA-20260923-02 — Tratar reset elétrico do EC como resolução do Event 37
**Problema:** CPU firmware Event 37.  
**Ação realizada:** bateria desconectada, descarga e ajustes/reset BIOS/EC já feitos anteriormente.  
**Resultado observado:** evento voltou em 23/09/2026 16:40:12, `PccChanges=1`, após 71 segundos.  
**Por que não resolveu:** a causa da política de limitação da plataforma não foi identificada; não é falha tratável por repetir descarga elétrica.  
**Aprendizado:** evitar novos F9/flash/limpezas de EC sem nova evidência; correlacionar política de power capping e teste funcional CPU/hardware.  
**Relacionado a:** `research/findings.md`.

## FA-20260923-03 — Considerar o storage estável apenas pela ausência de WHEA
**Problema:** WHEA históricos em storahci.  
**Ação realizada:** RST 15.9 demonstrou estabilidade observada; depois 17.8 tornou-se driver carregado.  
**Resultado observado:** novo `iaStorAC 129` em 23/09/2026, sem novo WHEA citado nessa consulta.  
**Aprendizado:** ausência de WHEA não exclui timeout/reset do armazenamento; validar ID 129, Disk, WHEA, SMART e resposta funcional após troca controlada do driver.
