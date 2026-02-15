# CLAUDE.md — AI-First Universal Template

> **Uso:** Copie este template para o `CLAUDE.md` na raiz de qualquer projeto.
> Preencha os placeholders `[...]` e remova as seções que nao se aplicam.
> Este template consolida as melhores praticas de Engenharia de Contexto para agentes de IA.

---

## WHY - Project Purpose

[Descreva o proposito do projeto em 1-2 frases. Isso evita que a IA sugira solucoes fora do escopo.]

**Exemplos:**
- "Monorepo full-stack para gestao de logistica com tRPC e NestJS."
- "CLI para automacao de deploys em ambientes multi-cloud."
- "Biblioteca de componentes React para design system interno."

---

## WHAT - Architecture

[Mapa visual das pastas principais. Da "visao espacial" para a IA localizar arquivos sem buscas exaustivas.]

```text
project/
├── src/                # [Descreva]
├── tests/              # [Descreva]
├── docs/               # [Descreva]
└── ...
```

**Stack**: [Liste tecnologias principais. Ex: TypeScript, React, Node.js, PostgreSQL]

---

## HOW - Key Commands

[Comandos essenciais para dev, build e teste. A IA usa estes comandos diretamente.]

```bash
# Development
[comando]              # [descricao]

# Build
[comando]              # [descricao]

# Test
[comando]              # [descricao]

# Database (se aplicavel)
[comando]              # [descricao]
```

---

## Coding Guidelines

[Regras de estilo e padroes do projeto. Seja especifico — a IA segue padroes genericos da internet se voce nao instruir.]

**Exemplos de boas praticas:**
1. Functional React only (no classes)
2. No code comments — self-documenting code
3. Minimal logging/console output
4. Simplicity first — YAGNI
5. snake_case for database columns, camelCase for TypeScript
6. No barrel exports (index.ts re-exports)

---

## Critical Notes (Guardrails)

[Instrucoes negativas explicitas. IAs tendem a seguir o caminho mais "simples" — force aderencia ao SEU projeto.]

**Exemplos de guardrails:**
- NUNCA use `db push` em producao — sempre crie migrations
- NUNCA use `any` no TypeScript — sempre tipar explicitamente
- NUNCA commite arquivos `.env` — use `.env.example` como referencia
- NUNCA modifique arquivos de migracao ja aplicados
- Ao criar tabelas: use snake_case no banco e @map para camelCase no ORM

---

## AI-First Context Architecture

Distribua o conhecimento em camadas para reduzir consumo de tokens e evitar confusao:

```text
project/
├── CLAUDE.md                   # Visao Global (este arquivo)
├── .claude/
│   ├── knowledge/              # Doutrina: arquitetura profunda, guias de design
│   ├── specs/                  # Checkpoints ativos (specs de features)
│   │   └── archive/            # Specs concluidas (memoria historica)
│   └── session_ledger.md       # Handover de sessoes (diario de bordo)
├── apps/
│   ├── api/
│   │   └── CLAUDE.md           # Regras locais da API
│   └── web/
│       └── CLAUDE.md           # Regras locais do frontend
├── packages/
│   └── db/
│       └── CLAUDE.md           # Regras locais do banco (guardrails criticos)
└── specs/                      # Regras de negocio (o que construir)
```

### Principios de Modularidade

