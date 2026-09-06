# Active Context

## Objetivo atual
Executar uma **reconstrução limpa da plataforma** do Lenovo IdeaPad 320-15IKB Type 80YH, e não apenas reinstalar o Windows.

## Resultado final esperado
O primeiro Windows utilizável só deve existir depois que **todas as camadas persistentes ou fisicamente remanescentes** tiverem sido classificadas e tratadas como necessário: resetar/limpar, atualizar/regravar oficialmente, testar/aprovar ou substituir se defeituosas.

## Estado atual
- GitHub conectado ao ChatGPT.
- Repositório de memória ativo: `ugcbyaanacamargo-web/formata-o-correta-agent-memory`.
- gstack Workflows carregado para autoplan, engineering review, investigação, guard/careful, review e retro.
- Skills locais carregadas: adaptive-orchestrator, planner, deep-investigator, memory-manager, knowledge-linker, template-engineer, phase-executor e verifier.
- Modelo-base do equipamento consolidado a partir da conversa e arquivos anteriores:
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
- O histórico já mostrou que uma instalação nova pode receber pilhas de driver incoerentes; portanto “Windows novo” não é sinônimo de “plataforma correta”.

## Princípios de trabalho
> Se um componente continua fisicamente no notebook depois que o SSD é apagado, ele entra na análise pré-formatação.

> “Funciona” não significa “está correto”. O estado final deve ser o correto para este modelo/hardware, sustentado por documentação, identificação real e teste.

> Nenhuma camada crítica pode ficar implícita atrás de frases genéricas como “configurar a BIOS” ou “instalar os drivers”.

## Próxima fronteira de decisão
Produzir uma **especificação pré-formatação completa** com pesquisa profunda para cada grupo persistente:

1. **Placa-mãe/plataforma:** SPI/BIOS/UEFI, NVRAM, ACPI, PCH/chipset, clocks/alimentação relevantes e controladores onboard.
2. **Segurança:** UEFI/Legacy, Secure Boot, PK/KEK/db/dbx, TPM/PTT, Clear Intel PTT Key, Reset to Setup Mode e Restore Factory Keys.
3. **Firmware de plataforma:** BIOS 4WCN47WW, Intel ME/CSME, EC e CPU/microcode quando relevante.
4. **Memória:** RAM física, SPD e critério de aprovação antes do Windows.
5. **Vídeo:** Intel HD 620, NVIDIA 940MX, VBIOS/firmware, PCIe e alimentação.
6. **Armazenamento:** WD Green, firmware, controladora/NAND, SMART/testes, Secure Erase/Sanitize, link/controlador SATA/PCH e SATA Mode correto.
7. **Rede:** Ethernet NVM/EEPROM/PXE/firmware quando aplicável, Wi‑Fi NVM/calibração/firmware, Bluetooth e Hardware IDs reais.
8. **Demais controladores:** áudio/codec, card reader, USB/Type-C, PCIe Root Ports, touchpad, câmera e dispositivos ACPI.
9. **Instalação:** mídia oficial, drivers essenciais offline, Dynamic Update, primeiro boot sem Internet e bloqueio da reintrodução automática de drivers.
10. **Nuvem pós-instalação:** conta/e-mail novo, Windows Backup, OneDrive, Store, ativação e manutenção oficial de firmware/Secure Boot.

A Fase 1 só passa quando cada item acima tiver:
- estado esperado;
- o que persiste à formatação;
- método oficial de reset/update/teste;
- risco da operação;
- critério objetivo para prosseguir;
- fonte primária ou evidência do equipamento.

## Regra de atualização
Atualizar este arquivo sempre que mudar:
- objetivo;
- fase atual;
- bloqueio;
- próxima ação;
- decisão operacional relevante.
