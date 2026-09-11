# n8n-nodes-palatine-speech

## Basic Information

- Package: `n8n-nodes-palatine-speech`
- Category: 🤖 AI & Voice Tools
- Version: 1.1.1
- Maintainer: palatine_zealot
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-palatine-speech)
- Repository: [View Source](https://github.com/PalatineVision/n8n-nodes-palatine-speech)

## Description

n8n node for integrating Palatine Speech API into workflow

## Installation

```
n8n-nodes-palatine-speech
```

## Nodes (1)

### Palatine Speech

- Node Type: `n8n-nodes-palatine-speech.palatineSpeech`
- Version: 3
- Requires Credentials: Yes

Transcribe audio, diarize speakers, analyze sentiment, generate AI summaries, or use OpenAI-compatible LLM Chat Completions via Palatine. Keywords: n8n-community-node-package, n8n, palatine, speech-to-text, transcribe, transcription, stt, audio, ai, automation, voice-to-text, speech-recognition, audio-transcription, audio2text, audio-processing, diarization, speaker-diarization, speaker-segmentation, summarization, audio-summarization, sentiment-analysis, emotion-detection, tone-analysis, llm, chat-completions, openai-compatible, structured-output, json-schema

#### Available Operations

- **Transcribe** (`transcribe`)
  Convert speech in an audio file to text
- **Diarize** (`diarize`)
  Split audio by speakers and return timestamps
- **Sentiment Analysis** (`sentiment`)
  Detect sentiment/emotion in audio
- **Summarize File** (`summarizeFile`)
  Generate an AI summary of an uploaded file

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `llmModel` | resourceLocator | Yes | `{"mode":"list","value":""}` |
| `userMessage` | string | Yes | `""` |
| `binaryProperty` | string | Yes | `"data"` |
| `binaryProperty` | string | Yes | `"data"` |
| `resource` | options | No | `"audio"` |
| `operation` | options | No | `"transcribe"` |
| `operation` | options | No | `"chatCompletions"` |
| `model` | options | No | `"palatine_small"` |
| `responseFormat` | options | No | `"json"` |
| `summarizeTask` | options | No | `"meeting_summary"` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Palatine Speech",
  "type": "n8n-nodes-palatine-speech.palatineSpeech",
  "typeVersion": 3,
  "position": [
    250,
    300
  ],
  "parameters": {
    "llmModel": {
      "mode": "list",
      "value": ""
    },
    "userMessage": "",
    "binaryProperty": "data",
    "operation": "transcribe"
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
