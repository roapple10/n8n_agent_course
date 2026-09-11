# n8n-nodes-docx-to-md

## Basic Information

- Package: `n8n-nodes-docx-to-md`
- Category: 📄 Document Processing
- Version: 0.2.2
- Maintainer: sfrangulov
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-docx-to-md)
- Repository: [View Source](https://github.com/sfrangulov/n8n-nodes-docx-to-md)

## Description

n8n node to convert Docx files to Markdown

## Installation

```
n8n-nodes-docx-to-md
```

## Nodes (1)

### Docx to Markdown

- Node Type: `n8n-nodes-docx-to-md.docxToMd`
- Version: 1

Converts Docx file to Markdown

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `inputBinaryField` | string | Yes | `"data"` |
| `destinationOutputField` | string | Yes | `"text"` |
| `removeImages` | boolean | No | `false` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Docx to Markdown",
  "type": "n8n-nodes-docx-to-md.docxToMd",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "inputBinaryField": "data",
    "destinationOutputField": "text"
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
