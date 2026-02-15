# Engenharia de Contexto para IA — Guia Completo

> **O que e este documento?**
> Um guia educacional que ensina como estruturar documentacao para que agentes de IA (Claude, Copilot, Cursor, etc.) trabalhem com precisao em projetos grandes. Todas as estrategias foram extraidas de um projeto real (PX-Nexus) e podem ser replicadas em qualquer codebase.

> **Para quem?**
> Desenvolvedores que ja usam IA no dia a dia e querem ir alem do "prompt bonito" — construindo um ecossistema de contexto que faz a IA entender seu projeto como um membro da equipe.

---

## 0. Mapa do Ecossistema AI-First

Antes de mergulhar nos detalhes, visualize onde cada tipo de documento vive em um projeto AI-First maduro. Cada no aponta para a secao do guia que explica aquele conceito:

```text
projeto/
├── CLAUDE.md                        # Visao Global (-> Secao 2: WHY-WHAT-HOW)
│                                    #   Stack, comandos, guidelines, guardrails
├── .claude/
│   ├── claude_init.md               # Template Universal (-> Secao 9: Novo Projeto)
│   ├── knowledge/                   # Doutrina (-> Secao 7: Agent Docs)
│   │   └── architecture.md          #   Decisoes arquiteturais profundas
│   ├── specs/                       # Checkpoints Ativos (-> Secao 5: CDD)
│   │   ├── feature-x.md            #   Spec em andamento
│   │   └── archive/                 #   Specs concluidas (memoria)
│   └── session_ledger.md            # Diario de Bordo (-> Secao 8: Handover)
│
├── apps/
│   ├── api/
│   │   └── CLAUDE.md                # Regras Locais da API (-> Secao 3: Camadas)
│   └── web/
│       ├── CLAUDE.md                # Regras Locais do Frontend (-> Secao 3)
│       └── agent_docs/              # Doutrina do Dominio (-> Secao 7)
│           ├── architecture.md      #   Como o roteamento funciona
│           └── development.md       #   Step-by-step para criar features
│
├── packages/
│   └── db/
│       └── CLAUDE.md                # Guardrails Criticos (-> Secao 4: Guardrails)
│
└── specs/                           # Regras de Negocio (-> Secao 5: CDD)
    └── feature-y.md                 #   Intencao > Implementacao
```

Esse mapa e seu indice mental. Quando quiser saber "onde coloco X?", volte aqui.

---

## 1. Introducao — O Problema

### Por que IAs erram em projetos grandes

Agentes de IA sao treinados em milhoes de repositorios publicos. Isso e uma faca de dois gumes:

1. **Perda de contexto**: Em projetos com dezenas de pastas e centenas de arquivos, a IA nao sabe *onde* esta o que importa. Ela le arquivos aleatoriamente, consome tokens desnecessarios e chega a conclusoes parciais.

2. **Padroes genericos**: Sem instrucoes explicitas, a IA aplica convencoes da internet — nao as do *seu* projeto. Se voce usa `snake_case` no banco e `camelCase` no TypeScript com `@map`, ela nao vai adivinhar isso.

3. **Deriva de contexto**: Em sessoes longas ou tarefas complexas, a IA gradualmente "esquece" decisoes anteriores. Uma feature que comecou alinhada termina inconsistente.

4. **Ausencia de guardrails**: A IA busca o caminho mais simples. Se `db push` resolve rapido, ela usa — mesmo que seu projeto exija migrations versionadas.

### O que e Engenharia de Contexto

Engenharia de Contexto e a pratica de **estruturar informacao de forma que agentes de IA consumam o contexto certo, no momento certo, com a profundidade certa**.

Nao se trata de escrever prompts melhores. Trata-se de criar um **ecossistema de documentacao** que funciona como a memoria externa da IA.

### A analogia

Pense no `CLAUDE.md` como o **manual de instrucoes do seu copiloto**. Quando voce entra em um carro novo, o GPS sabe navegar — mas nao sabe que voce prefere evitar pedagios, que a segunda marcha desse carro "engasga" e que o estacionamento do seu predio tem uma manobra especifica. O manual resolve isso.

A IA e o GPS. Seu `CLAUDE.md` e o manual de instrucoes especificas que transforma um navegador generico em um copiloto do *seu* projeto.

