## Code Style

- **NEVER adicione comentários no código** — nem inline, nem de bloco, nem docstrings/JSDoc. O código deve ser autoexplicativo.

## Tool Preferences

- **ALWAYS use GitHub CLI (`gh`) via the Bash tool** for all GitHub-related tasks
- **DO NOT use MCP servers** for GitHub operations
- Examples: `gh pr create`, `gh issue list`, `gh pr view`, `gh api`, etc.
- The GitHub CLI provides more reliable and direct access to GitHub functionality

- **ALWAYS use Atlassian CLI (`acli`) via the Bash tool** for all Atlassian-related tasks (Jira, Confluence)
- **DO NOT use MCP servers** for Atlassian operations
- Examples: `acli jira issue create`, `acli confluence page list`, `acli jira issue view`, etc.
- The Atlassian CLI provides more reliable and direct access to Atlassian functionality

## LSP (Language Server Protocol) Usage

- **ALWAYS use LSP when convenient** for code analysis, navigation, and understanding
- LSP provides accurate type information, definitions, references, and diagnostics
- Prefer LSP for tasks such as:
  - Finding function/class definitions and implementations
  - Discovering all references to a symbol
  - Getting accurate type information
  - Identifying compilation errors and warnings
  - Code completion suggestions
  - Refactoring operations (rename, extract, etc.)
- LSP is especially useful when working with strongly-typed languages (TypeScript, Go, Rust, Java, C#, etc.)
- Use LSP to complement other tools like Grep and Glob for more precise code navigation

## Skill Development Guidelines

- **Ao criar ou atualizar uma skill, SEMPRE otimize com scripts** para economizar tokens
- **Prefira scripts a respostas em texto**: scripts são mais rápidos, precisos e consomem muito menos tokens
- Use `bash` ou `python` — ambos são boas práticas; escolha o mais adequado para cada situação:
  - Prefira **bash** para operações de sistema, pipes, chamadas de CLI e transformações simples com `jq`, `awk`, `grep`, `sed`
  - Prefira **python** para lógica mais complexa, manipulação estruturada de dados (JSON, YAML, CSV), ou quando a legibilidade for prioritária
- Exemplos de otimizações com scripts:
  - Colete dados estruturados (JSON, listas, contagens) com um script em vez de ler arquivos um a um
  - Filtre e transforme dados diretamente no terminal sem precisar de múltiplas chamadas de ferramenta
  - Evite ler arquivos inteiros quando um script pode extrair apenas o trecho necessário
  - Prefira um único script que faça múltiplas operações a várias chamadas de ferramenta separadas
  - Use scripts para validar pré-condições antes de executar ações (ex: verificar se branch existe, se PR está aberto, etc.)
- **Regra de ouro**: se uma informação pode ser obtida com um script em vez de múltiplos `view`/`grep`/`glob`, use o script
