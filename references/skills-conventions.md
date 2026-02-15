# Skills - Estrutura e Convenções

Este documento define as convenções oficiais para criação e organização de skills no Claude Code.

## Estrutura de Pastas (Padrão Oficial)

Todas as skills devem seguir a estrutura oficial do Claude Code:

```
skill-name/
├── SKILL.md              # Obrigatório - definição da skill
├── scripts/              # Código executável (Python/Bash/etc.)
├── references/           # Documentação para carregar no contexto
└── assets/               # Arquivos usados no output (templates, etc.)
```

## Propósito das Pastas

### `SKILL.md` (Obrigatório)

- Contém YAML frontmatter com `name` e `description`
- Instruções e orientações para uso da skill
- Deve ser conciso (<500 linhas)
- Apenas o essencial - detalhes vão para `references/`

### `scripts/` (Opcional)

**Quando usar:** Código executável que precisa de confiabilidade determinística ou é reescrito repetidamente.

**Exemplos:**
- `scripts/rotate_pdf.py` para rotação de PDFs
- `scripts/validate.sh` para validações automatizadas
- `scripts/format.py` para formatação de dados

**Benefícios:**
- Token eficiente
- Determinístico
- Pode ser executado sem carregar no contexto

### `references/` (Opcional)

**Quando usar:** Documentação de referência que o Claude deve consultar sob demanda.

**Exemplos:**
- `references/finance.md` - schemas financeiros
- `references/api_docs.md` - especificações de API
- `references/policies.md` - políticas da empresa
- `references/templates.md` - templates de documentos

**Benefícios:**
- Mantém SKILL.md enxuto
- Carregado apenas quando necessário
- Suporta arquivos grandes (>10k palavras)

**Boas práticas:**
- Se arquivos grandes, inclua padrões de busca no SKILL.md
- Informação deve estar em SKILL.md OU references/, não ambos
- Prefira references/ para detalhes; SKILL.md para workflow essencial

### `assets/` (Opcional)

**Quando usar:** Arquivos que serão usados no output final (não carregados no contexto).

**Exemplos:**
- `assets/logo.png` - recursos de marca
- `assets/template.html` - templates HTML
- `assets/boilerplate/` - código boilerplate
- `assets/font.ttf` - fontes personalizadas

**Benefícios:**
- Separa recursos de output da documentação
- Não consome tokens do contexto
- Arquivos prontos para copiar/modificar

## Princípios de Design

### 1. Progressive Disclosure

Sistema de carregamento em três níveis para gerenciar contexto eficientemente:

1. **Metadata (name + description)** - Sempre no contexto (~100 palavras)
2. **SKILL.md body** - Quando a skill é acionada (<5k palavras)
3. **Bundled resources** - Conforme necessário (Ilimitado para scripts executáveis)

### 2. Concisão é Fundamental

- O contexto é um bem público compartilhado
- Assuma que o Claude já é inteligente
- Adicione apenas contexto que o Claude não possui
- Prefira exemplos concisos a explicações verbosas
- Mantenha SKILL.md < 500 linhas

### 3. Evite Duplicação

- Informação deve viver em SKILL.md OU em references/, não ambos
- Prefira references/ para informação detalhada
- SKILL.md deve ter apenas instruções procedurais essenciais

### 4. Sem Arquivos Auxiliares

Uma skill deve conter apenas arquivos essenciais. **NÃO crie:**

- README.md
- INSTALLATION_GUIDE.md
- QUICK_REFERENCE.md
- CHANGELOG.md
- Ou qualquer documentação auxiliar

A skill deve conter apenas informação necessária para o agente executar a tarefa.

## Pattern: High-level Guide com References

Quando uma skill suporta múltiplas variações, frameworks ou opções:

**No SKILL.md:**
```markdown
## Frameworks Suportados

Esta skill suporta React, Vue e Angular. Escolha o framework apropriado:

- **React** - Para apps modernos com hooks e componentes funcionais
- **Vue** - Para apps com template-driven development
- **Angular** - Para apps enterprise com TypeScript

Após escolher, leia o guia específico em `references/{framework}-guide.md`
```

**Nos arquivos de referência:**
- `references/react-guide.md` - Patterns específicos do React
- `references/vue-guide.md` - Patterns específicos do Vue
- `references/angular-guide.md` - Patterns específicos do Angular

## Checklist para Criar uma Skill

- [ ] SKILL.md criado com frontmatter (name, description)
- [ ] Descrição clara de quando usar a skill
- [ ] Instruções concisas (<500 linhas no SKILL.md)
- [ ] Detalhes movidos para `references/` quando necessário
- [ ] Scripts em `scripts/` se houver código executável
- [ ] Assets em `assets/` se houver recursos de output
- [ ] Sem arquivos auxiliares (README, CHANGELOG, etc.)
- [ ] Testado o acionamento da skill

## Referências

- [Claude Code Skills - Documentação Oficial](https://code.claude.com/docs/en/skills)
- [The Complete Guide to Building Skills for Claude](https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf)
- Skill oficial: `skill-creator` em `~/.claude/skills/skill-creator/`
