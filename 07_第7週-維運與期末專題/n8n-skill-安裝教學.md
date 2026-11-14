# 🚀 n8n 官方技能庫（n8n Skills）安裝教學

本教學提供最簡化的核心步驟，快速為專案安裝 n8n 官方技能庫，讓 Antigravity 在搭配 `n8n-mcp` 操作工作流程時自動遵循官方最佳實踐。

* **官方專案庫**：[https://github.com/n8n-io/skills](https://github.com/n8n-io/skills)

---

## ⚡ 核心安裝步驟（PowerShell）

### **Step 1：下載並建置外掛**

開啟 PowerShell 於專案根目錄執行：

```powershell
# 1. 淺層下載官方庫
git clone --depth 1 https://github.com/n8n-io/skills temp_n8n_skills

# 2. 執行 Antigravity 專屬建置腳本（處理 24KB 限制與外掛結構）
node temp_n8n_skills/.antigravity-plugin/build.mjs
```

---

### **Step 2：部署至專案並清理暫存**

```powershell
# 1. 建立專案技能與外掛目錄
New-Item -ItemType Directory -Path .agents\plugins\n8n-skills, .agents\skills -Force

# 2. 複製建置成果到外掛目錄（並移除遠端 mcp 設定以保留本機已設定之 n8n-mcp）
Copy-Item -Path temp_n8n_skills\dist\antigravity\* -Destination .agents\plugins\n8n-skills -Recurse -Force
Remove-Item -Path .agents\plugins\n8n-skills\mcp_config.json -Force -ErrorAction SilentlyContinue

# 3. 同步技能至專案 skills 目錄
Copy-Item -Path .agents\plugins\n8n-skills\skills\* -Destination .agents\skills -Recurse -Force

# 4. 清理暫存下載檔案
Remove-Item -Path temp_n8n_skills -Recurse -Force
```

---

### **Step 3：建立專案規則（AGENTS.md）**

於專案根目錄建立 `AGENTS.md`，指示 AI 呼叫 `n8n-mcp` 前主動載入技能規範：

```markdown
# n8n & n8n-mcp Guidelines
When working with n8n workflows, nodes, expressions, or calling `n8n-mcp` tools:
1. Always route through `.agents/skills/using-n8n-skills-official/SKILL.md` before taking action.
2. Follow matching capability skills (lifecycle, node-config, expressions, code-nodes, error-handling, etc.).
3. Run `validate_workflow` and verify connections before publishing.
4. Never put API keys, passwords, or secrets into text fields; always use n8n credentials.
5. Prefer native expressions or Edit Fields before reaching for Code nodes.
```

---

### **Step 4：驗證安裝**

執行 Antigravity CLI 驗證外掛完整性：

```powershell
& "$env:USERPROFILE\.gemini\bin\agy.exe" plugin validate --strict .agents/plugins/n8n-skills
```

> 輸出顯示 `✔ Validation passed` 即代表安裝成功！

---

## 📖 技能速查清單（共 15 個技能）

| 技能名稱 | 核心用途 |
| :--- | :--- |
| **`using-n8n-skills-official`** | **總入口路由**：分析任務並導派專屬技能。 |
| `n8n-workflow-lifecycle-official` | 流程生命週期、便籤排版、發布前檢查清單。 |
| `n8n-node-configuration-official` | 各節點屬性依賴與最佳設定。 |
| `n8n-expressions-official` | `{{}}` 表達式與 Luxon 日期計算語法。 |
| `n8n-code-nodes-official` | Code 節點使用評估（JS/Python）與替代方案。 |
| `n8n-error-handling-official` | Webhook 錯誤響應、重試與 try/catch 模式。 |
| `n8n-subworkflows-official` | 子流程拆分、資料傳遞與複用模式。 |
| `n8n-loops-official` | 批次處理、Loop Over Items 與 API 分頁。 |
| `n8n-agents-official` | n8n Agent 架構、工具定義與記憶體維護。 |
| `n8n-ai-nodes-official` | 流程內 AI 節點（AI Agent 節點、分類器、RAG）。 |
| `n8n-credentials-and-security-official`| 憑證安全與敏感資料隔離原則。 |
| `n8n-binary-and-data-official` | 檔案、圖片與二進位資料串接處置。 |
| `n8n-data-tables-official` | n8n 內建 Data Tables 資料表操作與持久化。 |
| `n8n-debugging-official` | 流程錯誤排查與診斷分析。 |
| `n8n-extending-mcp-official` | 將 n8n 流程封裝為 MCP 工具。 |

---

## 💬 對話測試指令範例

安裝完成後，在 Antigravity 對話框中可直接輸入：
* 「請依照 n8n 官方技能規範，檢查我目前的工作流程是否有反模式（Antipatterns）。」
* 「請使用 n8n-mcp 與官方節點設定技能，幫我建立一個具備錯誤處理的 Webhook 流程。」
