# n8n-nodes-transcript-lol

## Basic Information

- Package: `n8n-nodes-transcript-lol`
- Category: 🤖 AI & Voice Tools
- Version: 0.3.3
- Maintainer: pkpio
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-transcript-lol)
- Repository: [View Source](https://github.com/transcript-lol/n8n-nodes-transcript-lol)

## Description

n8n community node for Transcript.lol - AI-powered audio and video transcription service

## Installation

```
n8n-nodes-transcript-lol
```

## Nodes (2)

### Transcript LOL

- Node Type: `n8n-nodes-transcript-lol.transcriptLol`
- Version: 1
- Requires Credentials: Yes

Create recordings and get transcripts from Transcript LOL

#### Available Operations

- **Create** (`create`)
  Create a new recording for transcription
- **Get** (`get`)
  Get a recording by ID
- **Get Many** (`getMany`)
  Get many recordings from a workspace

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `language` | options | Yes | `"en"` |
| `workspaceId` | options | Yes | `""` |
| `recordingId` | string | Yes | `""` |
| `title` | string | Yes | `""` |
| `sourceUrl` | string | Yes | `""` |
| `workspaceId` | options | Yes | `""` |
| `recordingId` | string | Yes | `""` |
| `resource` | options | No | `"recording"` |
| `operation` | options | No | `"create"` |
| `operation` | options | No | `"get"` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Transcript LOL",
  "type": "n8n-nodes-transcript-lol.transcriptLol",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "language": "en",
    "workspaceId": "",
    "recordingId": "",
    "title": "",
    "sourceUrl": "",
    "operation": "create"
  }
}
```

---

### Transcript LOL Trigger

- Node Type: `n8n-nodes-transcript-lol.transcriptLolTrigger`
- Version: 1
- Requires Credentials: Yes

Starts the workflow when a Transcript.lol event occurs

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `event` | options | Yes | `"TRANSCRIPT_CREATED"` |
| `workspaceId` | options | Yes | `""` |
| `options` | collection | No | `{}` |

#### Connection

- Input Types: 
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Transcript LOL Trigger",
  "type": "n8n-nodes-transcript-lol.transcriptLolTrigger",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "event": "TRANSCRIPT_CREATED",
    "workspaceId": ""
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
