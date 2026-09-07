# Verification

## Gate geral

Antes de concluir uma tarefa complexa:

- [ ] objetivo do usuário realmente atingido;
- [ ] ação validada por teste, dado, fonte ou resultado observável;
- [ ] fontes necessárias consultadas;
- [ ] memória antiga confrontada com nova evidência;
- [ ] relações/modelo atualizados quando necessário;
- [ ] próximo agente consegue continuar sem recomeçar.

## Gate do motor Hermes/OpenViking

### Arquitetura
- [x] Motor existente escolhido, sem reinventar runtime.
- [x] Hermes Agent oficial usado como referência de runtime.
- [x] OpenViking oficial usado como referência de context DB.
- [x] Integração Hermes ↔ OpenViking confirmada oficialmente.
- [x] GitHub definido como plano de controle versionado.

### Distribuição
- [x] `distribution.yaml` existe.
- [x] `SOUL.md` existe.
- [x] `.gitignore` bloqueia credenciais/runtime privado.
- [x] `distribution_owned` inclui apenas conhecimento/contrato que deve viajar.
- [x] `memories/` e `sessions/` não são confundidos com `memory/`.

### Contexto/retrieval
- [x] `MEMORY_INDEX.md` roteia para canônicos.
- [x] escopo real de `SOUL.md` vs `AGENTS.md` validado na documentação Hermes.
- [x] bootstrap do profile funciona conceitualmente mesmo fora do CWD do repositório: SOUL instrui retrieval do HERMES_HOME + orchestrator.
- [x] links relativos principais apontam para caminhos existentes.
- [x] L0/L1/L2 adotado como estratégia de carregamento, sem sidecars falsos.
- [x] Source Ledger registra fontes do motor.
- [x] Knowledge Graph registra relações do motor.
- [x] política de conflito entre memória de runtime e GitHub definida.

### Estado real
- [x] GitHub conectado no host atual.
- [x] gstack Workflows disponível no host atual.
- [x] documentação/branch do perfil Hermes preparada.
- [ ] Hermes instalado/rodando localmente — **não afirmado**.
- [ ] OpenViking server configurado — **não afirmado**.
- [x] estratégia GitHub↔Hermes definida sem segredos; configuração/autenticação efetiva permanece propositalmente para o runtime.

### Promoção
- [x] diff final revisado;
- [x] draft PR #2 criado;
- [x] PR #1 da formatação linkado como dependente;
- [ ] merge autorizado/revisado.

O motor só é considerado **promovido** quando os itens de promoção passarem. A preparação estrutural pode estar pronta sem afirmar que o runtime local já foi instalado.
