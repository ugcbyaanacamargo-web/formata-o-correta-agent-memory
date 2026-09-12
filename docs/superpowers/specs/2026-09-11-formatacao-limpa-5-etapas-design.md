# FORMATAÇÃO CORRETA — Design da Reconstrução Limpa em 5 Etapas

## Status
Aprovado conceitualmente pelo usuário em 2026-09-11. Este documento formaliza o desenho antes da implementação dos scripts.

## Objetivo
Realizar uma **reconstrução limpa da plataforma** do Lenovo IdeaPad 320-15IKB Type 80YH, reduzindo o processo a poucas etapas resolutivas, sem perder a cobertura de firmware, hardware, armazenamento, drivers, Windows e reintrodução por nuvem.

O objetivo não é “formatar C:”. O objetivo é impedir que uma nova instalação seja construída sobre estado persistente inadequado, hardware defeituoso, modo SATA incorreto, firmware incompatível, pilha de drivers incoerente ou restauração automática de estado antigo.

## Princípios obrigatórios

1. **Poucas etapas, alta cobertura.** O plano operacional terá 5 etapas.
2. **Um script amplo de coleta por etapa quando necessário.** Evitar comandos pingados.
3. **Um script completo de solução por etapa.** O script de solução só nasce depois da análise do resultado real da coleta.
4. **Terceiro script somente se indispensável** para validação independente, rollback ou correção final claramente determinada.
5. **Nenhum quarto script.** Se uma etapa não convergir em até 3 scripts, replanejar a etapa.
6. **Primeiro script da Etapa 1 é somente leitura.** Não altera BIOS, TPM, Secure Boot, drivers, registro, armazenamento nem firmware.
7. **Ações destrutivas exigem gate.** Clear TPM/PTT, reset de Secure Boot, Secure Erase/Sanitize, flash de firmware, exclusão de partições e equivalentes só ocorrem após confirmação de método, pré-requisitos, risco e estado esperado.
8. **Não assumir AHCI/RST.** O modo SATA será decidido a partir do hardware real, BIOS 4WCN47WW, controlador, SSD e driver correspondente.
9. **Conta nova não substitui limpeza de plataforma.** Hardware IDs, firmware, licença OEM e defeitos físicos continuam existindo.
10. **Primeiro boot do Windows será construído offline.** Windows Update não terá liberdade para escolher a pilha inicial de drivers antes da baseline.
11. **Nenhuma camada crítica fica implícita.** Placa-mãe/PCH, BIOS/UEFI, NVRAM, ACPI, ME, EC, TPM/PTT, Secure Boot, CPU/microcode, RAM/SPD, GPU/VBIOS, SSD/SATA, LAN, WLAN, Bluetooth, áudio, card reader, USB/PCIe e controladores onboard entram no processo.
12. **Sucesso exige evidência nova.** Cada etapa termina em PASS/FAIL verificável.

---

# Etapa 1 — Raio-X total pré-formatação

## Objetivo
Obter, em uma única coleta, todas as informações locais decisórias necessárias para definir com segurança o estado correto da plataforma antes de qualquer ação destrutiva.

## Script 01 — Coleta total, somente leitura
Nome planejado:

`execution/phase-01/01-coleta-total-pre-formatacao.ps1`

O script deverá coletar, quando tecnicamente acessível sem alteração:

### Identidade/plataforma
- fabricante, modelo, Type/MTM, serial, UUID, SMBIOS/DMI;
- placa-mãe/baseboard;
- BIOS/UEFI: fabricante, versão, data, modo de boot;
- EC quando exposto pelo sistema;
- PCH/chipset e controladores de sistema;
- CPU e recursos expostos;
- microcode/versões observáveis quando disponíveis.

### Segurança/boot
- UEFI × Legacy observado;
- Secure Boot ligado/desligado;
- informações acessíveis sobre PK/KEK/db/dbx sem modificar o estado;
- TPM/PTT: versão, fabricante, readiness, provisionamento e capacidades;
- BCD;
- entradas de firmware/Windows Boot Manager acessíveis;
- WinRE;
- BitLocker/device encryption state.

### RAM
- capacidade total;
- módulos físicos detectados;
- fabricante/part number/serial/frequência/SPD quando exposto;
- sinais de erro já registrados;
- estado necessário para planejar teste de memória offline posterior.

### Vídeo/PCIe
- Intel HD Graphics 620;
- NVIDIA GeForce 940MX;
- Hardware IDs;
- versões de driver;
- PCIe root ports relacionados;
- erros relevantes de dispositivo/PCIe/WHEA.

