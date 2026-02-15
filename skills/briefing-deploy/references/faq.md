# FAQ de Feature

O FAQ pode ser criado de duas formas:
1. **Embutido** na Documentação Completa (como seção final)
2. **Documento separado** para distribuição ampla a mais pessoas e times

Sempre pergunte ao usuário qual formato ele prefere. Se ele não souber,
sugira documento separado quando a feature impactar múltiplos times.

## Template — FAQ como documento separado

---

# FAQ — [Nome da Feature]

**Última atualização:** [Data]

### 1. O que é [Nome da Feature]?
[Resposta clara e curta, 2-3 frases no máximo]

### 2. Para quem é essa funcionalidade?
[Persona/público-alvo]

### 3. Como o usuário acessa/utiliza?
[Passo a passo simplificado]

### 4. Quando estará disponível?
[Data ou fase de rollout]

### 5. Quais os principais benefícios?
[Lista dos benefícios em linguagem de valor para o usuário]

### 6. Tem alguma limitação ou restrição?
[O que NÃO faz, restrições conhecidas, casos não cobertos]

### 7. O que muda para os prestadores?
[Impacto nos prestadores — se não houver, dizer explicitamente]

### 8. O que muda para os clientes?
[Impacto na experiência do cliente — se não houver, dizer explicitamente]

### 9. Como o atendimento/suporte deve proceder se houver dúvidas?
[Orientações para o time de atendimento]

### 10. Com quem falar em caso de dúvidas?
[Ponto focal / canal de comunicação]

---

## Template — FAQ embutido na Documentação Completa

Adicionar como última seção do documento, com o cabeçalho:

```
## Perguntas Frequentes (FAQ)
```

E seguir o mesmo formato de perguntas e respostas acima, adaptando conforme relevância.

## Instruções para o Claude

- Gere as perguntas com base nas informações já fornecidas sobre a feature
- Se a feature impacta prestadores ou clientes, as perguntas 7 e 8 são obrigatórias
- Adapte as perguntas ao contexto — remova as que não fazem sentido e adicione
  outras que sejam relevantes para a feature específica
- Use linguagem simples e direta, como se estivesse explicando para alguém do
  time de atendimento
- Numere todas as perguntas sequencialmente