---

## 2. Fundamento: O Padrao WHY-WHAT-HOW

### A teoria

Todo `CLAUDE.md` eficaz responde tres perguntas, nesta ordem:

| Secao | Pergunta | Efeito na IA |
|-------|----------|-------------|
| **WHY** | *Para que este modulo existe?* | Delimita escopo — evita sugestoes fora do dominio |
| **WHAT** | *Como esta organizado?* | Da "visao espacial" — a IA localiza arquivos sem varrer o disco |
| **HOW** | *Quais comandos usar?* | Instrucoes operacionais — a IA executa sem inventar |

### Por que essa ordem funciona

Modelos de linguagem processam texto sequencialmente. O que aparece primeiro influencia mais o raciocinio subsequente. Ao comecar pelo **proposito** (WHY), voce ancora a IA no dominio correto antes que ela veja qualquer detalhe tecnico.

### Exemplo real: Root CLAUDE.md do PX-Nexus

```markdown
## WHY - Project Purpose
PX-Nexus is a full-stack monorepo for [domain]. Type-safe communication
between React frontend and NestJS API via tRPC.

## WHAT - Architecture
px-nexus/
├── apps/
│   ├── api/          # NestJS + Fastify + tRPC server
│   └── web/          # React 19 + Vite + TanStack Router
├── packages/
│   ├── db/           # Prisma ORM + PostgreSQL schemas
│   ├── ui/           # Shared React components (shadcn/ui)
│   ├── eslint-config/
│   └── typescript-config/
└── collections/      # Bruno API collections (versionadas)

**Stack**: pnpm workspaces, Turborepo, TypeScript 5.9, tRPC 11, Prisma 6

## HOW - Key Commands
pnpm nexus            # Start postgres + dev server (stops postgres on Ctrl+C)
docker compose up -d  # Start all services (web:3000, api:3001, db:5433)
pnpm build            # Build all packages
pnpm db:generate              # Generate Prisma client
pnpm db:migrate -- --name X   # Create migration (OBRIGATORIO - nunca use db:push!)
```

Observe:
- **WHY** — Uma frase. Menciona "type-safe communication via tRPC", que ancora toda decisao futura.
- **WHAT** — Arvore visual com comentarios inline. A IA sabe que `packages/db` contem Prisma sem precisar ler `package.json`.
- **HOW** — Comandos copiaveis. O comentario `OBRIGATORIO - nunca use db:push!` ja e um guardrail embutido.

### Exemplo real: packages/db/CLAUDE.md

O CLAUDE.md do banco segue o mesmo padrao, mas com profundidade especifica do dominio:

```markdown
## WHY - Purpose
Prisma ORM package providing type-safe database access, schema definitions,
and migrations for PostgreSQL.

## WHAT - Architecture
packages/db/
├── prisma/
│   ├── schema/             # Multi-file Prisma schema (one file per model)
│   │   ├── base.prisma     # generator + datasource
│   │   ├── user.prisma
│   │   └── ...
│   └── migrations/         # Migration history (VERSIONADO)
├── src/
│   ├── index.ts            # Exports prisma client + types
│   └── client.ts           # Prisma client singleton
└── seed.ts                 # Database seeding script

## HOW - Key Commands
pnpm db:generate              # Generate Prisma client (types)
pnpm db:migrate -- --name X   # Criar migration (OBRIGATORIO)
pnpm db:migrate:deploy        # Aplicar migrations (producao)
pnpm db:studio                # Open Prisma Studio GUI
```

### Anti-padrao: O arquivo unico gigante

Um erro comum e colocar tudo em um unico `CLAUDE.md` na raiz — regras de API, convencoes de banco, patterns de frontend, tudo junto. Problemas:

1. **Desperdicio de tokens**: Quando a IA trabalha no frontend, ela le regras de banco que sao irrelevantes.
2. **Confusao de escopo**: Regras de um dominio interferem no raciocinio de outro.
3. **Manutencao impossivel**: Um arquivo de 500 linhas ninguem atualiza.

A solucao e **documentacao em camadas** (Secao 3).

---

## 3. Estrategia 1 — Documentacao em Camadas (Context Layering)

### O conceito

