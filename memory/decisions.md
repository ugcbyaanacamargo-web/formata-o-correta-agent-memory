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
