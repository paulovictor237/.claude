# Boas Práticas para Escrever um Bom CLAUDE.md

Guia completo baseado na documentação oficial do Claude Code.

## 📍 Estrutura e Localização

Os arquivos CLAUDE.md funcionam em hierarquia:

| Localização | Escopo | Uso |
|------------|---------|-----|
| `./CLAUDE.md` ou `./.claude/CLAUDE.md` | Projeto | Instruções compartilhadas no controle de versão |
| `./CLAUDE.local.md` | Local/pessoal | Preferências pessoais (auto-adicionado ao .gitignore) |
| `~/.claude/CLAUDE.md` | Usuário | Preferências pessoais para todos os projetos |
| `/Library/Application Support/ClaudeCode/CLAUDE.md` | Organização | Políticas gerenciadas pela empresa |

**Importante**: Arquivos mais específicos têm precedência sobre os mais gerais.

## ✨ Princípios Fundamentais

1. **Seja Específico**: "Use indentação de 2 espaços" é melhor que "Formate o código corretamente"
2. **Use Estrutura**: Organize em bullet points sob cabeçalhos markdown descritivos
3. **Revise Periodicamente**: Mantenha atualizado conforme o projeto evolui
4. **Seja Conciso**: Especialmente importante para GitHub Actions onde o contexto é limitado

## 📝 Estrutura Recomendada

```markdown
# Visão Geral do Projeto
- Breve descrição do que o projeto faz
- Tecnologias e frameworks principais
- Link para documentação principal

# Estilo de Código
- Estilo de indentação (2 espaços, 4 espaços, tabs)
- Convenções de nomenclatura (camelCase, snake_case, etc.)
- Regras específicas da linguagem

# Arquitetura e Padrões
- Padrões arquiteturais (MVC, microserviços, etc.)
- Design patterns utilizados
- Decisões arquiteturais importantes

# Workflows Comuns
- Comandos de build: `npm run build`
- Comandos de teste: `npm test`
- Como rodar o projeto localmente

# Workflow Git
- Convenções de nomes de branches
- Convenções de mensagens de commit
- Processo de review de PRs

# Requisitos de Testes
- Framework de testes usado
- Expectativas de cobertura mínima
- Como executar testes antes de submeter PRs

# Segurança e Best Practices
- Guidelines de segurança específicos
- Padrões de autenticação/autorização
- Tratamento de dados sensíveis

# Regras Específicas do Projeto
- Padrões de design de API
- Convenções de banco de dados
- Padrões de tratamento de erros
- Padrões de logging
- Padrões de documentação
```

## 🔧 Recursos Avançados

### 1. Importar Arquivos Externos

Use `@caminho/para/arquivo` para incluir outros arquivos:

```markdown
Veja @README para visão geral do projeto.

# Workflow Git
@docs/git-instructions.md

# Padrões de Testes
@docs/testing-guidelines.md
```

Você pode usar caminhos relativos ou absolutos, incluindo do seu home:

```markdown
@~/.claude/minhas-instrucoes.md
```

**Limite**: Máximo de 5 níveis de profundidade de importação.

### 2. Regras Modulares com `.claude/rules/`

Para projetos maiores, organize instruções em múltiplos arquivos:

```
seu-projeto/
├── .claude/
│   ├── CLAUDE.md           # Instruções principais
│   └── rules/
│       ├── estilo-codigo.md
│       ├── testes.md
│       ├── api-design.md
│       ├── seguranca.md
│       └── frontend/
│           ├── react.md
│           └── styles.md
```

**Todos os arquivos `.md` em `.claude/rules/` são carregados automaticamente.**

### 3. Regras Específicas por Caminho

Use frontmatter YAML para aplicar regras condicionalmente:

```markdown
---
paths: src/api/**/*.ts
---

# Regras de Desenvolvimento de API

- Todos os endpoints devem incluir validação de entrada
- Use o formato padrão de resposta de erro
- Inclua comentários de documentação OpenAPI
```

Exemplos de padrões de caminho:

```markdown
---
paths: src/components/**/*.tsx
---

# Regras de Componentes React
```