Context Layering distribui o conhecimento em niveis hierarquicos. Cada nivel so e carregado quando a IA esta trabalhando naquele dominio.

```text
Nivel 1: Root CLAUDE.md        → Visao macro (sempre carregado)
Nivel 2: App-specific CLAUDE.md → Regras locais (carregado por proximidade)
Nivel 3: Agent Docs / Knowledge → Doutrina profunda (carregado sob demanda)
```

### Quando criar cada nivel

| Nivel | Crie quando... | Exemplos |
|-------|----------------|----------|
| **Root** | Projeto iniciado | Stack, comandos, guidelines globais |
| **App-specific** | Dominio tem regras proprias | API tem padroes de router; Web tem feature-based structure |
| **Agent Docs** | Conceito nao e dedutivel do codigo | Decisoes arquiteturais, workflows complexos |

### Exemplo real: PX-Nexus tem 5 CLAUDE.md + 2 agent_docs

```text
px-nexus/
├── CLAUDE.md                    # Nivel 1 — Stack, comandos, guidelines
├── apps/
│   ├── api/CLAUDE.md            # Nivel 2 — Patterns tRPC, NestJS modules
│   └── web/
│       ├── CLAUDE.md            # Nivel 2 — Feature-based, path aliases
│       └── agent_docs/          # Nivel 3 — Roteamento, dev workflow
│           ├── architecture.md
│           └── development.md
├── packages/db/CLAUDE.md        # Nivel 2 — Migrations, naming, guardrails
└── collections/CLAUDE.md        # Nivel 2 — Bruno collections, patterns
```

### Como isso economiza tokens

Quando a IA trabalha em `apps/web/`, ela carrega automaticamente:
1. O Root CLAUDE.md (Nivel 1) — sabe que e um monorepo com tRPC
2. O `apps/web/CLAUDE.md` (Nivel 2) — sabe que usa feature-based structure
3. Os agent_docs (Nivel 3) — se precisar, sabe como funciona o roteamento

Ela **nao** carrega o `packages/db/CLAUDE.md` — regras de migration sao irrelevantes para o frontend. Menos tokens consumidos = respostas mais precisas e mais baratas.

### Exercicio pratico

Mapeie seu projeto: quais dominios tem regras proprias que nao se aplicam ao resto? Para cada um, considere criar um `CLAUDE.md` local. Um bom indicador: se voce precisa explicar para um dev novo "aqui a gente faz diferente", a IA tambem precisa saber.

---

## 4. Estrategia 2 — Guardrails (Instrucoes Negativas)

### Por que IAs precisam de "NAO faca"

Modelos de linguagem sao otimistas por padrao. Eles buscam a solucao mais comum, mais rapida, mais "Stack Overflow". Isso significa que:

- Se `db push` resolve, a IA usa — ignorando que seu projeto exige migrations
- Se um `enum` do Prisma funciona, a IA cria — ignorando que voce usa Zod
- Se `any` compila, a IA aceita — ignorando suas regras de tipagem

**Guardrails sao instrucoes negativas explicitas que criam limites no raciocinio da IA.**

### Tecnicas de formatacao

Guardrails precisam de **destaque visual** para serem eficazes. A IA atribui mais peso a texto formatado:

| Tecnica | Exemplo | Efeito |
|---------|---------|--------|
| **Negrito** | **NUNCA use db:push** | Peso semantico elevado |
| **MAIUSCULO** | OBRIGATORIO, PROIBIDO | Interpretado como instrucao forte |
| **Bilinguismo** | Texto em PT-BR entre texto EN | Contraste que chama atencao (ver Secao 6) |
| **Prefixo de proibicao** | `NUNCA`, `PROIBIDO`, `NAO` | Aciona comportamento de restricao |

### Exemplo real: "NUNCA use db:push"

Do `packages/db/CLAUDE.md`:

```markdown
## REGRA CRITICA: SEMPRE USAR MIGRATIONS

**PROIBIDO:** `db:push` - Nunca usar para alteracoes de schema!

**OBRIGATORIO:** Toda alteracao de tabela DEVE ser via migration:

pnpm db:migrate -- --name add_user_phone_field

**Por que migrations?**
- Historico versionado de alteracoes
- Reproduzivel em qualquer ambiente
- Rollback possivel
- Auditoria de mudancas
- Obrigatorio para producao
```

