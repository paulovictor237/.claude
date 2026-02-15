---
name: jira-board-report
description: Gera um relatório detalhado das tarefas do board Kanban Academia (APX) filtradas por colunas específicas (IN PROGRESS, CODE REVIEW, TO TEST, TESTING & MERGE, Waiting to deploy) com contagem de dias em andamento e parado na coluna.
---

## Propósito
Use esta skill para gerar o relatório diário ou periódico do board AcademiaPX. Ela extrai tarefas das colunas de desenvolvimento e formata a saída com links, responsáveis (@mencionados) e tempo de permanência.

## Uso
Execute o script de extração para gerar o relatório formatado para Slack.

```bash
# Por padrão, não mostra tarefas IN PROGRESS
python3 scripts/fetch_jira_board.py

# Para incluir tarefas IN PROGRESS
python3 scripts/fetch_jira_board.py --in-progress
```

## Formato de Saída
O relatório é gerado em formato Slack-friendly:

*Nome da Coluna*

*Nome da tarefa (Chave)*
• *Link:* https://motoristapx.atlassian.net/browse/CHAVE
• *Responsável:* @Nome
• *Dias em andamento:* *X dias* (Início: YYYY-MM-DD)
• *Dias parado na coluna atual:* *Z dias* (Desde: YYYY-MM-DD)

## Notas Técnicas
- A contagem de "Dias em andamento" utiliza a data de criação da issue como base inicial (proxy) na ausência do histórico completo.
- A contagem de "Dias parado na coluna atual" utiliza a data da última mudança de categoria de status.
- Membros da equipe são automaticamente mapeados para seus respectivos arrobas conforme solicitado.
