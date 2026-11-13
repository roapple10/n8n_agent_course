# n8n MCP 入門：用 Antigravity Agent 建立與檢查工作流程

## 本課學習成果

完成練習後，你可以：

- 說明 MCP 如何讓 AI Agent 使用 n8n 工具。
- 在 Antigravity IDE 連接本機 n8n。
- 讓 Agent 查找 n8n 節點、建立測試工作流程並檢查設定。
- 在不啟用正式流程、不使用真實憑證的情況下，完成一個可重現的練習。

## 1. MCP 是什麼？

MCP 是 **Model Context Protocol** 的縮寫，是 AI 應用程式連接外部資料與工具的一種共同規格。可以把它想成 AI 工具的標準插座：Agent 不必為每個服務都用完全不同的方式整合，就能依照 MCP 規格發現工具、了解參數並提出呼叫。

MCP 連線中常見的角色：

| 角色 | 在本課的例子 | 用途 |
|---|---|---|
| Host | Antigravity IDE | 你與 Agent 工作的應用程式 |
| MCP Client | Antigravity 內的 MCP 連線功能 | 連到 MCP Server、傳送工具呼叫 |
| MCP Server | `n8n-mcp` | 提供 n8n 節點查詢、工作流程檢查及管理工具 |
| 外部系統 | 你的本機 n8n | 保存與執行工作流程 |

Agent 先根據你的需求選擇工具，再透過 MCP Client 呼叫 `n8n-mcp`；`n8n-mcp` 讀取節點資料或呼叫 n8n API，最後把結果交回 Agent。MCP 本身不會讓模型自動變聰明；它提供的是受設定與權限限制的連線能力。

## 2. n8n 有哪些 MCP 用法？

「n8n MCP」可能指不同功能，先認清它們的方向：

| 功能 | 方向 | 這堂課如何使用 |
|---|---|---|
| 社群專案 `n8n-mcp` | Antigravity Agent → `n8n-mcp` → 本機 n8n | 本課主要做法。查詢節點與範本、建立/修改工作流程、驗證和測試 |
| n8n Instance-level MCP | Antigravity Agent → n8n 內建 MCP Server | n8n 2.x 的內建替代連線；透過 `/mcp-server/http` 連線 |
| MCP Server Trigger | MCP Client → 單一 n8n 工作流程 | 將你設計的特定工作流程提供為 MCP 工具 |
| MCP Client Tool | n8n 的 AI Agent → 外部 MCP Server | 讓 n8n 內的 Agent 使用其他 MCP Server 提供的工具 |

本課使用 `n8n-mcp` 作為主要教學路徑，因為它也提供節點說明、範本搜尋與驗證工具，適合在 IDE 中開發。它不是 n8n 內建的 MCP Server Trigger 節點。n8n 的內建 MCP 連線會在第 8 節介紹。

## 3. `n8n-mcp` 可以做什麼？

連接本機 n8n 後，Antigravity Agent 可以透過 MCP 工具：

- 查詢節點、節點欄位及設定範例。
- 搜尋可延伸的工作流程範本。
- 驗證節點設定與工作流程結構。
- 列出、讀取、建立或修改 n8n 工作流程。
- 在確認觸發方式與影響後測試工作流程。

因此，Agent 不只根據模型記憶猜節點設定，也可以先查節點資料，再建立和檢查流程。工具實際能做什麼，仍取決於你連接的伺服器版本、n8n API 金鑰權限與 n8n 設定。

### 這堂課的連線方式

```text
Antigravity IDE 中的 Agent
          │ MCP / stdio
          ▼
本機 n8n-mcp 程序
          │ n8n Public API
          ▼
http://localhost:5678
```

Agent 和 n8n 在同一台電腦時，不需要 ngrok 或公開網域。若 Antigravity 在另一台電腦或容器中執行，`localhost` 會指向那台電腦或容器本身；必須另外安排可安全連線的網路，不能直接照抄本機網址。

## 4. 課前準備

請準備：

1. 已啟動的本機 n8n，並能在瀏覽器開啟 `http://localhost:5678`。
2. 已安裝 Antigravity IDE。
3. 已安裝 Node.js 與 npm；在終端機執行 `node -v`、`npm -v`，確認有顯示版本。
4. 一個只供練習的 n8n 測試環境。不要把 Agent 接到含正式流程或正式憑證的環境。

## 5. 安裝並連接 n8n MCP

### 步驟 A：先認識 API Key，再建立測試金鑰

#### API 和 API Key 是什麼？

