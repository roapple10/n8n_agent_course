# n8n-nodes-evo-go

## Basic Information

- Package: `n8n-nodes-evo-go`
- Category: 💬 Communication & Messaging
- Version: 1.0.4
- Maintainer: oriondesign
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-evo-go)
- Repository: [View Source](https://github.com/Administrador/n8n-nodes-evo-go)

## Description

Evolution Go API is a REST API developed in Go to integrate WhatsApp with applications, offering support for multiple instances and advanced messaging features.

## Installation

```
n8n-nodes-evo-go
```

## Nodes (1)

### EvoGo

- Node Type: `n8n-nodes-evo-go.evoGo`
- Version: 1
- Requires Credentials: Yes

EvoGo Node - integrate EvoGo in your n8n workflows

#### Available Operations

- **Create Instance** (`create`)
  Create a new instance in EvoGo
- **Delete Instance** (`delete`)
  Delete an instance from EvoGo
- **Delete Proxy** (`deleteProxy`)
  Delete proxy for an instance from EvoGo
- **Disconnect** (`disconnect`)
  Disconnect an instance from EvoGo
- **Fetch All Instances** (`fetchAll`)
  Get all instances from EvoGo
- **Fetch Instance** (`fetch`)
  Get a single instance by ID from EvoGo
- **Get Logs** (`getLogs`)
  Get logs for an instance
- **Get QR** (`getQr`)
  Get QR code for instance connection
- **Get Status** (`getStatus`)
  Get status of an instance
- **Instance Connect** (`instanceConnect`)
  Connect an instance to EvoGo
- ... and 3 more operations

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `sendButtonButtons` | fixedCollection | Yes | `{"values":[{"buttonType":"reply","displayText":"","id":""}]}` |
| `adminApiKey` | string | Yes | `""` |
| `instanceApiKey` | string | Yes | `""` |
| `pairPhone` | string | Yes | `""` |
| `sendTextNumber` | string | Yes | `""` |
| `sendTextContent` | string | Yes | `""` |
| `sendLinkNumber` | string | Yes | `""` |
| `sendLinkText` | string | Yes | `""` |
| `sendMediaNumber` | string | Yes | `""` |
| `sendMediaUrl` | string | Yes | `""` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "EvoGo",
  "type": "n8n-nodes-evo-go.evoGo",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "sendButtonButtons": {
      "values": [
        {
          "buttonType": "reply",
          "displayText": "",
          "id": ""
        }
      ]
    },
    "adminApiKey": "",
    "instanceApiKey": "",
    "pairPhone": "",
    "sendTextNumber": "",
    "operation": "create"
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