```markdown
---
paths: tests/**/*.test.js
---

# Padrões de Testes
```

### 4. Symlinks para Regras Compartilhadas

Compartilhe regras comuns entre múltiplos projetos:

```bash
# Compartilhar diretório de regras
ln -s ~/regras-compartilhadas .claude/rules/shared

# Compartilhar arquivo específico
ln -s ~/padroes-empresa/seguranca.md .claude/rules/seguranca.md
```

## 💡 Dicas Práticas

1. **Inclua comandos frequentemente usados** para evitar buscas repetidas
2. **Documente seus padrões, não práticas genéricas** - Claude já conhece best practices gerais
3. **Atualize após mudanças arquiteturais** - Mantenha sincronizado com o código
4. **Use o comando `/memory`** para editar CLAUDE.md diretamente durante a sessão
5. **Teste com sua equipe** - Certifique-se que reflete como sua equipe trabalha
6. **Mantenha regras de projeto separadas** - Use `.claude/rules/` para diferentes preocupações
7. **Use imports estrategicamente** - Evite imports circulares e mantenha profundidade mínima

## 🎯 Boas Práticas para GitHub Actions

Quando usar Claude Code com GitHub Actions:

1. **Mantenha focado**: Contextos em Actions são mais limitados
2. **Documente critérios de code review**: Seja explícito sobre o que Claude deve procurar
3. **Defina padrões de código claramente**: Seja específico sobre estilo e padrões
4. **Inclua requisitos de segurança**: Destaque preocupações importantes
5. **Especifique ferramentas e permissões permitidas**: Ajude Claude a entender mudanças aceitáveis

## 📋 Exemplo Completo - Projeto Node.js/React

```markdown
# MeuApp - Plataforma de Gerenciamento de Tarefas

Aplicação web full-stack para gerenciamento de tarefas construída com React e Node.js.

## Setup de Desenvolvimento

- Use Node.js 18+
- Instalar dependências: `npm install`
- Servidor de desenvolvimento: `npm run dev` (inicia na porta 3000)
- Build para produção: `npm run build`
- Rodar testes: `npm test`
- Rodar linter: `npm run lint`

## Estilo de Código

- Use indentação de 2 espaços
- Prefira `const` sobre `let` e `var`
- Use camelCase para variáveis e funções
- Use PascalCase para componentes React e classes
- Comprimento máximo de linha: 100 caracteres
- Use async/await ao invés de chains .then()
- Sempre inclua tratamento de erro em blocos try/catch

## Padrões de Componentes React

- Use componentes funcionais com hooks
- Use custom hooks para lógica compartilhada
- Estrutura de arquivo de componente: imports, componente, exports
- Props devem ser validados com PropTypes
- Cada componente deve ter uma única responsabilidade

## Testes

- Framework: Jest + React Testing Library
- Cobertura mínima: 80% para componentes, 90% para utilities
- Nomenclatura: `describe('ComponentName', () => { it('should...') })`
- Sempre teste interações do usuário, não detalhes de implementação
- Rodar testes antes de commit: `npm test`

## Workflow Git

- Feature branches: `feature/nome-feature`
- Bug branches: `bugfix/nome-bug`
- Formato de commit: `type(scope): description` (ex: `feat(auth): add login form`)
- PRs devem ter testes passando e checks de linter
- Pelo menos um code review antes de merge

## Padrões de API

- Design de endpoints RESTful
- Use códigos HTTP corretamente (200, 201, 400, 404, 500)
- Formato de request/response: JSON
- Respostas de erro: `{ error: "message", code: "ERROR_CODE" }`
- Documente todos os endpoints com comentários JSDoc

## Banco de Dados

- Use Postgres com migrations Knex.js
- Nomenclatura de migrations: `YYYY-MM-DD_HH-mm-ss_description`
- Sempre escreva migrations para mudanças de schema
- Rodar migrations: `npm run migrate`

## Segurança

- Nunca commitar secrets ou API keys
- Valide toda entrada de usuário no servidor
- Use queries parametrizadas para prevenir SQL injection
- Hash de senhas com bcrypt
- Use HTTPS em produção
- Configure headers CORS apropriados
```

