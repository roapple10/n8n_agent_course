# n8n-nodes-thang-zalo-app

## Basic Information

- Package: `n8n-nodes-thang-zalo-app`
- Category: 🔧 Utilities & Tools
- Version: 1.1.5
- Maintainer: ntnguyenthangtn
- npm: [View Package](https://www.npmjs.com/package/n8n-nodes-thang-zalo-app)

## Description

Các node udng2 để hỗ trợ người dùng zalo

## Installation

```
n8n-nodes-thang-zalo-app
```

## Nodes (6)

### Zalo Login Via QR Code

- Node Type: `n8n-nodes-thang-zalo-app.zaloLoginByQr`
- Version: 1
- Requires Credentials: Yes

Đăng nhập Zalo bằng QR code và lưu thông tin vào Credential

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `proxy` | string | No | `""` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Zalo Login Via QR Code",
  "type": "n8n-nodes-thang-zalo-app.zaloLoginByQr",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {}
}
```

---

### Zalo Send Message

- Node Type: `n8n-nodes-thang-zalo-app.zaloSendMessage`
- Version: 4
- Requires Credentials: Yes

Gửi tin nhắn qua API Zalo sử dụng kết nối đăng nhập bằng cookie

#### Available Operations

- **Gửi tin nhắn** (`sendMessage`)
  Gửi tin nhắn
- **Gửi trạng thái tin nhắn** (`sendMessageStatus`)
  Gửi trạng thái tin nhắn

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `threadId` | string | Yes | `""` |
| `message` | string | Yes | `""` |
| `threadId` | string | Yes | `""` |
| `resource` | options | No | `"zaloSendMessage"` |
| `operation` | options | No | `"sendMessage"` |
| `type` | options | No | `0` |
| `urgency` | options | No | `0` |
| `quote` | collection | No | `{}` |
| `mentions` | collection | No | `{}` |
| `attachments` | fixedCollection | No | `{}` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Zalo Send Message",
  "type": "n8n-nodes-thang-zalo-app.zaloSendMessage",
  "typeVersion": 4,
  "position": [
    250,
    300
  ],
  "parameters": {
    "threadId": "",
    "message": "",
    "operation": "sendMessage"
  }
}
```

---

### Zalo User

- Node Type: `n8n-nodes-thang-zalo-app.zaloUser`
- Version: 1
- Requires Credentials: Yes

Quản lý người dùng Zalo

#### Available Operations

- **Chấp nhận lời mời kết bạn** (`acceptFriendRequest`)
- **Gửi lời mời kết bạn** (`sendFriendRequest`)
  Gửi lời mời kết bạn
- **Chặn người dùng** (`blockUser`)
  Chặn người dùng
- **Bỏ chặn người dùng** (`unblockUser`)
  Bỏ chặn người dùng
- **Đổi ảnh đại diện (Không hỗ trợ)** (`changeAccountAvatar`)
  Đổi ảnh đại diện - Không được hỗ trợ trong phiên bản API hiện tại
- **Thay đổi cài đặt tài khoản (Không hỗ trợ)** (`changeAccountSetting`)
  Thay đổi cài đặt tài khoản - Không được hỗ trợ trong phiên bản API hiện tại
- **Lấy thông tin người dùng** (`getUserInfo`)
  Lấy thông tin người dùng
- **Lấy danh sách bạn bè** (`getAllFriends`)
  Lấy danh sách bạn bè