1. **Root CLAUDE.md**: Visao macro, stack global, comandos de orquestracao
2. **App-specific CLAUDE.md**: Arquitetura interna, regras de ouro do dominio, comandos locais
3. **knowledge/**: Explica conceitos abstratos que a IA nao consegue deduzir do codigo
4. **specs/**: Separa Intencao (negocio) de Implementacao (codigo)

### Padrao Semantico (WHY-WHAT-HOW)

Todo `CLAUDE.md` deve seguir este padrao:
- **WHY**: Proposito do modulo — evita sugestoes fora do escopo
- **WHAT**: Mapa de pastas — da visao espacial para a IA
- **HOW**: Comandos e workflows — instrucoes operacionais
- **Guidelines**: Regras de estilo e padroes de codigo
- **Critical Notes**: Proibicoes explicitas e guardrails

---

## Spec-First Development (CDD)

O **Checkpoint-Driven Development** usa especificacoes como "checkpoints de verdade tecnica" para evitar deriva de contexto em tarefas complexas.

### Workflow

1. **Discovery**: Antes de codar, mapeie impactos e escreva a spec em `.claude/specs/`
2. **Validation**: Revise o "contrato" de implementacao com a IA
3. **Execution**: Implemente seguindo a spec como guia de checkpoint a cada arquivo alterado
4. **Pruning**: Apos implementacao e testes, mova a spec para `.claude/specs/archive/`

### Ciclo de Vida de uma Spec

```
Criacao → Alinhamento → Implementacao → Arquivo
```

- **Codigo** diz o que o sistema FAZ
- **Spec** diz o que o sistema DEVERIA FAZER
- Nunca apague specs — elas protegem regras de negocio em futuros refactorings

---

## Instructions for AI Agents (Behavioral Hook)

**Voce e um AI-First Architect operando sob CDD.**

### Ao iniciar uma tarefa:

1. Verifique se existe `.claude/session_ledger.md` para retomar raciocinio anterior
2. Analise se o contexto necessario esta presente
3. Se faltar um `CLAUDE.md` local ou uma spec, sugira a criacao antes de prosseguir
4. Use `CLAUDE.md` locais em subpastas antes de ler arquivos cegamente

### Durante a execucao:

1. **Search First**: Valide existencia e relevancia de arquivos antes de le-los
2. Use a spec ativa como checkpoint obrigatorio
3. Siga os guardrails definidos nas Critical Notes
4. Mantenha bilinguismo: Ingles para tecnica, Portugues para guardrails

### Ao finalizar (Obrigatorio):

#### SYNC ALERT
Se alterou codigo, verifique se a documentacao precisa de atualizacao:
- `.claude/knowledge/` — guias de arquitetura
- `.claude/specs/` — specs ativas
- `CLAUDE.md` (raiz ou local) — comandos e estrutura
- Informe ao usuario qual documento foi sincronizado

#### AI-First Suggestion
Sempre sugira o proximo passo para melhorar a documentacao de contexto:
- "Notei que a logica de X e complexa. Sugiro criarmos um `knowledge/architecture.md`."
- "Esta feature nao tem spec. Quer que eu gere `specs/nome-da-feature.md`?"
- "O `CLAUDE.md` local de `apps/api` esta desatualizado. Quer que eu atualize?"

### Session Handover

Ao final de tarefas complexas, atualize `.claude/session_ledger.md` com:
- O que foi feito
- O que falta fazer
- Decisoes tecnicas tomadas (o raciocinio)

---

## Onboarding Mode (Projeto Existente)

Workflow para mapear projetos legados e torna-los AI-First:

### Passo 1 — Reconhecimento
```
Analise a estrutura do projeto e gere:
1. Arvore de pastas principal (top 2 niveis)
2. Stack tecnologica identificada
3. Comandos encontrados em package.json / Makefile / docker-compose
```

### Passo 2 — Esqueleto do CLAUDE.md
```
Com base no reconhecimento, gere o CLAUDE.md raiz preenchido com:
- WHY: Inferido do README ou package.json description
- WHAT: Arvore de pastas real
- HOW: Comandos reais encontrados
- Guidelines: Inferido dos linters/configs existentes (.eslintrc, .prettierrc, tsconfig)
```

### Passo 3 — Modularizacao
```
Para cada app/pacote significativo:
1. Crie CLAUDE.md local com arquitetura interna
2. Identifique guardrails criticos (configs de banco, deploy, etc)
3. Documente workflows especificos (ex: como criar uma migration)
```

### Passo 4 — Specs Retroativas
```
Para features complexas ja implementadas:
1. Identifique as principais regras de negocio no codigo
2. Gere specs retroativas em /specs para preservar a intencao original
3. Estas specs protegem contra refactorings que quebrem regras
```

### Passo 5 — Validacao
```
Teste o contexto gerado:
1. Pergunte a IA "O que este projeto faz?" — deve responder com precisao
2. Peca uma tarefa simples — deve seguir os padroes sem instrucao extra
3. Ajuste os CLAUDE.md conforme necessario
```

---

## AI-First Maturity Checklist

Checklist progressivo de adocao — marque conforme evolui:

### Nivel 1 — Fundacao
- [ ] `CLAUDE.md` raiz configurado (WHY / WHAT / HOW)
- [ ] Comandos de dev, build e teste documentados
- [ ] Coding guidelines definidas
- [ ] Critical notes (guardrails) explicitas

### Nivel 2 — Modularidade
- [ ] `CLAUDE.md` local em cada app/pacote significativo
- [ ] Arvore de pastas documentada em cada CLAUDE.md
- [ ] Workflows especificos por dominio (API, Web, DB)

### Nivel 3 — Memoria
- [ ] `.claude/knowledge/` com guias de arquitetura
- [ ] `.claude/specs/` sendo usado para Checkpoint-Driven Development
- [ ] `.claude/session_ledger.md` para handover de sessoes

### Nivel 4 — Doutrina
- [ ] Specs retroativas para features complexas existentes
- [ ] Convencoes de nomenclatura documentadas
- [ ] Padroes de design explicados em knowledge/
- [ ] Onboarding testado — IA responde com precisao sobre o projeto