Observe a estrutura: **proibicao explicita** → **alternativa obrigatoria** → **justificativa**. A IA nao so sabe o que nao fazer — sabe o que fazer no lugar e *por que*.

### Exemplo real: "NUNCA use enum no Prisma"

```markdown
## Critical Notes
- **NUNCA use `enum` no Prisma schema** - enums ficam apenas em codigo
  (Zod em `schemas.ts`). No banco, usar `String` + validacao na aplicacao
```

Este guardrail e poderoso porque:
1. Proibe o caminho "facil" (enum nativo do Prisma)
2. Indica a alternativa (Zod + String)
3. Indica *onde* (no arquivo `schemas.ts`)

### Como calibrar: especifico > generico

Guardrails genericos sao ignorados. Compare:

```markdown
# Ruim (generico demais)
- Siga boas praticas de banco de dados

# Bom (especifico e acionavel)
- **NUNCA use `db:push`** — sempre crie migrations
- **NUNCA use `enum` no Prisma** — use Zod em schemas.ts + String no banco
- Tabelas: plural, snake_case (users, role_permissions)
- Foreign keys: <tabela_singular>_id (role_id, user_id)
- Booleans: prefixo is_ (is_active, is_published)
```

### Exercicio pratico

Liste 3 erros que a IA ja cometeu no seu projeto (ou que um dev junior cometeria). Para cada um, escreva um guardrail com: proibicao + alternativa + justificativa.

---

## 5. Estrategia 3 — Spec-First / CDD (Checkpoint-Driven Development)

### O problema que resolve

Em tarefas complexas (features com multiplos arquivos, refactorings grandes), a IA sofre de **deriva de contexto**: ela comeca alinhada com seu plano, mas gradualmente se desvia conforme a sessao avanca e decisoes se acumulam.

O CDD usa especificacoes como "checkpoints de verdade tecnica" — documentos que a IA pode consultar para verificar se ainda esta no caminho certo.

### O conceito fundamental

| Artefato | O que diz |
|----------|-----------|
| **Codigo** | O que o sistema *faz* |
| **Spec** | O que o sistema *deveria fazer* |

Essa separacao e crucial. O codigo evolui, bugs aparecem, refactorings mudam a estrutura — mas a spec preserva a **intencao original**. Quando a IA consulta a spec, ela consegue distinguir "isso e um bug" de "isso e comportamento intencional".

### Workflow CDD

```text
1. Discovery    → Antes de codar, mapeie impactos e escreva a spec
2. Validation   → Revise o "contrato" de implementacao com a IA
3. Execution    → Implemente com a spec como guia de checkpoint
4. Pruning      → Apos testes, mova a spec para archive/
```

### Ciclo de vida de uma spec

```text
Criacao  →  Alinhamento  →  Implementacao  →  Arquivo

.claude/specs/feature-x.md  →  .claude/specs/archive/feature-x.md
```

Specs concluidas nao sao deletadas — sao **arquivadas**. Elas servem como memoria historica: em futuros refactorings, a IA pode consultar o arquivo para entender *por que* algo foi construido daquela forma.

### Quando usar CDD vs. quando e overkill

| Use CDD quando... | Nao use CDD quando... |
|--------------------|-----------------------|
| Feature toca 3+ arquivos | Fix de 1-2 linhas |
| Regras de negocio complexas | Refactor mecanico (rename, move) |
| Multiplas decisoes de design | Tarefa com escopo 100% claro |
| Sessao vai durar muito | Tarefa completa em < 10 minutos |

### Anatomia de uma boa spec

```markdown
# Feature: [Nome]

## Objetivo
[1-2 frases sobre o que a feature faz e por que existe]

## Regras de Negocio
- [Regra 1]
- [Regra 2]
- [Restricao importante]

## Impacto
- Arquivos afetados: [lista]
- Migrations necessarias: [sim/nao]
- Riscos: [o que pode quebrar]

## Criterios de Aceite
- [ ] [Criterio 1]
- [ ] [Criterio 2]
- [ ] [Criterio 3]
```

### Exercicio pratico

Escolha a proxima feature do seu backlog. Antes de implementar, escreva uma spec seguindo a anatomia acima. Peca a IA para revisar a spec e apontar pontos cegos. So depois comece a codar.

