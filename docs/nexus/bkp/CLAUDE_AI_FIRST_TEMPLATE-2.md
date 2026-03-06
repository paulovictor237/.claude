# CLAUDE.md (AI-First & CDD Template)

## 🎯 WHY - Project Purpose
[Descreva o propósito do projeto]

## 🏗️ WHAT - Architecture
```text
project/
├── .claude/
│   ├── knowledge/      # Doutrina e Arquitetura (CDD)
│   ├── specs/          # Checkpoints ativos
│   └── session_ledger.md # Handover de sessões
├── apps/               # Aplicações
└── packages/           # Pacotes compartilhados
```

## ⌨️ HOW - Key Commands
[Comandos principais]

---

## 🤖 AI-FIRST GUIDELINES (Checkpoint-Driven Development)

Como este é um projeto **AI-First**, siga rigorosamente a metodologia **CDD**:

1.  **CDD Workflow:** Para qualquer tarefa não trivial, crie/solicite uma spec em `.claude/specs/` antes de codar.
2.  **Modularidade:** Use `CLAUDE.md` locais em subpastas para reduzir o consumo de tokens.
3.  **Bilinguismo:** Inglês para técnica, Português para "Guardrails" e Avisos Críticos.

---

## 🛠️ TOOLING OPTIMIZATION (Mandatory)

1.  **Search First:** Antes de `read_file`, valide a existência e relevância com `ls` ou `grep`.
2.  **Context Pruning:** Mova specs finalizadas para `.claude/specs/archive/`.
3.  **Session Handover:** Atualize o `.claude/session_ledger.md` ao final de cada tarefa complexa.

---

## 🧠 INSTRUCTIONS FOR AI AGENTS (Behavioral Hook)

**Você é um AI-First Architect operando sob CDD.**

- **Ao iniciar:** Verifique o `.claude/session_ledger.md` para retomar o raciocínio anterior.
- **Durante:** Use a spec ativa como checkpoint obrigatório.
- **Ao finalizar (Sync Alert):**
    - Se alterou código, atualize a documentação em `.claude/knowledge/` se necessário.
    - Informe ao usuário qual documento foi sincronizado.
    - Sugira o próximo passo de maturidade de contexto (ex: "Criar spec para a próxima feature").

---

## 🔍 AI-FIRST MATURITY CHECKLIST
- [ ] `.claude/knowledge/` contém os guias de arquitetura.
- [ ] `.claude/specs/` sendo usado para Checkpoint-Driven Development.
- [ ] `.claude/session_ledger.md` atualizado com o status atual.
