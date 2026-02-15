---
name: listen
description: Lê a última interação em voz alta usando edge-tts (vozes neurais). Use quando o usuário pedir para ouvir, reproduzir, escutar ou ler em voz alta a última resposta ou interação. Também acione quando o usuário mencionar termos como "listen", "ouça", "fale", "leia em voz alta", "text-to-speech", "TTS", ou qualquer variação relacionada a áudio da resposta.
---

# Listen

Lê a última resposta da conversa em voz alta usando edge-tts (text-to-speech neural) e reproduz o áudio automaticamente.

## Como usar

1. **Identifique sua resposta anterior** nesta conversa (não inclua mensagens do usuário).

2. **Prepare o texto**:
   - Remova emojis e caracteres especiais problemáticos
   - Mantenha apenas o texto principal da resposta

3. **Escolha a voz apropriada** baseada no idioma:
   - **Português**: Use `pt-BR-FranciscaNeural`
   - **Inglês**: Use `en-US-JennyNeural`

4. **Gere e reproduza o áudio**:

   Para textos curtos (até ~200 caracteres):
   ```bash
   edge-tts --voice "pt-BR-FranciscaNeural" --text "TEXTO_AQUI" --write-media /tmp/listen_output.mp3 && afplay /tmp/listen_output.mp3
   ```

   Para textos longos (recomendado - use heredoc para textos multilinha):
   ```bash
   cat > /tmp/listen_input.txt << 'EOF'
   TEXTO_AQUI
   EOF

   edge-tts --voice "pt-BR-FranciscaNeural" --file /tmp/listen_input.txt --write-media /tmp/listen_output.mp3 && afplay /tmp/listen_output.mp3
   ```

   Ou comando único para textos longos:
   ```bash
   cat > /tmp/listen_input.txt << 'EOF'
   TEXTO_AQUI
   EOF

   edge-tts --voice "pt-BR-FranciscaNeural" --file /tmp/listen_input.txt --write-media /tmp/listen_output.mp3 && afplay /tmp/listen_output.mp3
   ```

## Notas importantes

- **Use heredoc com cat** para criar arquivos temporários - evita problemas com aspas e caracteres especiais
- **Use a abordagem de arquivo** (`--file`) para textos longos ou com formatação complexa
- **Arquivos temporários** são salvos em `/tmp/listen_*` e serão limpos automaticamente pelo sistema
- **Formato de áudio**: MP3 (compatível com afplay no macOS)
- **Não use Write** para arquivos temporários - o sistema exige leitura prévia, causando erros desnecessários

## Ferramentas permitidas

- `Bash(edge-tts*)` - Geração de áudio neural
- `Bash(afplay*)` - Reprodução de áudio no macOS
- `Bash(cat > /tmp/listen_*)` - Criação de arquivos temporários com heredoc