API 可以想成兩個程式互相溝通時使用的服務窗口。這堂課中，Antigravity 裡的 Agent 透過 `n8n-mcp` 請本機 n8n 查詢或管理工作流程。n8n 需要確認「是哪位使用者提出請求」，所以要附上一把 API Key。可以把它想成一張有使用者身分的通行證：持有它的程式可以依照該使用者在 n8n 的權限呼叫 API。

這把 key 不是另外向網站申請，也不是 Groq 的模型金鑰；它是在你登入自己的 n8n 後自行建立。請只建立在自己的本機練習環境，並把它當成密碼保管。

| 名稱 | 用途 | 本課放置位置 |
|---|---|---|
| `N8N_API_KEY` | 讓 `n8n-mcp` 以你的 n8n 使用者身分呼叫 n8n Public API | Antigravity 的 `n8n-mcp` 設定 |
| Groq API Key | 讓工作流程呼叫 Groq 模型 | n8n 的 Groq 憑證中；不是 MCP 設定 |
| `N8N_MCP_ACCESS_TOKEN` | 連接 n8n 內建 Instance-level MCP 的專用 Token | 只在第 10 節的另一種連線方式使用 |

#### 在自己的本機 n8n 建立 API Key

1. 啟動本機 n8n，使用自己的帳號登入 `http://localhost:5678`。
2. 開啟 **Settings → n8n API**。通常先點畫面左下角的 **Settings**；如果你的版本選單文字略有不同，請找 **n8n API** 或 **API keys**。
3. 點 **Create an API key** 或 **Add API key**。
4. 名稱填 `Antigravity MCP classroom`，方便日後認出這把 key 是課堂練習使用，並設定有效期限。
5. 建立後立刻複製 key，暫存在密碼管理器或暫存的安全位置。若畫面只顯示一次，離開前請確認已複製好。

你不需要向老師或 n8n 官方索取共用金鑰。每位同學都要在自己的 n8n 帳號建立自己的 key。此 key 代表你的 n8n 使用者權限，所以只連到自己的測試 n8n；不要使用共用正式環境的 key。

> **如果找不到 n8n API 或無法建立 key：** n8n 官方文件指出 Public API 在免費試用期間不可用。請確認使用的是可使用 Public API 的本機練習環境與版本；不要改用其他同學的 key。

#### 保護與撤銷

- 不要把 key 貼到 Agent 聊天、課堂作業、工作流程提示文字、截圖或 GitHub。也不要傳給同學。
- 若不小心分享或提交到 Git，回到 **Settings → n8n API / API keys** 撤銷或刪除該 key，再建立新 key 並更新 Antigravity 設定。只從檔案刪掉舊字串並不足以讓它失效。
- API Key 能呼叫的範圍可能很廣；官方文件說明，非 Enterprise 方案的 API Key 可存取該帳號的所有資源與功能。因此本課只使用自己的本機測試環境和假資料，不要連正式 n8n。

### 步驟 B：在 Antigravity IDE 安裝 `n8n-mcp`

1. 在 Antigravity IDE 開啟 Agent 側欄右上角的 **…**。
2. 選 **MCP Servers → Manage MCP Servers → View raw config**，IDE 會開啟它目前使用的 MCP 設定檔。
3. 將 [設定範例檔](課堂練習/Antigravity-n8n-mcp-config.example.json)中的 `n8n-mcp` 區塊加入 `mcpServers`。
4. 在設定檔 `env` 區塊找到 `N8N_API_KEY`，將右側的 `REPLACE_WITH_YOUR_LOCAL_TEST_N8N_API_KEY` 換成剛建立的 key，例如：`"N8N_API_KEY": "貼上你自己的key"`。只貼 key 本身，不加 `Bearer ` 字樣，也不要貼到 Agent 聊天訊息；含真實金鑰的設定檔不要放進課程 Git 儲存庫。
5. 儲存設定並回到 **MCP Servers**，選 **Refresh** 或重新啟動 `n8n-mcp`。
6. 第一次連線時，`npx` 會從 npm 取得 `n8n-mcp` 套件；等待伺服器狀態顯示已連線。

