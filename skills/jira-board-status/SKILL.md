---
name: jira-board-status
description: Analisa o board Jira do projeto academia-px e gera relatório de tarefas em andamento, organizadas por prioridade de coluna com dias em andamento e dias parados.
---

# Análise de Board Jira - Academia PX

## Objetivo

Extrair e organizar tarefas do board Jira do projeto academia-px nas colunas críticas de trabalho, fornecendo visibilidade sobre prioridades e tempo de permanência das tarefas.

## Configurações do Board

**Board:** academia-px
**Colunas a Analisar (em ordem de prioridade):**

1. TESTING & MERGE (Validation) - **Maior prioridade**
2. TO TEST (Testar)
3. CODE REVIEW (Code Review)
4. IN PROGRESS (Em andamento) - **Menor prioridade**

**Equipe (membros que devem ter @ no responsável):**

- @Daniel Boso
- @Gabriel Reinert
- @PeVe (Paulo Victor)
- @João Pedro Cordeiro
- @Lucas Leal

## Processo de Extração

### 1. Buscar Dados do Board

Use o **Atlassian CLI (`acli`)** para obter as issues do board. **NUNCA use MCP servers.**

```bash
# Obter issues do board academia-px
acli jira issue list --project=APX --board="academia-px" --status="In Progress,Code Review,To Test,Testing & Merge" --output-format=json
```

### 2. Para Cada Issue, Extrair

Para cada tarefa encontrada nas colunas especificadas, você deve coletar:

1. **Título da tarefa** (summary)
2. **Chave da issue** (ex: APX-1469)
3. **Link direto** (https://motoristapx.atlassian.net/browse/CHAVE)
4. **Responsável atual** (assignee)
5. **Status atual** (coluna onde está)
6. **Data de entrada em IN PROGRESS** (primeira transição para "In Progress")
7. **Data de entrada na coluna atual** (última transição para o status atual)

### 3. Calcular Métricas

Para cada tarefa, calcule:

- **Dias em andamento**: Diferença entre HOJE (2026-02-10) e a data de entrada em "IN PROGRESS"
  - Incluir a data de início na contagem
  - Exemplo: Se entrou em 2026-01-09, são 33 dias (de 09/01 até 10/02 inclusive)

- **Dias parado na coluna atual**: Diferença entre HOJE e a data de entrada na coluna atual
  - Exemplo: Se entrou na coluna em 2026-01-21, são 21 dias

### 4. Mapear Responsáveis

Quando o assignee corresponder a um dos membros da equipe, adicione o @ na saída:

- Se o assignee for "Daniel Boso" → **@Daniel Boso**
- Se o assignee for "Gabriel Reinert" → **@Gabriel Reinert**
- Se o assignee for "Paulo Victor" ou "PeVe" → **@PeVe**
- Se o assignee for "João Pedro Cordeiro" → **@João Pedro Cordeiro**
- Se o assignee for "Lucas Leal" → **@Lucas Leal**
- Para outros nomes, incluir o nome sem @ (ou "Não atribuído" se vazio)

## Formato de Saída

Organize as tarefas em blocos por coluna, da maior para a menor prioridade:

### Template por Coluna

```markdown
## **[NOME_DA_COLUNA]**

**Título da tarefa (CHAVE-ISSUE)**

- **Link:** `https://motoristapx.atlassian.net/browse/CHAVE-ISSUE`
- **Responsável:** @Nome do Responsável (ou Não atribuído)
- **Dias em andamento:** **X dias** (Início: AAAA-MM-DD)
- **Dias parado na coluna atual:** **Y dias** (Desde: AAAA-MM-DD)
```

### Ordem das Colunas (da maior para menor prioridade)

1. **[TESTING & MERGE]** (ou **[Validation]**)
2. **[TO TEST]**
3. **[CODE REVIEW]**
4. **[IN PROGRESS]**

### Exemplo Completo

```markdown
## **[TESTING & MERGE]**

**Integrar pacote @px-center/config no projeto web (APX-1469)**

- **Link:** `https://motoristapx.atlassian.net/browse/APX-1469`
- **Responsável:** @João Pedro Cordeiro
- **Dias em andamento:** **18 dias** (Início: 2026-01-09)
- **Dias parado na coluna atual:** **6 dias** (Desde: 2026-01-21)

---

**Refatorar módulo de autenticação (APX-1502)**

- **Link:** `https://motoristapx.atlassian.net/browse/APX-1502`
- **Responsável:** @Gabriel Reinert
- **Dias em andamento:** **12 dias** (Início: 2026-01-15)
- **Dias parado na coluna atual:** **3 dias** (Desde: 2026-01-24)

## **[TO TEST]**

**Implementar cache Redis para API (APX-1487)**

- **Link:** `https://motoristapx.atlassian.net/browse/APX-1487`
- **Responsável:** @PeVe
- **Dias em andamento:** **25 dias** (Início: 2026-01-02)
- **Dias parado na coluna atual:** **8 dias** (Desde: 2026-01-19)

## **[CODE REVIEW]**

**Adicionar testes unitários ao módulo de pagamento (APX-1455)**

- **Link:** `https://motoristapx.atlassian.net/browse/APX-1455`
- **Responsável:** @Daniel Boso
- **Dias em andamento:** **32 dias** (Início: 2025-12-26)
- **Dias parado na coluna atual:** **15 dias** (Desde: 2026-01-12)

## **[IN PROGRESS]**

**Desenvolver dashboard de analytics (APX-1510)**

- **Link:** `https://motoristapx.atlassian.net/browse/APX-1510`
- **Responsável:** @Lucas Leal
- **Dias em andamento:** **5 dias** (Início: 2026-02-05)
- **Dias parado na coluna atual:** **5 dias** (Desde: 2026-02-05)
```

## Regras Importantes

1. **Use APENAS o `acli`** (Atlassian CLI) via Bash tool - NUNCA use MCP servers
2. **Links sempre entre backticks** (`) para formatação de código
3. **Ignorar tarefas** que não estejam nas 4 colunas especificadas
4. **Data de referência para hoje:** Use sempre a data atual do sistema
5. **Incluir data de início** na contagem de dias (ex: de dia 9 até dia 10 = 2 dias)
6. **Separador entre tarefas:** Use `---` (linha horizontal) entre tarefas da mesma coluna
7. **Formato de lista**, não tabela
8. **Ordenação:** Sempre da maior para menor prioridade de coluna

