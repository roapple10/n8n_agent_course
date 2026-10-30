# 第 5 週｜Telegram 潛客評分工作流：學生端到端操作

本教學帶你從準備憑證、打通本機 n8n 到 Telegram、送出測試案例，到確認 Bot 回覆與 Google Sheet 寫入。請依章節順序操作。

> **本課使用 Cloudflare Quick Tunnel 進行短期測試。** 它會提供臨時公開 HTTPS 網址，僅供學習與開發；停止通道後網址失效，重新啟動通常會換新網址。不要把 Quick Tunnel 當成正式客服或長期營運入口。[Cloudflare Quick Tunnel 官方說明](https://developers.cloudflare.com/tunnel/get-started/quick-tunnels/)

## 本課完成目標

完成後，你可以從 Telegram 私訊 Bot 傳入潛客資料，讓 n8n：

1. 接收 Telegram 訊息並取得傳訊者的 Chat ID。
2. 使用 AI 依需求、預算、公司規模、導入時程評分。
3. 將潛客資料與評分寫入 Google Sheet。
4. 把評分摘要回覆到傳送資料的 Telegram 私訊。

工作流：[第05週｜Telegram 潛客評分與人工覆核](http://localhost:5678/workflow/MLfy78XHYzwdC5nJ)

Google Sheet：[第05週｜Telegram 潛客評分與跟進](https://docs.google.com/spreadsheets/d/13x61xzrlTiQ7od7SE209ar3qAzJ_lOWWFP9kQVd6qs4/edit)

## 第 1 章：了解工作流與兩種測試入口

```text
Telegram 輸入 ─┐
               ├→ 統一輸入 → AI 潛客評分 → 結構化輸出 → 整理評分與回覆
n8n 測試聊天 ──┘                                               ↓
                                             寫入潛客名單（Google Sheet）
                                                              ↓
                                                       依來源回覆（IF）
                                                         ├─ telegram → Telegram 回覆
                                                         └─ n8n_chat → n8n Chat 回覆
```

「統一輸入」會分辨訊息來源：Telegram Trigger 收到的資料含 `message.chat`，來源是 `telegram`；n8n 編輯器的聊天測試來源是 `n8n_chat`。因此，編輯器聊天成功只會回覆在 n8n Chat 面板，不會送 Telegram。

Google Sheet 寫入排在 IF 分支前。若寫入節點失敗，後面的 Telegram 回覆也不會執行。

## 第 2 章：準備三組憑證

開始前先準備 Telegram、Groq 和 Google 三個帳號。每位學生都使用自己的帳號和憑證；不要向同學索取或共用 Token、API Key。憑證只存進 n8n 的 **Credentials**，不要貼在工作流文字、測試案例、截圖或教學文件。

### 2.1 建立自己的 Telegram Bot

1. 在 Telegram 搜尋官方帳號 [@BotFather](https://t.me/botfather)，確認帳號名稱是 BotFather 後開啟對話。
2. 傳送 `/newbot`，依提示輸入 Bot 顯示名稱，再設定 username。username 必須是尚未被使用的名稱，並以 `bot` 結尾，例如 `my_class_lead_bot`。
3. BotFather 建立完成後會回傳 **HTTP API token**。把它當成密碼保存；不要貼在群組或截圖中。若曾公開，立即回到 BotFather 撤銷並重新產生。
4. 點選 BotFather 提供的 Bot 連結開啟自己的 Bot，按 **Start**，先傳送 `test`。這樣之後才能收到 Bot 私訊回覆。
5. 登入 n8n，左側開啟 **Credentials**，按 **Add credential**（或 **New credential**），搜尋並選擇 **Telegram API**。
6. 在 **Access Token** 欄貼上剛才取得的 token，按 **Save**。憑證名稱可取 `我的 Telegram Bot`，方便辨認。
7. 回到本課工作流，打開 `Telegram 輸入` 節點，在 Credential 欄選剛建立的憑證；再打開 `Telegram 回覆` 節點，選擇同一個憑證。

官方步驟可參考 [Telegram Bot 教學](https://core.telegram.org/bots/tutorial) 和 [n8n Telegram 憑證說明](https://docs.n8n.io/integrations/builtin/credentials/telegram/)。

### 2.2 建立 Groq API Key

1. 前往 [GroqCloud Console](https://console.groq.com/) 註冊或登入自己的帳號。
2. 開啟 [Groq API Keys](https://console.groq.com/keys)，按 **Create API Key**，輸入容易辨認的名稱後建立。
3. 立即複製新 Key 並妥善保存。完整 Key 通常只在建立時顯示；不要放進工作流欄位、聊天訊息或截圖。
4. 登入 n8n，開啟 **Credentials**，按 **Add credential**（或 **New credential**），搜尋並選擇 **Groq API**。將 Key 貼入 API Key 欄，替憑證命名後儲存。也可以從 `Groq 模型` 節點的 Credential 欄選 **Create new credential**。
5. 回到 `Groq 模型` 節點，選取剛建立的憑證，並選擇可用模型。模型清單和額度以 Groq Console 目前顯示為準；若本機清單沒有教學範例中的模型，選一個 Groq 帳戶可用的聊天模型即可。

官方文件：[Groq API Keys](https://console.groq.com/docs/keys)、[Groq Models](https://console.groq.com/docs/models)。

### 2.3 準備 Google 試算表並連接 n8n

1. 使用自己的 Google 帳號登入。先開啟本課的[範例試算表](https://docs.google.com/spreadsheets/d/13x61xzrlTiQ7od7SE209ar3qAzJ_lOWWFP9kQVd6qs4/edit)。若你沒有編輯權限，請在雲端硬碟建立副本：選 **檔案 → 建立副本**，把副本存到自己的雲端硬碟，之後使用自己的副本練習。不要要求將共用範例表開放給所有人編輯。
2. 確認試算表有 `潛客名單` 分頁，且第一列是欄位名稱。若建立了副本，記下副本網址並保持分頁名稱不變。
3. 若尚未建立 Google OAuth 用戶端，請先依[第 4 週：Google Drive 與 Google Sheets API／OAuth 憑證申請指南](../04_第4週-Google-Drive與Sheets/API與憑證申請指南.md)完成 Google Cloud 專案、API 啟用、OAuth 設定及自架 n8n 的憑證申請。無須在本章重做；已有可用的 Google OAuth 憑證可直接繼續。
4. 在 n8n 打開 `寫入潛客名單` 節點，Credential 選 **Create new credential**，建立 **Google Sheets OAuth2 API**。依第 4 週指南使用已建立的 Client ID／Client Secret，按 **Save** 和 **Sign in with Google**，以有試算表存取權的 Google 帳號完成授權。
5. 回到節點設定，Credential 選剛連接的帳號。Document 選自己的範例表副本（或你有編輯權的指定試算表），Sheet 選 `潛客名單`，再確認欄位對應正確。

### 2.4 檢查三組憑證

回到工作流逐一確認：`Telegram 輸入` 與 `Telegram 回覆` 使用同一個 Telegram Credential；`Groq 模型` 使用自己的 Groq Credential；`寫入潛客名單` 使用有該試算表編輯權限的 Google Sheets Credential。若憑證選單沒有新項目，重新載入工作流頁面後再選取。

## 第 3 章：安裝 Cloudflare Tunnel（只需一次）

本章提供快速操作步驟。從安裝 `cloudflared` 到設定、重啟與故障排除的完整流程，請參考[Cloudflare Quick Tunnel 安裝與 n8n 設定：端到端教學](Cloudflare%20Quick%20Tunnel%20安裝與%20n8n%20設定教學.md)。

先確認 n8n 已啟動，並可在自己的電腦開啟 `http://localhost:5678`。若開啟後不需登入就能直接進入 n8n，先替 n8n 設定登入保護。Quick Tunnel 會讓外部連到本機 n8n；Cloudflare 官方也提醒，任何取得 Quick Tunnel 網址的人都可能連到該本機服務。

### macOS（Homebrew）

開啟「終端機」並執行：

```bash
brew install cloudflared
cloudflared --version
```

若尚未安裝 Homebrew，請至 [Cloudflare 官方下載頁](https://developers.cloudflare.com/tunnel/downloads/)選擇 macOS 版本：Apple Silicon 選 arm64，Intel Mac 選 amd64。

### Windows

從 [Cloudflare 官方下載頁](https://developers.cloudflare.com/tunnel/downloads/)下載並安裝 Windows 64-bit MSI。重新開啟 PowerShell，執行：

```powershell
cloudflared --version
```

若顯示找不到指令，先關閉並重新開啟 PowerShell；仍無法使用時，確認安裝完成，或依官方下載頁的手動安裝步驟操作。

### Linux

從 [Cloudflare 官方下載頁](https://developers.cloudflare.com/tunnel/downloads/)依自己的 Linux 發行版安裝，再執行 `cloudflared --version` 確認。

## 第 4 章：啟動 Quick Tunnel 並取得 HTTPS 網址

每次要測試時，都要有一個正在執行的 Quick Tunnel。若你已經啟動 Tunnel，直接找到執行 `cloudflared` 的終端機，複製它目前顯示的 `https://……trycloudflare.com` 網址，不要再開第二條通道。

若尚未啟動：

1. 保持 n8n 開啟，另開一個新的終端機或 PowerShell 視窗。
2. 執行以下命令：

   ```bash
   cloudflared tunnel --url http://localhost:5678
   ```

3. 等待畫面顯示 `Your quick Tunnel has been created!`，複製接下來的 `https://……trycloudflare.com` 網址。每次新建的網址都可能不同。
4. **不要關閉這個終端機**。關閉終端機或停止 `cloudflared`，通道就會中斷。

Quick Tunnel 不需要 Cloudflare 帳號或自有網域，網址在 `cloudflared` 執行期間有效。Cloudflare 將 Quick Tunnel 定位為測試／開發用途，且 hostname 每次建立都會改變。[Cloudflare Quick Tunnel 官方限制](https://developers.cloudflare.com/tunnel/get-started/quick-tunnels/)

## 第 5 章：讓 n8n 使用 Quick Tunnel 網址

**這一步是關鍵。** 即使 `cloudflared` 正在執行，如果 n8n 仍以 `localhost` 建立 Telegram webhook，Telegram 還是會回報 `bad webhook: An HTTPS URL must be provided for webhook`。

n8n 必須在啟動時知道外部 HTTPS 網址，才能把正確的 webhook URL 註冊給 Telegram。n8n 現行設定使用 `N8N_WEBHOOK_URL`；放在反向代理後面時也要設 `N8N_PROXY_HOPS=1`。[n8n 官方 webhook URL 設定](https://docs.n8n.io/deploy/host-n8n/configure-n8n/basic-configuration/configuration-examples/configure-webhook-urls-with-reverse-proxy/)

### 本課 Docker Compose 設定方式

本課的 n8n 服務名稱是 `n8n`。第一次設定時，先在 `docker-compose.yml` 同一資料夾建立自己的 `.env`：開啟終端機並進入 Compose 資料夾，執行 `cp .env.example .env`。如果 `.env` 已存在，**不要再複製或覆蓋**；直接用文字編輯器編輯既有 `.env`，保留裡面其他設定。

接著在 `.env` 找到 `N8N_WEBHOOK_URL`，把範例值替換為第 4 章剛取得的完整 HTTPS 網址，保留最後的 `/`。確認 `N8N_PROXY_HOPS=1`。`.env.example` 已附上這兩項設定與操作提示。

再確認 `docker-compose.yml` 的 `services` → `n8n` → `environment` 有以下兩項（本課 Compose 使用清單格式）：

```yaml
services:
  n8n:
    environment:
      - N8N_WEBHOOK_URL=${N8N_WEBHOOK_URL:-http://localhost:5678/}
      - N8N_PROXY_HOPS=${N8N_PROXY_HOPS:-1}
```

若原本已存在 `environment:`，只在該區塊新增兩項，不要再建立第二個 `environment:`。`.env` 是本機設定檔，不要上傳 Git、貼到群組或放入截圖。

儲存檔案後，在 `docker-compose.yml` 所在資料夾執行：

```bash
cd "n8n/05_第5週-Telegram與潛客分析"
docker compose up -d n8n
```

上面的 `cd` 路徑是從課程專案根目錄開始；若你的 Compose 檔放在其他位置，請改成自己的 Compose 資料夾。這會以新設定重建／啟動 n8n 容器。等 `http://localhost:5678` 重新可以開啟，再回到工作流停用後重新啟用／發布一次，讓 Telegram Trigger 載入新的 webhook 設定。Quick Tunnel 終端機必須保持開啟。

### 若 n8n 不是用 Docker Compose 啟動

將 `N8N_WEBHOOK_URL=https://你的隨機名稱.trycloudflare.com/` 與 `N8N_PROXY_HOPS=1` 設為 **n8n 服務的環境變數**，再重新啟動 n8n。只在目前終端機設定變數、但 n8n 是由另一個服務或桌面程式啟動，並不會改變已運行的 n8n；必須把變數放進實際啟動 n8n 的設定。

重啟後回到工作流，按 `Telegram 輸入` 節點查看它顯示的 webhook URL。確認網址以 `https://` 開頭，且 hostname 與目前的 `trycloudflare.com` 網址相同。若仍顯示 `localhost`，代表 n8n 沒有載入 `N8N_WEBHOOK_URL`；先不要按 Execute workflow，回頭檢查設定並重啟。

## 第 6 章：逐一檢查 n8n 工作流節點設定

打開工作流畫布，從左到右點選節點。每個節點的名稱與設定如下；你的 n8n 版本可能使用不同的欄位排版，但憑證、試算表分頁與資料欄位必須對得上。

| 節點 | 要確認的設定 | 用途 |
|---|---|---|
| `Telegram 輸入` | Credential 選自己的 Telegram Bot；Updates 選 `Message`。 | 接收傳給 Bot 的私訊。啟用後由 Telegram 將訊息送到 n8n 的 HTTPS webhook。 |
| `n8n 測試聊天` | 不需 Telegram Credential。 | 方便在 n8n Chat 面板測試 AI 與寫表流程；這個入口的回覆不會送到 Telegram。 |
| `統一輸入` | Code 節點，程式碼已讀取 Telegram `message.text`、`message.chat.id`，並設定 `source` 為 `telegram`；n8n Chat 的來源則為 `n8n_chat`。 | 把兩種入口整理成相同欄位，讓後面的 AI 和試算表共用。初學者先不要修改程式碼。 |
| `AI 潛客評分` | Prompt source 選 Define；輸入為 `={{ JSON.stringify($json) }}`；開啟 Structured Output；System Message 使用繁體中文並按需求匹配 40、預算 25、公司規模 20、導入時程 15 分計分。 | 從訊息擷取資料並產生評分、優先級、理由及下一步。 |
| `Groq 模型` | Credential 選自己的 Groq API 憑證；確認已選帳戶可用的聊天模型。 | 提供 AI Agent 使用的語言模型。 |
| `結構化輸出` | Schema type 選 Manual；輸出需包含公司、聯絡人、產業、規模、預算、需求、時程、四項分數、總分、優先級、理由、下一步與人工覆核欄位。 | 限定 AI 回傳可供程式和 Sheet 使用的結構化欄位。 |
| `整理評分與回覆` | Code 節點，將 AI 結果與來源、Chat ID 合併；計算總分、人工覆核狀態、Sheet 欄位與 `telegramReplyText`。 | 整理成 Sheet 的欄位並準備回覆文字。初學者先不要修改程式碼。 |
| `寫入潛客名單` | Credential 選有編輯權限的 Google Sheets OAuth2；Resource 為 Sheet；Operation 為 Append；Document 選「第05週｜Telegram 潛客評分與跟進」；Sheet 選 `潛客名單`；欄位 Mapping 對應節點輸出的同名欄位。 | 每收到一筆資料就新增一列。寫表放在回覆前，所以 Sheet 權限錯誤時不會繼續回覆。 |
| `依來源回覆` | 條件比較 `來源` 是否等於 `telegram`。true 接到 Telegram 回覆，false 接到 n8n Chat 回覆。 | 避免把 Telegram 的 Chat ID 誤當成 n8n Chat session，或把回覆送錯地方。 |
| `Telegram 回覆` | Credential 必須與 `Telegram 輸入` 使用同一個 Bot；Operation 為 `sendMessage`；Chat ID 取整理後資料的 Telegram Chat ID；Text 使用 `telegramReplyText`。 | 把評分摘要私訊回原本傳送資料的人。 |
| `n8n Chat 回覆` | 使用 `manual` 回覆模式，訊息取整理後的回覆文字。 | 把 n8n Chat 測試結果顯示在編輯器面板。 |

Google Sheet：[第05週｜Telegram 潛客評分與跟進](https://docs.google.com/spreadsheets/d/13x61xzrlTiQ7od7SE209ar3qAzJ_lOWWFP9kQVd6qs4/edit)。確認試算表有 `潛客名單` 分頁，第一列欄名與節點的欄位 Mapping 完全一致。不要把 Bot Token、API Key 或 OAuth 憑證寫入節點文字或截圖。

## 第 7 章：啟用並測試 Telegram

> **要讓 Bot 持續接收訊息，必須同時滿足四個條件：**工作流已 **Published／Active**、n8n 正在執行、Quick Tunnel 正在執行且網址仍有效、Telegram Trigger 已向 Telegram 登記目前的 HTTPS webhook。只按 **Publish** 不會讓已關閉的電腦或 Tunnel 持續在線；在編輯器按 **Execute workflow** 也不是長期監聽模式。

1. 確認 Quick Tunnel 終端機仍在執行，而且 `.env` 內的 `N8N_WEBHOOK_URL` 是該 Tunnel 的 HTTPS 網址。
2. 回到 n8n 工作流，按右上角 **Publish**；如果已顯示 **Published**，代表已發布。這個工作流要由 Telegram 持續觸發，不能只停在編輯器聊天測試。
3. 如果剛修改 `N8N_WEBHOOK_URL` 或重新啟動 Tunnel，先依第 5 章重啟 n8n，再回工作流停用後重新啟用／發布一次，讓 Telegram 重新登記 webhook。
4. 在 Telegram 開啟自己的 Bot 私訊；第一次使用先按 **Start**。傳送第 8 章的虛構案例。
5. 等待幾秒，回 n8n 點選 **Executions**，打開最新一筆執行。確認 `Telegram 輸入` 有收到訊息、`寫入潛客名單` 成功，且 `Telegram 回覆` 成功。
6. 回 Telegram 確認看到評分摘要；再到 Google Sheet 確認新增一列。

**持續接收檢查：**完成上述測試後，先不要關閉執行 n8n 的服務或 Quick Tunnel 終端機。再從 Telegram 傳一則新的合成訊息；若 **Executions** 出現新的成功執行且 Bot 回覆，代表目前接收正常。關閉電腦、停止 n8n 或按 `Ctrl+C` 結束 Quick Tunnel 後，訊息就不會送到這台本機 n8n。重新啟動或 Quick Tunnel 換網址時，依第 11 章更新 `N8N_WEBHOOK_URL`、重啟 n8n，並重新發布／啟用 Telegram Trigger。

> **Telegram 測試提醒：** 同一個 Bot Token 同一時間只能有一個有效 webhook。不要讓另一個 n8n 工作流或測試監聽器同時使用相同 Bot；切換測試／正式工作流後，重新啟用目前要測的工作流。

### n8n Chat 和 Telegram 的差異

在 n8n 編輯器按 **Execute workflow** 後，透過底部 Chat 面板送出的內容，來源會是 `n8n_chat`，結果只顯示在 n8n Chat，不會送到 Telegram。要驗證 Telegram 回覆，請從 Telegram Bot 私訊傳資料，並確認執行結果走 `依來源回覆` 的 true → `Telegram 回覆` 分支。

## 第 8 章：傳送測試案例

以下是虛構資料。請在 Telegram 私訊 Bot 時，將整段文字貼上並送出：

```text
公司名稱：青禾數位
聯絡人：測試聯絡人
產業：B2B 軟體服務
公司規模：45 人
預算：新台幣 30,000 元
需求與痛點：目前透過試算表追蹤網站詢問的潛客，常漏掉回覆與後續聯絡；希望導入 CRM，自動分級潛客並提醒業務跟進。
預計導入時間：1 個月內
```

欄位完整、需求明確，適合測試正常評分、寫表和 Telegram 回覆。分數由 AI 依提示詞權重計算，可能略有差異；驗收重點是節點分支和資料流，不要求每次分數完全一致。

## 第 9 章：驗收成功

### 在 n8n Executions 檢查

打開最新一次執行，依序確認：

1. `Telegram 輸入` 成功，輸入資料含 `message.chat.id`。
2. `統一輸入` 的 `source` 是 `telegram`，`telegramChatId` 有值。
3. `AI 潛客評分`、`整理評分與回覆` 和 `寫入潛客名單` 成功。
4. `依來源回覆` 的 true 輸出有 1 item；false 輸出沒有 item。
5. `Telegram 回覆` 成功。

### 在 Telegram 和 Google Sheet 檢查

- 回到傳送案例的 Telegram 私訊，確認 Bot 回覆評分、評分依據、下一步建議。
- 開啟 Google Sheet 的 `潛客名單` 分頁，確認新增一列，來源為 `telegram`、公司名稱為「青禾數位」，且 Chat ID 有值。

### 本次示範的驗收結果

本工作流已改用 Groq，並以 n8n 的 Telegram Trigger 測試資料完成一次端到端驗收（Execution ID：`217`）：Groq 評分、Google Sheets 新增列、Telegram 回覆節點均成功；測試 Bot 實際回覆「中（73/100）」。本次測試資料由 n8n MCP 模擬 Telegram Trigger 的輸入，回覆則實際送到 Telegram，並寫入課程試算表。學生請依第 7 章從自己的 Telegram Bot 傳送案例，驗證真正的外部訊息觸發；AI 分數可能不同，驗收以流程成功、Bot 回覆與 Sheet 新增列為準。

## 第 10 章：常見錯誤排查

| 現象 | 原因與處理方式 |
|---|---|
| `bad webhook: An HTTPS URL must be provided for webhook` | n8n 傳給 Telegram 的 URL 仍是 HTTP／localhost。確認 `.env` 的 `N8N_WEBHOOK_URL` 是目前 Quick Tunnel 的 HTTPS 網址、以 `/` 結尾；重啟 n8n 後停用再啟用／發布工作流。 |
| n8n 顯示的 webhook hostname 與 Tunnel 不同 | `N8N_WEBHOOK_URL` 沒設定、設定錯字，或重啟了 Tunnel 但沒有更新 n8n 設定。更新變數、重建 n8n，再發布工作流。 |
| Tunnel 網址開不起來 | 確認 `cloudflared` 終端機仍在執行，且本機 `http://localhost:5678` 可開啟。 |
| 沒有新的 execution | 確認工作流已發布／啟用、Tunnel 還在執行、Bot 私訊已按 Start，且傳訊息的是正確的 Bot。若剛更新 Tunnel 網址，先重啟 n8n，再停用並重新啟用工作流；確認 Bot Token 沒有被另一個工作流共用。 |
| 執行成功但沒有 Telegram 回覆 | 檢查 `統一輸入.source`。若是 `n8n_chat`，代表訊息來自 n8n Chat，會走 `n8n Chat 回覆`。請從 Telegram Bot 私訊重新傳送案例。 |
| 在 Google Sheets 節點停止 | 確認憑證帳號有編輯試算表的權限，Spreadsheet ID 與 `潛客名單` 分頁名稱正確。寫表在 IF 前，寫表失敗時不會繼續到 Telegram 回覆。 |
| Telegram 回覆節點顯示 Chat ID 錯誤 | 確認來源為實際 Telegram 訊息、`telegramChatId` 有值，且 Telegram 憑證有效。不要使用 n8n Chat 的 session ID 當 Telegram Chat ID。 |
| 新建 Tunnel 後舊 webhook 失效 | Quick Tunnel hostname 會變。更新 `N8N_WEBHOOK_URL`、重啟 n8n，並重新發布／啟用 Telegram Trigger，讓 Telegram 登記新網址。 |

## 第 11 章：重開電腦後恢復

1. 啟動 Docker Desktop 和 n8n 容器，確認 `http://localhost:5678` 可以開啟。
2. 開新終端機，執行 `cloudflared tunnel --url http://localhost:5678`；若 Quick Tunnel 已在執行，使用現有視窗即可。
3. 複製這次產生的 HTTPS 網址。若網址和上次不同，更新 `.env` 裡的 `N8N_WEBHOOK_URL`。
4. 在 Compose 檔所在資料夾執行 `docker compose up -d n8n`，等待 n8n 重新啟動。若 Docker 回報同名容器已存在，代表目前容器是用不同的 Compose 專案名稱啟動；先確認原本專案名稱，再以同一名稱執行 Compose，不要刪除容器或 Volume。
5. 回到工作流確認 Telegram webhook URL 是新的 HTTPS 網址，重新 Publish／Activate（必要時先停用再啟用以重新登記 webhook）。若畫面顯示 Published 但沒有新 execution，確認 n8n 已載入最新設定後，再停用並重新啟用工作流。
6. 從 Telegram 私訊傳送第 8 章案例，確認新的 execution、Telegram 回覆和 Google Sheet 列都成功。

重跑 Tunnel 只會改變公開網址，不會改變 n8n Credentials。只有 Bot Token 被撤銷或重新核發時，才需要更新 Telegram Credential。

## 評分與人工覆核原則

工作流參考權重：需求匹配 0–40、預算可行性 0–25、公司規模與擴展潛力 0–20、時程急迫度 0–15。總分限制在 0–100。公司、需求、預算或時程缺漏／矛盾時，標記人工覆核。AI 評分僅供初篩，不自動成交、承諾價格或拒絕客戶。

## 官方文件

- [Cloudflare Quick Tunnels](https://developers.cloudflare.com/tunnel/get-started/quick-tunnels/)
- [n8n：透過反向代理設定 webhook URL](https://docs.n8n.io/deploy/host-n8n/configure-n8n/basic-configuration/configuration-examples/configure-webhook-urls-with-reverse-proxy/)
- [n8n Telegram Trigger](https://docs.n8n.io/integrations/builtin/trigger-nodes/n8n-nodes-base.telegramtrigger/)
