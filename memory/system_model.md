# System Model — Lenovo IdeaPad 320-15IKB Type 80YH

## Plataforma
**Modelo:** Lenovo IdeaPad 320-15IKB Type 80YH.
**PCB física:** NM-B242 Rev.1.0 / ASKPCB.
**Objetivo:** reconstrução limpa da plataforma, não apenas reinstalação do Windows.

## CPU / gráficos
- Intel Core i7-7500U.
- Intel HD Graphics 620 integrada.
- NVIDIA N16S-GTR-S-A2, exposta como GeForce 940MX.
- Windows/auditorias observaram 4 GB de VRAM dedicada.
- UV4/UV6: SK hynix H5GC8H24AJR-T2C legível; UV5/UV13: SK hynix confirmado, código completo não confirmado pela foto.

## RAM
- 16 GB DDR4 em **um único SO-DIMM**.
- Lenovo FRU 01FR302.
- P/N físico da etiqueta: SM30N449903.
- fabricante/chips Samsung observados.

## Firmware / segurança
### BIOS SPI
- UC3 Winbond 25Q64FVSIG.
- BIOS observada: Lenovo 4WCN47WW.

### EC
- UE1 IT8586E.
- marcações: 1733-FXA / S0QEEA.

### Secure Boot
- estado observado: ON.
- PK/KEK/db/dbx ativos.
- migração Microsoft 2023 observada como atualizada em auditoria anterior.
- factory defaults observados como mais antigos que o conjunto ativo.
- regra: não usar Restore Factory Keys se isso regredir o conjunto ativo.

### TPM
- Intel PTT / TPM 2.0 confirmado.
- limpeza é operação independente de BIOS defaults e Secure Boot.

### Intel ME
- driver MEI e firmware ME são camadas diferentes.
- versão real do firmware deve ser consultada por método oficial; não inferir pelo driver.
- não reflashar sem pacote exato para a plataforma.

## Armazenamento
### SSD
- WD Green SATA 1 TB.
- firmware observado: 42077100.
- auditoria anterior: Healthy/Online, TRIM ativo, sem erro SMART crítico.

### Cadeia SATA
SSD → link SATA → Intel DEV_9D03 → driver storage → StorPort → Windows.

Histórico:
- WHEA storage antigo referenciou STORPORT/storahci/WD Green.
- depois houve estabilização com pilha Intel.
- o modo final de BIOS não será inferido apenas pelo nome do driver.

## Rede / controladores
- WLAN/Bluetooth: Intel Dual Band Wireless-AC 3165 / 3165NGW, FRU 00JT537.
- U26: Realtek RTS5449.
- TL1: marcação física 08T5009 / LF / 1740D.
- LAN, áudio, card reader e demais controladores serão vinculados pelo Hardware ID no primeiro boot.

## Power / placa
- PU402: BQ24710 pela leitura física.
- controlador ON: NCP81216.
- componentes com código visual não confirmado permanecem NÃO CONFIRMADOS; não completar por padrão.

## Manutenção física
- limpeza interna concluída.
- pasta térmica renovada.
- bateria foi desconectada em uma etapa posterior de diagnóstico; considerar o estado real na próxima coleta antes de qualquer operação de firmware.

## Persistência
Apagar o SSD NÃO apaga:
- BIOS/UEFI;
- NVRAM;
- Secure Boot;
- TPM/PTT;
- Intel ME;
- EC;
- VBIOS;
- firmware/NVM de dispositivos;
- firmware/SMART do SSD;
- identidade física/Hardware IDs.

## Regra de decisão
Ações são classificadas como:
- RESETAR/LIMPAR;
- ATUALIZAR oficialmente;
- PRESERVAR;
- TESTAR/APROVAR;
- SUBSTITUIR se defeituoso.

A classificação serve para levar a plataforma ao estado correto com o menor número de ciclos, não para maximizar número de resets.