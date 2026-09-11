# n8n-nodes-bitrix

## Basic Information

- Package: `n8n-nodes-bitrix`
- Category: 🔧 Utilities & Tools
- Version: 1.3.0
- Maintainer: dewocom
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-bitrix)
- Repository: [View Source](https://github.com/dewocom/n8n-nodes-bitrix)

## Description

n8n node for bitrix rest api

## Installation

```
n8n-nodes-bitrix
```

## Nodes (1)

### Bitrix

- Node Type: `n8n-nodes-bitrix.bitrix`
- Version: 1
- Requires Credentials: Yes

Consume Bitrix24 REST API

#### Available Operations

- **Create** (`add`)
  Create a new entity record
- **Delete** (`delete`)
  Delete an entity record by ID
- **Get** (`get`)
  Retrieve a specific record by ID
- **Get Fields Description** (`fields`)
  Retrieve metadata about all available fields
- **List** (`list`)
  Retrieve filtered list of records
- **Update** (`update`)
  Modify an existing record by ID

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `entityTypeId` | options | Yes | `""` |
| `id` | string | Yes | `""` |
| `apiMethod` | string | Yes | `""` |
| `authentication` | options | No | `"bitrixOAuth2Api"` |
| `resource` | options | No | `"crm.deal"` |
| `operation` | options | No | `"add"` |
| `operation` | options | No | `"custom"` |
| `inputType` | options | No | `"fields"` |
| `fields` | fixedCollection | No | `{}` |
| `fields` | fixedCollection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Bitrix",
  "type": "n8n-nodes-bitrix.bitrix",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "entityTypeId": "",
    "id": "",
    "apiMethod": "",
    "operation": "add"
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