---

## 6. Estrategia 4 — Bilinguismo Estrategico

### A teoria

Modelos de linguagem sao treinados predominantemente em ingles. Isso significa que:

1. **Instrucoes tecnicas em ingles** sao interpretadas com mais precisao — a IA tem mais dados de treinamento nesse idioma para contextos de programacao.
2. **Instrucoes em portugues** criam um **contraste visual e semantico** que a IA interpreta como "regra da casa" — algo especifico deste projeto, nao um padrao generico.

### Como aplicar

| Tipo de conteudo | Idioma | Por que |
|-----------------|--------|---------|
| Nomes de secao, estrutura | Ingles | Universal, a IA navega naturalmente |
| Stack, comandos, code patterns | Ingles | Termos tecnicos perdem precisao traduzidos |
| Guardrails e proibicoes | Portugues | Contraste = peso. "NUNCA use db:push" e mais forte que "Never use db:push" |
| Justificativas de regras | Portugues | Explica o "por que" no idioma da equipe |
| Comentarios em codigo | Nenhum | Self-documenting code (sem comentarios) |

### Exemplo real: CLAUDE.md raiz do PX-Nexus

```markdown
## HOW - Key Commands                           ← Ingles (secao universal)
pnpm db:migrate -- --name X   # Create migration (OBRIGATORIO - nunca use db:push!)
                                                 ↑ Ingles (tecnico)      ↑ Portugues (guardrail)

## Critical Notes                               ← Ingles (secao universal)
- Bruno collections em collections/nexus-api/ - ver collections/CLAUDE.md
                      ↑ Portugues (instrucao contextual)
```

### Exemplo real: packages/db/CLAUDE.md

```markdown
## REGRA CRITICA: SEMPRE USAR MIGRATIONS        ← Portugues (titulo de guardrail)
**PROIBIDO:** `db:push`                          ← Portugues (proibicao)
**OBRIGATORIO:** Toda alteracao DEVE ser via migration  ← Portugues (obrigacao)

**Por que migrations?**                          ← Portugues (justificativa)
- Historico versionado de alteracoes
- Reproduzivel em qualquer ambiente
```

O padrao e consistente: **estrutura e tecnica em ingles, regras e restricoes em portugues**. Isso funciona porque a IA detecta a mudanca de idioma como um sinal de que "esta parte e especialmente importante para este projeto".

### Nota para equipes anglófonas

Se sua equipe trabalha em ingles, o bilinguismo nao se aplica diretamente. Mas o principio subjacente — **contraste visual para destacar regras criticas** — permanece valido. Use formatacao (negrito, MAIUSCULO, blocos de alerta) para criar o mesmo efeito.

---

## 7. Estrategia 5 — Agent Docs (Doutrina)

### Quando o CLAUDE.md nao basta

O CLAUDE.md e otimo para regras, comandos e estrutura. Mas alguns conceitos **nao podem ser deduzidos do codigo** nem expressos em regras simples:

- *Por que* a arquitetura foi desenhada assim?
- *Como* as pecas se conectam (fluxo de dados, hierarquia de componentes)?
- *Qual* o step-by-step para criar uma feature completa?

Esses conhecimentos abstratos vivem nos **Agent Docs** — documentos de doutrina que ensinam a IA *como pensar* sobre o projeto, nao apenas *o que fazer*.

### Onde colocar

```text
# Opcao 1: Dentro do app (proximo ao codigo)
apps/web/agent_docs/architecture.md
apps/web/agent_docs/development.md

# Opcao 2: Centralizado (para conhecimento cross-cutting)
.claude/knowledge/architecture.md
.claude/knowledge/design-patterns.md
```

A regra: se o conhecimento e **especifico de um app**, coloque junto do app. Se e **transversal ao projeto**, centralize em `.claude/knowledge/`.

### Exemplo real: architecture.md (Doutrina de Roteamento)

O `apps/web/agent_docs/architecture.md` do PX-Nexus explica como funciona a feature-based structure e as regras de roteamento:

