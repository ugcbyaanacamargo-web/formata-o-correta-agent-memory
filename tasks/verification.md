# Verification

## Gate geral
Antes de concluir uma tarefa complexa:
- [ ] O objetivo do usuário foi realmente atingido?
- [ ] A ação foi validada por teste, dado, fonte ou resultado observável?
- [ ] As fontes necessárias foram consultadas?
- [ ] A memória antiga foi confrontada com as novas evidências?
- [ ] O modelo do sistema foi atualizado se as relações mudaram?
- [ ] O próximo agente conseguiria continuar daqui sem recomeçar do zero?

## Gate específico — reconstrução limpa

### Cobertura pré-formatação
- [ ] Placa-mãe/plataforma tratada como conjunto.
- [ ] BIOS/UEFI e efeito do F9 definidos por fonte/evidência.
- [ ] NVRAM/boot tratados separadamente.
- [ ] Secure Boot + PK/KEK/db/dbx definidos.
- [ ] TPM/PTT definido separadamente.
- [ ] Intel ME/CSME e EC considerados.
- [ ] PCH/chipset e ACPI considerados.
- [ ] CPU/microcode considerados quando relevante.
- [ ] RAM/SPD testados/aprovados.
- [ ] Intel HD 620 e NVIDIA 940MX/VBIOS considerados.
- [ ] SSD/firmware/NAND/controladora aprovados.
- [ ] Cadeia SATA completa validada.
- [ ] SATA Mode decidido por evidência específica do 80YH.
- [ ] Ethernet/NVM/PXE quando aplicável considerados.
- [ ] Wi‑Fi/NVM/calibração/firmware considerados.
- [ ] Bluetooth considerado.
- [ ] Áudio, card reader, USB/Type-C, PCIe, touchpad, câmera e ACPI onboard considerados.

### Antes de instalar Windows
- [ ] Nenhum componente crítico falhou no gate físico.
- [ ] Operações destrutivas possuem método oficial e pré-requisitos.
- [ ] Secure Boot está em estado operacional, não deixado sem chaves por acidente.
- [ ] SSD está aprovado e sanitizado conforme o método escolhido.
- [ ] SATA Mode e driver correspondente estão definidos.
- [ ] Mídia Microsoft oficial está pronta.
- [ ] Baseline de drivers offline está definida.
- [ ] Instalação inicial ocorrerá sem restauração de conta/backup antigo.

### Primeiro boot offline
- [ ] UEFI confirmado.
- [ ] Secure Boot confirmado.
- [ ] TPM/PTT confirmado.
- [ ] SSD correto detectado.
- [ ] controlador SATA correto.
- [ ] driver de armazenamento realmente carregado confirmado.
- [ ] nenhum reboot pendente de troca de driver.
- [ ] Device Manager sem falhas críticas.
- [ ] drivers críticos correspondem à baseline.
- [ ] Windows Update ainda não sobrepôs drivers.
- [ ] nenhuma restauração de conta antiga ocorreu.
- [ ] OneDrive antigo não foi sincronizado.

### Gate final
- [ ] Estado final comparado com “como deveria estar”.
- [ ] Nenhuma dependência crítica permanece aberta.
- [ ] WHEA/Event Viewer não mostram falha estrutural incompatível com conclusão.
- [ ] Integridade do Windows validada.
- [ ] Memória, decisões e relações foram consolidadas no GitHub.

Se qualquer item essencial falhar, a fase correspondente permanece aberta.
