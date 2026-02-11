---
description: Faz merge do conteúdo da worktree atual de volta para sua branch de origem
argument-hint: [target-branch]
---

# Merge Worktree

Faz merge do conteúdo da worktree atual de volta para a branch de origem, com detecção automática da branch de destino e confirmação do usuário.

## Fluxo de Execução

### 1. Verificar Estado Atual

Primeiro, verificar se estamos em um worktree (não no repositório principal):

```bash
# Obter informações de todos os worktrees
git worktree list --porcelain

# Obter diretório atual
pwd

# Obter branch atual
git branch --show-current
```

**Regras:**
- Se estamos no worktree principal (normalmente o primeiro listado), ABORTAR com mensagem: "Este comando deve ser executado de dentro de um worktree secundário, não do repositório principal."
- Se não estamos em um worktree, ABORTAR com mensagem: "Não foi possível detectar informações do worktree."

### 2. Detectar Branch de Destino

Se o usuário forneceu `[target-branch]` como argumento, usar essa branch.

Caso contrário, detectar automaticamente:

```bash
# Verificar se existe branch 'main'
git show-ref --verify --quiet refs/heads/main && echo "main" || echo ""

# Se não existir 'main', verificar 'master'
git show-ref --verify --quiet refs/heads/master && echo "master" || echo ""

# Obter a branch default do remote
git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'
```

**Usar a primeira branch encontrada como sugestão.**

Depois de detectar a branch sugerida, usar `AskUserQuestion` para confirmar:

- **Question:** "Confirme a branch de destino para o merge"
- **Header:** "Branch destino"
- **Options:**
  1. `{branch-detectada}` (sugerida) - "Fazer merge na branch {branch-detectada}"
  2. "Outra branch" - "Especificar uma branch diferente"

Se o usuário escolher "Outra branch", perguntar novamente qual branch usar.

### 3. Verificar Mudanças Não Commitadas

Verificar se há mudanças não commitadas:

```bash
git status --porcelain
```

Se houver mudanças (output não vazio):

**Usar `AskUserQuestion` para pedir mensagem de commit:**

- **Question:** "Há mudanças não commitadas. Forneça uma mensagem de commit para salvá-las antes do merge."
- **Header:** "Commit message"
- **Options:**
  1. "WIP: Merge preparado para {target-branch}" - "Usar mensagem padrão"
  2. "Outra mensagem" - "Fornecer mensagem customizada"

Se o usuário escolher "Outra mensagem", solicitar a mensagem.

**Depois, commitar as mudanças:**

```bash
git add -A
git commit -m "{mensagem-escolhida}"
```

### 4. Preparar para o Merge

Obter o nome da branch atual do worktree (a branch que será merged):

```bash
WORKTREE_BRANCH=$(git branch --show-current)
```

### 5. Mudar para a Branch de Destino

Precisamos ir para a branch de destino para fazer o merge. Existem duas abordagens:

**Abordagem A (Recomendada):** Ir para o worktree principal

```bash
# Obter o caminho do worktree principal (primeira entrada em git worktree list)
MAIN_WORKTREE=$(git worktree list --porcelain | grep -m 1 "^worktree" | cut -d' ' -f2)

# Ir para o worktree principal
cd "$MAIN_WORKTREE"

# Fazer checkout da branch de destino
git checkout {target-branch}
```

**Abordagem B:** Usar git worktree add temporário

```bash
# Criar worktree temporário para a branch de destino
TEMP_DIR=$(mktemp -d)
git worktree add "$TEMP_DIR" {target-branch}
cd "$TEMP_DIR"
```

**Usar Abordagem A por padrão.**

### 6. Fazer o Merge

Executar o merge:

```bash
git merge "$WORKTREE_BRANCH" --no-ff
```

**Análise do resultado:**

