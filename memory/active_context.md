# Active Context — FORMATAÇÃO CORRETA

## Objetivo operacional atual (23/09/2026)
Estabilizar o Lenovo IdeaPad 320-15IKB Type 80YH como conjunto (Windows, AppX, drivers, memória, firmware, armazenamento), com correções verificadas; não considerar um aviso isolado como prova de causa sistêmica. Reinstalação limpa somente com pré-condições e validação pós-boot. O usuário prefere operação remota e explicações breves.

## Estado auditado
- Windows 10 Home Single Language 22H2 build 19045.7725; Windows RE habilitado, BitLocker C: desligado, conta remota elevada. Não foi confirmado backup integral de dados.
- Duas telas azuis 05/09 e 23/09: 0x1A/0x41792 MEMORY_CORRUPTION_ONE_BIT; WinDbg analisou minidumps e dump completo sem apontar autor da corrupção. MemTest86 passou, o que não exclui defeito intermitente. Não ativar Driver Verifier remotamente sem caminho de recuperação/autorização pós-boot.
- Três eventos WHEA de storage em agosto registraram STORPORT/storahci/WD Green. No checkpoint de 04/09 não houve recorrência após troca para Intel RST; em 23/09 controlador SATA estava no Intel iaStorAC 17.8.1.1066, sem novos WHEA identificados. Não trocar driver SATA por tentativa.
- SearchApp falhava desde 22/08, ScreenClippingHost desde 16/09; ambos com 0xc000027b recente. Registro isolado do pacote Microsoft.Windows.Search foi concluído com sucesso em 23/09; ativação `search-ms:` não produziu crash imediato (não prova estabilidade sustentada).
- Registro do pacote MicrosoftWindows.Client.CBS concluiu, mas houve também evento AppX 404 0x8007042B. Ativação `ms-screenclip:` voltou a causar ScreenClippingHost 0xc000027b após o registro.
- Procmon capturou a falha ScreenClipping: 6 recusas de leitura de atributos em C:\Users; outras recusas em MuiCache e User Shell Folders com pedidos Read/Write ou All Access. ALL APPLICATION PACKAGES tem leitura nas principais raízes C:\Windows/C:\Program Files/Registro e User Shell Folders. C:\Users não tem ACE desse grupo. Teste reversível concedendo SOMENTE ReadAttributes nesse diretório, sem herança, NÃO resolveu: crash reproduzido às 22:35:33. ACE removida, SDDL original conferido byte a byte. NÃO conceder controle total em C:\Users nem reset recursivo por esta hipótese.
- Comparação pública encontrou outra pessoa com o mesmo ScreenClippingHost.exe/ScreenClipping.dll/0xc000027b e exatamente o deslocamento 0x31e89 (02/09/2026); isto não prova a causa mas enfraquece atribuição exclusiva ao hardware local.
- DISM /CheckHealth informou ausência de corrupção; /ScanHealth foi executado, mas o resultado terminal completo não foi preservado no conector (não afirmar conclusão daquele scan sem novo resultado integral).
- Desktop Commander 0.2.51: 249 arquivos correspondem ao pacote npm oficial; npx instala ExcelJS 4.4.0 e glob/rimraf/inflight legados; sharp 0.34.5 e uuid 8.3.2 com avisos de segurança. Versão npm mais recente em 23/09 = 0.2.51; NÃO rodar `npm audit fix --force` porque o solver rebaixou para 0.2.23. Não modificar a instalação ativa enquanto sustenta o acesso remoto.

## Portas de segurança
Não fazer mudanças em BIOS/ME/EC/Secure Boot/TPM/SSD, driver boot, ACL de disco/Registro em massa ou Driver Verifier sem evidência específica, backup, recuperação e teste. Nunca enviar dump, Procmon CSV/PML, tokens ou configurações de sessão para este repositório público.

## Próxima decisão
Separar: (a) crash AppX Search/Captura (teste funcional/logs e possível perfil do Windows), (b) corrupção de memória e firmware pendentes de isolamento seguro, (c) atualização upstream do Desktop Commander. Preservar resultados negativos — re-registro e ACL C:\Users ReadAttributes não corrigiram Captura. Consolidar evidências sem dizer que tudo foi resolvido.
