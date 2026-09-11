# n8n-nodes-chat-data

## Basic Information

- Package: `n8n-nodes-chat-data`
- Category: 💬 Communication & Messaging
- Version: 1.2.1
- Maintainer: chatdata
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-chat-data)
- Repository: [View Source](https://github.com/chat-data-llc/n8n-nodes-chat-data)

## Description

Chatdata integration for n8n. Manage chatbots, send messages, and retrieve leads from your Chatdata account.

## Installation

```
n8n-nodes-chat-data
```

## Nodes (2)

### Chat Data

- Node Type: `n8n-nodes-chat-data.chatData`
- Version: 1
- Requires Credentials: Yes

Basic Chat Data Node

#### Available Operations

- **Send a Message** (`sendMessage`)
  Send a message to a chat
- **Get Leads** (`getLeads`)
  Retrieve leads/customers from a chatbot
- **Get Conversations** (`getConversations`)
  Retrieve conversation history from a chatbot
- **Append a Message** (`appendMessage`)
  Append a message to an existing conversation as a human agent or assistant

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `messages` | fixedCollection | Yes | `{}` |
| `senderType` | options | Yes | `"bot"` |
| `chatbot_id` | options | Yes | `""` |
| `chatbot_id` | options | Yes | `""` |
| `limit` | number | Yes | `50` |
| `chatbot_id` | options | Yes | `""` |
| `limit` | number | Yes | `50` |
| `chatbot_id` | options | Yes | `""` |
| `conversationId` | string | Yes | `""` |
| `message` | string | Yes | `""` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Chat Data",
  "type": "n8n-nodes-chat-data.chatData",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "messages": {},
    "senderType": "bot",
    "chatbot_id": "",
    "limit": 50,
    "operation": "sendMessage"
  }
}
```

---

### Chat Data Trigger

- Node Type: `n8n-nodes-chat-data.chatDataTrigger`
- Version: 1
- Requires Credentials: Yes

Triggers workflows on Chat Data events

#### Available Operations

- **On Lead Submission** (`onLeadSubmission`)
  Trigger when a lead submission occurs
- **On Live Chat Escalation** (`onLiveChatEscalation`)
  Trigger when a chat is escalated to a live agent
- **On New Message** (`onNewMessage`)
  Trigger when a new chat message is received

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `chatbot_id` | options | Yes | `""` |
| `chatbot_id` | options | Yes | `""` |
| `chatbot_id` | options | Yes | `""` |
| `operation` | options | No | `"onNewMessage"` |
| `resource` | hidden | No | `"trigger"` |
| `options` | collection | No | `{}` |
| `options` | collection | No | `{}` |
| `options` | collection | No | `{}` |
| `webhook` | hidden | No | `"default"` |
| `webhook` | hidden | No | `"default"` |

#### Connection

- Input Types: 
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Chat Data Trigger",
  "type": "n8n-nodes-chat-data.chatDataTrigger",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "chatbot_id": "",
    "operation": "onLeadSubmission"
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
