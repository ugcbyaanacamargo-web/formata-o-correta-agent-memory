# Knowledge Graph

Mapa legível de relações entre conceitos, componentes, causas, evidências e ações.

## Grafo atual

```text
[Reconstrução limpa da plataforma] --depende-de--> [Placa-mãe / firmware]
[Reconstrução limpa da plataforma] --depende-de--> [Hardware crítico aprovado]
[Reconstrução limpa da plataforma] --depende-de--> [Armazenamento aprovado e sanitizado]
[Reconstrução limpa da plataforma] --depende-de--> [Windows offline controlado]

[BIOS/UEFI] --controla/influencia--> [ACPI]
[BIOS/UEFI] --controla/influencia--> [SATA Mode]
[BIOS/UEFI] --relacionado-a--> [NVRAM]
[BIOS/UEFI] --relacionado-a--> [Secure Boot]

[Secure Boot] --contém--> [PK]
[Secure Boot] --contém--> [KEK]
[Secure Boot] --contém--> [db]
[Secure Boot] --contém--> [dbx]

[F9 Setup Defaults] --reseta--> [Opções configuráveis da BIOS]
[F9 Setup Defaults] --não-equivale-a--> [Limpeza total da plataforma]

[TPM/PTT] --separado-de--> [Secure Boot]
[TPM/PTT] --separado-de--> [F9 Setup Defaults]

[PCH/chipset] --influencia--> [SATA]
[PCH/chipset] --influencia--> [USB]
[PCH/chipset] --influencia--> [PCIe]

[SSD WD Green] --parte-de--> [Cadeia SATA]
[Controlador SATA] --parte-de--> [Cadeia SATA]
[PCH/chipset] --parte-de--> [Cadeia SATA]
[SATA Mode] --parte-de--> [Cadeia SATA]
[Driver de armazenamento] --parte-de--> [Cadeia SATA]
[StorPort] --parte-de--> [Cadeia SATA]

[Secure Erase/Sanitize] --remove--> [Dados/estado de mídia]
[Secure Erase/Sanitize] --não-corrige--> [Defeito físico do SSD]

[RAM defeituosa] --pode-causar--> [Corrupção nova]
[SSD/cadeia SATA defeituosos] --podem-causar--> [Corrupção nova]

[Hardware ID] --leva-a-selecionar--> [Driver Windows]
[Windows Update] --pode-reinstalar--> [Driver]
[Conta Microsoft antiga] --pode-restaurar--> [Configurações/backup]
[Conta nova] --não-remove--> [Identidade física do hardware]

[Primeiro boot offline] --reduz--> [Reintrodução automática de drivers]
[Baseline de drivers] --verifica/condiciona--> [Primeiro boot offline]
```