- **Tìm kiếm người dùng** (`findUser`)
  Tìm kiếm người dùng

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `gender` | options | Yes | `1` |
| `userId` | string | Yes | `""` |
| `userId` | string | Yes | `""` |
| `message` | string | Yes | `""` |
| `userId` | string | Yes | `""` |
| `userId` | string | Yes | `""` |
| `userId` | string | Yes | `""` |
| `filePath` | string | Yes | `""` |
| `name` | string | Yes | `""` |
| `dob` | string | Yes | `""` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Zalo User",
  "type": "n8n-nodes-thang-zalo-app.zaloUser",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "gender": 1,
    "userId": "",
    "message": "",
    "operation": "acceptFriendRequest"
  }
}
```

---

### Zalo Group

- Node Type: `n8n-nodes-thang-zalo-app.zaloGroup`
- Version: 1
- Requires Credentials: Yes

Quản lý nhóm Zalo

#### Available Operations

- **Tạo Nhóm** (`createGroup`)
  Tạo một nhóm mới
- **Lấy Thông Tin Nhóm** (`getGroupInfo`)
  Lấy thông tin của một nhóm
- **Thêm Phó Nhóm** (`addGroupDeputy`)
  Thêm phó nhóm cho một nhóm
- **Thêm Thành Viên Vào Nhóm** (`addUserToGroup`)
  Thêm thành viên vào nhóm
- **Đổi Avatar Nhóm** (`changeGroupAvatar`)
  Đổi avatar của nhóm
- **Đổi Tên Nhóm** (`changeGroupName`)
  Đổi tên của nhóm
- **Lấy Danh Sách Thành Viên** (`getGroupMembers`)
  Lấy danh sách thành viên của nhóm
- **Lấy Tất Cả Nhóm** (`getAllGroups`)
  Lấy danh sách tất cả các nhóm
- **Xóa Thành Viên Khỏi Nhóm** (`removeUserFromGroup`)
  Xóa thành viên khỏi nhóm

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `groupName` | string | Yes | `""` |
| `userIds` | string | Yes | `""` |
| `groupId` | string | Yes | `""` |
| `groupId` | string | Yes | `""` |
| `userId` | string | Yes | `""` |
| `groupId` | string | Yes | `""` |
| `userIds` | string | Yes | `""` |
| `groupId` | string | Yes | `""` |
| `imageUrl` | string | Yes | `""` |
| `groupId` | string | Yes | `""` |

#### Connection

- Input Types: `main`
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Zalo Group",
  "type": "n8n-nodes-thang-zalo-app.zaloGroup",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "groupName": "",
    "userIds": "",
    "groupId": "",
    "userId": "",
    "operation": "createGroup"
  }
}
```

---

### Zalo Message Trigger

- Node Type: `n8n-nodes-thang-zalo-app.zaloMessageTrigger`
- Version: 1
- Requires Credentials: Yes

Sự kiện lắng nghe tin nhắn trên Zalo với hỗ trợ voice-to-text

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `eventTypes` | multiOptions | Yes | `[0,1]` |
| `selfListen` | boolean | Yes | `false` |
| `enableVoiceProcessing` | boolean | Yes | `true` |
| `languageDetectMode` | options | No | `"auto"` |
| `manualLanguage` | options | No | `"vi"` |

#### Connection

- Input Types: 
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Zalo Message Trigger",
  "type": "n8n-nodes-thang-zalo-app.zaloMessageTrigger",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "eventTypes": [
      0,
      1
    ],
    "selfListen": false,
    "enableVoiceProcessing": true
  }
}
```

---

### Zalo Friend Trigger

- Node Type: `n8n-nodes-thang-zalo-app.zaloFriendTrigger`
- Version: 1
- Requires Credentials: Yes

Lắng nghe sự kiện kết bạn trên Zalo

#### Core Properties

| Property | Type | Required | Default |
|----------|------|----------|---------|
| `eventTypes` | multiOptions | Yes | `[2]` |

#### Connection

- Input Types: 
- Output Types: `main`

#### Example Configuration

```json
{
  "name": "Zalo Friend Trigger",
  "type": "n8n-nodes-thang-zalo-app.zaloFriendTrigger",
  "typeVersion": 1,
  "position": [
    250,
    300
  ],
  "parameters": {
    "eventTypes": [
      2
    ]
  }
}
```

---

---

[← Back to Community Nodes Index](README.md)