## 📋 Exemplo para Projeto Python/Django

```markdown
# Sistema de Blog - Django REST Framework

API backend para sistema de blog com autenticação e gerenciamento de posts.

## Setup de Desenvolvimento

- Use Python 3.11+
- Criar ambiente virtual: `python -m venv venv`
- Ativar ambiente: `source venv/bin/activate`
- Instalar dependências: `pip install -r requirements.txt`
- Rodar migrations: `python manage.py migrate`
- Servidor dev: `python manage.py runserver`
- Rodar testes: `pytest`

## Estilo de Código

- Use 4 espaços para indentação (padrão PEP 8)
- Use snake_case para funções e variáveis
- Use PascalCase para classes
- Comprimento máximo de linha: 88 caracteres (Black formatter)
- Ordenação de imports: stdlib, terceiros, locais
- Use type hints em todas as funções
- Docstrings no formato Google

## Estrutura do Projeto

- Models em `models.py`
- Views em `views.py` ou `views/` para apps grandes
- Serializers em `serializers.py`
- URLs em `urls.py`
- Testes em `tests/`

## Django Best Practices

- Use Class-Based Views quando apropriado
- Sempre use select_related() e prefetch_related() para otimizar queries
- Use Django signals com moderação
- Mantenha lógica de negócio em models ou services
- Use Django ORM ao invés de SQL raw quando possível

## API Standards

- Use Django REST Framework para APIs
- Versionamento de API: `/api/v1/`
- Paginação padrão: 20 itens por página
- Autenticação: JWT tokens
- Documentação automática com drf-spectacular

## Testes

- Framework: pytest + pytest-django
- Cobertura mínima: 85%
- Use factories (factory_boy) ao invés de fixtures
- Teste cada endpoint de API
- Teste permissões e autenticação

## Workflow Git

- Feature branches: `feature/nome-feature`
- Formato commit: tipo convencional (feat, fix, docs, etc)
- PRs devem passar CI/CD (testes, linter, type checking)

## Segurança

- Use variáveis de ambiente para secrets (django-environ)
- CORS configurado apropriadamente
- Rate limiting em endpoints públicos
- Validação de entrada em serializers
- Nunca usar DEBUG=True em produção
```

## 🔍 Visualizar Memória Carregada

Para ver quais arquivos de memória estão carregados na sua sessão:

```bash
/memory
```

Este comando mostra todos os arquivos CLAUDE.md, arquivos de regras e imports ativos.

## 📚 Ordem de Busca de Memória

Claude Code busca arquivos de memória recursivamente:

1. Começa no diretório de trabalho atual (`cwd`)
2. Sobe recursivamente em direção à raiz (mas não incluindo `/`)
3. Lê qualquer arquivo `CLAUDE.md` ou `CLAUDE.local.md` encontrado
4. Também descobre arquivos aninhados em subárvores sob `cwd` (carregados sob demanda)

Isso é especialmente útil para monorepos grandes com diferentes projetos em vários níveis.

## ⚠️ O Que Evitar

1. **Não seja genérico**: Evite instruções vagas como "escreva código limpo"
2. **Não duplique documentação**: Não reescreva o que já está no README
3. **Não inclua tutoriais**: Claude já conhece as linguagens e frameworks
4. **Não seja excessivamente prescritivo**: Permita flexibilidade quando apropriado
5. **Não documente o óbvio**: Claude entende convenções padrão de linguagens

## ✅ O Que Incluir

1. **Convenções específicas do seu time**: Como vocês nomeiam coisas, organizam código
2. **Decisões arquiteturais**: Por que escolheram certos padrões
3. **Comandos frequentes**: Scripts e comandos que você usa todo dia
4. **Regras de negócio**: Lógica específica do domínio
5. **Restrições técnicas**: Limitações ou requisitos específicos do projeto

---

**Dica Final**: Comece simples e expanda conforme necessário. Um CLAUDE.md curto e focado é melhor que um longo e genérico.