## Comandos acli Úteis

```bash
# Listar issues de um board específico
acli jira issue list --project=APX --board="academia-px" --status="In Progress" --output-format=json

# Ver detalhes completos de uma issue (incluindo histórico)
acli jira issue get APX-1469 --output-format=json

# Ver histórico de transições de status
acli jira issue get APX-1469 --changelog --output-format=json

# Buscar issues por JQL
acli jira issue jql "project = APX AND status IN ('In Progress', 'Code Review', 'To Test', 'Testing & Merge')" --output-format=json
```

## Tratamento de Erros

- Se não conseguir acessar o Jira, informar o usuário claramente
- Se uma issue não tiver data de entrada em IN PROGRESS, reportar como "Data não disponível"
- Se uma issue não tiver assignee, mostrar "Não atribuído" sem @
- Se o `acli` não estiver configurado, orientar o usuário a configurar

## Workflow do Skill

1. **Confirmar data atual** do sistema
2. **Executar comando acli** para buscar issues do board academia-px
3. **Filtrar issues** apenas das 4 colunas especificadas
4. **Para cada issue**, obter histórico de transições para calcular datas
5. **Calcular métricas** (dias em andamento e dias na coluna)
6. **Mapear responsáveis** com @ quando aplicável
7. **Agrupar por coluna** (priority order)
8. **Formatar saída** seguindo o template exato
9. **Apresentar resultado** ao usuário

## Notas Técnicas

- O campo `changelog` do Jira contém o histórico de transições de status
- A primeira transição para "In Progress" é a data de início do trabalho
- A última transição para o status atual determina quando entrou na coluna
- Podem existir múltiplas transições entre colunas (ex: voltou de Code Review para In Progress)
- Sempre use a **primeira** entrada em IN PROGRESS para "Dias em andamento"
- Sempre use a **última** entrada na coluna atual para "Dias parado na coluna atual"