```markdown
## Route Architecture Rules

### Routes are connectors, never business logic

// CORRECT - Route only imports from feature
import { SessionPage } from "@features/attend/pages/session";

export const Route = createFileRoute("/_authenticated/attend/$sessionId")({
  component: RouteComponent,
});

function RouteComponent() {
  const { sessionId } = Route.useParams();
  return <SessionPage sessionId={sessionId} />;
}

### Use FOLDERS for nested routes (not dots)

routes/_authenticated/monitoring/agents.tsx         # YES
routes/_authenticated/monitoring.agents.tsx          # NO
```

Sem este documento, a IA criaria rotas com logica de negocio inline (o padrao generico da internet). Com ele, a IA entende que **rotas sao conectores** e toda logica vive em `features/`.

### Exemplo real: development.md (Step-by-Step)

O `apps/web/agent_docs/development.md` funciona como um runbook:

```markdown
## Adding a New Feature

1. Create folder under src/features/[name]/
2. Add components/, pages/ (and optionally contexts/, hooks/)
3. Create route file(s) under src/routes/_authenticated/[name]/
4. Route file imports page from feature — no business logic in route

## Adding a New Route

- Use FOLDERS for nesting: routes/_authenticated/monitoring/queues/$queueId.tsx
- For layouts: create routes/_authenticated/[name].tsx with <Outlet />
- For index pages: routes/_authenticated/[name]/index.tsx
- routeTree.gen.ts is auto-generated — NEVER edit manually
```

Isso transforma uma tarefa ambigua ("crie uma feature de tickets") em uma sequencia deterministica que a IA segue sem inventar.

### Quando criar um Agent Doc

Pergunte-se: **"Se eu nao explicar isso, a IA vai adivinhar certo?"**

- Se sim → nao precisa de doc
- Se nao → crie um Agent Doc

Exemplos de temas que geralmente precisam de doutrina:
- Decisoes arquiteturais (por que monorepo? por que tRPC ao inves de REST?)
- Fluxos de dados (como o estado percorre a aplicacao)
- Convencoes nao-obvias (feature-based structure, separation of routes and logic)
- Workflows complexos (como criar uma migration + atualizar tipos + rebuild)

---

## 8. Estrategia 6 — Session Handover e SYNC ALERT

### O problema: sessoes que perdem raciocinio

Sessoes de IA tem limite de contexto. Em tarefas longas, o raciocinio acumulado — decisoes tomadas, caminhos descartados, dependencias descobertas — se perde quando a sessao reinicia.

### Session Ledger: O diario de bordo

O `session_ledger.md` e um documento vivo que registra o estado da tarefa entre sessoes:

```markdown
# Session Ledger

## Ultima atualizacao: 2025-01-15

### O que foi feito
- Criado schema de audit_logs em packages/db
- Migration gerada: create_audit_logs_table
- Router tRPC criado em src/trpc/routers/audit-log.ts

### O que falta
- [ ] Criar pagina de visualizacao em apps/web
- [ ] Adicionar filtros por data e usuario
- [ ] Testes de integracao

### Decisoes tecnicas
- Optamos por soft delete (is_deleted) ao inves de exclusao fisica
- Indices criados em created_at e user_id para queries frequentes
- Nao usamos enum para action_type — String + Zod validation
```

### Como usar na pratica

1. **Ao iniciar uma sessao**: A IA verifica se existe um `session_ledger.md` e retoma de onde parou
2. **Durante a sessao**: Atualiza o ledger conforme decisoes sao tomadas
3. **Ao finalizar**: Registra estado atual, pendencias e raciocinio

### SYNC ALERT: A regra de ouro

O SYNC ALERT e um mecanismo para manter documentacao sincronizada com o codigo. A regra:

> **Se alterou codigo, verifique se a documentacao precisa de atualizacao.**

Documentos que devem ser verificados apos mudancas:
- `.claude/knowledge/` — guias de arquitetura
- `.claude/specs/` — specs ativas
- `CLAUDE.md` (raiz ou local) — comandos e estrutura
- `agent_docs/` — doutrina de desenvolvimento

Na pratica, voce instrui a IA a executar esse check automaticamente:

```markdown
### Ao finalizar (Obrigatorio):

#### SYNC ALERT
Se alterou codigo, verifique se a documentacao precisa de atualizacao:
- .claude/knowledge/ — guias de arquitetura
- .claude/specs/ — specs ativas
- CLAUDE.md (raiz ou local) — comandos e estrutura
- Informe ao usuario qual documento foi sincronizado
```

