# Cloudflare Quick Tunnel 安裝與 n8n 設定：端到端教學

本教學帶你從安裝 `cloudflared` 開始，建立臨時 HTTPS 網址、設定本機 n8n，最後用 Telegram 測試 Webhook。若只想在瀏覽器使用本機 n8n，不需 Quick Tunnel，直接依 Docker 教學啟動即可。若要測 LINE／Telegram，請先取得 Tunnel 網址並填入 `.env`，再啟動或重啟 Docker Compose，讓 n8n 一開始就載入正確的 HTTPS 網址。

> **重要：** Quick Tunnel 是測試與開發用途。網址會隨機產生，停止通道後失效，重新啟動通常會換新網址。持有網址的人可能連到你的 n8n 登入頁，因此請替 n8n 設定登入保護，不要把網址或登入資料公開分享。正式長期使用請改用具固定網域與存取控管的部署方式。

## 完成後會有什麼

```text
Telegram 伺服器
      │ HTTPS Webhook
      ▼
https://隨機名稱.trycloudflare.com
      │ Cloudflare Quick Tunnel
      ▼
本機 n8n：http://localhost:5678
```

本教學使用 Cloudflare **Quick Tunnel**，不需 Cloudflare 帳號或自有網域。官方將 Quick Tunnel 定位為測試／開發工具；它會產生臨時的 `trycloudflare.com` 網址，停止 `cloudflared` 後網址就無法使用。[Cloudflare Quick Tunnel 官方說明](https://developers.cloudflare.com/tunnel/get-started/quick-tunnels/)

## 開始前準備

- 已安裝並能啟動本課的 n8n Docker Compose 專案。
- 在瀏覽器開啟 `http://localhost:5678` 時，可以看到 n8n 登入頁或工作區。
- 已替 n8n 設定登入保護。若任何人開啟 `http://localhost:5678` 都能直接進入工作區，先完成登入保護，再建立公開 Tunnel。
- Telegram Bot 已建立；若要做本教學最後的測試，先在 Bot 私訊按 **Start**。

## 第 1 步：安裝 cloudflared

每台電腦只需安裝一次。安裝完後，請關閉並重新開啟終端機，再確認版本。

### macOS

若已安裝 Homebrew，打開「終端機」並執行：

```bash
brew install cloudflared
cloudflared --version
```

若尚未安裝 Homebrew，可從 [Cloudflare 官方下載頁](https://developers.cloudflare.com/tunnel/downloads/)下載 macOS 版本：Apple Silicon 選 `arm64`，Intel Mac 選 `amd64`。

### Windows

1. 從 [Cloudflare 官方下載頁](https://developers.cloudflare.com/tunnel/downloads/)下載並安裝 Windows 64-bit MSI。
2. 關閉並重新開啟 PowerShell，執行：

   ```powershell
   cloudflared --version
   ```

若顯示找不到指令，先重新開啟 PowerShell；仍無法使用時，確認 MSI 安裝完成，或參考官方下載頁的手動安裝方式。

### Linux

依照 [Cloudflare 官方下載頁](https://developers.cloudflare.com/tunnel/downloads/)選擇自己的 Linux 發行版與處理器架構安裝，再執行：

```bash
cloudflared --version
```

若終端機顯示版本號，代表安裝完成。

## 第 2 步：確認第五週資料夾

先打開終端機／PowerShell，切換到課程專案中的第五週資料夾：

```bash
cd "n8n/05_第5週-Telegram與潛客分析"
```

這個路徑是從課程專案根目錄開始；若你把課程專案放在其他位置，請先切換到自己的專案資料夾，再執行相對應的 `cd` 路徑。

確認這個資料夾中有 `docker-compose.yml` 和 `.env.example`。如果只想在瀏覽器使用 n8n，現在可執行 `docker compose up -d`，再開啟 `http://localhost:5678`；要測 LINE／Telegram，先不要啟動 Compose，依序完成下一步到第 4 步，設定好 Tunnel 網址後再啟動。

## 第 3 步：建立 Quick Tunnel 並取得 HTTPS 網址

1. 開一個終端機／PowerShell 視窗。以下稱它為「Tunnel 視窗」。初次設定時即使 n8n 尚未啟動，也可以先取得 Quick Tunnel 網址。
2. 在 Tunnel 視窗執行：

   ```bash
   cloudflared tunnel --url http://localhost:5678
   ```

3. 等待終端機顯示 `Your quick Tunnel has been created!`，找到並複製 `https://……trycloudflare.com` 網址。不要照抄範例網址，每個人每次產生的網址可能不同。
4. **Tunnel 視窗要保持開啟。** 關閉視窗或按 `Control+C` 會停止通道。等第 4 步啟動 n8n 後，再將這個網址貼到瀏覽器測試轉送是否正常。

## 第 4 步：將 HTTPS 網址設定給 n8n

Telegram 必須收到 HTTPS Webhook 網址。只啟動 Tunnel 還不夠；n8n 也要在啟動時知道目前的外部網址。這裡使用 `N8N_WEBHOOK_URL`，並設定 `N8N_PROXY_HOPS=1`。[n8n 官方反向代理與 Webhook URL 設定](https://docs.n8n.io/deploy/host-n8n/configure-n8n/basic-configuration/configuration-examples/configure-webhook-urls-with-reverse-proxy/)

### 4.1 找到 Compose 設定資料夾

開另一個終端機視窗（或回到啟動 n8n 的視窗），切換至 `docker-compose.yml` 所在資料夾：

```bash
cd "n8n/05_第5週-Telegram與潛客分析"
```

### 4.2 確認 `.env` 存在

`.env` 是本機設定檔，可能已經有其他課程設定。若 `.env` **已存在，直接編輯，不要再次複製 `.env.example` 覆蓋它**。

只有在資料夾中還沒有 `.env` 時，才從範例複製一份：

macOS／Linux：

```bash
cp .env.example .env
```

Windows PowerShell：

```powershell
Copy-Item .env.example .env
```

第五週 Compose 的 `.env.example` 只有 Webhook 網址和代理設定，不需要填寫任何服務金鑰。

### 4.3 編輯 `.env`

用文字編輯器開啟 `.env`：

- macOS：在 Compose 資料夾執行 `open -e .env`，或用自己熟悉的文字編輯器開啟。
- Windows：在 Compose 資料夾執行 `notepad .env`。
- Linux：可執行 `nano .env`。

找到 `N8N_WEBHOOK_URL`，將值改為第 3 步取得的完整 HTTPS 網址，並在網址最後保留 `/`。確認 `N8N_PROXY_HOPS=1`。例如：

```dotenv
N8N_WEBHOOK_URL=https://這次產生的名稱.trycloudflare.com/
N8N_PROXY_HOPS=1
```

請以你自己這次取得的網址替換範例中的文字。編輯時保留 `.env` 的其他行，不要把整個範例檔貼上覆蓋。不要把 `.env` 上傳 Git、貼到群組或放進截圖；這個檔案可能包含其他服務的密鑰。

### 4.4 確認 Docker Compose 會把設定傳給 n8n

打開 `docker-compose.yml`，在 `services` → `n8n` → `environment` 確認有這兩行：

```yaml
      - N8N_WEBHOOK_URL=${N8N_WEBHOOK_URL:-http://localhost:5678/}
      - N8N_PROXY_HOPS=${N8N_PROXY_HOPS:-1}
```

若已存在，請勿重複加入。若原本有 `environment:` 區塊，只在同一區塊新增缺少的項目，不要建立第二個 `environment:`。

### 4.5 啟動 n8n 並套用設定

儲存 `.env` 後，在 Compose 資料夾執行：

```bash
docker compose up -d
```

等 n8n 啟動完成，再確認 `http://localhost:5678` 可正常開啟，並將 Quick Tunnel 網址貼到瀏覽器確認可到達 n8n。Tunnel 視窗必須保持執行。之後更換 Tunnel 網址時，更新 `.env` 後再次執行 `docker compose up -d`，讓 n8n 套用新網址；不用刪除容器或 Volume。

## 第 5 步：重新發布 Telegram 工作流

1. 在 n8n 開啟本課的 Telegram 工作流。
2. 確認 `Telegram 輸入` 節點的 Webhook URL 以 `https://` 開頭，且網域是這次的 `trycloudflare.com` 網址。如果仍顯示 `localhost` 或 `http://`，先回第 4 步檢查 `.env` 和 Compose 設定。
3. 若工作流尚未啟用，按 **Publish／Activate** 啟用。
4. 若工作流原本已啟用，但你剛更換了 Tunnel 網址，將工作流停用再重新啟用／發布一次，讓 Telegram 註冊新的 Webhook。

Telegram Bot 同一時間只能使用一個有效 Webhook。若另一個工作流也使用同一個 Bot，先停止另一個工作流，再啟用目前要測試的工作流。

## 第 6 步：從 Telegram 做端到端測試

1. 在 Telegram 開啟自己的 Bot 私訊。第一次使用先按 **Start**。
2. 傳送一筆測試資料，例如：

   ```text
   公司名稱：青禾數位測試
   聯絡人：測試聯絡人
   產業：B2B 軟體服務
   公司規模：45 人
   預算：新台幣 30,000 元
   需求與痛點：希望導入 CRM，自動分級潛客並提醒業務跟進。
   預計導入時間：1 個月內
   ```

3. 在 n8n 工作流開啟 **Executions**，檢查最新執行是否成功。確認 `Telegram 輸入`、`Groq 模型`、`寫入潛客名單` 和 `Telegram 回覆` 節點成功。
4. 回到 Telegram，確認 Bot 回覆評分與下一步建議。
5. 開啟課程 Google Sheet 的 `潛客名單` 分頁，確認新增一列。

> n8n 編輯器內的 Chat 面板是另一個測試入口。它的回覆只顯示在 n8n，不會送到 Telegram。要驗證 Telegram 回覆，必須從 Telegram Bot 私訊傳送資料。

## Tunnel 關閉或電腦重開後如何恢復

Quick Tunnel 網址只在 `cloudflared` 程序執行時有效。電腦重開、關閉 Tunnel 視窗或按 `Control+C` 後，網址可能失效或改變。要恢復 LINE／Telegram，先取得新網址並更新 `.env`，再啟動／重啟 n8n：

1. 啟動 Docker Desktop。
2. 另開 Tunnel 視窗，執行：

   ```bash
   cloudflared tunnel --url http://localhost:5678
   ```

3. 複製新的 `https://……trycloudflare.com` 網址。若 n8n 尚未啟動，Tunnel 仍會先建立網址。
4. 在 Compose 資料夾更新 `.env` 的 `N8N_WEBHOOK_URL`，保留網址尾端的 `/`，並確認 `N8N_PROXY_HOPS=1`。
5. 回到 Compose 資料夾執行，讓 n8n 以新網址啟動：

   ```bash
   docker compose up -d
   ```

6. 確認 `http://localhost:5678` 和新 Quick Tunnel 網址都能開啟。Tunnel 視窗要保持執行。
7. 回到工作流停用後重新啟用／發布，讓 Telegram 註冊新的 Webhook。
8. 從 Telegram 傳送測試資料，確認新執行、Bot 回覆和 Google Sheet 新增資料列。

每次重開 Quick Tunnel 若網址改變，都要更新 `.env` 並重啟 n8n。只重跑 `cloudflared` 而沒有更新 n8n，Telegram 仍可能呼叫舊網址。

## 常見問題

| 現象 | 檢查方式 |
|---|---|
| `cloudflared: command not found` 或找不到指令 | 確認安裝完成，關閉並重新開啟終端機，再執行 `cloudflared --version`。 |
| Tunnel 網址打不開 | 確認 n8n 正在執行，`http://localhost:5678` 可開啟，而且 Tunnel 視窗沒有關閉。 |
| Telegram 顯示 `bad webhook: An HTTPS URL must be provided for webhook` | 確認 `.env` 的 `N8N_WEBHOOK_URL` 是完整的 `https://...trycloudflare.com/` 網址；重新啟動 n8n，再停用並重新啟用／發布工作流。 |
| 工作流沒有新的 Execution | 確認工作流已啟用、Tunnel 正在執行、Bot 私訊已按 Start，且正在使用正確的 Bot。 |
| 執行成功但 Telegram 沒收到回覆 | 確認訊息是從 Telegram Bot 傳入，而不是 n8n Chat 面板；檢查 Execution 是否走到 `Telegram 回覆` 節點。 |
| 重開 Tunnel 後原本網址失效 | Quick Tunnel 會換新網域。更新 `.env` 的 `N8N_WEBHOOK_URL`、重啟 n8n，再重新發布／啟用工作流。 |
| Compose 回報設定或環境變數錯誤 | 確認命令是在 `docker-compose.yml` 所在資料夾執行，且 `.env` 存在；不要刪除其他課程設定。 |

## 官方參考

- [Cloudflare Quick Tunnels](https://developers.cloudflare.com/tunnel/get-started/quick-tunnels/)
- [Cloudflare Tunnel 下載與安裝](https://developers.cloudflare.com/tunnel/downloads/)
- [n8n：透過反向代理設定 Webhook URL](https://docs.n8n.io/deploy/host-n8n/configure-n8n/basic-configuration/configuration-examples/configure-webhook-urls-with-reverse-proxy/)
