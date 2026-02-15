---
description: Lê a última interação em voz alta usando edge-tts (vozes neurais)
allowed-tools: Bash(edge-tts*), Bash(afplay*), Write(/tmp/listen_*)
---

Identifique sua resposta anterior nesta conversa.
Use o `edge-tts` para gerar o áudio e `afplay` para reproduzi-lo.

- Se o conteúdo estiver em português, use a voz `pt-BR-FranciscaNeural`.
- Se estiver em inglês, use a voz `en-US-JennyNeural`.

Passos:
1. Salve o texto da resposta anterior (sem emojis ou caracteres especiais problemáticos).
2. Execute o comando:
```
edge-tts --voice "VOICE" --text "TEXTO" --write-media /tmp/listen_output.mp3 && afplay /tmp/listen_output.mp3
```

Se o texto for muito longo, salve-o em um arquivo temporário e use `--file`:
```
echo "TEXTO" > /tmp/listen_input.txt
edge-tts --voice "VOICE" --file /tmp/listen_input.txt --write-media /tmp/listen_output.mp3 && afplay /tmp/listen_output.mp3
```

Certifique-se de escapar corretamente as aspas e caracteres especiais para o shell.