這個設定使用 `npx -y n8n-mcp` 啟動本機 MCP Server，並以 `N8N_API_URL=http://localhost:5678` 連回同一台電腦的 n8n。若 IDE 找不到 `npx`，請確認 Node.js/npm 已安裝，或依 [n8n-mcp 的 Antigravity 設定說明](https://github.com/czlonkowski/n8n-mcp/blob/main/docs/ANTIGRAVITY_SETUP.md)改用 npm 全域安裝與實際執行檔路徑。

### 步驟 C：確認工具已連線

1. 在 Antigravity 的 MCP Servers 管理畫面確認 `n8n-mcp` 狀態正常。
2. 在 Agent 面板詢問：「請使用 n8n-mcp 搜尋 Manual Trigger 節點，並列出節點名稱和用途。先不要建立或修改任何工作流程。」
3. 確認 Agent 回答是透過節點查詢取得資料；若要確認 n8n API 金鑰也有效，可再請 Agent 使用 n8n-mcp 列出工作流程名稱，先不要修改或執行任何流程。若出現未授權、401 或 403，先看第 9 節排除問題。

## 6. 實作案例：建立「課堂學習紀錄」草稿

這個案例只建立一個手動啟動、輸出固定測試資料的工作流程，不連接 Email、Telegram、Google Sheets 等外部服務。

### 第一步：先請 Agent 規劃

在 Antigravity Agent 面板輸入：

> 我要建立一個「課堂學習紀錄」工作流程，請先用 n8n-mcp 查找 Manual Trigger 和 Edit Fields 節點，並先搜尋是否有合適的簡單範本。請先回覆流程架構、每個節點用途、輸出欄位和測試方式；此時不要建立或修改 n8n 工作流程，也不要啟用流程。

閱讀 Agent 提出的架構，確認只有：

```text
Manual Trigger → Edit Fields
```

輸出欄位建議：

- `courseWeek`: `第 7 週`
- `topic`: `MCP 與 n8n 工作流程開發`
- `learningStatus`: `practice`

### 第二步：讓 Agent 建立草稿

確認架構後，再輸入：

> 請依照剛才確認的架構，在我連線的本機 n8n 建立一個新的、未啟用的「MCP 練習｜課堂學習紀錄」工作流程。使用 Manual Trigger 和 Edit Fields，輸出 courseWeek、topic、learningStatus 三個固定測試欄位。不要新增憑證，不要使用外部服務，不要啟用或發布。建立後請回覆 workflow ID。

Agent 可能會要求核准 MCP 工具呼叫。每次核准前，先看清楚工具名稱和操作內容；此步驟應建立新流程，不能刪除、發布或修改其他流程。

### 第三步：驗證並檢查

請 Agent 執行：

> 請使用 n8n-mcp 驗證剛建立的工作流程。列出驗證錯誤與警告；若要修正，先說明將修改哪些節點，等我確認後再修改。不要啟用或發布。

之後回到 n8n 編輯器，確認節點、欄位與連線符合預期。再從 n8n 編輯器手動執行一次，檢查輸出中是否有三個預期欄位。這個流程不會寫入外部系統。

### 預期成果

- Antigravity 的 MCP Servers 畫面顯示 `n8n-mcp` 已連線。
- Agent 能查到節點資訊。
- 本機 n8n 出現一個新的、未啟用的練習流程。
- 驗證結果沒有未處理的錯誤；手動執行後輸出包含預期欄位。

## 7. 學生練習

### 練習一：加上輸入欄位

請 Agent 先提出修改計畫，然後在課堂學習紀錄中新增一個 `learnerNote` 欄位，使用固定的假資料。重新驗證並手動執行，記錄修改前後的輸出差異。

### 練習二：自行選題

從重複性高、資料不敏感的學習或個人管理情境中選一項，請 Agent：

1. 先搜尋相關範本與節點。
2. 先回報架構與外部副作用。
3. 建立未啟用、只含測試資料的工作流程。
4. 執行節點與整個工作流程驗證。
5. 交付 workflow ID、節點說明、測試輸入/輸出和驗證結果。

可參考資料夾 [`n8n AI Automation Workshop`](../n8n%20AI%20Automation%20Workshop/README.md) 中的 `n8n-skills/resources`、`n8n_template/Learn_n8n.json` 與 `n8n_template/one_node.json`。先完成本課的無憑證練習，再挑選含外部服務的範本；外部 API 憑證由自己在 n8n Credentials 設定，不要貼給 Agent。

## 8. 讓 Agent 遵守專題開發規則

可將[Agent 規則範本](課堂練習/Antigravity-n8n-MCP-Agent-Rules.md)複製到專題資料夾，命名為 `AGENTS.md`。Agent 每次開發前應先讀課程的 `n8n-skills/SKILL.md`，優先參考節點說明與範本，並先做驗證。

使用 Agent 時遵守以下順序：

1. 先查文件或範本，不要直接猜節點設定。
2. 先確認需求與流程架構，再建立或修改。
3. 先用測試資料和未啟用流程。
4. 先驗證節點、連線與表達式，再手動測試。
5. 啟用、發布、刪除、修改既有正式流程，或執行會寄信、寫入資料、付費的操作前，先停下來檢查內容並取得本人明確確認。

## 9. 常見問題

- **`n8n-mcp` 沒出現在工具清單**：確認 JSON 格式正確，`mcpServers` 拼寫正確，然後在 MCP Servers 畫面重新整理。
- **Agent 顯示 `npx` 找不到**：在終端機檢查 `node -v` 和 `npm -v`；若有安裝但 Antigravity 找不到，改用全域安裝及 n8n-mcp 官方 Antigravity 指南中的實際檔案路徑。
- **無法連上 n8n**：確認 n8n 正在執行，`N8N_API_URL` 是 `http://localhost:5678`，且 API Key 尚未失效。
- **出現 401 / 403 或 API Key 無效**：回到 **Settings → n8n API / API keys** 確認 key 仍有效；重新複製並貼到 `N8N_API_KEY` 的值，僅貼 key 本身，不要加 `Bearer `。如果曾分享過，撤銷舊 key 並建立新 key。
- **容器中連不到 `localhost`**：若 Antigravity 或 `n8n-mcp` 在 Docker 中，`localhost` 指向容器自身；需要改用兩個服務都能到達的主機位址或 Docker 網路名稱。
- **工具可以查節點但不能管理工作流程**：確認使用的是可管理 n8n API 的測試 API Key，並檢查 n8n-mcp MCP Server 的錯誤訊息。
- **改用官方 Instance-level MCP 時沒有工作流程資料**：先到 n8n Instance-level MCP 設定頁啟用伺服器，再只開放這次練習用的工作流程。

## 10. 延伸：連接 n8n 內建 Instance-level MCP

n8n 內建 MCP Server 是另一種連線方式，不需要安裝第三方 `n8n-mcp` 套件。它可讓相容的 AI 應用程式透過 Streamable HTTP 連接 n8n。使用此功能需要 n8n 版本與管理員設定支援。

1. 在 n8n 開啟 **Settings → Instance-level MCP**，選 **Enable MCP access**。
2. 選 **Connect a client → API key**，建立或複製此功能專用的 MCP 存取 Token。它和 `N8N_API_KEY` 不相同。
3. 複製畫面提供的 **Server URL**；本機服務通常會以 `/mcp-server/http` 結尾。優先使用畫面顯示的完整網址。
4. 在 Antigravity IDE 的 MCP 設定中新增 Streamable HTTP Server，使用 `serverUrl` 和 `Authorization: Bearer <MCP_TOKEN>`。
5. 在 n8n Instance-level MCP 的 Access 區只開放測試工作流程；測完後移除不再需要的工作流程權限或撤銷用戶端。

```json
{
  "mcpServers": {
    "n8n-native": {
      "serverUrl": "http://localhost:5678/mcp-server/http",
      "headers": {
        "Authorization": "Bearer 請填入從n8n取得的MCP存取Token"
      }
    }
  }
}
```

n8n 會要求工作流程逐一開放給 Instance-level MCP。不要為了方便將整個正式 n8n 的所有工作流程都開放；連線到同一個 n8n 執行個體的 MCP 用戶端可能看到相同的已開放工作流程。

## 11. 安全檢查表

- 使用本機測試 n8n 和假資料，不要連正式流程。
- `N8N_API_KEY`、`N8N_MCP_ACCESS_TOKEN` 和其他 API 金鑰放在 Antigravity MCP 設定的環境欄位，不要放進 Agent 對話或 Git。
- 不要使用 `.env`、`mcp_config.json` 或工作流程 JSON 來分享真實金鑰。
- 先檢查 Agent 送出的 MCP 工具呼叫，再按核准。
- 新工作流程先保持停用；修改或啟用既有流程前，檢查版本與副作用。
- 測試資料不可包含個資、正式郵件、真實付款資訊或客戶資料。
- 不要為了讓遠端 IDE 連線而直接公開本機 n8n 或使用未授權的 tunnel。

## 12. 參考資料

- [n8n Public API 認證與建立 API Key](https://docs.n8n.io/api/authentication/)
- [MCP 官方入門](https://modelcontextprotocol.io/docs/getting-started/intro)
- [Google Antigravity MCP 設定說明](https://antigravity.google/docs/mcp?tab=ide)
- [n8n-mcp 專案與功能](https://github.com/czlonkowski/n8n-mcp)
- [n8n-mcp Antigravity 設定指南](https://github.com/czlonkowski/n8n-mcp/blob/main/docs/ANTIGRAVITY_SETUP.md)
- [n8n 內建 MCP Server 連線說明](https://docs.n8n.io/connect/connect-to-n8n-mcp-server/)
- [n8n MCP Server Trigger 節點](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-langchain.mcptrigger/)
- [n8n AI Automation Workshop README](../n8n%20AI%20Automation%20Workshop/README.md)
- [Workshop MCP 設定範例](../n8n%20AI%20Automation%20Workshop/%24.mcp.json)
