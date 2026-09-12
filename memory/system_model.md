# System Model

Este arquivo representa o conhecimento interligado do projeto.

> Estado: modelo operacional consolidado da conversa. Valores que determinam ações destrutivas ainda devem ser confirmados por pesquisa primária antes da execução.

## Entidade: Lenovo IdeaPad 320-15IKB Type 80YH
**Função:** Plataforma-alvo da reconstrução limpa.  
**Depende de:** placa-mãe, firmware, armazenamento, periféricos internos e Windows.  
**Influencia:** todas as escolhas de BIOS, firmware e driver.  
**Problemas conhecidos:** histórico de mistura de drivers e eventos ligados à cadeia de armazenamento.  
**Arquivos relacionados:** `memory/active_context.md`, `tasks/plan.md`.

## Componente: Placa-mãe / plataforma
**Função:** Base física que conecta e alimenta todos os componentes.  
**Inclui:** SPI flash, BIOS/UEFI, NVRAM, PCH/chipset, Intel ME/CSME, EC, TPM/PTT, ACPI, controladores onboard, clocks, VRM/alimentação, PCIe, SATA, USB e identidade DMI/SMBIOS.  
**Influencia:** Windows pode nascer com o mesmo problema se a origem estiver nesta camada.  
**Regra:** formatar SSD não altera a maior parte dessa camada.

## Componente: BIOS/UEFI 4WCN47WW
**Função:** Inicialização da plataforma e exposição de recursos ao sistema operacional.  
**Depende de:** SPI flash, EC/ME e configuração persistente.  
**Influencia:** boot, ACPI, segurança, SATA e enumeração de hardware.  
**Problemas conhecidos:** efeito exato de F9 e defaults ainda precisam de confirmação específica.  
**Regra:** não reflashear apenas para “ficar limpo”.

## Componente: NVRAM / UEFI Boot
**Função:** Persistir variáveis de firmware e entradas de boot.  
**Pode conter:** BootOrder, Boot####, Windows Boot Manager, variáveis OEM e parte do estado de Secure Boot.  
**Influencia:** boot e estado da plataforma antes do Windows.  
**Regra:** apagar SSD não equivale a limpar NVRAM inteira.

## Componente: Secure Boot
**Função:** Controlar confiança de código de boot.  
**Elementos:** PK, KEK, db, dbx.  
**Depende de:** firmware UEFI/NVRAM.  
**Regra:** se o conjunto anterior for resetado, restaurar Factory Keys antes da instalação e aplicar manutenção oficial depois.

## Componente: TPM / Intel PTT
**Função:** Estado criptográfico e confiança da plataforma.  
**Depende de:** firmware/plataforma Intel.  
**Influencia:** provisionamento do Windows, Windows Hello, chaves e atestação.  
**Regra:** limpeza é operação separada de F9 e de Secure Boot.

## Componente: Intel ME / CSME
**Função:** Firmware de gerenciamento da plataforma Intel.  
**Influencia:** funcionamento de baixo nível e comunicação via MEI.  
**Regra:** firmware ME não é o mesmo que driver MEI do Windows.

## Componente: EC
**Função:** Gerenciamento de energia, bateria, sensores, teclado e eventos de plataforma.  
**Influencia:** ACPI, energia e comportamento térmico.  
**Regra:** Windows novo continua usando o mesmo EC.

## Componente: ACPI
**Função:** Interface firmware ↔ sistema operacional para energia e dispositivos.  
**Depende de:** BIOS/UEFI/EC.  
**Influencia:** enumeração, energia, suspensão e dispositivos.  
**Regra:** erro persistente de firmware pode ser recriado no Windows novo sem “arquivo antigo voltar”.

## Componente: PCH / chipset
**Função:** Integra barramentos/controladores da plataforma, incluindo funções ligadas a SATA, USB e PCIe.  
**Influencia:** armazenamento, rede, USB e dispositivos internos.  
**Regra:** Intel Chipset Device Software/INF não deve ser confundido com firmware ou reparo físico do PCH.

## Componente: CPU / microcode
**Hardware:** Intel Core i7-7500U.  
**Influencia:** execução, virtualização, threads e microcode carregado pela plataforma/OS.  
**Regra:** defeito físico não é corrigido por formatação.

## Componente: RAM / SPD
**Hardware:** 16 GB.  
**Função:** memória de trabalho; SPD persiste identificação/timings.  
**Regra:** conteúdo DRAM normal é volátil, mas RAM defeituosa pode criar corrupção nova durante instalação.  
**Gate:** testar antes de confiar na instalação.

## Componente: GPUs
**Hardware:** Intel HD Graphics 620 + NVIDIA GeForce 940MX.  
**Camadas:** hardware, alimentação/PCIe, firmware/VBIOS e driver Windows.  
**Regra:** formatar remove driver, não necessariamente firmware nem defeito físico.

## Componente: SSD WD Green 2.5" 1 TB
**Camadas:** dados/partições, firmware, controladora, NAND, SMART/saúde, link SATA e alimentação.  
**Regra:** Secure Erase/Sanitize elimina dados/estado de mídia; não repara hardware.  
**Gate:** teste de saúde e cadeia SATA antes da instalação.

## Componente: Cadeia SATA
**Fluxo:** SSD → conector/link SATA → controlador SATA → PCH → SATA Mode BIOS → driver de armazenamento → StorPort → Windows.  
**Histórico:** já houve estado envolvendo `storahci` e posterior configuração/instalação de Intel RST/`iaStorA`.  
**Regra:** não reduzir a análise ao SSD.

## Componente: Ethernet / LAN
**Camadas:** hardware, NVM/EEPROM/firmware quando aplicável, MAC/PXE/Option ROM e driver Windows.  
**Regra:** identificar controlador real antes de selecionar pacote.

## Componente: Wi‑Fi / WLAN
**Camadas:** módulo físico, Hardware IDs, MAC, NVM/calibração quando aplicável, firmware e driver.  
**Regra:** identificar módulo real antes de escolher Intel/Realtek/Qualcomm ou versão.

## Componente: Bluetooth
**Camadas:** hardware, firmware/estado, interface interna e driver.  
**Regra:** tratar separadamente mesmo quando integrado ao módulo WLAN.

## Componente: Áudio
**Camadas:** controlador de plataforma, codec, ACPI, driver e extensões OEM.  

## Componente: Card reader
**Camadas:** controlador, barramento, firmware quando aplicável e driver.

## Componente: USB / PCIe
**Camadas:** PCH/root ports, hubs, links, energia e dispositivos.  
**Regra:** falha física de link/alimentação pode reaparecer como “erro de driver”.

## Componente: Windows / Driver Store
**Função:** Sistema operacional e drivers.  
**Regra:** instalação limpa não garante pilha coerente.  
**Risco:** Windows Update, Lenovo Vantage, Intel DSA, agregadores e pacotes genéricos podem sobrepor versões.

## Componente: Nuvem / serviços externos
**Inclui:** Windows Backup, conta Microsoft, OneDrive, Microsoft Store, Windows Update e ativação digital.  
**Regra:** conta nova reduz herança da conta antiga, mas não muda Hardware IDs, firmware, licença OEM ou defeito físico.
