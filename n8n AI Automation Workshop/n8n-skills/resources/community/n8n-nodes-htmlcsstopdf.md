# n8n-nodes-htmlcsstopdf

## Basic Information

- Package: `n8n-nodes-htmlcsstopdf`
- Category: 🤖 AI & Voice Tools
- Version: 3.2.5
- Maintainer: htmlcsstoimage
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-htmlcsstopdf)
- Repository: [View Source](https://github.com/PdfMunk/n8n-nodes-htmltopdf)

## Description

n8n community node to convert HTML and CSS to PDF using PdfMunk API - perfect for invoices, reports, certificates, and document generation

## Installation

```
n8n-nodes-htmlcsstopdf
```

## Nodes (1)

### HTML to PDF

- Node Type: `n8n-nodes-htmlcsstopdf.htmlcsstopdf`
- Version: 1
- Requires Credentials: Yes

Convert HTML to PDF, Parse PDF, Extract Data, and Manage PDF Security

#### Available Operations

- **HTML to PDF** (`htmlToPdf`)
  Generate PDF from HTML/CSS
- **URL to PDF** (`urlToPdf`)
  Capture Website Screenshot to PDF

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | No | `"pdfCreation"` |
| `operation` | options | No | `"htmlToPdf"` |
| `operation` | options | No | `"mergePdfs"` |
| `operation` | options | No | `"lockPdf"` |
| `operation` | options | No | `"parsePdf"` |
| `url` | string | No | `"https://example.com"` |
| `output_format` | options | No | `"url"` |
| `dynamic_params` | fixedCollection | No | `{}` |
| `merge_input_type` | options | No | `"url"` |
| `merge_output` | options | No | `"url"` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "HTML to PDF",
  "type": "n8n-nodes-htmlcsstopdf.htmlcsstopdf",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "operation": "htmlToPdf"
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
