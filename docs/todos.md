# TODO - Claude Code Configuration

## Workflows e Processos

### Code Review Workflow

utilize o mcp do github e do jira/atlassian

1. solicitar a url do pr no aberto no github
2. com o nome dado para o pr vc consegue buscar a tareja no jira: exemplo [APX-1490]
3. leia a tarefa do jira usando o MPC
4. Ler o épico pai da tarefa
5. Revisar o código implementado
6. Verificar se o código está alinhado com as regras de negócio propostas
7. Enumerar todos os comentários do code review
8. Perguntar ao usuário quais números de comentários devem ser postados no PR

### Refinamento Técnico Workflow

**Situação**
Você é um técnico responsável por transformar épicos de produto em especificações técnicas implementáveis. O projeto utiliza arquitetura PX Academy com backend Laravel e frontend Next.js 15 em ambiente multi-tenant com subdomínios.

**Tarefa**
O assistente deve analisar o épico fornecido e gerar uma especificação técnica estruturada contendo:

1. Resumo do contexto em até 300 caracteres
2. Divisão de tarefas por jornadas (fluxos de trabalho com início e fim definidos)
3. Identificação clara com **[FRONT]** ou **[BACK]** no início de cada tarefa
4. Numeração sequencial com [1], [2], etc. apenas para tarefas com dependência direta
5. Descrição focada exclusivamente em regras de negócio e condições lógicas

**Objetivo**
Criar um documento de especificação técnica suficientemente claro para orientar desenvolvimento independente de ambas as equipes, eliminando ambiguidades sobre fluxos, regras e responsabilidades.

**Conhecimento**

- Arquitetura multi-tenant com subdomínios em Next.js 15
- Backend Laravel com padrões RESTful
- Tamanho de tarefa ideal: médio (nem granular demais, nem muito amplo)
- Linguagem deve ser objetiva, focada em lógica condicional e etapas sequenciais
- Cada tarefa deve ser independentemente compreensível para o desenvolvedor responsável

## Especializações Técnicas

### Backend

- **Laravel PHP** - Framework principal
- **Laravel Nova** - Interface de administração

### Frontend

- **Next.js** - Framework React
- **React** - Biblioteca base
- **TanStack Query** (React Query) - Gerenciamento de estado assíncrono
- **React Hook Form** - Gerenciamento de formulários
- **Tailwind CSS** - Estilização
- **Zod** - Validação de schemas

## Comandos e Features para Testar

- `/interface` - Comando para conectar interfaces
- `/compactar` - Testar após atualizar o CLAUDE.md

## Configurações Pendentes

### Ambientes e Credenciais

- **Questão**: Onde configurar domínios e contas de staging para acesso do Claude?
- **Sugestão**: Criar seção específica no CLAUDE.md ou em arquivo de configuração

### Cenários de Teste

- Usar conta de staging
- Configurar cenário com conta de backoffice de staging
- Testar fluxos completos em ambiente de homologação

## Documentação

### Como Referenciar Explicitamente

- **Agentes**: Como mencionar e invocar agentes de forma explícita
- **Skills**: Como referenciar skills customizadas no contexto

---

## Próximos Passos

1. Definir padrões de comentários para code review
2. Criar templates para refinamento técnico
3. Documentar processo de integração com Slack
4. Testar comandos /interface e /compactar
5. Definir estratégia para gestão de credenciais de staging
6. Documentar sintaxe para invocar agentes e skills
