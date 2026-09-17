# Active Context

## Objetivo atual
Executar a **FORMATAÇÃO CORRETA** do Lenovo IdeaPad 320-15IKB Type 80YH como reconstrução limpa em 4 fases resolutivas.

## Regra operacional
Cada fase: um Script 1 de coleta completa; pesquisa profunda usando o ZIP real + fontes oficiais + memória; uma resposta/Script 2 que conclui a fase e já valida o resultado.

Sem investigação infinita. Sem comandos pingados. Sem Script 3 por rotina.

## Fase atual
**FASE 1 — Plataforma persistente / BIOS / firmware / segurança.**

## Base física
- Type 80YH / PCB NM-B242 Rev.1.0.
- i7-7500U + Intel HD 620.
- NVIDIA N16S-GTR-S-A2 / GeForce 940MX.
- 16 GB em um único SO-DIMM, FRU 01FR302, P/N físico SM30N449903.
- Intel 3165NGW FRU 00JT537.
- Winbond 25Q64FVSIG (UC3).
- EC IT8586E / 1733-FXA / S0QEEA.
- Realtek RTS5449.
- PU402 BQ24710.
- ON NCP81216.
- WD Green SATA 1 TB.

## Estado já conhecido
- limpeza interna e pasta térmica concluídas;
- BIOS 4WCN47WW observada;
- Secure Boot ON;
- migração Microsoft Secure Boot 2023 já observada como atualizada;
- TPM 2.0 Intel PTT confirmado;
- SSD firmware observado 42077100;
- cadeia SATA teve WHEA histórico, depois estabilização com driver Intel;
- Event 37 persistiu em coleta posterior mesmo após reset BIOS/EC;
- primeiro boot da nova instalação será offline.

## Plano canônico
`tasks/plan.md`

## Próxima ação
Gerar o Script 1 completo da Fase 1, revisar o script e entregar um único comando de execução.