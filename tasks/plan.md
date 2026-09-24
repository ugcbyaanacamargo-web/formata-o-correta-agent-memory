# Current Plan — FORMATAÇÃO CORRETA

## Objetivo
Restaurar a confiabilidade e integridade do Lenovo 320-15IKB Type 80YH sem apenas esconder eventos. Cada alteração deve ter reprodução, critério de sucesso e rollback, com validação suficiente antes de dizer "resolvido". Estado comprovado em [Active Context](../memory/active_context.md).

## Fase 1 — Windows/AppX e ferramentas
- [x] Comparar Desktop Commander 0.2.51 com pacote oficial npm: 249/249 arquivos, SRI coincide.
- [x] Explicar versões vulneráveis/obsoletas e impedir `npm audit fix --force` que rebaixa para 0.2.23.
- [x] Re-registrar Microsoft.Windows.Search; ativação `search-ms:` sem crash imediato.
- [ ] Confirmar estabilidade de SearchApp em período sustentado e busca real na interface.
- [ ] ScreenClippingHost: registro CBS não resolve; 0xc000027b reproduzido mesmo após ajuste temporário C:\Users ReadAttributes; mudança revertida. Seguir investigação de crash específico por perfil/componente e comparar com relato externo de mesma assinatura.
- [ ] Avaliar KB5129236 19045.7727 pelo critério dos defeitos que efetivamente corrige e elegibilidade ESU; NÃO chamar correção para Snipping Tool sem evidência.
- [ ] Corrigir atualização do Desktop Commander quando upstream publicar versão compatível. Qualquer build com overrides precisa de teste em instalação isolada antes de trocar o processo remoto ativo.

## Fase 2 — Estabilidade da plataforma
- [x] Identificar WHEA histórico com CPER e NOVO iaStorAC ID129 em 23/09 21:46:19 (RecordId 11276); falha armazenamento REABERTA após a mudança para RST 17.8.1.1066. Não reverter SATA por hipótese.
- [ ] Corrompimento de memória 0x1A/0x41792 em 05/09 e 23/09: isolamento seguro de driver vs memória intermitente, com usuário e recuperação física disponíveis; backup de dados primeiro, não ativar Driver Verifier remotamente sem recovery.
- [ ] Confirmar firmware/Intel ME/ACPI/EC com relatório atual próprio; não usar apenas relatos antigos Ubuntu como prova de estado atual.
- [x] Auditar ACL da raiz C:\\: Authenticated Users FullControl (OI)(CI), inclusive herança em diretórios sem ACL protegida. Efeito sobre risco de serviço sem aspas demonstrado; sem indício de exploração C:\\Program.exe.
- [x] Corrigir 4 ImagePath de serviços SYSTEM não delimitados por aspas (Odoo, Codex, PC Manager, WslInstaller), com backup local, validação de caminhos e estados.
- [ ] Remediar ACL da raiz C:\\ (e revalidar heranças em ferramentas de firmware) somente após backup externo recuperável/rollback e decisão de alcance; não usar icacls /reset /T.
- [ ] Investigar Event129/latência de armazenamento e proximidade do AppXSvc 7000/7009, inclusive recorrência sob uso.

## Fase 3 — Reinstalação final (somente se justificada)
- [ ] Confirmar backup EXTERNO testado (nenhuma unidade externa encontrada em 24/09), mídia oficial íntegra, firmware/SSD validado, caminho de drivers e recuperação.
- [ ] Instalação limpa controlada, sem misturar atualizadores de driver.
- [ ] Validar primeiro boot, aplicativos, WU/Store, drivers, BSOD/WHEA após uso real.

## Critério de conclusão
Não existem falhas reproduzíveis abertas, desvios relevantes sem avaliação, nem mudança destrutiva sem recuperação; memória no GitHub corresponde ao resultado atual.
