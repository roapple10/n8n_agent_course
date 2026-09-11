# n8n-nodes-openpix

## Basic Information

- Package: `n8n-nodes-openpix`
- Category: 🔧 Utilities & Tools
- Version: 0.3.0
- Maintainer: fersilva
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-openpix)
- Repository: [View Source](https://github.com/open-pix/n8n-nodes-openpix)

## Description

n8n nodes for OpenPix

## Installation

```
n8n-nodes-openpix
```

## Nodes (2)

### OpenPix

- Node Type: `n8n-nodes-openpix.openpix`
- Version: 1
- Requires Credentials: Yes

Automate OpenPix workflow API

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `chargeValue` | number | No | `""` |
| `correlationID` | string | No | `""` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "OpenPix",
  "type": "n8n-nodes-openpix.openpix",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {}
}
```

---

### OpenPix Trigger

- Node Type: `n8n-nodes-openpix.openpixTrigger`
- Version: 1
- Requires Credentials: Yes

Handle OpenPix Events via Webhook

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `events` | options | Yes | `""` |

#### Connection

- Input Types: 
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "OpenPix Trigger",
  "type": "n8n-nodes-openpix.openpixTrigger",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "events": ""
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
