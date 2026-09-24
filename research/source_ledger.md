# Source Ledger — FORMATAÇÃO CORRETA

Consultadas em 23/09/2026 para distinguir evidência histórica e comportamento esperado.

## SRC-20260923-01 — Microsoft, evento 129 e timeouts
- https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/troubleshoot-data-corruption-and-disk-errors
- Microsoft Learn, orientação Windows Server; descreve mecanismo Storport que registra ID 129 quando solicitação expira/reset. **Escopo documentado é Windows Server, extrapolar ao Windows 10 apenas mecanismo e corroborar com evento local.** Relacionado: FND-20260923-01.

## SRC-20260923-02 — Lenovo Intel RST 15.9.1.1018
- https://pcsupport.lenovo.com/sr/en/products/laptops-and-netbooks/300-series/320-touch-15ikb/downloads/ds121515
- Lenovo DS121515: RST 15.9.1.1018 Windows 10 x64; lista Type **80XL/80YE** para 320-15IKB, **não lista Type 80YH**. Hardware ID/INF e experimento local são evidência complementar; NÃO afirmar aprovação Lenovo expressa para 80YH.

## SRC-20260923-03 — Microsoft Add-AppxPackage / MSIX
- https://learn.microsoft.com/en-us/powershell/module/appx/add-appxpackage
- https://learn.microsoft.com/pt-br/windows/msix/desktop/managing-your-msix-deployment-troubleshooting
- Microsoft: `0x80073D02 ERROR_PACKAGES_IN_USE` e registro deferido; documentação de pacote comum, não autoriza remover componente de sistema Client.CBS em uso.

## SRC-20260923-04 — Microsoft Event 37
- https://learn.microsoft.com/en-us/troubleshoot/windows-server/setup-upgrade-and-drivers/event-id-37-windows-kernel-processor-power
- Microsoft explica limitação de frequência definida pela plataforma e avaliação de políticas de power capping. **Artigo aplica-se a Server 2016**; no Lenovo diagnóstico é apoiado também pelo XML local de 23/09.

## SRC-20260923-05 — Microsoft Secure Boot 2023
- https://support.microsoft.com/pt-br/servicing/os/secure-boot/2026/03/secure-boot-troubleshooting-guide
- Aviso oficial: restaurar chaves antigas em máquina com Windows UEFI CA 2023 pode impedir boot. Não usar Restore Factory Keys por ritual.

## SRC-20260923-06 — Microsoft instalação limpa
- https://support.microsoft.com/pt-br/windows/deployment/install-upgrade/reinstall-windows-with-the-installation-media
- A instalação limpa remove apps/configurações do Windows; não reflasheia EC/ME/BIOS, nem garante corrigir limitações físicas ou firmware.
