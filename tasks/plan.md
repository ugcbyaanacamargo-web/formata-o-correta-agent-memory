# Plano Canônico — FORMATAÇÃO CORRETA em 4 Fases

## Objetivo
Reconstruir do zero o Lenovo IdeaPad 320-15IKB Type 80YH, eliminando herança de Windows, armazenamento, configurações persistentes e pilhas de driver inadequadas, sem transformar a execução em investigação infinita.

## Contrato de execução
Cada fase usa **2 execuções do usuário**:

1. **Script 1 — Coleta completa da fase**
   - coleta tudo que pode mudar a solução daquela fase;
   - não altera o sistema, salvo escrita do próprio relatório;
   - produz ZIP único.

2. **Script 2 / resposta resolutiva — Solução completa da fase**
   - nasce somente depois de confrontar o ZIP com memória + fotos da placa + fontes oficiais atuais;
   - pode ser script, um único passe manual na BIOS/instalador, ou ambos quando a interface exige;
   - já inclui a validação necessária para fechar a fase.

**Não existe Script 3 por rotina.** Se a solução não puder ser decidida com o Script 1, a fase foi mal especificada e deve ser replanejada, não estendida indefinidamente.

## Regras globais
- Prioridade: solução.
- Sem DriversCloud/agregadores para escolher driver.
- Sem flash/reset destrutivo por ritual.
- Resetar estado configurável quando isso elimina herança; preservar firmware/chaves quando o estado atual já é o correto e resetá-lo causaria regressão.
- Toda operação destrutiva valida alvo/modelo antes de executar.
- Primeiro Windows utilizável nasce **offline**.
- Drivers são escolhidos por: hardware físico + Hardware ID + suporte exato do pacote + documentação oficial.
- Firmware é escolhido por: modelo exato + versão + pacote oficial + necessidade real.
- Eventos isolados só bloqueiam avanço se violarem o critério funcional/estrutural da fase.
- Dados pessoais que precisem sobreviver devem estar fora do SSD antes da Fase 2.

---

# FASE 1 — PLATAFORMA PERSISTENTE / BIOS / FIRMWARE / SEGURANÇA

## Resultado esperado
Notebook chega ao ponto pré-formatação com firmware e configurações persistentes em estado conhecido, correto e pronto para instalar.

## Script 1 — Coleta total atual
Uma única coleta, refletindo o estado **depois** das manutenções e resets já feitos.

Coletar:
- SMBIOS/DMI, Type/MTM, placa, BIOS e EC;
- BIOS Setup exposto por WMI e, quando não exposto, lista exata do que precisa ser fotografado;
- UEFI/Legacy, BootOrder, Boot####, Windows Boot Manager e resíduos NVRAM;
- Secure Boot: estado, SetupMode, PK/KEK/db/dbx ativos, defaults, status Microsoft 2023 e SBAT;
- TPM/PTT: fabricante, versão, readiness, ownership, provisionamento;
- Intel ME/CSME: firmware real quando ferramenta oficial de consulta conseguir expor, separado do driver MEI;
- CPU/ACPI/energia, Event 37, WHEA e eventos de firmware;
- SATA controller DEV_9D03, modo observável, driver realmente carregado e stack;
- RAM/SPD, GPU Intel/NVIDIA, VBIOS observável;
- dispositivos Firmware/PnP;
- estado AC/bateria somente quando altera operação de firmware.

## Pesquisa após o ZIP
Confrontar com Lenovo Type 80YH / BIOS 4WCN47WW, Microsoft UEFI/Secure Boot/TPM, Intel quando aplicável e as fotos físicas da NM-B242.

## Script 2 / solução
Executar **um único passe de normalização**:
- BIOS Setup defaults quando apropriado e imediatamente aplicar a matriz final correta;
- definir UEFI, SATA Mode, Secure Boot, PTT, Hyper-Threading, Virtualization, Fast Boot, PXE, SGX e demais opções reais da 4WCN47WW;
- limpar TPM pelo método suportado pelo Windows quando confirmado como parte do baseline limpo e sem dados criptográficos a preservar;
- remover somente entradas NVRAM realmente obsoletas;
- preservar Secure Boot 2023 atualizado; não usar Restore Factory Keys se isso rebaixar o estado ativo;
- reset de estado EC/power somente pelo procedimento seguro aplicável;
- não reflashear BIOS 4WCN47WW se já for a versão oficial correta e íntegra;
- não reflashear ME/EC/VBIOS sem pacote oficial exato e necessidade comprovada;
- fechar SATA Mode + driver-alvo para a instalação.

