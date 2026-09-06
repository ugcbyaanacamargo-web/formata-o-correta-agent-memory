# Current Plan

## Objetivo
Realizar uma **reconstrução limpa da plataforma** do Lenovo IdeaPad 320-15IKB Type 80YH, eliminando estado persistente inadequado e evitando que o primeiro Windows seja construído sobre firmware, hardware, armazenamento ou drivers incorretos.

## Critério global
O Windows só será instalado depois de a plataforma cumprir os gates pré-boot. A tarefa só termina quando o estado final for comparado com a referência correta e validado por evidência recente.

## Fase 0 — Consolidar memória e baseline
**Status:** em andamento.  
**Resultado esperado:** modelo canônico do sistema, decisões persistidas e fontes/valores ainda não verificados claramente marcados.  
**Gate:** próximo agente consegue retomar sem reler toda a conversa.

## Fase 1 — Especificar o estado correto pré-formatação
**Status:** próxima fase.  
**Pesquisa obrigatória antes de qualquer ação destrutiva:**
- BIOS 4WCN47WW: menus reais, defaults e efeito de F9;
- UEFI/Legacy, Secure Boot e PTT;
- Clear Intel PTT Key;
- Reset to Setup Mode;
- Restore Factory Keys;
- PK/KEK/db/dbx e atualização posterior;
- Intel ME/CSME e EC;
- SATA Mode correto para o 80YH e SSD atual;
- firmware/diagnóstico/Secure Erase-Sanitize atual do WD Green;
- critérios de teste para RAM, SSD e cadeia SATA;
- identificação exata de LAN/WLAN/Bluetooth e drivers OEM.

**Saída esperada:** Collection Specification + Resolution Specification da preparação pré-boot.

## Fase 2 — Aprovar hardware crítico
**Gate de entrada:** Fase 1 PASS.  
**Abrange:** RAM, SSD, SATA/PCH, CPU/GPU básica, LAN/WLAN/Bluetooth e demais controladores que possam invalidar uma instalação nova.  
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
BIOS, EC, ME, NVRAM, Secure Boot, TPM/PTT, PCH/chipset, RAM, SSD/SATA, GPUs, LAN/WLAN/Bluetooth, áudio, card reader, USB/PCIe, ACPI, energia, Windows, drivers carregados, WHEA/Event Viewer, SFC/DISM, Windows Update, hora/RTC e estabilidade.

## Orçamento de execução
Cada fase operacional deve usar no máximo 2–3 scripts executados pelo usuário, conforme `skills/planner` e `skills/phase-executor`. Se não convergir, replanejar em vez de gerar Script 4/5/6.
