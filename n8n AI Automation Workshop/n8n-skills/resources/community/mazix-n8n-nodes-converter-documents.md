# @mazix/n8n-nodes-converter-documents

## Basic Information

- Package: `@mazix/n8n-nodes-converter-documents`
- Category: 📄 Document Processing
- Version: 1.2.2
- Maintainer: mzxs
- npm: [View Package](https://www.npmjs.com/package/@mazix/n8n-nodes-converter-documents)
- Repository: [View Source](https://github.com/mazixs/n8n-node-converter-documents)

## Description

n8n node to convert various document formats (DOCX, DOC, XML, YML, XLSX, CSV, PDF, TXT, PPT, PPTX, HTML, JSON, ODT, ODP, ODS) to JSON or text format

## Installation

```
@mazix/n8n-nodes-converter-documents
```

## Nodes (1)

### Convert File to JSON

- Node Type: `@mazix/n8n-nodes-converter-documents.convertFileToJson`
- Version: 5

DOCX / XML / YML / XLSX / CSV / PDF / TXT / PPTX / HTML → JSON\|text

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `outputFormat` | options | No | `"text"` |
| `binaryPropertyName` | string | No | `"data"` |
| `maxFileSize` | number | No | `50` |
| `maxConcurrency` | number | No | `4` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Convert File to JSON",
  "type": "@mazix/n8n-nodes-converter-documents.convertFileToJson",
  "typeVersion": 5,
  "position": [
    250,
    300
  ],
  "parameters": {}
}
```

---

---

[← Back to Community Nodes Index](README.md)
