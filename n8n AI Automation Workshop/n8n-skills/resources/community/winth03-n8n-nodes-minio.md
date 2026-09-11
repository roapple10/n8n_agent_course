# @winth03/n8n-nodes-minio

## Basic Information

- Package: `@winth03/n8n-nodes-minio`
- Category: 🔧 Utilities & Tools
- Version: 1.3.0
- Maintainer: winth03
- npm: [View Package](https://www.npmjs.com/package/@winth03/n8n-nodes-minio)
- Repository: [View Source](https://github.com/winth03/n8n-nodes-minio)

## Description

n8n node wrapper for the official MinIO JavaScript SDK

## Installation

```
@winth03/n8n-nodes-minio
```

## Nodes (1)

### MinIO

- Node Type: `@winth03/n8n-nodes-minio.minIo`
- Version: 1
- Requires Credentials: Yes

Connect to your MinIO server

#### Available Operations

- **List** (`list`)
  Lists all buckets owned by the authenticated user
- **Make** (`make`)
  Creates a new bucket with the specified name
- **Remove** (`remove`)
  Removes an empty bucket
- **Exists** (`exists`)
  Checks if a bucket exists and is accessible

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `bucketName` | resourceLocator | Yes | `{"mode":"list","value":""}` |
| `bucketName` | string | Yes | `""` |
| `bucketName` | resourceLocator | Yes | `{"mode":"list","value":""}` |
| `objectName` | resourceLocator | Yes | `{"mode":"list","value":""}` |
| `fieldName` | string | Yes | `"data"` |
| `bucketName` | resourceLocator | Yes | `{"mode":"list","value":""}` |
| `objectName` | resourceLocator | Yes | `{"mode":"list","value":""}` |
| `resource` | options | No | `"bucket"` |
| `operation` | options | No | `"list"` |
| `operation` | options | No | `"list"` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "MinIO",
  "type": "@winth03/n8n-nodes-minio.minIo",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "bucketName": {
      "mode": "list",
      "value": ""
    },
    "objectName": {
      "mode": "list",
      "value": ""
    },
    "fieldName": "data",
    "operation": "list"
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
