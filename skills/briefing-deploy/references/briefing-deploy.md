# Briefing Deploy

Documento de alinhamento pré-deploy que reúne dados técnicos, contexto da feature
e avaliação de impacto nos times. Todos os campos são obrigatórios salvo quando
indicado o contrário.

## Template

Use exatamente esta estrutura. Mantenha os checkboxes e o formato de campos.

---

# Briefing Deploy — [Nome da Feature]

---

## 📋 DADOS TÉCNICOS

| Campo | Valor |
|-------|-------|
| **Pull Request** | [Link do PR] |
| **Task** | [Link ou ID da task] |
| **Time** | [Nome do time responsável] |
| **Tech Manager** | [Nome do Tech Manager] |
| **Data prevista** | [Data prevista para o deploy] |

---

## 🎯 SOBRE A FEATURE

**O que é:**
[Descrição clara da funcionalidade]

**Para quem (persona):**
[Público-alvo / persona impactada]

**Problema que resolve:**
[Qual dor ou necessidade está sendo endereçada]

**Resultado esperado:**
[O que se espera alcançar com essa feature]

---

## 📣 COMUNICAÇÃO

**Principal benefício:**
[Benefício #1 em linguagem de valor]

**Diferenciais:**
[O que torna essa solução especial ou diferente]

**Telas:** _(se possível)_
[Link das telas para entendermos a comunicação dentro do app]

---

## 🤖 CORTEX

**Cortex já foi atualizado?**
- [ ] Não
- [ ] Sim — com contexto novo
- [ ] Sim — com alteração em contexto existente

---

## ⚠️ IMPACTO NOS TIMES (OBRIGATÓRIO)

### ATENDIMENTO / SUPORTE

**Impacto nos prestadores:**
- [ ] Nenhum
- [ ] Baixo
- [ ] Médio
- [ ] Alto

**Se for Médio/Alto, informar quais são os possíveis impactos:**
[Descrever impactos]

**Time de atendimento já foi alinhado:**
- [ ] Não
- [ ] Sim

---

### GS (GESTÃO DE SUCESSO)

**Impacta na experiência dos clientes:**
- [ ] Sim
- [ ] Não

**Time de GS já foi alinhado:**
- [ ] Não
- [ ] Sim

---

## Instruções para o Claude

- Preserve rigorosamente o formato de checkboxes — eles são essenciais para o
  preenchimento por outros membros do time
- Se o usuário disser o nível de impacto (ex: "impacto alto nos prestadores"),
  marque o checkbox correspondente com [x]
- Se o usuário disser que o time já foi alinhado, marque o "Sim" correspondente
- Campos sem informação devem ficar como `[PREENCHER]`
- A seção "IMPACTO NOS TIMES" é obrigatória — nunca omita, mesmo que o usuário
  não forneça as informações. Nesse caso, deixe os checkboxes desmarcados e
  sinalize que o PM precisa preencher
- Se o usuário não fornecer link de PR ou Task, pergunte — são dados técnicos
  importantes para o briefing
- A seção "CORTEX" é obrigatória — sempre pergunte se a feature precisa de
  atualização no contexto do chat do app
