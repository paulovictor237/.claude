# AI-First Engineering: Checkpoint-Driven Development (CDD)

Este guia define a metodologia **CDD** para maximizar a precisão de agentes de IA em projetos complexos. O CDD utiliza especificações como "checkpoints" de verdade técnica para evitar deriva de contexto.

---

## 1. Estrutura de Conhecimento (.claude/)
Adotamos a estrutura de diretórios padrão da comunidade para separar o código da documentação de suporte à IA:

- **`/CLAUDE.md` (Raiz):** Entrypoint para a IA. Contém o "Mapa da Mina" e comandos vitais.
- **`.claude/knowledge/`:** Repositório de "Doutrina". Arquitetura profunda, regras de design e guias de estilo.
- **`.claude/specs/`:** Checkpoints ativos. Onde o **CDD** acontece.
- **`.claude/specs/archive/`:** Memória histórica de specs concluídas.
- **`.claude/session_ledger.md`:** Diário de bordo para Handover de sessões.

---

## 2. Metodologia: Checkpoint-Driven Development (CDD)
O CDD consiste em nunca permitir que a IA execute grandes blocos de código sem um "Checkpoint" (Spec) validado.

1.  **Checkpoint Discovery:** Antes de codar, a IA mapeia os impactos e escreve a spec em `.claude/specs/`.
2.  **Checkpoint Validation:** O usuário revisa o "contrato" de implementação.
3.  **Atomic Execution:** A IA implementa seguindo a spec, usando-a como guia de checkpoint a cada arquivo alterado.
4.  **Context Pruning:** Após a implementação e testes, a spec é movida para o `/archive/` para manter o contexto limpo.

---

## 🛠️ TOOLING OPTIMIZATION
Para máxima eficiência de tokens e precisão:

1.  **Search First:** NUNCA ler arquivos cegamente. Sempre use `grep` ou `ls` para validar se o arquivo é o alvo correto.
2.  **Context Pruning:** Mantenha apenas specs ativas no diretório principal. Specs concluídas vão para o arquivo.
3.  **Session Handover:** Ao final de cada tarefa complexa, atualize o `.claude/session_ledger.md` com:
    - O que foi feito.
    - O que falta fazer.
    - Decisões técnicas tomadas (o "raciocínio").

---

## ⚠️ SYNC ALERT (Regra de Ouro)
Ao final de **QUALQUER** interação que altere o código:
- A IA **DEVE** verificar se os documentos em `.claude/knowledge/` ou `.claude/specs/` precisam de atualização.
- Se a arquitetura mudou, o `engineering_guide.md` ou o `CLAUDE.md` devem ser sincronizados imediatamente.