## Gate
PASS quando BIOS/UEFI e opções finais estão definidas; Secure Boot está operacional; TPM/PTT está no estado alvo; NVRAM não tem resíduo relevante; SATA Mode está fechado; nenhum firmware crítico exige ação pendente; Event 37/SBAT só permanecem como residual não bloqueante se a plataforma estiver funcional e os estados de segurança/energia estiverem válidos.

---

# FASE 2 — SSD / MÍDIA / APAGAMENTO / INSTALAÇÃO LIMPA

## Resultado esperado
Windows 10 Home Single Language 22H2 x64 oficial instalado em UEFI/GPT sobre SSD aprovado e sem partições/Windows antigo.

## Script 1 — Coleta e preparação decisória
Coletar:
- modelo exato do WD Green, serial, firmware, SMART/reliability, temperatura, erros e TRIM;
- link/controlador SATA;
- compatibilidade do SSD com SANDISK Dashboard Secure Erase/Sanitize;
- confirmar firmware SSD atual contra o firmware oficial para o modelo exato;
- edição/licença Windows armazenada/ativada;
- hash/versão da mídia Microsoft preparada;
- presença dos drivers offline mínimos necessários para o instalador/primeiro boot.

## Pesquisa após o ZIP
Validar firmware SSD, método oficial de Secure Erase/Sanitize, mídia Microsoft Windows 10 22H2, edição correta da licença e necessidade ou não de carregar driver de storage no Setup.

## Script 2 / solução
Sequência única:
1. se suportado, executar Secure Erase/Sanitize oficial do SSD;
2. se não suportado, usar instalação limpa Microsoft com remoção total das partições do SSD-alvo;
3. inicializar pelo pendrive em UEFI;
4. instalar somente no espaço não alocado;
5. deixar Setup criar EFI/MSR/Windows/Recovery;
6. manter rede desconectada;
7. não restaurar backup/configuração antiga;
8. criar conta local temporária para construir a baseline offline;
9. não liberar Windows Update.

## Gate
PASS quando SSD e firmware estão aprovados; instalação/partições antigas foram eliminadas; Windows novo inicializa em UEFI/GPT; continua offline; nenhuma restauração antiga ocorreu.

---

# FASE 3 — BASELINE DE DRIVERS OFFLINE

## Resultado esperado
Todos os dispositivos críticos possuem a pilha correta antes de qualquer atualização automática pela Internet.

## Script 1 — Raio-X pós-instalação offline
Coletar Hardware IDs/PnP, drivers carregados/provider/INF, chipset/PCH/ACPI, SATA/storage, MEI, Serial IO, Intel HD 620, NVIDIA 940MX, LAN, Intel 3165 WLAN + Bluetooth, áudio, card reader, USB/Type-C, touchpad, câmera, dispositivos desconhecidos, Secure Boot/PTT e eventos de boot/WHEA/ACPI/storage/PnP.

## Pesquisa após o ZIP
Escolher cada pacote por esta ordem:
1. Lenovo exato para Type 80YH/modelo quando o pacote realmente declara compatibilidade;
2. fabricante do componente quando o pacote OEM não cobre o Hardware ID/versão necessária;
3. Microsoft inbox quando for a opção oficialmente adequada.

Proibido escolher pacote apenas porque "instala".

## Script 2 / solução
Instalar em ordem coerente a baseline decidida: chipset INF; MEI; Serial IO / ACPI / Lenovo VPC quando aplicáveis; storage; Intel Graphics; NVIDIA; LAN; WLAN/Bluetooth; áudio; card reader; touchpad e demais dispositivos necessários.

