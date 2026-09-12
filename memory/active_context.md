# Active Context

## Objetivo atual

Antes de continuar o plano técnico de formatação, transformar este repositório em um **perfil operacional portátil e persistente** para o projeto FORMATAÇÃO CORRETA usando motores existentes:

- Hermes Agent = runtime;
- OpenViking = memória/contexto semântico;
- GitHub = fonte versionada e auditável.

## Estado atual

- GitHub conectado ao ChatGPT.
- Repositório identificado: `ugcbyaanacamargo-web/formata-o-correta-agent-memory`.
- Contrato local de skills já existe em [skills/](../skills/).
- gstack Workflows está disponível no host ChatGPT atual.
- Hermes Agent oficial foi estudado.
- OpenViking oficial foi estudado.
- Hermes possui integração OpenViking de primeira classe.
- Branch de adaptação ativa: `chatgpt/hermes-openviking-profile-20260906`.
- O PR da reconstrução/formatação permanece separado e deve continuar draft até este fundamento ser resolvido.

## Decisão de arquitetura

Não criar um motor próprio.

Preparar este GitHub como **Hermes Profile Distribution** especializada e manter compatibilidade conceitual com OpenViking para retrieval/memória progressiva.

Ver [ENGINE.md](../ENGINE.md).

## Fronteira atual

Concluir e revisar:

1. `distribution.yaml`;
2. `SOUL.md`;
3. contrato [AGENTS.md](../AGENTS.md);
4. roteamento [MEMORY_INDEX.md](../MEMORY_INDEX.md);
5. links entre canônicos;
6. política de memória privada vs versionada;
7. proveniência Hermes/OpenViking;
8. PR de adaptação do motor.

## Próxima ação após esta fase

Somente depois do gate do motor:

- consolidar/atualizar a branch da reconstrução limpa;
- iniciar pesquisa técnica da Fase 1 da formatação usando o novo contrato de retrieval, decisão e verificação.

## Regra de atualização

Atualizar este arquivo quando mudar:
- objetivo;
- fase;
- bloqueio;
- próxima ação;
- decisão operacional relevante.
