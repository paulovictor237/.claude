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

## Context References

Para configurações específicas de projetos e ferramentas, consulte os arquivos na pasta `context/`:

- **Jira/Atlassian:** Configurações padrão do projeto em `~/.claude/context/jira-config.md`
