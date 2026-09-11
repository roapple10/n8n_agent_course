# n8n 中如何使用 MCP (Model Context Protocol)

> **2025 趨勢**：MCP (Model Context Protocol) 是由 Anthropic 提出的開放標準，旨在標準化 LLM 與外部數據和工具的連接方式。可以把它想像成 **AI 時代的 USB-C 接口**。

在 n8n 中，我們可以通過 MCP 實現兩種強大的模式：讓 n8n 調用外部 MCP 工具（作為客戶端），以及讓外部 AI 調用 n8n 流程（作為伺服器）。

---

##  什麼是 MCP？

簡單來說，MCP 解決了「每個 AI 模型都要單獨寫適配器來連接工具」的痛點。
- 以前：要讓 GPT 連接 Google Drive，需要寫一套代碼；要讓 Claude 連接 Google Drive，又要寫一套。
- 現在：Google Drive 提供一個 MCP Server，GPT 和 Claude 都可以直接通過 MCP Client 連接它。

---

##  n8n 中的 MCP 支持

目前 n8n 對 MCP 的支持主要通過 **Community Node (社區節點)** 來實現，核心節點是 `n8n-nodes-mcp`。

### 1. 安裝 MCP 節點
由於這是社區節點，你需要自託管 (Self-hosted) 的 n8n 才能安裝。
1. 進入 n8n -> **Settings** -> **Community Nodes**。
2. 點擊 **Install**，輸入 `n8n-nodes-mcp`。
3. 安裝完成後，你在節點面板搜尋 "MCP" 就能看到了。

---

##  模式一：n8n 作為 MCP Client (客戶端)

在這個模式下，n8n 的 **AI Agent** 可以使用外部運行的 MCP Server 提供的工具。

**場景**：你已經有一個運行在本地的 MCP Server (例如連接了本地文件系統的 server)，你想讓 n8n 的 AI Agent 能讀取你電腦裡的本地文件。

**配置步驟**：
1. **拖入 MCP Tool 節點**（注意是 Tool 類型）。
2. **配置連接**：輸入 MCP Server 的連接方式 (通常是 SSE 或 Stdio，n8n 目前主要支持基於網路的連接)。
3. **連接 Agent**：將這個 MCP Tool 節點連接到 AI Agent 節點的 `Tools` 輸入端。
4. **運行**：AI Agent 會自動發現 MCP Server 裡有哪些工具（例如 `read_file`, `list_directory`），並在需要時調用它們。

---

##  模式二：n8n 作為 MCP Server (伺服器)

在這個模式下，n8n 把自己變成一個 MCP Server，向外部的 AI (例如你電腦上運行的 Claude Desktop App) 暴露工具。

**場景**：你在使用 Claude Desktop App，你想讓 Claude 能直接觸發你在 n8n 裡寫好的自動化流程（比如「幫我發送到 Slack」）。

**配置步驟**：
1. **拖入 MCP Trigger 節點**：這會作為工作流的起點。
2. **定義工具**：在 Trigger 節點中定義工具名稱（如 `send_slack_message`）和參數 Schema (JSON Schema)。
3. **連接流程**：Trigger 後面接上具體的業務邏輯 (Slack 節點)。
4. **配置 Claude Desktop**：在 Claude Desktop 的設定檔 `claude_desktop_config.json` 中，添加 n8n 的 MCP Server 地址。

```json
{
  "mcpServers": {
    "n8n-flow": {
      "command": "node",
      "args": ["path/to/mcp-client-proxy", "http://your-n8n-instance:5678/webhook/mcp"]
    }
  }
}
```
*(注意：具體配置取決於 n8n MCP 節點的實現方式，通常需要一個中轉適配器)*

---

##  MCP vs Native Tools (原生工具)

| 特性 | n8n 原生工具 (Custom Workflow Tool) | MCP 工具 |
|------|-----------------------------------|----------|
| **易用性** | ⭐⭐⭐ (直接拖拽配置) | ⭐⭐ (需要理解 Server/Client 概念) |
| **通用性** | 僅限 n8n 內部使用 | **通用** (Claude, Cursor, n8n 都能用) |
| **生態度** | n8n 自帶 1000+ | 快速增長的 MCP 開源生態 |
| **適用場景** | 快速構建內部自動化 | 連接外部專業開發工具或本地資源 |

---

##  總結

- 如果你只是想在 n8n 內部做自動化，優先使用 **n8n 原生工具**。
- 如果你想利用 **Claude Desktop** 或 **Cursor** 等外部強大 AI 來調用你的 n8n 自動化能力，或者想在 n8n 裡使用一些特殊的開源 MCP 工具，那麼 **MCP** 是你的最佳選擇。

隨著 2025 年 MCP 生態的爆發，掌握這個協議將讓你的 AI Agent 如虎添翼。
