---
name: doc-lancamento-produto
user-invokable: true
description: "Skill para criar documentação padronizada de lançamento de produto. Use esta skill sempre que alguém pedir para criar documentação de feature, release notes, FAQ de produto, briefing de deploy, ou qualquer comunicação relacionada a lançamento de funcionalidade. Também acione quando o usuário mencionar: doc de lançamento, release notes, briefing deploy, FAQ de feature, comunicar feature, documentar funcionalidade, notas de release, comunicação de deploy, ou qualquer variação desses termos. Na dúvida, use esta skill — é melhor usá-la quando não necessário do que perder um caso onde ela seria útil."
---

# Documentação de Lançamento de Produto

Esta skill padroniza a criação de documentação para lançamentos de produto e features.
Ela cobre quatro tipos de documento, cada um com propósito e público distintos.

## Tipos de Documentação

| Tipo | Quando usar | Público | Referência |
|------|------------|---------|------------|
| **Documentação Completa** | Nova feature ou mudança significativa | PM, time de produto, stakeholders internos | `references/documentacao-completa.md` |
| **FAQ** | Dúvidas frequentes sobre a feature | Times de atendimento, GS, stakeholders amplos | `references/faq.md` |
| **Release Notes** | Comunicar lançamento no Teams | Time de Tecnologia, GS & FMA | `references/release-notes.md` |
| **Briefing Deploy** | Alinhar times antes do deploy | Engenharia, GS, Atendimento, Suporte | `references/briefing-deploy.md` |

## Como usar

1. Identifique qual tipo de documento o usuário precisa (pergunte se não ficar claro)
2. Leia o arquivo de referência correspondente antes de gerar qualquer conteúdo
3. Siga rigorosamente o template definido na referência
4. Preencha com as informações fornecidas pelo usuário
5. Sinalize campos que ficaram em branco para o usuário completar

Se o usuário pedir mais de um tipo ao mesmo tempo (ex: "quero a doc completa e o briefing de deploy"),
gere cada um separadamente seguindo seu respectivo template.

## Regras gerais

- Sempre use linguagem clara e objetiva, sem jargão desnecessário
- Campos obrigatórios nunca devem ser omitidos — se a informação não foi fornecida, deixe como `[PREENCHER]`
- Quando houver checklist (como no Briefing Deploy), mantenha o formato de checkboxes
- Para Release Notes no Teams, lembre o usuário de marcar os stakeholders dos times impactados
- Pergunte ao usuário se ele quer a FAQ embutida na documentação completa ou como documento separado