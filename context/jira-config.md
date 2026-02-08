# Configuração Padrão - Jira

Este arquivo contém as configurações padrão para operações no Jira.
Todas as tarefas devem referenciar estas configurações, a menos que explicitamente especificado de outra forma.

## Projeto: AcademiaPX

- **Project Key:** `APX`
- **Project Lead:** lian.karasinski
- **Project Type:** software

## Board Padrão: Kanban Academia

- **Board ID:** `16`
- **Board Type:** kanban
- **Board URL Path:** `/projects/APX/boards/16`

## Dicas de Otimização para Comandos ACLI

### Criar Issues
```bash
acli jira issue create --project APX --board 16 --type Story --summary "Título" --description "Descrição"
```

### Buscar Issues
```bash
acli jira issue search --jql "project = APX AND status = 'In Progress'" --limit 50
```

### Visualizar Board
```bash
acli jira board get --id 16
```

### Buscar Issues do Board
```bash
acli jira board search --project APX --type kanban
```

## Notas

- Sempre use o project key `APX` como padrão em operações Jira
- Use o board ID `16` para queries mais rápidas relacionadas ao Kanban Academia
- Para outros boards do projeto, consulte: `acli jira board search --project APX`
