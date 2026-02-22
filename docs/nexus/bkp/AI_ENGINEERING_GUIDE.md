# AI-First Engineering: Guia de Boas Práticas (Blueprint PX-Nexus)

Este guia consolida as práticas de "Engenharia de Contexto" identificadas no projeto PX-Nexus. O objetivo é criar um ambiente onde assistentes de IA (como o Claude) operem com máxima precisão, autonomia e aderência aos padrões da equipe.

---

## 1. Arquitetura de Contexto Modular
Nunca use um único arquivo de instrução gigante. Distribua o conhecimento para reduzir o consumo de tokens e evitar confusão da IA.

### Hierarquia de Arquivos `CLAUDE.md`
- **Raiz (`/CLAUDE.md`):** Visão macro do monorepo, stack tecnológica global e comandos de orquestração (Docker/Turborepo).
- **Workspaces (`/apps/*/CLAUDE.md` ou `/packages/*/CLAUDE.md`):** Manuais locais com comandos específicos, arquitetura interna e regras de ouro do domínio (ex: regras de NestJS na API, regras de React no Web).
- **Agent Docs (`/agent_docs/`):** Documentação profunda para explicar "Doutrinas" (ex: como o estado global funciona, fluxos de autenticação complexos).

---

## 2. Anatomia de Referência (`CLAUDE.md`)
Todo arquivo de contexto deve seguir este padrão semântico:

1.  **WHY (Purpose):** O propósito existencial do módulo. Evita que a IA sugira soluções fora do escopo.
2.  **WHAT (Architecture):** Mapa visual das pastas (árvore). Dá "visão espacial" para a IA localizar arquivos sem buscas exaustivas.
3.  **HOW (Operational):** 
    - **Key Commands:** Comandos exatos para dev, build e testes.
    - **Workflows:** Passo a passo para tarefas comuns (ex: "Como criar uma nova tabela no banco").
4.  **PATTERNS & GUIDELINES:** Regras de estilo (ex: "No barrel exports", "Functional React only", "snake_case no banco").
5.  **CRITICAL NOTES (Guardrails):** Avisos de segurança e proibições explícitas (ex: "NUNCA use db:push").

---

## 3. Fluxo de Trabalho Baseado em Specs
Use especificações para separar a **Intenção** (negócio) da **Implementação** (código).

### Ciclo de Vida de uma Spec (`/specs/*.md`)
1.  **Criação (Planning Mode):** Antes de codar uma feature grande, escreva (ou peça para a IA escrever) a Spec detalhando regras de negócio, UI/UX e requisitos técnicos.
2.  **Alinhamento:** Valide com a IA se a Spec está clara e se ela tem contexto suficiente para executar.
3.  **Implementação:** A IA usa a Spec como um "contrato de entrega" e guia de checkpoint.
4.  **Documentação de Intenção:** Após o término, a Spec permanece no repositório. Ela serve para que, no futuro, a IA não quebre regras de negócio ao fazer refactorings (o código diz o que *é*, a Spec diz o que *deveria ser*).

---

## 4. Estratégias de Comunicação e Segurança
- **Bilinguismo Estratégico:**
    - **Inglês:** Para termos técnicos, arquitetura e comandos (linguagem universal de IAs).
    - **Português:** Para instruções críticas, ênfase máxima e regras de negócio específicas (cria um contraste que a IA interpreta como "Regra da Casa").
- **Instruções Negativas:** Seja explícito sobre o que **NÃO** fazer. IAs tendem a seguir padrões genéricos da internet; os "Guardrails" forçam a aderência ao *seu* projeto.
- **Auto-Documentação:** Incentive a IA a atualizar os `agent_docs` ou as `specs` sempre que uma decisão arquitetural importante for tomada.

---

## 5. Exemplo de Estrutura de Pastas para IA
```text
projeto/
├── CLAUDE.md                # Visão Global
├── specs/                   # Requisitos e Regras de Negócio (O Quê)
├── docs/                    # Manuais Técnicos de Integração
├── apps/
│   └── web/
│       ├── CLAUDE.md        # Regras Locais (Como)
│       └── agent_docs/      # Doutrina de Arquitetura (Porquê)
```

---

*Este documento foi gerado via engenharia reversa das práticas de elite do projeto PX-Nexus.*
