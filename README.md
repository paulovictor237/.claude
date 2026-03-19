# PeveWave

Configuração pessoal do ambiente Claude Code.

## Setup

```bash
bash scripts/link-claude.sh
```

Cria symlinks de `wave/`, `AGENT.md`, `RTK.md` e `settings.json` para `~/.claude/`.

---

## Ferramentas

### RTK

Token-optimized CLI proxy para Claude Code (60–90% de economia).

- Docs: https://www.rtk-ai.app/#install

```bash
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
```

> Não execute `rtk init --global` se o `link-claude.sh` já tiver instalado o `RTK.md`.

---

### CodeGraph

Grafo semântico de código para navegação inteligente.

- Repo: https://github.com/colbymchenry/codegraph

```bash
npx @colbymchenry/codegraph
```

---

### ccstatusline

Status line para o Claude Code.

- Repo: https://github.com/sirmalloc/ccstatusline

```bash
npx -y ccstatusline@latest
```