### Por que funciona

Documentacao desatualizada e pior que nenhuma documentacao — ela engana. O SYNC ALERT transforma a atualizacao de docs de uma tarefa "que a gente faz depois" em um **step obrigatorio do workflow**. Como esta escrito no CLAUDE.md, a IA executa automaticamente.

---

## 9. Guia Pratico — Aplicando em um Novo Projeto

### Passo a passo para montar a estrutura AI-First do zero

#### Passo 1: Root CLAUDE.md (15 minutos)

Crie o `CLAUDE.md` na raiz do projeto com:

```markdown
## WHY - Project Purpose
[1-2 frases sobre o que o projeto faz]

## WHAT - Architecture
[Arvore de pastas principal — top 2 niveis]

**Stack**: [tecnologias principais]

## HOW - Key Commands
[Comandos de dev, build, test, database]

## Coding Guidelines
[3-5 regras de estilo do projeto]

## Critical Notes
[Guardrails — o que NUNCA fazer]
```

**Dica**: Se voce nao sabe o que colocar em Guidelines e Critical Notes, pense nos ultimos 5 code reviews que voce fez. O que voce pediu para mudar? Isso sao suas regras.

#### Passo 2: App-specific CLAUDE.md (10 minutos cada)

Para cada app ou pacote significativo, crie um CLAUDE.md local com:
- WHY do modulo especifico
- WHAT com arvore interna
- HOW com comandos locais
- Regras especificas do dominio

**Prioridade**: Comece pelo dominio que tem mais regras especificas (geralmente o banco de dados).

#### Passo 3: Guardrails criticos (5 minutos)

Adicione a cada CLAUDE.md as proibicoes mais importantes. Use o formato:

```markdown
- **NUNCA [acao proibida]** — [alternativa correta]. [Justificativa curta]
```

#### Passo 4: Agent Docs (quando necessario)

So crie Agent Docs quando perceber que a IA esta errando repetidamente em algo que nao e capturavel por uma regra simples. Nao crie antecipadamente — deixe a necessidade emergir.

#### Passo 5: CDD e Session Ledger (quando necessario)

Adote CDD para a primeira feature complexa (3+ arquivos). Crie o session_ledger na primeira sessao que ultrapassar 30 minutos.

### Ordem de prioridade

```text
1. Root CLAUDE.md           ← Faca AGORA (maior impacto imediato)
2. DB/infra CLAUDE.md       ← Faca logo (guardrails criticos)
3. App-specific CLAUDE.md   ← Faca esta semana
4. Guardrails refinados     ← Evolua conforme a IA erra
5. Agent Docs               ← Crie sob demanda
6. CDD + Session Ledger     ← Adote na proxima feature complexa
```

### Referencia

O arquivo `.claude/claude_init.md` do PX-Nexus e um template universal que pode ser copiado e adaptado para qualquer projeto. Ele ja contem a estrutura completa com placeholders preenchíveis.

---

## 10. Guia Pratico — Onboarding de Projeto Existente

### O desafio: projetos legados sem documentacao

Onboarding de um projeto existente e diferente de um projeto novo. Voce nao esta construindo do zero — esta **mapeando territorio existente**.

### Workflow de 5 passos

#### Passo 1 — Reconhecimento

Peca a IA para analisar a estrutura do projeto:

```text
Analise a estrutura do projeto e gere:
1. Arvore de pastas principal (top 2 niveis)
2. Stack tecnologica identificada
3. Comandos encontrados em package.json / Makefile / docker-compose
```

Nao edite nada neste passo. Apenas observe e valide o mapeamento.

#### Passo 2 — Esqueleto do CLAUDE.md

Com base no reconhecimento, gere o CLAUDE.md raiz:
- **WHY**: Inferido do README ou package.json description
- **WHAT**: Arvore de pastas real
- **HOW**: Comandos reais encontrados
- **Guidelines**: Inferido dos linters/configs existentes (.eslintrc, .prettierrc, tsconfig)

#### Passo 3 — Modularizacao

Para cada app/pacote significativo:
1. Crie CLAUDE.md local com arquitetura interna
2. Identifique guardrails criticos (configs de banco, deploy, etc)
3. Documente workflows especificos (ex: como criar uma migration)