O script valida Hardware ID antes de cada pacote, registra antes/depois, reinicia quando necessário, bloqueia temporariamente substituição automática de drivers e valida Device Manager e driver realmente carregado.

## Gate
PASS quando não existe falha crítica de PnP; storage correto está carregado; gráficos híbridos estão corretos; rede/áudio/controladores internos estão coerentes; nenhum driver crítico veio de updater genérico.

---

# FASE 4 — INTERNET CONTROLADA / ESU / AUDITORIA FINAL

## Resultado esperado
Sistema atualizado, ativado, estável e comprovadamente igual ao baseline definido.

## Script 1 — Auditoria antes da liberação completa
Com políticas de driver ainda controladas, coletar ativação/licença, elegibilidade/estado ESU, build/servicing, Windows Update disponível, Secure Boot/dbx, candidatos de driver/firmware, estado de Store/OneDrive/restore, PnP, WHEA, storage, ACPI, Event 37 e eventos de segurança.

## Pesquisa após o ZIP
Comparar com Microsoft release health/ESU atual da data da execução, Lenovo 80YH e fornecedores de componente somente quando houver necessidade.

## Script 2 / solução final
- liberar Internet de forma controlada;
- ativar Windows;
- inscrever/revalidar ESU quando necessário;
- instalar updates de segurança/servicing oficiais;
- manter drivers críticos protegidos contra substituição não aprovada;
- instalar somente atualização de driver/firmware escolhida pela pesquisa;
- criar/usar a conta nova sem restaurar o PC antigo;
- impedir restauração automática antiga do OneDrive/Windows Backup;
- executar auditoria final completa.

## Gate global
Comparar **COMO DEVERIA ESTAR × COMO FICOU** para BIOS/UEFI, Secure Boot, TPM/PTT, EC/ME, SATA/SSD, CPU/energia, RAM, Intel HD 620 + NVIDIA 940MX, LAN/WLAN/Bluetooth, áudio/card reader/USB/PCIe/touchpad/câmera, Windows, drivers carregados, Device Manager, WHEA/Event Viewer, SFC/DISM, Windows Update/ESU e ativação.

A reconstrução só termina com PASS global.

---

# Base física que governa o plano
- Lenovo IdeaPad 320-15IKB, Type 80YH.
- PCB NM-B242 Rev.1.0.
- Intel Core i7-7500U / Intel HD Graphics 620.
- NVIDIA N16S-GTR-S-A2 / GeForce 940MX, 4 GB VRAM observados pelo sistema.
- Intel Dual Band Wireless-AC 3165 / 3165NGW, FRU 00JT537.
- RAM: 16 GB em um único SO-DIMM, FRU 01FR302, P/N físico SM30N449903.
- BIOS SPI UC3: Winbond 25Q64FVSIG.
- EC UE1: IT8586E / 1733-FXA / S0QEEA.
- U26: Realtek RTS5449.
- PU402: BQ24710.
- controlador ON NCP81216.
- WD Green SATA 1 TB, firmware observado 42077100.

## Estado histórico já aproveitado
- limpeza interna e pasta térmica concluídas;
- BIOS 4WCN47WW observada;
- Secure Boot ON e migração Microsoft 2023 já observada como atualizada;
- Intel PTT/TPM 2.0 confirmado;
- storage já apresentou WHEA histórico e depois estabilizou com pilha Intel;
- Event 37 persistiu após reset BIOS/EC em coleta posterior;
- Windows antigo já teve corrupção de servicing, depois ficou íntegro; ele será eliminado, não reparado;
- primeiro boot da nova instalação será offline.

## Fontes oficiais de referência
- Lenovo: página de drivers Type 80YH e BIOS 4WCN47WW.
- Microsoft: mídia/instalação limpa, TPM, Secure Boot 2023, Windows 10 22H2/ESU.
- SANDISK/WD: firmware WD Green e Secure Erase/Sanitize.
- Intel/NVIDIA/Realtek: somente para componente/Hardware ID quando necessário.

## Próxima ação
Construir o **Script 1 da Fase 1** com base nesta especificação e nas coletas anteriores, sem repetir comandos pingados.