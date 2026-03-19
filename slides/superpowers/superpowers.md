
# 🧭 1. Abertura

## Slide: O que é o Superpowers

* Um conjunto de **skills para o Claude Code**
* Dá “super poderes” ao agente

👉 Na prática:

* Ele deixa de ser só um gerador de código
* Passa a seguir um **processo estruturado de desenvolvimento**

---

## Slide: Origem e adoção

* Inicialmente um projeto open-source
* Foi adotado oficialmente pelo Claude Code
* Hoje disponível no marketplace oficial

---

## Slide: Como instalar

```bash
/plugin install superpowers@claude-plugins-official
```

---

# 🧭 2. Quando usar (ou não usar)

## Slide: Quando usar Superpowers?

* Se for algo muito pequeno
  → faça direto

* Para todo o resto
  → use Superpowers

---

## Pontos

* Mesmo features pequenas se beneficiam
* Brainstorm evita problemas antes de acontecer

---

## Slide: Custo (tokens e complexidade)

* Fluxo enxuto
* Menor que SDD
* Baixo overhead

👉 Conclusão:

> Vale usar até para tarefas pequenas

---

# ⚙️ 3. Formas de uso

## Slide: Modo guiado

```bash
/using-superpowers
```

* Guia automático pelo fluxo
* Ideal para uso cotidiano

---

## Slide: Modo manual

```bash
/superpowers:brainstorm
/superpowers:write-plan
/superpowers:execute-plan
```

---

## Boas práticas

* Cada etapa gera um `.md`
* Use nova sessão entre etapas
* Passe o markdown anterior como contexto

---

# 🧠 4. O que cada etapa faz

---

## Slide: Brainstorm

**O agente:**

* Faz perguntas
* Define escopo
* Escolhe stack
* Cria uma spec clara

👉 Aqui você NÃO escreve código

---

**Use quando:**

* Início de qualquer feature
* Dúvida de abordagem
* Refatorações

---

**Muito útil para:**

* Detectar problemas cedo
* Decidir arquitetura

---

**Subskills envolvidas**

* análise de requisitos
* exploração de soluções
* definição de escopo

---

## Slide: Write Plan

**O agente:**

* Quebra em tarefas pequenas
* Define ordem
* Sugere estrutura de arquivos
* Define critérios de validação

---

**Use quando:**

* Feature não trivial

---

**Muito útil para:**

* Evitar se perder
* Organizar execução

---

**Subskills envolvidas**

* decomposição de tarefas
* planejamento incremental
* critérios de aceite

---

## Slide: Execute Plan

**O agente:**

* Implementa passo a passo
* Cria subagentes
* Aplica TDD quando possível
* Faz validações
* Pode revisar código

---

**Use quando:**

* Já existe um plano claro

---

**Muito útil para:**

* Velocidade
* Consistência
* Menos erros

---

**Subskills envolvidas**

* subagent-driven development
* geração de código
* validação
* code review automático

---

# 🔁 5. Fluxo recomendado

## Slide: Fluxo

```text
brainstorm → plan → execute
```

---

## Boas práticas

* Não pular etapas
* Revisar antes de avançar
* Usar nova sessão
* Reutilizar os `.md`

---

# ⚡ 6. Uso no dia a dia

## Slide: Skills essenciais

### Debug

```bash
/superpowers:debug
```

* Investigar bugs
* Evitar tentativa e erro

---

### Code Review

```bash
/superpowers:requesting-code-review
```

* Antes de commit
* Antes de PR

---

### Finalização

* `branch-finishing`
* Preparação de entrega

---

# 🚀 7. Fluxo avançado

## Slide: Avançado (use quando necessário)

* debug
* code-review
* branch-finishing

---

## Observação

Worktrees:

* Eram úteis
* Hoje menos necessárias com:

```bash
claude --worktree
```

---

# 🧠 8. Mensagem final

## Slide: Ideia principal

Superpowers não é sobre comandos.

É sobre:

> seguir um processo antes de codar

---

## Benefícios

* Melhor decisão
* Menos retrabalho
* Código mais consistente

---

## Regra simples

* Precisa pensar → use skill
* É trivial → faça direto
