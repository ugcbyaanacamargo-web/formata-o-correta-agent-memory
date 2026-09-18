# Active Context

## Objetivo atual
Executar a **FORMATAÇÃO CORRETA** do Lenovo IdeaPad 320-15IKB Type 80YH como reconstrução limpa em 4 fases resolutivas.

## Regra operacional
Cada fase: um Script 1 de coleta completa; pesquisa profunda usando o ZIP real + fontes oficiais + memória; uma resposta/Script 2 que conclui a fase e já valida o resultado.

Sem investigação infinita. Sem comandos pingados. Sem Script 3 por rotina.

## Fase atual
**FASE 1 — Plataforma persistente / BIOS / firmware / segurança.**

## Coleta da Fase 1 — 2026-09-17
ZIP: `FORMACAO_CORRETA_FASE1_80YH_20260917_234331.zip`
SHA-256 do ZIP: `3bfb9bd7b244027ec95d1ebf7e8834e70bff48d19f1ebb1149dee70d4c60148e`

Integridade:
- 117/117 arquivos do manifesto de hashes conferidos;
- 75 coletores PASS;
- 10 WARN; os WARN de storage significam ausência de eventos/provedor e não falha observada;
- a única lacuna decisória é a BIOS não expor `Lenovo_BiosSetting`.

## Estado confirmado
- LENOVO / Type 80YH / ideapad 320-15IKB.
- BIOS `4WCN47WW`, release 1.47, EC 1.47, SMBIOS 3.0.
- Firmware type UEFI.
- Secure Boot = True.
- `UEFICA2023Status = Updated`, sem UEFICA2023Error, AvailableUpdates = 0.
- KEK/db ativos contêm certificados Microsoft 2023; defaults são mais antigos.
- TPM 2.0 Intel PTT, firmware 302.12.0.0, pronto/ativado/owned, sem vulnerabilidade reportada.
- SATA controller Intel DEV_9D03 exposto como SATA AHCI Controller; driver carregado `iaStorAC 17.8.1.1066`.
- MEI driver `1828.12.0.1152`.
- ESRT expõe device firmware resource `865D322C-6AC7-4734-B43E-55DB5A557D63` com version 3510.
- RAM Samsung M471A2K43CB1-CRC, 16 GB, 2133 MT/s.
- NVIDIA 940MX: VBIOS 82.08.6D.00.8A, 4096 MiB.
- plano de energia ativo: Equilibrado.
- Event 37: 63 em 180d; ocorrência mais recente 17/09/2026 23:12.
- WHEA: 3 históricos; último 26/08/2026.
- SBAT Event 292: 55 históricos; último 12/09/2026, sem recorrência nos boots de 17/09.
- ACPI EC Event 13/15 permanece histórico de agosto.
- NVRAM contém entrada residual `EFI USB Device (SanDisk)` com device unknown.

## Lacuna prevista pelo próprio Script 1
A BIOS desta unidade não implementa a classe WMI `Lenovo_BiosSetting`. Portanto, os valores atuais de SATA Mode, PTT, Virtualization, Hyper-Threading, Fast Boot, PXE, SGX e BIOS Back Flash precisam ser confirmados visualmente na BIOS.

## Próxima ação
Sem novo script: obter fotos atuais e nítidas de todas as páginas da BIOS (Information/Main, Configuration, Security, Boot e Exit), sem alterar nada. Depois disso, produzir imediatamente o Script 2 / passe final da Fase 1.
