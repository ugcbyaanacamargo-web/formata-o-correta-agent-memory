# Current Plan — Reconstrução Limpa em 5 Etapas

## Objetivo
Realizar uma **reconstrução limpa da plataforma** do Lenovo IdeaPad 320-15IKB Type 80YH, eliminando estado persistente inadequado e evitando que o Windows novo seja construído sobre firmware, hardware, armazenamento ou drivers incorretos.

## Regra global
O processo operacional tem **5 etapas**. Cada etapa usa preferencialmente:

1. **um script amplo de coleta** quando necessário;
2. análise/pesquisa com o resultado real;
3. **um script completo de solução**;
4. terceiro script somente para validação independente, rollback ou correção final claramente determinada.

Se uma etapa consumir 3 scripts sem atingir PASS, **não existe Script 4**: a etapa volta ao planner para replanejamento.

## Especificação aprovada
Design canônico:

`docs/superpowers/specs/2026-09-11-formatacao-limpa-5-etapas-design.md`

---

## Etapa 1 — Raio-X total pré-formatação
**Status:** DESIGN APROVADO / aguardando revisão escrita antes da implementação do Script 01.

### Objetivo
Coletar em uma única execução todas as evidências locais necessárias para decidir o estado correto da plataforma antes de qualquer ação destrutiva.

### Script 01 planejado
`execution/phase-01/01-coleta-total-pre-formatacao.ps1`

Características:
- PowerShell;
- execução elevada quando necessário;
- **somente leitura**;
- nenhuma alteração em BIOS, TPM, Secure Boot, drivers, registro, SSD ou firmware;
- saída estruturada + ZIP único;
- coleta ampla de plataforma, segurança, RAM, GPU, SSD/SATA, rede, controladores, drivers, Windows e eventos.

### Depois do Script 01
O agente deverá:
- validar o pacote;
- confrontar com memória canônica;
- pesquisar fontes primárias;
- classificar cada camada em RESETAR/LIMPAR, ATUALIZAR/REGRAVAR, TESTAR/APROVAR, PRESERVAR ou SUBSTITUIR;
- resolver UEFI/Secure Boot/PTT/SATA/firmware/hardware crítico;
- produzir a Resolution Specification.

### Script 02
Preparação/normalização pré-formatação, criado **somente depois** da análise real do Script 01.

### Gate
Nenhuma decisão estrutural crítica aberta sobre hardware, Secure Boot/PTT, SATA Mode, firmware essencial, SSD/cadeia SATA ou baseline de drivers.

---

## Etapa 2 — Plataforma, firmware e segurança
**Status:** PENDENTE.

### Objetivo
Colocar a plataforma em estado conhecido e correto antes de apagar o Windows.

### Abrange
- BIOS/UEFI Setup;
- NVRAM/boot relevante;
- Secure Boot + PK/KEK/db/dbx;
- TPM/PTT;
- Intel ME/CSME;
- EC;
- firmware de dispositivos quando houver pacote oficial e necessidade comprovada;
- testes físicos definidos na Etapa 1 para RAM, SSD e cadeia crítica.

### Regra
Ações manuais de BIOS serão agrupadas em **um único passe** derivado da Resolution Specification.

### Gate
Plataforma e hardware críticos aprovados; nenhum estado persistente necessário permanece indefinido.

---

## Etapa 3 — SSD, mídia e instalação limpa
**Status:** PENDENTE.

### Objetivo
Apagar a instalação antiga pelo método escolhido, usar armazenamento aprovado e instalar Windows oficial em modo controlado/offline.

### Abrange
- firmware/saúde do SSD;
- Secure Erase/Sanitize quando aplicável;
- SATA Mode já decidido;
- mídia Microsoft oficial;
- drivers essenciais offline;
- UEFI/GPT;
- recriação limpa de EFI/MSR/Windows/Recovery;
- sem Dynamic Update/Internet durante a construção inicial.

### Gate
Windows novo instalado em SSD aprovado, sem restore antigo, com boot UEFI correto.

---

## Etapa 4 — Primeiro boot OFFLINE
**Status:** PENDENTE.

### Objetivo
Construir a baseline inicial do Windows antes de permitir Windows Update ou outras fontes automáticas de driver.

### Abrange
- Secure Boot/PTT vistos pelo Windows novo;
- controlador SATA e driver realmente carregado;
- chipset INF/MEI/Serial IO/ACPI/VPC quando aplicáveis;
- Intel/NVIDIA;
- LAN/WLAN/Bluetooth;
- áudio/card reader/touchpad;
- dispositivos desconhecidos;
- bloqueio temporário de substituição automática de drivers;
- nenhuma conta antiga/OneDrive/restore.

### Gate
Pilha crítica coerente com a baseline definida e nenhum driver crítico escolhido automaticamente pela internet.

---

## Etapa 5 — Internet controlada e auditoria final
**Status:** PENDENTE.

### Objetivo
Liberar conectividade, aplicar manutenção oficial necessária sem perder a baseline e provar o estado final.

### Abrange
- conta/e-mail novo;
- nenhum restore do PC anterior;
- OneDrive sem restauração automática antiga;
- Windows Update controlado;
- Secure Boot/dbx/certificados compatíveis;
- firmware/drivers restantes oficialmente suportados;
- ativação;
- auditoria final completa.

### Gate global
Comparação **COMO DEVERIA ESTAR × COMO FICOU** aprovada para:
placa-mãe/plataforma, BIOS/UEFI, EC, ME, NVRAM, Secure Boot, TPM/PTT, PCH/chipset, CPU/microcode, RAM/SPD, SSD/SATA, GPUs/VBIOS, LAN/WLAN/Bluetooth, áudio/card reader/USB/PCIe, ACPI/energia, Windows, drivers carregados, WHEA/Event Viewer, SFC/DISM, Windows Update e estabilidade.

Somente após esse gate a reconstrução é considerada concluída.

---

## Próxima ação
Após a revisão escrita da especificação pelo usuário, invocar `superpowers:writing-plans` para gerar o plano de implementação e então criar o **Script 01 completo da Etapa 1**.
