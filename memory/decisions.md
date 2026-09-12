# Decisions

Registro de decisões que devem sobreviver entre sessões.

## Formato

### DEC-YYYYMMDD-NN — Título
**Contexto:**  
**Decisão:**  
**Por quê:**  
**Evidência usada:**  
**Consequências:**  
**Pode ser revertida quando:**  

---

## Decisões atuais

### DEC-20260906-01 — GitHub como memória viva
**Contexto:** Arquivos adicionados às Fontes do ChatGPT não devem ser tratados como cópias automaticamente sincronizadas.  
**Decisão:** Manter memória mutável neste repositório e usar as Fontes do Projeto principalmente para conteúdo estático.  
**Por quê:** Evita versões concorrentes de um mesmo arquivo de memória.  
**Consequências:** O agente deve consultar a versão atual no GitHub antes de usar memória operacional.

### DEC-20260906-02 — A meta é reconstrução limpa da plataforma
**Contexto:** Apagar partições ou reinstalar o Windows não altera todas as camadas persistentes do notebook.  
**Decisão:** Tratar a operação como reconstrução limpa da plataforma: hardware/firmware → armazenamento → Windows → internet/nuvem.  
**Por quê:** BIOS/UEFI, NVRAM, TPM/PTT, Secure Boot, Intel ME, EC, firmwares e defeitos físicos podem sobreviver e influenciar a instalação nova.  
**Evidência usada:** Conversa do projeto, auditorias anteriores e modelo consolidado do sistema.  
**Consequências:** O Windows só entra depois dos gates pré-boot.

### DEC-20260906-03 — Não preservar estado antigo apenas porque está funcional
**Contexto:** O objetivo é eliminar estado inadequado, não apenas recuperar funcionalidade.  
**Decisão:** Para cada camada, classificar a ação como RESETAR/LIMPAR, ATUALIZAR/REGRAVAR OFICIALMENTE, TESTAR/APROVAR ou SUBSTITUIR SE DEFEITUOSO.  
**Por quê:** “Aceitável” ou “funciona” não é critério de estado permanente correto.  
**Consequências:** Não usar reset/flash indiscriminado; cada operação precisa de método e critério próprios.

### DEC-20260906-04 — F9 não significa limpeza total da placa
**Contexto:** O histórico antigo tratou Setup Defaults como purificação total da placa-mãe.  
**Decisão:** Considerar F9 apenas como reset das opções configuráveis da BIOS até que o comportamento específico da 4WCN47WW seja documentado.  
**Por quê:** F9 não deve ser assumido como limpeza de TPM, Secure Boot keys, toda NVRAM, Intel ME, EC, VBIOS ou firmware do SSD.  
**Consequências:** TPM/PTT, Secure Boot e demais regiões persistentes têm fluxos separados.

### DEC-20260906-05 — Secure Boot deve voltar a estado operacional antes do Windows
**Contexto:** O objetivo inclui eliminar chaves/estado antigo quando aplicável.  
**Decisão:** Se houver reset de Secure Boot, não deixar a máquina permanentemente em Setup Mode ou sem chaves; restaurar Factory Keys e depois aplicar manutenção oficial compatível.  
**Consequências:** PK/KEK/db/dbx não serão tratados como simples “drivers para baixar depois”.

### DEC-20260906-06 — SSD sanitizado e SSD saudável são requisitos diferentes
**Contexto:** Secure Erase/Sanitize apaga dados, mas não repara NAND/controladora/link SATA defeituosos.  
**Decisão:** Aprovar o hardware de armazenamento antes de instalar; sanitização só depois/como parte do fluxo definido.  
**Consequências:** Se a unidade ou cadeia SATA falhar, substituir/corrigir antes do Windows.

### DEC-20260906-07 — SATA Mode não será escolhido por regra genérica
**Contexto:** O histórico antigo afirmou AHCI como obrigatório e RST como default sem prova específica suficiente.  
**Decisão:** Determinar o modo correto para o 80YH + BIOS 4WCN47WW + controlador físico + SSD real + driver correspondente.  
**Consequências:** Não instalar o Windows enquanto essa decisão estrutural estiver aberta.

### DEC-20260906-08 — Primeiro boot será construído offline
**Contexto:** Windows Update e identificação por Hardware ID podem recriar uma pilha inadequada logo após a instalação.  
**Decisão:** Preparar mídia oficial e baseline de drivers antes da instalação; primeiro boot sem internet e sem restauração de conta antiga.  
**Consequências:** Só liberar internet depois da baseline mínima e dos gates de primeiro boot.