### Armazenamento
- modelo exato do WD Green atual;
- serial, firmware, bus/media type;
- SMART/health exposto pelo Windows;
- volumes/partições/GPT/EFI/MSR/Recovery;
- controlador SATA físico;
- Hardware IDs do controlador;
- serviço/driver de armazenamento configurado e realmente carregado;
- `storahci`, `iaStorA`, StorPort e serviços relacionados;
- erros WHEA/storage/disk/storahci/stornvme/StorPort relevantes;
- status TRIM quando aplicável.

### Rede e controladores internos
- Ethernet/LAN: modelo, Hardware IDs, MAC, driver, versão;
- Wi‑Fi/WLAN: módulo físico, Hardware IDs, MAC, driver, versão;
- Bluetooth;
- áudio/controlador/codec;
- card reader;
- touchpad;
- câmera;
- USB/Type-C/hubs;
- dispositivos ACPI;
- dispositivos desconhecidos/problemáticos.

### Drivers e fontes de atualização
- Driver Store relevante;
- drivers assinados instalados;
- versão, provider, INF e data;
- serviços associados;
- presença de Lenovo Vantage, Intel DSA, DriversCloud e outras fontes de atualização que possam ter misturado a pilha.

### Windows e integridade observável
- edição/build/arquitetura;
- ativação e canal de licença observável;
- chave OEM embutida apenas se puder ser detectada sem expor segredo desnecessário no relatório;
- SFC/DISM apenas em modo de verificação quando fizer sentido;
- políticas relevantes de Windows Update/driver update;
- histórico de updates relevante.

### Eventos
Janela suficiente para capturar:
- WHEA;
- Kernel-Power;
- ACPI/EC;
- storage/disk/storahci/StorPort;
- WLAN/network;
- driver install/PnP;
- Secure Boot/TPM;
- erros críticos e warnings de hardware relacionados.

## Saída do Script 01
O script deverá gerar uma pasta de execução e um ZIP único contendo:
- `manifest.json`;
- `summary.md`;
- arquivos JSON/CSV/TXT brutos por domínio;
- logs de execução;
- hash do próprio script;
- timestamp;
- versão do PowerShell/Windows;
- status de cada coletor.

Nenhum token, senha, cookie, chave privada ou segredo de conta deve ser coletado.

## Análise após o Script 01
Depois que o usuário enviar o ZIP:
1. validar integridade e versão do script;
2. ler o resultado inteiro;
3. confrontar com memória canônica do GitHub;
4. pesquisar Lenovo/Microsoft/Intel/SANDISK/Western Digital e outras fontes primárias quando necessário;
5. classificar cada camada em:
   - RESETAR/LIMPAR;
   - ATUALIZAR/REGRAVAR OFICIALMENTE;
   - TESTAR/APROVAR;
   - PRESERVAR;
   - SUBSTITUIR SE DEFEITUOSO;
6. decidir explicitamente o estado correto de UEFI/Secure Boot/PTT/SATA/firmware e hardware crítico.

## Script 02 — Preparação/normalização pré-formatação
Só será criado após a análise real do Script 01.

Ele deverá executar somente as mudanças automatizáveis e comprovadas da Etapa 1, com:
- pré-condições;
- backup/checkpoint quando aplicável;
- antes/depois;
- abort seguro;
- log estruturado.

Mudanças que exigem BIOS/UEFI física serão convertidas em um procedimento único e curto, não em comandos fictícios.

## Critério de PASS da Etapa 1
A Etapa 1 passa quando existe uma **Resolution Specification** completa definindo o que deve acontecer com cada camada antes da instalação e não existe decisão estrutural aberta sobre:
- hardware crítico;
- Secure Boot/PTT;
- SATA Mode;
- firmware essencial;
- SSD/cadeia SATA;
- baseline de drivers necessária para continuar.

---

# Etapa 2 — Plataforma, firmware e segurança

## Objetivo
Colocar a plataforma em estado conhecido e correto antes de apagar o Windows.

Abrange:
- Setup BIOS/UEFI;
- NVRAM/boot relevante;
- Secure Boot + PK/KEK/db/dbx;
- TPM/PTT;
- Intel ME/CSME;
- EC;
- firmware de dispositivos quando houver pacote oficial e necessidade comprovada;
- testes físicos definidos na Etapa 1 para RAM, SSD e cadeia crítica.

## Orçamento
- Script A: coleta/validação específica somente se a Etapa 1 não tiver fornecido uma evidência que só pode ser obtida aqui.
- Script B: solução/normalização automatizável.
- Script C: validação independente/rollback somente se necessário.