- Se o merge for bem-sucedido (exit code 0), prosseguir para o passo 7
- Se houver conflitos (exit code != 0), executar:
  ```bash
  git merge --abort
  ```

  Depois, PARAR e reportar ao usuário:

  > ⚠️ **Conflitos de Merge Detectados**
  >
  > Não foi possível fazer merge automaticamente da branch `{WORKTREE_BRANCH}` para `{target-branch}`.
  >
  > **Próximos passos:**
  > 1. Vá para o worktree principal ou para a branch de destino
  > 2. Execute: `git merge {WORKTREE_BRANCH}`
  > 3. Resolva os conflitos manualmente
  > 4. Após resolver, execute: `git merge --continue`
  > 5. Execute o comando `/merge-worktree` novamente se desejar limpar o worktree

  ABORTAR execução aqui.

### 7. Merge Bem-Sucedido

Se o merge foi bem-sucedido, reportar:

> ✅ **Merge Concluído com Sucesso**
>
> A branch `{WORKTREE_BRANCH}` foi merged com sucesso em `{target-branch}`.
>
> **Commits integrados:**
> ```
> {output de: git log {target-branch}..{WORKTREE_BRANCH} --oneline}
> ```

### 8. Perguntar sobre Remoção do Worktree

Usar `AskUserQuestion`:

- **Question:** "Deseja remover o worktree '{WORKTREE_BRANCH}' agora que o merge foi concluído?"
- **Header:** "Limpar worktree"
- **Options:**
  1. "Sim, remover worktree" - "Remover o worktree e sua branch local"
  2. "Não, manter worktree" - "Manter o worktree para uso futuro"

Se o usuário escolher "Sim, remover worktree":

```bash
# Voltar para o worktree principal se ainda não estamos lá
MAIN_WORKTREE=$(git worktree list --porcelain | grep -m 1 "^worktree" | cut -d' ' -f2)
cd "$MAIN_WORKTREE"

# Obter o caminho do worktree a ser removido
WORKTREE_PATH=$(git worktree list --porcelain | grep -A2 "branch refs/heads/$WORKTREE_BRANCH" | grep "^worktree" | cut -d' ' -f2)

# Remover o worktree
git worktree remove "$WORKTREE_PATH" --force

# Opcional: Deletar a branch local (confirmar com usuário primeiro)
git branch -d "$WORKTREE_BRANCH"
```

Reportar:

> 🗑️ **Worktree Removido**
>
> O worktree `{WORKTREE_PATH}` foi removido com sucesso.
> A branch local `{WORKTREE_BRANCH}` foi deletada.

Se o usuário escolher "Não, manter worktree", apenas reportar:

> ℹ️ **Worktree Mantido**
>
> O worktree permanece disponível em: `{WORKTREE_PATH}`
> Você pode removê-lo manualmente quando desejar com: `git worktree remove {WORKTREE_PATH}`

### 9. Resumo Final

Exibir resumo final:

> ## 📋 Resumo da Operação
>
> - ✅ Branch merged: `{WORKTREE_BRANCH}` → `{target-branch}`
> - ✅ Commits integrados: {número de commits}
> - ✅ Worktree: {removido/mantido}
> - 📍 Branch ativa: `{target-branch}`
> - 📁 Diretório atual: `{pwd}`
>
> **Próximos passos sugeridos:**
> - Push das mudanças: `git push origin {target-branch}`
> - Verificar o resultado: `git log --oneline -5`

## Tratamento de Erros

**Erro: Não é um worktree**
- Verificar se `git worktree list` mostra múltiplos worktrees
- Verificar se estamos no worktree correto

**Erro: Branch de destino não existe**
- Listar branches disponíveis: `git branch -a`
- Pedir ao usuário para escolher uma branch válida

**Erro: Mudanças não commitadas não podem ser commitadas**
- Reportar arquivos problemáticos
- Sugerir commit manual ou uso de `git stash`

**Erro: Merge falha (não por conflitos)**
- Reportar erro completo
- Abortar merge: `git merge --abort`
- Sugerir investigação manual

## Notas Importantes

- **SEMPRE** usar `git merge --no-ff` para preservar histórico do worktree
- **SEMPRE** confirmar a branch de destino com o usuário antes de fazer merge
- **SEMPRE** parar em conflitos e deixar o usuário resolver
- **NUNCA** forçar operações destrutivas sem confirmação do usuário
- Se houver problemas, sempre dar ao usuário comandos para resolver manualmente
