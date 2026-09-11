# n8n-nodes-odoo-enhanced

## Basic Information

- Package: `n8n-nodes-odoo-enhanced`
- Category: 🔧 Utilities & Tools
- Version: 1.0.0
- Maintainer: jumox_8
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-odoo-enhanced)
- Repository: [View Source](https://github.com/votre-username/n8n-nodes-odoo-enhanced)

## Description

Enhanced Odoo node for n8n with features from PR #15676

## Installation

```
n8n-nodes-odoo-enhanced
```

## Nodes (1)

### Odoo Enhanced (PR15676)

- Node Type: `n8n-nodes-odoo-enhanced.odooEnhanced`
- Version: 2
- Requires Credentials: Yes

Consume Odoo API with enhanced features from PR #15676

#### Available Operations

- **Create** (`create`)
  Create a new item
- **Delete** (`delete`)
  Delete an item
- **Execute a Method** (`executeMethod`)
  Execute a method on a custom resource
- **Get** (`get`)
  Get an item
- **Get Many** (`getAll`)
  Get many items
- **Update** (`update`)
  Update an item

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `customFilterToggle` | boolean | Yes | `false` |
| `methodName` | string | Yes | `""` |
| `customResourceId` | string | Yes | `""` |
| `customResourceId` | string | Yes | `""` |
| `customResourceId` | string | Yes | `""` |
| `resource` | options | No | `"custom"` |
| `operation` | options | No | `"create"` |
| `basicFilter` | fixedCollection | No | `{}` |
| `methodArgs` | fixedCollection | No | `{}` |
| `methodKwargs` | fixedCollection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Odoo Enhanced (PR15676)",
  "type": "n8n-nodes-odoo-enhanced.odooEnhanced",
  "typeVersion": 2,
  "position": [
    250,
    300
  ],
  "parameters": {
    "customFilterToggle": false,
    "methodName": "",
    "customResourceId": "",
    "operation": "create"
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
