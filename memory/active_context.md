# Active Context

## Objetivo atual
Executar uma **reconstrução limpa da plataforma** do Lenovo IdeaPad 320-15IKB Type 80YH, e não apenas reinstalar o Windows.

## Resultado final esperado
O primeiro Windows utilizável só deve existir depois que as camadas anteriores ao sistema operacional estiverem em estado conhecido e correto, com armazenamento aprovado, segurança/firmware normalizados, modo SATA definido por evidência e drivers essenciais preparados de forma controlada.

## Estado atual
- GitHub conectado ao ChatGPT.
- Repositório de memória ativo: `ugcbyaanacamargo-web/formata-o-correta-agent-memory`.
- gstack Workflows carregado para autoplan, engineering review, investigação, guard/careful, review e retro.
- Skills locais do repositório carregadas: adaptive-orchestrator, planner, deep-investigator, memory-manager, knowledge-linker, template-engineer, phase-executor e verifier.
- Modelo-base do equipamento consolidado a partir da conversa e arquivos anteriores:
  - Lenovo IdeaPad 320-15IKB;
  - Type 80YH;
  - BIOS de referência usada no projeto: `4WCN47WW`;
  - EC de referência usado no projeto: `1.47`;
  - Intel Core i7-7500U;
  - 16 GB RAM;
  - Intel HD Graphics 620;
  - NVIDIA GeForce 940MX;
  - SSD WD Green 2.5" 1 TB.
- Secure Boot deve ser tratado como atualmente ligado, conforme instrução do usuário.
- O histórico já mostrou que uma instalação nova pode receber pilhas de driver incoerentes; portanto “Windows novo” não é sinônimo de “plataforma correta”.

## Princípio de trabalho
> Se um componente continua fisicamente no notebook depois que o SSD é apagado, ele entra na análise pré-formatação.

> “Funciona” não significa “está correto”. O estado final deve ser o correto para este modelo/hardware, sustentado por documentação, identificação real e teste.

## Próxima fronteira de decisão
Produzir a especificação pré-formatação com pesquisa profunda para decidir, antes de qualquer ação destrutiva:
1. comportamento real da BIOS 4WCN47WW e efeito exato do F9;
2. estado final correto de UEFI/Secure Boot/PTT;
3. sequência correta para TPM/PTT e PK/KEK/db/dbx;
4. SATA Mode correto para este 80YH e o SSD instalado;
5. método oficial atual para firmware e Secure Erase/Sanitize do WD Green;
6. testes de aprovação de RAM, SSD, PCH/controlador SATA e rede;
7. baseline de drivers essenciais a integrar/instalar offline.

## Regra de atualização
Atualizar este arquivo sempre que mudar:
- objetivo;
- fase atual;
- bloqueio;
- próxima ação;
- decisão operacional relevante.
