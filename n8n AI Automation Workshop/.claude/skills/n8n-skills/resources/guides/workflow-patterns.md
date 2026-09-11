# Common Workflow Patterns

Here are common workflow patterns you can use as a starting point.

## 1. HTTP Data Fetching

Fetch data from APIs and process it

Nodes used:
- HTTP Request
- Set
- IF

Example: Use HTTP Request node to fetch data from external APIs, Set node to transform formats, and IF node for conditional logic

## 2. Email Automation

Monitor emails and auto-respond or forward

Nodes used:
- Email Trigger (IMAP)
- Gmail
- IF

Example: Use Email Trigger to monitor inbox, IF node to filter specific conditions, and Gmail node to auto-reply or forward

## 3. Database Synchronization

Sync data between different systems

Nodes used:
- Schedule Trigger
- HTTP Request
- Postgres
- MySQL

Example: Scheduled trigger to read data from one database, transform it, and write to another database

## 4. Webhook Processing

Receive external webhooks and trigger actions

Nodes used:
- Webhook
- Set
- HTTP Request
- Slack

Example: Receive webhook events, process data, and send notifications to Slack or other systems

## 5. AI Assistant Integration

Use AI models to process and generate content

Nodes used:
- AI Agent
- OpenAI
- Vector Store
- Embeddings OpenAI

Example: Build AI assistants to handle user queries, integrate vector databases for semantic search

## 6. File Processing

Automatically process and transform files

Nodes used:
- Google Drive Trigger
- Extract from File
- Move Binary Data
- Dropbox

Example: Monitor Google Drive for new files, extract and process content, then upload to Dropbox

## Complete Template Library

We have collected 20 popular workflow templates from n8n.io, categorized by use case:

- [AI & Chatbots](../templates/ai-chatbots/README.md) - AI Agents, RAG systems, intelligent conversations
- [Social Media & Video](../templates/social-media/README.md) - TikTok, Instagram, YouTube automation
- [Data Processing & Analysis](../templates/data-processing/README.md) - Google Sheets, database integration
- [Communication & Collaboration](../templates/communication/README.md) - Email, WhatsApp, Telegram automation

See the [complete template index](../templates/README.md) for all available templates.
