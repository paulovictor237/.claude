✦ A engenharia reversa das práticas de uso do Claude neste projeto revela uma estrutura de "Contexto em Camadas" extremamente eficiente. Os engenheiros não apenas deixaram instruções, mas criaram um ecossistema onde a IA entende não só o como, mas
o porquê de cada decisão.

Aqui estão as principais práticas identificadas que você pode replicar:

1. Estrutura de Documentação em Camadas (Contextualização Progressiva)
   O projeto usa arquivos CLAUDE.md como pontos de entrada de contexto, mas os segmenta por responsabilidade:

- Root `CLAUDE.md`: Visão macro do monorepo, stack tecnológica global e comandos de orquestração (Turborepo/Docker). Serve para dar o "mapa da mina".
- App-Specific `CLAUDE.md`: Cada aplicação (api, web, db) tem seu próprio arquivo com comandos locais, arquitetura de pastas interna e regras de ouro específicas daquele domínio.
- Agent Docs (`agent_docs/`): Documentação técnica profunda escrita especificamente para ser consumida por LLMs, detalhando padrões de design e fluxos complexos (ex: routing com TanStack Router).

2. O Padrão "WHY-WHAT-HOW"
   Todos os arquivos seguem uma estrutura semântica rigorosa que facilita o processamento pela IA:

- WHY (Purpose): Explica a razão de existir daquele módulo. Isso evita que a IA sugira soluções que fujam do propósito original.
- WHAT (Architecture): Um mapa visual (tree) das pastas, permitindo que a IA localize arquivos sem precisar varrer todo o disco.
- HOW (Key Commands): Comandos essenciais para rodar, testar e buildar.
- Critical Notes / Coding Guidelines: Onde moram as "regras de negócio" do código (ex: "Functional React only", "No code comments", "YAGNI").

3. "Guardrails" (Trilhos de Segurança)
   Eles usam instruções negativas e impositivas para evitar erros comuns de agentes:

- Instruções em Negrito/Maiúsculo: No packages/db/CLAUDE.md, há um aviso gritante: **IMPORTANT** DO NOT PUT MIGRATIONS ON....
- Proibições Explícitas: "NUNCA use db:push", "NUNCA use enum no Prisma schema". Isso corta o comportamento padrão da IA de sugerir a solução mais "simples" mas errada para o projeto.

4. Automação de Contexto para Comandos
   Eles incluíram comandos que ajudam a manter a sanidade do projeto:

- `pnpm nexus`: Um comando customizado que sobe o banco e o servidor e, ao fechar, limpa os recursos. Isso mostra uma preocupação em facilitar o fluxo de trabalho do desenvolvedor (e da IA).

5. Convenções de Nomenclatura Estritas
   O arquivo do banco de dados detalha exatamente como os mapeamentos entre TypeScript (camelCase) e PostgreSQL (snake_case) devem ser feitos usando @map. Isso garante que a IA gere código que siga o padrão do projeto na primeira tentativa.

---

Como aplicar isso nos seus projetos:

1.  Crie um `CLAUDE.md` na raiz: Foque na stack e no "como rodar".
2.  Crie `CLAUDE.md` em cada subprojeto: Detalhe a arquitetura de pastas e regras específicas.
3.  Seja explícito sobre o que NÃO fazer: LLMs tendem a seguir padrões genéricos da internet; você precisa "desensiná-las" o que não se aplica ao seu projeto.
4.  Use mapas de pastas: Documente a árvore de diretórios principal. Isso economiza muitos tokens de busca da IA.
5.  Referencie outros docs: Use o CLAUDE.md para apontar para documentos de arquitetura mais densos (ex: agent_docs/architecture.md).

Este projeto é um excelente exemplo de "AI-First Documentation", onde a documentação não é apenas para humanos, mas um "manual de instruções" para que o seu par de programação (IA) seja de fato produtivo.

    1 px-nexus/
    2 ├── CLAUDE.md                        # 🟢 O "Cérebro" (Visão macro e comandos globais)
    3 ├── docs/                             # 📚 Manuais Técnicos (Aprofundamento)
    4 │   ├── backend/                      #   - Regras de tRPC e WebSockets
    5 │   ├── database/                     #   - Estratégias de Migrations e Schema
    6 │   └── frontend/                     #   - Padrões de Estado e Estilização
    7 ├── specs/                            # 📋 Regras de Negócio (O que construir)
    8 │   ├── audit-logs.md
    9 │   └── support-desk-ui.md

10 ├── apps/
11 │ ├── api/
12 │ │ └── CLAUDE.md # 🔵 Manual da API (NestJS, Routers)
13 │ └── web/
14 │ ├── CLAUDE.md # 🔵 Manual do Web (React, TanStack)
15 │ └── agent_docs/ # 🤖 Doutrina para a IA (Arquitetura e Fluxo)
16 │ ├── architecture.md
17 │ └── development.md
18 ├── packages/
19 │ └── db/
20 │ └── CLAUDE.md # 🔴 Manual do Banco (Prisma, Migrations)
21 └── collections/
22 └── CLAUDE.md # 🟣 Manual das Requisições (Bruno)

O que cada "cor" representa na estratégia:

- 🟢 Verde (Raiz): Configura o ambiente e dá o mapa da mina.
- 🔵 Azul (Apps): Define as regras de estilo e arquitetura de código de cada plataforma.
- 🔴 Vermelho (Crítico): Impõe restrições de segurança (onde moram os "NUNCA" e "PROIBIDO").
- 🤖 Robô (Agent Docs): Explica conceitos abstratos (como o estado flui) que a IA teria dificuldade de deduzir sozinha.
- 📚 Cinza (Docs/Specs): Base de conhecimento técnica e funcional para consultas pontuais.
