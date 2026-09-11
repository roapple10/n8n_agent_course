# @asaasbr/n8n-nodes-asaas

## Basic Information

- Package: `@asaasbr/n8n-nodes-asaas`
- Category: 🔧 Utilities & Tools
- Version: 1.1.3
- Maintainer: asaas-pagamentos
- npm: [View Package](https://www.npmjs.com/package/@asaasbr/n8n-nodes-asaas)
- Repository: [View Source](https://github.com/asaasdev/n8n-plugin-asaas)

## Description

n8n nodes for integrating with the Asaas API

## Installation

```
@asaasbr/n8n-nodes-asaas
```

## Nodes (1)

### Asaas

- Node Type: `@asaasbr/n8n-nodes-asaas.asaas`
- Version: 1
- Requires Credentials: Yes

Interagir com a API do Asaas

#### Available Operations

- **Atualizar Status Da Antecipação Automática** (`updateAutomaticStatus`)
- **Cancelar Antecipação** (`cancel`)
- **Get Many** (`getAll`)
- **Recuperar Antecipação** (`get`)
- **Recuperar Limites De Antecipações** (`getLimits`)
- **Recuperar Status Da Antecipação Automática** (`getAutomaticStatus`)
- **Simular Antecipação** (`simulate`)
- **Solicitar Antecipação** (`request`)

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `value` | number | Yes | `0` |
| `value` | number | Yes | `0` |
| `value` | number | Yes | `0` |
| `value` | number | Yes | `0` |
| `value` | number | Yes | `0` |
| `url` | string | Yes | `""` |
| `billingTypes` | fixedCollection | Yes | `{}` |
| `chargeTypes` | fixedCollection | Yes | `{}` |
| `items` | fixedCollection | Yes | `{}` |
| `callback` | collection | Yes | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Asaas",
  "type": "@asaasbr/n8n-nodes-asaas.asaas",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "value": 0,
    "operation": "updateAutomaticStatus"
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
