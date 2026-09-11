# n8n-nodes-qdrant

## Basic Information

- Package: `n8n-nodes-qdrant`
- Category: 🔧 Utilities & Tools
- Version: 0.2.1
- Maintainer: qdrant-tech
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-qdrant)
- Repository: [View Source](https://github.com/qdrant/n8n-nodes-qdrant)

## Description

Official n8n node to interface with Qdrant - https://qdrant.tech

## Installation

```
n8n-nodes-qdrant
```

## Nodes (1)

### Qdrant

- Node Type: `n8n-nodes-qdrant.qdrant`
- Version: 1
- Requires Credentials: Yes

Official n8n node to interface with Qdrant - https://qdrant.tech

#### Available Operations

- **List Collections** (`listCollections`)
  List all collections in the Qdrant instance
- **Create Collection** (`createCollection`)
  Create a new collection in the Qdrant instance
- **Update Collection** (`updateCollection`)
  Update parameters of an existing collection in the Qdrant instance
- **Get Collection** (`getCollection`)
  Get details of a specific collection
- **Check If Collection Exists** (`collectionExists`)
  Check if a collection exists in the Qdrant instance
- **Delete Collection** (`deleteCollection`)
  Delete the specified collection

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `query` | json | Yes | `"[0.532, 0.953, 0.123]"` |
| `collectionName` | string | Yes | `""` |
| `vectors` | json | Yes | `"{}"` |
| `collectionName` | resourceLocator | Yes | `{"mode":"list","value":null}` |
| `collectionName` | resourceLocator | Yes | `{"mode":"list","value":null}` |
| `collectionName` | string | Yes | `""` |
| `collectionName` | resourceLocator | Yes | `{"mode":"list","value":null}` |
| `collectionName` | resourceLocator | Yes | `{"mode":"list","value":null}` |
| `points` | json | Yes | `"[\n    {\n        \"id\": 0,\n        \"payload\": {\n            \"color\": \"red\",\n            \"age\": 32\n        },\n        \"vector\": [\n            0.9,\n            0.1,\n            0.1\n        ]\n    },\n    {\n        \"id\": 1,\n        \"payload\": {\n            \"color\": \"green\",\n            \"age\": 55\n        },\n        \"vector\": [\n            0.1,\n            0.9,\n            0.1\n        ]\n    }\n]"` |
| `collectionName` | resourceLocator | Yes | `{"mode":"list","value":null}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Qdrant",
  "type": "n8n-nodes-qdrant.qdrant",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "query": "[0.532, 0.953, 0.123]",
    "collectionName": {
      "mode": "list",
      "value": null
    },
    "vectors": "{}",
    "operation": "listCollections"
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
