# n8n-nodes-rd-station-crm

## Basic Information

- Package: `n8n-nodes-rd-station-crm`
- Category: 🔧 Utilities & Tools
- Version: 1.3.1
- Maintainer: pexuleco
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-rd-station-crm)
- Repository: [View Source](https://github.com/rdstation/n8n-nodes-rd-station-crm)

## Description

Nós personalizados do n8n para integração com a API do RD Station CRM (v1)

## Installation

```
n8n-nodes-rd-station-crm
```

## Nodes (13)

### RD Station CRM Contatos

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmContacts`
- Version: 1
- Requires Credentials: Yes

Operações com contatos no RD Station CRM

#### Available Operations

- **Criar** (`create`)
  Criar um novo contato
- **Atualizar** (`update`)
  Atualizar um contato existente
- **Listar** (`getAll`)
  Listar contatos
- **Obter** (`get`)
  Obter um contato pelo ID

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"contact"` |
| `contact_id` | string | Yes | `""` |
| `name` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `filters` | collection | No | `{}` |
| `contactData` | collection | No | `{}` |
| `emails` | fixedCollection | No | `{}` |
| `phones` | fixedCollection | No | `{}` |
| `contact_custom_fields` | fixedCollection | No | `{}` |
| `legal_bases` | fixedCollection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Contatos",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmContacts",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "contact",
    "contact_id": "",
    "name": "",
    "operation": "create"
  }
}
```

---

### RD Station CRM Negociações

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmDeals`
- Version: 1
- Requires Credentials: Yes

Operações com negociações no RD Station CRM

#### Available Operations

- **Criar** (`create`)
  Criar uma nova negociação
- **Atualizar** (`update`)
  Atualizar uma negociação existente
- **Listar** (`getAll`)
  Listar negociações
- **Obter** (`get`)
  Obter uma negociação pelo ID
- **Listar Contatos** (`getContacts`)
  Listar contatos associados a uma negociação

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"deal"` |
| `deal_id` | string | Yes | `""` |
| `name` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `contacts` | fixedCollection | No | `{}` |
| `set_contacts` | fixedCollection | No | `{}` |
| `filters` | collection | No | `{}` |
| `periodFilters` | collection | No | `{}` |
| `dealData` | collection | No | `{}` |
| `deal_custom_fields` | fixedCollection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Negociações",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmDeals",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "deal",
    "deal_id": "",
    "name": "",
    "operation": "create"
  }
}
```

---

### RD Station CRM Tarefas

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmTasks`
- Version: 1
- Requires Credentials: Yes

Operações com tarefas no RD Station CRM

#### Available Operations

- **Criar** (`create`)
  Criar uma nova tarefa
- **Atualizar** (`update`)
  Atualizar uma tarefa existente
- **Listar** (`getAll`)
  Listar tarefas
- **Obter** (`get`)
  Obter uma tarefa pelo ID

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"task"` |
| `taskId` | string | Yes | `""` |
| `dealId` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `listParameters` | collection | No | `{}` |
| `taskData` | collection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Tarefas",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmTasks",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "task",
    "taskId": "",
    "dealId": "",
    "operation": "create"
  }
}
```

---

### RD Station CRM Notas

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmNotes`
- Version: 1
- Requires Credentials: Yes

Operações com anotações no RD Station CRM

#### Available Operations

- **Criar** (`create`)
  Criar uma nova anotação para um negócio
- **Listar** (`getAll`)
  Listar anotações

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"note"` |
| `dealId` | string | Yes | `""` |
| `userId` | string | Yes | `""` |
| `text` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `listParameters` | collection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Notas",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmNotes",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "note",
    "dealId": "",
    "userId": "",
    "text": "",
    "operation": "create"
  }
}
```

---

### RD Station CRM Organizações

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmCompanies`
- Version: 1
- Requires Credentials: Yes

Operações com organizações no RD Station CRM

#### Available Operations

- **Criar** (`create`)
  Criar uma nova organização
- **Atualizar** (`update`)
  Atualizar uma organização existente
- **Listar** (`getAll`)
  Listar organizações
- **Obter** (`get`)
  Obter uma organização pelo ID
- **Listar Contatos** (`getContacts`)
  Listar contatos associados a uma organização

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"organization"` |
| `organization_id` | string | Yes | `""` |
| `name` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `filters` | collection | No | `{}` |
| `organizationData` | collection | No | `{}` |
| `phones` | fixedCollection | No | `{}` |
| `organization_custom_fields` | fixedCollection | No | `{}` |
| `contactListParams` | collection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Organizações",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmCompanies",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "organization",
    "organization_id": "",
    "name": "",
    "operation": "create"
  }
}
```

---

### RD Station CRM Produtos em Negócios

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmDealProducts`
- Version: 1
- Requires Credentials: Yes

