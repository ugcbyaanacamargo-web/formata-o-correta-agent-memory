# Current Plan

## Objetivo
Realizar uma **reconstrução limpa da plataforma** do Lenovo IdeaPad 320-15IKB Type 80YH, eliminando estado persistente inadequado e evitando que o primeiro Windows seja construído sobre firmware, hardware, armazenamento ou drivers incorretos.

## Critério global
O Windows só será instalado depois de a plataforma cumprir os gates pré-boot. A tarefa só termina quando o estado final for comparado com a referência correta e validado por evidência recente.

## Regra de cobertura
Nenhum componente crítico pode ficar implícito. Se permanece fisicamente no notebook após apagar o SSD, ou pode reintroduzir estado durante/antes do primeiro boot, precisa estar classificado e ter um critério de decisão.

## Fase 0 — Consolidar memória e baseline
**Status:** em andamento.  
**Resultado esperado:** modelo canônico do sistema, decisões persistidas e fontes/valores ainda não verificados claramente marcados.  
**Gate:** próximo agente consegue retomar sem reler toda a conversa.

## Fase 1 — Especificar o estado correto pré-formatação
**Status:** próxima fase.

### 1A — Placa-mãe e firmware-base
Pesquisar e definir:
- SPI/BIOS/UEFI 4WCN47WW;
- efeito exato de F9/Setup Defaults;
- NVRAM/BootOrder/Boot####;
- ACPI;
- Intel ME/CSME;
- EC;
- PCH/chipset;
- CPU/microcode quando relevante;
- limites do que pode ser resetado versus apenas atualizado/regravado oficialmente.

### 1B — Segurança da plataforma
Definir:
- UEFI × Legacy Support;
- Secure Boot;
- PK;
- KEK;
- db;
- dbx;
- TPM/PTT;
- Clear Intel PTT Key;
- Reset to Setup Mode;
- Restore Factory Keys;
- estado correto antes da instalação;
- atualização posterior via Microsoft/OEM.

### 1C — Memória e vídeo
Definir:
- teste e critério de aprovação da RAM;
- SPD/timings relevantes;
- Intel HD Graphics 620;
- NVIDIA GeForce 940MX;
- VBIOS/firmware;
- PCIe/alimentação;
- quando firmware deve ser apenas preservado, atualizado oficialmente ou investigado.

### 1D — Armazenamento e cadeia SATA
Definir:
- modelo/firmware atual do WD Green;
- ferramenta oficial atual;
- SMART/teste curto/estendido;
- critério de falha/substituição;
- Secure Erase/Sanitize;
- conector/link SATA;
- controlador SATA;
- PCH;
- SATA Mode correto;
- driver correspondente (`storahci` ou Intel RST/`iaStorA`, somente após evidência).

### 1E — Rede e controladores periféricos
Identificar e definir:
- Ethernet/LAN: controlador, NVM/EEPROM/firmware, MAC/PXE/Option ROM quando aplicável;
- Wi‑Fi: módulo físico, Hardware IDs, NVM/calibração, firmware e driver;
- Bluetooth;
- áudio/codec;
- card reader;
- USB/Type-C/hubs internos;
- PCIe Root Ports;
- touchpad;
- câmera;
- demais dispositivos ACPI/onboard.

### 1F — Construção offline do Windows
Definir:
- mídia Microsoft oficial;
- edição correta;
- estratégia de partições após sanitização;
- Dynamic Update;
- drivers essenciais a integrar/instalar offline;
- bloqueio de atualização automática de drivers no primeiro boot;
- ordem controlada de conexão à internet;
- conta/e-mail novo e não restauração de backup antigo.

### Artefatos obrigatórios da Fase 1
Para cada camada/componente:
- estado esperado;
- o que persiste à formatação;
- ação: RESETAR/LIMPAR, ATUALIZAR/REGRAVAR OFICIALMENTE, TESTAR/APROVAR ou SUBSTITUIR SE DEFEITUOSO;
- método oficial;
- pré-requisitos;
- riscos;
- critério de sucesso;
- fonte primária;
- dado local necessário, se houver.

**Saída esperada:** Collection Specification + Resolution Specification da preparação pré-boot.

## Fase 2 — Aprovar hardware crítico
**Gate de entrada:** Fase 1 PASS.  
**Abrange:** placa-mãe/PCH, RAM, SSD, cadeia SATA, CPU/GPU, LAN/WLAN/Bluetooth e demais controladores que possam invalidar uma instalação nova.  
**Regra:** componente com falha crítica não recebe Windows como tentativa de correção.

## Fase 3 — Normalizar firmware/segurança
**Abrange:** Setup BIOS, NVRAM/boot relevante, TPM/PTT, Secure Boot/Factory Keys, ME/EC/firmwares somente quando houver método oficial e necessidade.  
**Regra:** nada de erase/reflash genérico.

## Fase 4 — Sanitizar armazenamento e fixar SATA Mode
**Gate:** SSD/cadeia aprovados e SATA Mode decidido por evidência.  
**Resultado:** unidade sanitizada quando aplicável e modo/driver de armazenamento definidos.

## Fase 5 — Preparar mídia oficial offline
**Abrange:** mídia Microsoft oficial, drivers essenciais escolhidos, integração offline quando necessária e ausência de Dynamic Update/Internet durante a construção inicial.

## Fase 6 — Instalar e validar primeiro boot offline
**Gate:** UEFI, Secure Boot, TPM/PTT, controlador SATA e driver realmente carregado coerentes; Device Manager sem falhas críticas; nenhuma restauração antiga.

## Fase 7 — Liberar internet de forma controlada
**Abrange:** conta/e-mail novo, sem restore do PC anterior, manutenção Windows/Secure Boot/firmware e drivers revisados individualmente.

## Fase 8 — Auditoria final
Comparar **COMO DEVERIA ESTAR × COMO FICOU**:
placa-mãe/plataforma, BIOS, EC, ME, NVRAM, Secure Boot, TPM/PTT, PCH/chipset, CPU, RAM/SPD, SSD/SATA, GPUs/VBIOS, LAN/NVM, WLAN/firmware, Bluetooth, áudio, card reader, USB/PCIe, ACPI, energia, Windows, drivers carregados, WHEA/Event Viewer, SFC/DISM, Windows Update, hora/RTC e estabilidade.

## Orçamento de execução
Cada fase operacional deve usar no máximo 2–3 scripts executados pelo usuário, conforme `skills/planner` e `skills/phase-executor`. Se não convergir, replanejar em vez de gerar Script 4/5/6.
