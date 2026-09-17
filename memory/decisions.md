# Decisions

## Decisões atuais

### DEC-20260906-01 — GitHub como memória viva
**Decisão:** manter a memória mutável no repositório e consultar a versão atual antes de reutilizar estado operacional.

### DEC-20260917-01 — Quatro fases resolutivas
**Decisão:** executar a FORMATAÇÃO CORRETA em 4 fases: plataforma persistente; SSD/instalação; baseline offline; internet/auditoria final.
**Motivo:** cobre todas as camadas que podem herdar estado sem criar microfases.

### DEC-20260917-02 — Duas execuções por fase
**Decisão:** cada fase tem um Script 1 de coleta e um Script 2/resposta resolutiva com validação embutida.
**Motivo:** impedir investigação infinita e comandos pingados.

### DEC-20260917-03 — Resetar estado não significa reflashear tudo
**Decisão:** resetar/limpar estados configuráveis que podem herdar erro; preservar firmware já correto; regravar somente quando houver pacote oficial exato + necessidade comprovada.
**Consequência:** BIOS/ME/EC/VBIOS não são reflasheados por ritual.

### DEC-20260917-04 — Secure Boot 2023 não deve ser regredido
**Decisão:** preservar o conjunto ativo atualizado quando a coleta confirmar UEFICA2023Status=Updated; não executar Restore Factory Keys se os defaults forem mais antigos.
**Motivo:** a coleta anterior mostrou chaves ativas mais atuais que os factory defaults.

### DEC-20260917-05 — TPM clear pelo caminho suportado
**Decisão:** quando a Fase 1 confirmar que não há dados criptográficos a preservar, limpar TPM/PTT usando funcionalidade do Windows, não reset cego pela UEFI.

### DEC-20260917-06 — SATA não será escolhido por regra genérica
**Decisão:** fechar SATA Mode e driver pela evidência do Type 80YH, DEV_9D03, BIOS real, SSD e pacote suportado.
**Motivo:** RST driver não prova por si só RAID/RST mode.

### DEC-20260917-07 — SSD: saúde e sanitização são coisas diferentes
**Decisão:** aprovar saúde/firmware primeiro; depois usar SANDISK Secure Erase/Sanitize quando o modelo oferecer suporte. Se não oferecer, usar limpeza total de partições no Windows Setup.

### DEC-20260917-08 — Primeiro boot offline
**Decisão:** instalar Windows oficial sem Internet e construir a pilha de drivers antes de liberar Windows Update.

### DEC-20260917-09 — Driver por identidade, não por agregador
**Decisão:** selecionar por hardware físico + Hardware ID + compatibilidade declarada; prioridade Lenovo Type 80YH, depois fabricante do componente, depois inbox Microsoft quando adequado.
**Exclusão:** não usar DriversCloud para escolher a baseline.

### DEC-20260917-10 — Resíduo não crítico não bloqueia eternamente
**Decisão:** Event 37, SBAT ou outro evento só bloqueia avanço quando viola estabilidade, segurança, energia ou outro critério funcional definido.
**Motivo:** evitar investigação infinita de eventos que não mudam a solução.