Gerenciar produtos em negociações no RD Station CRM

#### Available Operations

- **Adicionar** (`add`)
  Adicionar produtos a uma negociação
- **Atualizar** (`update`)
  Atualizar produtos em uma negociação
- **Remover** (`remove`)
  Remover produtos de uma negociação
- **Listar** (`getAll`)
  Listar todos os produtos de uma negociação

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"dealProduct"` |
| `dealId` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `productIds` | fixedCollection | No | `{}` |
| `products` | fixedCollection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Produtos em Negócios",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmDealProducts",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "dealProduct",
    "dealId": "",
    "operation": "add"
  }
}
```

---

### RD Station CRM Usuários

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmUsers`
- Version: 1
- Requires Credentials: Yes

Consultar usuários no RD Station CRM

#### Available Operations

- **Listar** (`getAll`)
  Listar todos os usuários
- **Obter** (`get`)
  Obter um usuário pelo ID

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"user"` |
| `userId` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `listParameters` | collection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Usuários",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmUsers",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "user",
    "userId": "",
    "operation": "getAll"
  }
}
```

---

### RD Station CRM Equipes

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmTeams`
- Version: 1
- Requires Credentials: Yes

Consultar equipes no RD Station CRM

#### Available Operations

- **Listar** (`getAll`)
  Listar todas as equipes
- **Obter** (`get`)
  Obter uma equipe pelo ID

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"team"` |
| `teamId` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `listParameters` | collection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Equipes",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmTeams",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "team",
    "teamId": "",
    "operation": "getAll"
  }
}
```

---

### RD Station CRM Funis

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmPipelines`
- Version: 1
- Requires Credentials: Yes

Consultar funis e etapas no RD Station CRM

#### Available Operations

- **Listar** (`getAll`)
  Listar todos os funis
- **Obter** (`get`)
  Obter um funil pelo ID

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"pipeline"` |
| `pipelineId` | string | Yes | `""` |
| `pipelineId` | string | Yes | `""` |
| `stageId` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `operation` | options | No | `"getAll"` |
| `listPipelineParameters` | collection | No | `{}` |
| `listStageParameters` | collection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Funis",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmPipelines",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "pipeline",
    "pipelineId": "",
    "stageId": "",
    "operation": "getAll"
  }
}
```

---

### RD Station CRM Campanhas

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmCampaigns`
- Version: 1
- Requires Credentials: Yes

Consultar campanhas no RD Station CRM

#### Available Operations

- **Listar** (`getAll`)
  Listar todas as campanhas
- **Obter** (`get`)
  Obter uma campanha pelo ID

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"campaign"` |
| `campaignId` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `listParameters` | collection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Campanhas",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmCampaigns",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "campaign",
    "campaignId": "",
    "operation": "getAll"
  }
}
```

---

### RD Station CRM Fontes

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmSources`
- Version: 1
- Requires Credentials: Yes

Consultar fontes de leads no RD Station CRM

#### Available Operations

- **Listar** (`getAll`)
  Listar todas as fontes
- **Obter** (`get`)
  Obter uma fonte pelo ID

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"source"` |
| `sourceId` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `listParameters` | collection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Fontes",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmSources",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "source",
    "sourceId": "",
    "operation": "getAll"
  }
}
```

---

### RD Station CRM Motivos de Perda

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmLossReasons`
- Version: 1
- Requires Credentials: Yes

Consultar motivos de perda no RD Station CRM

#### Available Operations

- **Listar** (`getAll`)
  Listar todos os motivos de perda
- **Obter** (`get`)
  Obter um motivo de perda pelo ID

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"lossReason"` |
| `lossReasonId` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `listParameters` | collection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Motivos de Perda",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmLossReasons",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "lossReason",
    "lossReasonId": "",
    "operation": "getAll"
  }
}
```

---

### RD Station CRM Webhooks

- Node Type: `n8n-nodes-rd-station-crm.rdStationCrmWebhooks`
- Version: 1
- Requires Credentials: Yes

Gerenciar webhooks no RD Station CRM

#### Available Operations

- **Listar** (`getAll`)
  Listar todos os webhooks
- **Obter** (`get`)
  Obter um webhook pelo ID
- **Criar** (`create`)
  Criar um novo webhook
- **Atualizar** (`update`)
  Atualizar um webhook existente
- **Deletar** (`delete`)
  Deletar um webhook

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `resource` | options | Yes | `"webhook"` |
| `webhookId` | string | Yes | `""` |
| `operation` | options | No | `"getAll"` |
| `listParameters` | collection | No | `{}` |
| `webhookData` | collection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "RD Station CRM Webhooks",
  "type": "n8n-nodes-rd-station-crm.rdStationCrmWebhooks",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "resource": "webhook",
    "webhookId": "",
    "operation": "getAll"
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