Ações manuais de BIOS serão agrupadas em **um único passe na BIOS**, com checklist derivado da Resolution Specification.

## PASS
Plataforma e hardware críticos aprovados; nenhuma configuração persistente necessária permanece em estado indefinido.

---

# Etapa 3 — SSD, mídia e instalação limpa

## Objetivo
Apagar a instalação antiga de forma apropriada, usar um SSD aprovado e instalar Windows a partir de mídia oficial preparada para o hardware real.

Abrange:
- firmware/saúde do SSD;
- Secure Erase/Sanitize quando for o método escolhido;
- modo SATA previamente decidido;
- mídia Microsoft oficial;
- drivers essenciais offline;
- instalação UEFI/GPT;
- recriação limpa de EFI/MSR/Windows/Recovery;
- ausência de Dynamic Update/Internet na construção inicial.

## Orçamento
- Script A: preparar/validar mídia, drivers e artefatos de instalação.
- Script B: automatizar o máximo possível da limpeza/instalação pelo ambiente apropriado (Windows/WinPE/Setup), sem tentar executar ações impossíveis no Windows que está sendo apagado.
- Script C: somente recuperação/validação se houver falha concreta.

## PASS
Windows novo instalado a partir de mídia oficial, em SSD aprovado/sanitizado conforme decisão, com boot UEFI correto e sem restauração antiga.

---

# Etapa 4 — Primeiro boot OFFLINE

## Objetivo
Construir a pilha inicial do Windows antes de permitir que Windows Update ou outras fontes alterem os drivers.

Abrange:
- UEFI/Secure Boot/PTT no Windows novo;
- controlador SATA e driver realmente carregado;
- chipset INF/MEI/Serial IO/ACPI/VPC quando aplicáveis;
- GPU Intel/NVIDIA;
- LAN/WLAN/Bluetooth;
- áudio/card reader/touchpad;
- dispositivos desconhecidos;
- política temporária para evitar substituição automática de drivers;
- nenhuma conta antiga/OneDrive/restore.

## Orçamento
- Script A: auditoria do primeiro boot offline.
- Script B: instalação da baseline de drivers e normalização offline.
- Script C: validação independente somente se necessário.

## PASS
Device Manager e pilha crítica coerentes com a baseline definida; nenhum driver crítico foi escolhido automaticamente pela internet.

---

# Etapa 5 — Internet controlada e auditoria final

## Objetivo
Liberar conectividade sem perder a baseline, aplicar manutenção oficial necessária e provar que a reconstrução terminou no estado esperado.

Abrange:
- conta/e-mail novo;
- nenhum restore do computador anterior;
- OneDrive sem restauração automática antiga;
- Windows Update controlado;
- Secure Boot/dbx/certificados compatíveis;
- firmware/driver restantes oficialmente suportados;
- ativação;
- auditoria final de hardware, firmware, drivers, integridade e eventos.

## Orçamento
- Script A: coleta completa pós-internet.
- Script B: correção final das diferenças comprovadas.
- Script C: verificação final independente somente se necessário.

## PASS global
Comparação `COMO DEVERIA ESTAR × COMO FICOU` aprovada para:
- placa-mãe/plataforma;
- BIOS/UEFI;
- EC;
- Intel ME;
- NVRAM/boot;
- Secure Boot;
- TPM/PTT;
- PCH/chipset;
- CPU/microcode;
- RAM/SPD;
- SSD/cadeia SATA;
- GPUs/VBIOS;
- LAN/WLAN/Bluetooth;
- áudio/card reader/USB/PCIe;
- ACPI/energia;
- Windows;
- drivers realmente carregados;
- WHEA/Event Viewer;
- SFC/DISM;
- Windows Update;
- estabilidade.

Somente após esse gate a reconstrução é considerada concluída.

---

# Fluxo resumido

```text
ETAPA 1 — RAIO-X TOTAL
Script 01 coleta tudo → análise/pesquisa → Script 02 prepara/normaliza

ETAPA 2 — PLATAFORMA/FIRMWARE/SEGURANÇA
normaliza e aprova o que existe antes do Windows

ETAPA 3 — SSD/MÍDIA/INSTALAÇÃO
sanitiza quando aplicável → instala Windows oficial offline

ETAPA 4 — PRIMEIRO BOOT OFFLINE
monta a baseline de drivers sem Windows Update

ETAPA 5 — INTERNET + AUDITORIA
atualiza de forma controlada → prova final
```

# Critério de replanejamento
Se uma etapa consumir 3 scripts sem atingir seu critério de PASS, não criar Script 4. Registrar a evidência, voltar ao planner e redesenhar a fronteira da etapa no nível de abstração correto.
