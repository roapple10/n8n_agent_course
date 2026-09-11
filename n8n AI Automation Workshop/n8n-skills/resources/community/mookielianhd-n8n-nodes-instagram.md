# @mookielianhd/n8n-nodes-instagram

## Basic Information

- Package: `@mookielianhd/n8n-nodes-instagram`
- Category: 🔧 Utilities & Tools
- Version: 3.4.0
- Maintainer: mookielian
- npm: [View Package](https://www.npmjs.com/package/@mookielianhd/n8n-nodes-instagram)
- Repository: [View Source](https://github.com/MookieLian/n8n-nodes-instagram)

## Description

Instagram node for n8n

## Installation

```
@mookielianhd/n8n-nodes-instagram
```

## Nodes (2)

### Instagram

- Node Type: `@mookielianhd/n8n-nodes-instagram.instagram`
- Version: 1
- Requires Credentials: Yes

Publish media to Instagram using Facebook Graph API

#### Available Operations

- **Publish** (`publish`)
  Publish the selected media type (image, reel, or story) to Instagram

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"image"` |
| `operation` | options | Yes | `"publish"` |
| `operation` | options | Yes | `"getInstagramAccount"` |
| `operation` | options | Yes | `"publish"` |
| `operation` | options | Yes | `"list"` |
| `operation` | options | Yes | `"get"` |
| `operation` | options | Yes | `"refreshAccessToken"` |
| `operation` | options | Yes | `"search"` |
| `operation` | options | Yes | `"sendMessage"` |
| `node` | string | Yes | `""` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Instagram",
  "type": "@mookielianhd/n8n-nodes-instagram.instagram",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "image",
    "operation": "publish"
  }
}
```

---

### Instagram Trigger

- Node Type: `@mookielianhd/n8n-nodes-instagram.instagramTrigger`
- Version: 2
- Requires Credentials: Yes

Instagram trigger to receive real-time webhook events from Meta and start a workflow when an event is received.

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `verifyToken` | string | Yes | `""` |
| `eventsToInclude` | multiOptions | No | `[]` |
| `skipSignatureVerification` | boolean | No | `true` |

#### Connection

- Input Types: 
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Instagram Trigger",
  "type": "@mookielianhd/n8n-nodes-instagram.instagramTrigger",
  "typeVersion": 2,
  "position": [
    250,
    300
  ],
  "parameters": {
    "verifyToken": ""
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