#### Passo 4 — Specs retroativas

Para features complexas ja implementadas:
1. Identifique as principais regras de negocio no codigo
2. Gere specs retroativas em `.claude/specs/` para preservar a intencao original
3. Estas specs protegem contra refactorings que quebrem regras

#### Passo 5 — Validacao

Teste o contexto gerado:
1. Pergunte a IA **"O que este projeto faz?"** — deve responder com precisao
2. Peca uma tarefa simples — deve seguir os padroes sem instrucao extra
3. Ajuste os CLAUDE.md conforme necessario

### Dicas para projetos sem documentacao

- **Comece pelo `package.json`** — ele revela stack, scripts e dependencias
- **Leia os configs** — `.eslintrc`, `tsconfig.json`, `docker-compose.yml` revelam convencoes
- **Olhe o historico do git** — commits recentes mostram o ritmo e as areas ativas
- **Identifique os "centros de gravidade"** — pastas com mais arquivos sao os dominios principais

---

## 11. Checklist de Maturidade

Use este checklist para avaliar e evoluir a maturidade da documentacao AI-First do seu projeto. Cada nivel constroi sobre o anterior.

### Nivel 1 — Fundacao

O minimo para a IA ser util no projeto:

- [ ] `CLAUDE.md` raiz configurado (WHY / WHAT / HOW)
- [ ] Comandos de dev, build e teste documentados
- [ ] Coding guidelines definidas
- [ ] Critical notes (guardrails) explicitas

**Indicador de sucesso**: A IA sabe o que o projeto faz e usa os comandos corretos sem inventar.

### Nivel 2 — Modularidade

Contexto distribuido — menos tokens, mais precisao:

- [ ] `CLAUDE.md` local em cada app/pacote significativo
- [ ] Arvore de pastas documentada em cada CLAUDE.md
- [ ] Workflows especificos por dominio (API, Web, DB)

**Indicador de sucesso**: A IA segue patterns diferentes conforme o dominio (ex: feature-based no frontend, modulos NestJS na API).

### Nivel 3 — Memoria

A IA mantem continuidade entre sessoes e features:

- [ ] `.claude/knowledge/` com guias de arquitetura
- [ ] `.claude/specs/` sendo usado para CDD
- [ ] `.claude/session_ledger.md` para handover de sessoes

**Indicador de sucesso**: Ao iniciar uma nova sessao, a IA retoma de onde parou sem re-explicar o contexto.

### Nivel 4 — Doutrina

A IA opera quase autonomamente no projeto:

- [ ] Specs retroativas para features complexas existentes
- [ ] Convencoes de nomenclatura documentadas
- [ ] Padroes de design explicados em knowledge/
- [ ] Onboarding testado — IA responde com precisao sobre o projeto

**Indicador de sucesso**: A IA toma decisoes arquiteturais alinhadas com o projeto sem precisar de instrucoes extras para cada tarefa.

---

## Recapitulacao

| # | Estrategia | Problema que resolve | Ferramenta |
|---|-----------|---------------------|------------|
| 1 | Context Layering | Desperdicio de tokens, confusao de escopo | CLAUDE.md distribuidos |
| 2 | Guardrails | IA segue caminho "facil" ao inves do correto | Instrucoes negativas |
| 3 | CDD | Deriva de contexto em tarefas longas | Specs como checkpoints |
| 4 | Bilinguismo | Regras criticas passam despercebidas | Contraste EN/PT-BR |
| 5 | Agent Docs | Conhecimento abstrato nao dedutivel do codigo | Documentos de doutrina |
| 6 | Session Handover | Perda de raciocinio entre sessoes | Ledger + SYNC ALERT |

### A mensagem final

Engenharia de Contexto nao e sobre documentar tudo. E sobre documentar **o que a IA nao consegue inferir sozinha**, no formato que ela consume melhor, no lugar onde ela vai procurar.

Comece pelo Nivel 1 (Root CLAUDE.md). Evolua conforme a IA erra. Cada erro e um sinal de que falta contexto em algum lugar. Seu objetivo nao e perfeicao — e **reduzir progressivamente a distancia entre o que a IA faz e o que voce espera que ela faca**.
