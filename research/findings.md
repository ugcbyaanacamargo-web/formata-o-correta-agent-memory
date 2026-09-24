# Achados verificáveis — FORMATAÇÃO CORRETA

## FND-20260923-01 — Histórico e experimento de armazenamento
- Instalação atual: `Win32_OperatingSystem.InstallDate = 22/08/2026 01:08:50`.
- Três WHEA históricos do fim de agosto continham `CPER/STORPORT/storahci/WD Green 2.5 1000GB`. Isto localiza o subsistema reportador; **não identifica sozinho o componente físico culpado**.
- Experimento posterior: pacote Intel RST `15.9.1.1018`, INF `iaahcic.inf`, serviço `iaStorA`, Hardware ID `PCI\VEN_8086&DEV_9D03&CC_0106`, controlador efetivamente carregado após reboot. Janela relatada de >5 dias sem WHEA novo.
- Consulta **ao vivo de 23/09/2026 22:23–22:26 -03**: IDE/SATA Intel `DEV_9D03` com `oem54.inf / iaStorAC 17.8.1.1066` ativo (Boot). `iaStorA.sys 15.9.1.1018` continua no disco, mas serviço parado/manual; `storahci` parado/manual. Driver `oem51.inf / iaahcic.inf 15.9.1.1018` e `oem53.inf / iastorac.inf 15.9.1.1018` permanecem no Driver Store.
- **Novo evento** `iaStorAC 129` em **23/09/2026 21:46:19.910 -03**, `\Device\RaidPort0` reset. Um único 129 deste provedor nos últimos 30 dias consultados. Serviço AppXSvc: SCM 7000/7009 às 21:46:20 (timeout 30000 ms). A coincidência de tempo **não demonstra causalidade**.
- Referência Microsoft: evento 129 resulta de timeout de pedido de armazenamento e reset pelo Storport. Driver efetivo e evento de reset são indicadores mais relevantes que simples nome/versão no Device Manager.
- Decisão: **não executar troca de driver de BOOT durante manutenção DISM ativa**. Preparar rollback controlado para `15.9.1.1018` com mídia de recuperação/backup verificáveis e reinício planejado; validar ausência de 129/WHEA após a troca. Página Lenovo DS121515 lista 320-15IKB Type 80XL/80YE, **não cita 80YH**: neste 80YH a sustentação adicional é Hardware ID/INF e teste real, não homologação expressa desse Type.

## FND-20260923-02 — Shell/AppX ainda falha
- Desde boot de 23/09/2026 16:38:55, log Application registrou **12 crashes ScreenClippingHost.exe** (ScreenClipping.dll, 0xc000027b), **2 crashes SearchApp.exe** (twinapi.appcore.dll, 0xc000027b), mais 1 evento 1000 não categorizado pelo filtro. Contagem da consulta válida até ~22:25; não total histórico.
- Client.CBS `1000.19062.1000.0` re-registro tentou, gerou AppX 401/404/419 `0x80073D02` (pacote em uso), mais 404 `0x8007042B`. Search `1.14.18.19041` também deu 0x80073D02. **Não repetir re-registro à força em sessão ativa**.
- No dump analisado previamente no computador, SearchApp `0xc000027b` revelou stowed exception `0x80270301` e bucket `STOWED_EXCEPTION_80270301_vccorlib140_app.DLL!Unknown`. Símbolos incompletos/erros SOS; isso **não identifica por si só a causa-raiz**.
- AppModel Microsoft PC Manager já emitia reparos nos primeiros minutos de agosto; recorrências observadas em 23/09. Erros atuais de Client.CBS/ScreenClipping não estão comprovados como presentes no T0 de agosto.
- DISM /Online /Cleanup-Image /ScanHealth estava em execução desde **23/09 22:21:45** na última consulta; não interromper, reiniciar nem instalar drivers concorrentes enquanto ativo.

## FND-20260923-03 — Plataforma/SSD
- Event 37 reapareceu no boot atual em **23/09/2026 16:40:12.671**, CPU lógica 3, duração 71 s, `PpcChanges=0,TpcChanges=0,PccChanges=1`. Histórico após reset de EC e BIOS; não prometer correção por formatação do Windows.
- WHEA históricos (último 26/08), ACPI/EC históricos, nenhum novo desses na consulta ao boot atual.
- WD Green 1 TB, firmware `42077100` Healthy; Dashboard curto/extenso PASS e resposta `O firmware está atualizado` compartilhados pelo usuário. Teste SMART **não prova ausência absoluta de falha intermitente**.
- BIOS/EC `4WCN47WW/1.47`, Secure Boot 2023 ativo, Intel PTT pronto: não reflashear/resetar/voltar Factory Keys por ritual. BIOS 80YH não expõe `Lenovo_BiosSetting` por WMI.
- Sistema Windows 10 Home Single Language 22H2 em UEFI/GPT; apenas disco 0 WD Green foi listado ao vivo. **Nenhum pendrive ou backup fora do SSD apareceu em Get-Disk/Get-Volume nessa consulta**. Logo: não sanitizar ou tocar no boot agora.

## FND-20260923-04 — Demais erros do boot
- Application PerfNet 2004: 2 eventos desde boot atual; Perflib 1008 de múltiplos fornecedores também visto na auditoria remota anterior, ainda exige correlação após servicing.
- SCM 7034 `Energy Server Service queencreek` às 20:19; consulta posterior após remoção na outra sessão encontrou zero eventos novos. Confirmar em novo boot.
- BTHUSB 34 no boot: limita suporte a modo periférico Bluetooth LE; não equivaler automaticamente a falha geral de Wi-Fi.
- DCOM 10016: seis no boot, requer checar CLSID/APPID e impacto antes de qualquer ACL. Não alterar permissões DCOM aleatoriamente.

## Gate antes de qualquer apagamento
1. Terminar ScanHealth/DISM em curso e ler saída completa.
2. Fechar corrente storage 129 com ação controlada/recuperação válida, não confundir ausência de WHEA com estabilidade absoluta.
3. Conferir Backup de dados fora do SSD e kit Windows/drivers offline + checksums + boot USB realmente testado.
4. Preservar Secure Boot CA 2023, evitar restauração factory keys mais antigas.
5. T0 offline antes drivers extras; T1 após drivers; T2 após internet/ESU/Store. Guardar relatórios antes/depois e interromper se gate falhar.

## FND-20260923-05 — Preparação material efetuada
- `DISM /Online /Cleanup-Image /CheckHealth` após ScanHealth: sem corrupção, exit code 0, build da imagem 19045.7725. Isto não prova saúde de AppX nem de disco.
- `pnputil /export-driver oem51.inf`, `oem53.inf`, `oem54.inf`: três operações reportaram sucesso, 16 arquivos exportados, manifesto SHA256 salvo na Área de Trabalho. Nenhuma alteração nos dispositivos/drivers em uso. Pasta reside no WD Green, logo deve ser copiada para meio externo previamente ao Sanitize.
