# @digital-boss/n8n-nodes-odoo-trigger

## Basic Information

- Package: `@digital-boss/n8n-nodes-odoo-trigger`
- Category: 🔧 Utilities & Tools
- Version: 1.1.3
- Maintainer: feelgood-interface
- npm: [View Package](https://www.npmjs.com/package/@digital-boss/n8n-nodes-odoo-trigger)
- Repository: [View Source](https://github.com/digital-boss/n8n-nodes-odoo-trigger)

## Description

Odoo-trigger support for n8n

## Installation

```
@digital-boss/n8n-nodes-odoo-trigger
```

## Nodes (1)

### Odoo Trigger

- Node Type: `@digital-boss/n8n-nodes-odoo-trigger.odooTrigger`
- Version: 1
- Requires Credentials: Yes

Handle Odoo events via webhooks (v.1.1.3)

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `trigger` | options | No | `"on_create"` |
| `odooResource` | options | No | `""` |

#### Connection

- Input Types: 
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Odoo Trigger",
  "type": "@digital-boss/n8n-nodes-odoo-trigger.odooTrigger",
  "typeVersion": 1,
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
