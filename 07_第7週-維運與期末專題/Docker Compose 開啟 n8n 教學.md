# 🚀 Docker Compose 啟動 n8n 與 Antigravity 連接 n8n-mcp 完整步驟

本教學說明如何透過 Docker Compose 啟動本機 n8n，並完成 Antigravity 連接 `n8n-mcp` 的設定與測試。

---

### **【前置準備】使用 Docker Compose 啟動本機 n8n**

1. 開啟 **Docker Desktop** 並確認已順利啟動。
2. 開啟 Terminal（PowerShell），切換至本週資料夾（`07_第7週-維運與期末專題`）：
   ```powershell
   docker compose up -d
   ```
3. 確認服務狀態為執行中：
   ```powershell
   docker compose ps
   ```
4. 開啟瀏覽器進入 [http://localhost:5678](http://localhost:5678)，首次啟動請依畫面建立本機帳號。

---

### **Step 1：全域安裝 n8n-mcp 套件**

開啟 Terminal（PowerShell），執行安裝指令：
```powershell
npm install -g n8n-mcp
```

---

### **Step 2：取得 n8n API Key**

1. 開啟瀏覽器進入本機 n8n：[http://localhost:5678](http://localhost:5678)
2. 點擊左下角 **Settings**（設定）→ **n8n API**。
3. 點擊 **Create an API key**。
4. 命名為 `Antigravity MCP` 並建立，複製產生的 API Key。

---

### **Step 3：前往並編輯 MCP 設定檔**

開啟 Antigravity MCP 設定檔：
👉 `C:\Users\User\.gemini\config\mcp_config.json`

貼上以下設定內容，並將 `"替換成你的_N8N_API_KEY"` 改為 Step 2 複製的 API Key：

```json
{
  "mcpServers": {
    "n8n-mcp": {
      "command": "npx",
      "args": ["-y", "n8n-mcp"],
      "env": {
        "MCP_MODE": "stdio",
        "LOG_LEVEL": "error",
        "DISABLE_CONSOLE_OUTPUT": "true",
        "N8N_API_URL": "http://localhost:5678",
        "N8N_BASE_URL": "http://localhost:5678",
        "N8N_API_KEY": "替換成你的_N8N_API_KEY"
      }
    }
  }
}
```

---

### **Step 4：在 Antigravity 對話框測試與操作**

對話框輸入測試指令範例：

* **連線測試**：
  > 「請使用 n8n-mcp 查詢 Manual Trigger 節點，確認是否連線成功。」
* **上傳工作流程**：
  > 「請使用 n8n-mcp 上傳 @[你的工作流程.json]」

---

### 💡 常用 Docker 維運指令

* **查看服務狀態**：`docker compose ps`
* **查看即時紀錄**：`docker compose logs -f n8n`
* **暫停服務**：`docker compose stop`
* **恢復服務**：`docker compose start`
* **停止服務（保留資料）**：`docker compose down`
