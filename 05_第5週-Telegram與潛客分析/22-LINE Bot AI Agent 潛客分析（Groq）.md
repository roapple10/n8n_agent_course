# LINE Bot AI Agent 潛客分析（Groq）

這是第 21 篇規則評分版的進階練習：LINE 收到潛客訊息後，先以相同規則計算可解釋分數，再由 **AI Agent + Groq Chat Model** 摘要需求、建議下一步與追問，最後回覆 LINE。AI 不會替分數加減，也不會把資料寫入名單。

> 本練習會把測試訊息送到 Groq API 供模型分析。請只使用合成資料，不要傳送真實客戶姓名、電話、email 或敏感內容。API 可用額度、模型與費率依 Groq 帳戶及當前方案而異，使用前請查閱 [Groq 模型與費率](https://console.groq.com/docs/models)。

## 你會完成什麼

- 匯入第二個、與規則版分開的 LINE 潛客分析工作流。
- 建立 Groq API Key，安全存進 n8n Credential。
- 讓 AI Agent 分析需求，並透過 LINE 回覆五項摘要。
- 比較固定規則評分與 AI 生成建議的差異。

## 事前準備

先依[第 21 篇 LINE Bot 教材](21-LINE%20Bot%20潛客分析工作流.md)完成測試官方帳號、Messaging API、n8n 登入保護、Cloudflare Quick Tunnel，以及 LINE 簽章與 Reply API Credential。準備自己的 n8n 和 LINE 測試帳號；不可連接真實客服帳號。

工作流檔案：`課堂練習/LINE Bot 潛客分析 AI Agent + Groq.json`。本版本 Webhook 路徑是 `line-lead-analysis-ai`，和第 21 篇規則版的 `line-lead-analysis` 不同。

## 操作步驟

### 1. 建立 Groq API Key

1. 前往 [Groq Console](https://console.groq.com/)，登入或建立自己的課堂測試帳號。
2. 開啟 **API Keys**（也可直接前往 [console.groq.com/keys](https://console.groq.com/keys)），選 **Create API Key**。
3. 為 Key 命名，例如 `n8n-classroom`，建立後立即複製並暫存於密碼管理工具。Key 通常只會完整顯示一次。
4. 不要把 Key 貼到工作流文字欄、JSON、截圖、聊天或 Git；若遺失就撤銷舊 Key 再建立新的。使用前查看 Groq 顯示的帳戶限制與模型費率。

### 2. 匯入工作流並設定三組 Credential

1. n8n → **Workflows → Import from File**，選上述 AI Agent JSON。匯入後先保持未發布。
2. 在「計算 LINE 簽章」節點選自己的 **Crypto Credential**（Channel secret）；在「回覆 LINE（設定 Token）」節點選自己的 **Header Auth Credential**（`Authorization` 標頭值為 `Bearer 你的 Channel access token`）。若尚未建立，照第 21 篇第二節及第四節 4.2 建立。
3. 點畫布上的 **Groq Chat Model**，在 Credential 欄位選 **Create new**，Credential 類型選 **Groq API**，貼上剛建立的 API Key 並儲存。Credential 名稱可用 `Groq 課堂測試`；名稱只是 n8n 內的標籤。Key 只存於 n8n Credential。
4. 在 Groq Chat Model 的 **Model** 下拉選單挑一個目前可用的文字模型；模型清單會隨 Groq 更新，不必照抄範例名稱。打開 **Options**，Temperature 設 `0.2`，Maximum Number of Tokens 設 `400`。
5. 確認 **Groq Chat Model** 的虛線輸出接到 **AI Agent｜潛客分析** 的 `Chat Model` 連接點；**Calculator｜Agent 工具** 接到 Agent 的 `Tool` 連接點。n8n AI Agent 必須至少連接一個工具；本例接 Calculator，Agent 只在需要算術時使用它，不會呼叫其他外部服務。
6. 儲存工作流。匯入的 AI Agent 已預填使用者提示和 System Message；一般練習不必改寫程式碼。先確認設定，再照下方步驟理解各節點。

```text
LINE Webhook → 簽章計算 → 簽章驗證 → 整理訊息 → AI Agent → 整理回覆 → LINE Reply
                                                       ↑          ↑
                                             Groq Chat Model   Calculator 工具
```

### 工作流節點設定速查

| 節點 | 檢查設定與用途 |
|---|---|
| **LINE Webhook** | HTTP Method `POST`；Path `line-lead-analysis-ai`；Options 開啟 **Raw Body**；Response 選 **Immediately／On Received**。LINE 傳入資料由此開始。 |
| **計算 LINE 簽章** | Action `Hmac`；Binary Data 開啟；Binary Property Name `data`；Type `SHA256`；Property Name `expectedSignature`；Encoding `BASE64`；Credential 選自己的 Crypto（Channel secret）。 |
| **驗證 LINE 簽章** | IF 的 String Equals 比較 `={{ $json.expectedSignature }}` 與 `={{ $('LINE Webhook').first().json.headers['x-line-signature'] }}`。只有 **true** 分支接到「整理 LINE 訊息」。 |
| **整理 LINE 訊息** | 已預設只取有文字內容與 replyToken 的訊息，計算規則分數並整理欄位。初學者先不用改 Code。分數沿用第 21 篇的規則。 |
| **AI Agent｜潛客分析** | Prompt 使用整理好的訊息與規則分數；System Message 規定繁體中文五行回覆、不得改動規則分數、未知資訊不可捏造。收到訊息後由 Agent 產生摘要和追問。 |
| **Groq Chat Model** | 選自己的 Groq API Credential 與目前可用模型；Temperature `0.2`、Maximum Number of Tokens `400`。它提供 AI Agent 使用的語言模型。 |
| **Calculator｜Agent 工具** | 不需設定密鑰。確認虛線接到 AI Agent 的 **Tool** 連接點；Agent 必須連接工具才可執行。 |
| **整理 LINE 回覆** | 已預設把 Agent 的 `output` 與原訊息的 `replyToken` 整理成 LINE API 所需格式；不要修改 Code。 |
| **回覆 LINE（設定 Token）** | POST `https://api.line.me/v2/bot/message/reply`；Authentication 用 Generic Credential Type → Header Auth；選自己的 LINE Reply Credential。不要在節點手動貼 Token。 |

若節點旁出現紅色警告，先確認 Credential 已建立並在該節點下拉選取，再按 **Save**。匯出的 JSON 不會包含密鑰，因此每位學生都要連自己的三組 Credential。

### 在 n8n 畫布逐一檢查設定

匯入後按以下順序在畫布點節點名稱，於右側面板檢查；Credential 的值只在 n8n 建立，不要填到一般參數欄。

1. **LINE Webhook**：確認 `HTTP Method` 是 `POST`、`Path` 是 `line-lead-analysis-ai`。展開 **Options**，確認 **Raw Body** 已開啟；`Respond` 選 **Immediately / On Received**。這讓 LINE 可以快速收到 Webhook 已接收的回應。
2. **計算 LINE 簽章**：確認 `Action = Hmac`、`Type = SHA256`、`Encoding = BASE64`、`Binary Data` 開啟，`Binary Property Name = data`、`Property Name = expectedSignature`。在 **Credential** 下拉選擇本 Channel 的 Crypto Credential；此憑證保存 Channel secret。
3. **驗證 LINE 簽章**：條件類型為 **String**，比較方式 **Equals**。左側切換 **Expression** 並填 `={{ $json.expectedSignature }}`；右側切換 **Expression** 並填 `={{ $('LINE Webhook').first().json.headers['x-line-signature'] }}`。檢查只有綠色 **true** 輸出接到「整理 LINE 訊息」。
4. **整理 LINE 訊息**：這是 Code 節點，已提供完整範例程式，負責過濾純文字訊息、計算規則分數。初學者不要改程式；右側程式碼中不要放 API Key 或 Token。
5. **AI Agent｜潛客分析**：保留匯入時的 `Prompt Type = Define below`、User Prompt 與 System Message。前者把 LINE 文字、分數和條件交給 Agent；System Message 規範輸出和資料邊界。先不要自行換成其他 Prompt，確保測試結果可比較。
6. **Groq Chat Model**：在 **Credential** 下拉選擇自己的 Groq API Credential；**Model** 從下拉選單選目前仍可用的模型，**Options → Temperature = 0.2**、**Maximum Number of Tokens = 400**。這個節點以虛線接 Agent 的 **Chat Model** 入口。
7. **Calculator｜Agent 工具**：不需 Credential 或額外參數；確認虛線接到 Agent 的 **Tool** 入口。它是 AI Agent 的簡單算術工具。
8. **整理 LINE 回覆**：保留預設 Code；它把 AI 的 `output` 和 LINE 的一次性 `replyToken` 組成回覆資料。不要把使用者識別碼或 Token 寫入程式。
9. **回覆 LINE（設定 Token）**：Method 為 `POST`，URL 為 `https://api.line.me/v2/bot/message/reply`；Authentication 選 **Generic Credential Type → Header Auth**，再選自己的 LINE Reply Credential。不要在 URL、Header 或 Body 欄位手動貼 access token。

完成檢查：畫布沒有 Credential 警告；Groq Chat Model 與 Calculator 的虛線都接到 Agent；Agent 輸出接到「整理 LINE 回覆」；最後接到 LINE Reply 節點。按 **Save**，再依下一節更新 Webhook 並 **Publish**。

### 3. 切換 LINE Webhook 到 AI 版本

> **持續接收的條件：**AI 工作流須維持 **Published／Active**，n8n 和 Quick Tunnel 都要持續執行；LINE Developers Console 的 Webhook URL 必須是目前 Tunnel 網址加上 AI 版路徑，且 **Use webhook** 已開啟；Official Account Manager 的 **Webhooks** 也須開啟。只發布工作流不代表已停止的 n8n／Tunnel 會自動重啟；按編輯器的 **Execute workflow** 不是持續接收 LINE 訊息的方式。

同一個 LINE Channel 的 Webhook URL 一次只能指向一個工作流。測 AI 版前，先在 n8n 將規則版 **Unpublish／停用**；不要讓兩個版本同時接同一個 Channel。

1. 保持 Quick Tunnel 執行；若重開過電腦，依第 21 篇「電腦重新啟動後怎麼恢復」重新啟動並取得新網址。
2. 在 AI 工作流開啟「LINE Webhook」節點，複製 Production URL 的路徑 `/webhook/line-lead-analysis-ai`。將本次 Tunnel 網址接上此路徑，例如 `https://你的隨機網址.trycloudflare.com/webhook/line-lead-analysis-ai`。
3. LINE Developers Console → 自己的 Provider 與 Messaging API Channel → **Messaging API → Webhook settings → Edit**，貼上完整 HTTPS URL 並按 **Update**。
4. 儲存並 **Publish** AI 工作流。按 **Verify**；成功後開啟 **Use webhook**。Official Account Manager → **設定 → 回應設定** 需停用 Greeting message／Auto-response messages，並啟用 Webhooks。簽章設定細節見第 21 篇第四節。

### 4. 手機測試與練習

以手機傳送以下合成訊息：

> 我們是 25 人的設計公司，想導入 CRM 和 LINE 自動化，預算約 10 萬，希望一個月內開始。

預期收到五項 AI 摘要。規則分數應為 **100/100（高）**；AI 的摘要、追問文字可因模型而不同。到 n8n **Executions** 查看最新執行：點開後確認「計算 LINE 簽章」與「驗證 LINE 簽章」成功，再確認「AI Agent｜潛客分析」和「回覆 LINE（設定 Token）」成功。LINE 的 Verify 測試只送空事件，不會呼叫 AI，也不會回覆潛客分析。

收到測試回覆後，再傳一則新的合成訊息；若 n8n 新增一筆成功 execution 且 LINE 收到回覆，代表 AI 版目前仍在接收。停止 n8n、Quick Tunnel 或電腦後，這個本機流程就會離線；Quick Tunnel 重開換網址時，依前一步更新 LINE Webhook URL、重新 Verify，並確認 AI 工作流仍已發布。

下圖為合成資料的實際互動畫面；模型措辭可能不同，但應包含潛客等級、需求摘要、規則分數、下一步和追問。

![LINE Bot 使用 Groq AI Agent 回覆合成潛客訊息的實際測試畫面](../教材截圖/LINE-AI-Agent-Groq-實際互動.png)

若執行失敗，先在 **Executions → 最新一筆 → Error details** 看第一個紅色節點，再按下表排除；不要在截圖或聊天中顯示任何憑證內容。

| 畫面或錯誤 | 檢查方式 |
|---|---|
| `Authorization failed`、`Invalid API Key`，紅色節點是 AI Agent／Groq Chat Model | 回 Groq Console 建立一把新的有效 API Key；在 n8n **Credentials** 更新 Groq API Credential 並儲存，再回 Groq Chat Model 重新選取憑證。確認沒有複製到空白、引號或多餘字元，舊 Key 若已撤銷便不可再用。不要把 Key 貼到工作流欄位。 |
| AI Agent 成功但 LINE 沒收到回覆 | 檢查「回覆 LINE（設定 Token）」執行結果、Reply API Credential 是否使用此 Channel 的有效長效 access token，以及是否在 replyToken 有效時間內回覆。 |
| 簽章驗證失敗或後續沒有節點執行 | 核對原始 Body 開關、Channel secret、Crypto Credential、Webhook 的 `x-line-signature` 條件和 LINE Channel 是否一致。 |
| 沒有任何新執行 | 檢查 Use webhook、Official Account Manager 的 Webhooks、工作流 Published 狀態、Webhook URL 路徑，以及 Cloudflare Tunnel 是否仍執行。 |

## 完成後

LINE Developers Console 關閉 **Use webhook**；Official Account Manager 關閉 Webhooks；n8n 將 AI 工作流 **Unpublish／停用**；終端機的 Quick Tunnel 按 **Ctrl+C** 停止。切回規則版時，同樣先停用 AI 版，將 LINE Webhook URL 改回 `/webhook/line-lead-analysis`，再發布規則版。

## 觀念整理

- **Groq API Key**：讓 n8n 呼叫 Groq 模型的密鑰；**LINE Channel secret** 驗證 LINE Webhook；**LINE Channel access token** 呼叫 LINE Reply API，三者用途不同。
- **AI Agent**：依提示理解訊息、調用連接的工具並產生分析；**Groq Chat Model** 是 Agent 使用的語言模型；**Calculator** 是算術工具。這個範例不把 AI 當成真實業務決策者。
- 潛客訊息會送到 Groq API。正式蒐集客戶資料前，應先告知分析用途、取得必要同意並依組織政策處理資料。

官方參考：[n8n AI Agent（至少連接一個工具）](https://docs.n8n.io/integrations/builtin/cluster-nodes/root-nodes/n8n-nodes-langchain.agent/) · [n8n Groq Chat Model](https://docs.n8n.io/integrations/builtin/cluster-nodes/sub-nodes/n8n-nodes-langchain.lmchatgroq/) · [Groq Quickstart](https://console.groq.com/docs/quickstart) · [Groq 可用模型](https://console.groq.com/docs/models)
