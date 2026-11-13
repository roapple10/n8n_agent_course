# 第 7 週：用 Docker Compose 維運本機 n8n

本週用資料夾內已提供的 `docker-compose.yml` 啟動本機 n8n，作為 Antigravity Agent、`n8n-mcp` 和期末專題的開發環境。你不需要自己撰寫 Compose 設定，也不需要另外建立 `.env` 才能啟動。

完成後，你會知道如何啟動、檢查、停止和重新啟動 n8n，了解工作流程與 Credentials 儲存在哪裡，並在升級或結束課程前做好基本備份。

> 請只連接自己的本機測試環境並使用練習資料。這份設定將 n8n 綁定在本機 `127.0.0.1:5678`，不要自行改成公開網路服務。

## 1. 認識本週的 Docker Compose 設定

本資料夾的 `docker-compose.yml` 已設定好 n8n 服務：

- n8n 在瀏覽器的網址是 `http://localhost:5678`。
- Docker 容器名稱是 `n8n-course`。
- 工作流程、帳號、Credentials 等 n8n 資料寫入名為 `n8n_data` 的 Docker 資料卷。
- `restart: unless-stopped` 會在 Docker 重新啟動時嘗試恢復服務。
- 時區設為 `Asia/Taipei`。

資料卷讓資料不會只留在容器本身。一般停止或重建容器時，資料卷仍保留；**不要使用 `docker compose down -v`**，除非你確定要刪除這個專案的所有 n8n 資料。

## 2. 安裝並啟動 Docker Desktop

1. 從 [Docker Desktop 官方下載頁](https://www.docker.com/products/docker-desktop/)下載適合電腦的版本並安裝。
2. 開啟 Docker Desktop，等待它顯示已啟動。練習時讓 Docker Desktop 保持開啟。
3. 開啟終端機；Windows 可使用 PowerShell，輸入：

   ```sh
   docker --version
   docker compose version
   ```

   兩個指令都應顯示版本號。如果提示 Docker Engine 無法連線，先回到 Docker Desktop 等待啟動完成。

## 3. 從本週資料夾啟動 n8n

在終端機切換到這份課程的第七週資料夾。請將路徑替換成自己電腦上的實際位置。

macOS / Linux：

```sh
cd "/你的課程資料夾/n8n/07_第7週-維運與期末專題"
```

Windows PowerShell：

```powershell
Set-Location "你的課程資料夾\n8n\07_第7週-維運與期末專題"
```

確認目前資料夾同時有 `docker-compose.yml` 和 `00-n8n-MCP與Antigravity-Agent實作.md`：

```sh
ls
```

啟動 n8n：

```sh
docker compose up -d
```

第一次啟動時 Docker 會下載 n8n 映像檔，請等待完成。`-d` 表示在背景執行。接著查看服務狀態：

```sh
docker compose ps
```

服務狀態正常後，在瀏覽器開啟 [http://localhost:5678](http://localhost:5678)。第一次使用時，依畫面建立自己的 n8n 帳號。這是本機 n8n 帳號，不是 Groq 帳號或 Antigravity 帳號。

## 4. 連接 Antigravity Agent

先完成[ n8n MCP 與 Antigravity Agent 實作教學](00-n8n-MCP與Antigravity-Agent實作.md)中的 API Key 建立和 MCP 設定，再回到這裡確認連線：

1. 確認瀏覽器可開啟 `http://localhost:5678`，而且 `docker compose ps` 顯示 n8n 正在執行。
2. Antigravity 的 MCP 設定使用 `N8N_API_URL`：`http://localhost:5678`。
3. `N8N_API_KEY` 使用你在自己的 n8n **Settings → n8n API** 建立的 API Key。不要把真實 key 寫入這個資料夾的範例檔、課程 Git 或 Agent 對話。
4. 在 Antigravity MCP Servers 畫面重新整理 `n8n-mcp`，並依主教材的步驟請 Agent 查詢節點或列出測試工作流程。

`localhost` 指執行 Antigravity 的這台電腦。這份設定適用於 Antigravity 與 Docker Desktop 都在同一台電腦上的情況。如果把 Agent 或 `n8n-mcp` 搬到另一個容器或另一台電腦，`localhost` 會指向不同位置，需另行設定可互相連線的網路位址。

## 5. 練習維運：查看狀態與紀錄

確認 n8n 服務狀態：

```sh
docker compose ps
```

查看最近的 n8n 啟動紀錄：

```sh
docker compose logs --tail=80 n8n
```

持續查看新紀錄：

```sh
docker compose logs -f n8n
```

按 **Ctrl+C** 只會停止顯示紀錄，不會停止 n8n。遇到 Agent 無法連線時，依序檢查：Docker Desktop 是否啟動、n8n 網頁是否打得開、`docker compose ps` 狀態，以及 MCP 設定中的網址和 API Key。

## 6. 練習停止與恢復

暫停練習並保留容器：

```sh
docker compose stop
```

稍後恢復：

```sh
docker compose start
```

如果要停止並移除容器與 Compose 網路，但保留 n8n 資料卷：

```sh
docker compose down
```

之後從同一個第七週資料夾重新啟動：

```sh
docker compose up -d
```

重新開啟 `http://localhost:5678`，確認帳號和剛才建立的測試工作流程還在。這就是本課資料卷持續保存資料的檢查練習。

## 7. 專題資料備份與升級前檢查

Docker 的資料卷保存 n8n 本機資料，但它不是另一份獨立備份。準備升級、重設環境或整理期末專題前，先從 n8n 編輯器匯出重要工作流程 JSON，存放在自己的安全位置。匯出的工作流程不等於完整帳號備份；不要把真實 Credentials、API Key 或密碼分享到課程 Git。

本資料夾使用 `image: n8nio/n8n:latest`，代表下次下載映像檔時會取得當時的最新版。升級前先匯出重要流程，再從本週資料夾執行：

```sh
docker compose pull
docker compose up -d
```

接著查看狀態與啟動紀錄，並登入 n8n 確認期末專題流程可正常開啟。若是重要或正式環境，應先規劃經測試的固定版本和完整備份；本課練習環境不要存放正式資料或正式服務憑證。

## 8. 課堂操作任務

1. 使用這個資料夾的 Compose 設定啟動 n8n，記錄 `docker compose ps` 顯示的服務狀態。
2. 依主教材連接 Antigravity `n8n-mcp`，請 Agent 只讀取節點資訊並列出工作流程名稱。
3. 在 n8n 建立一個未啟用的期末專題測試流程，確認它能在瀏覽器中看到。
4. 執行 `docker compose down`，再用 `docker compose up -d` 恢復服務，確認測試流程仍存在。
5. 回答：工作流程資料由哪個 Docker 資料卷保存？`docker compose down` 和 `docker compose down -v` 有什麼差別？
6. 匯出一份不含真實憑證的練習工作流程 JSON，放到個人專題備份位置，不要提交任何 API Key。

## 9. 常見問題

| 情況 | 處理方式 |
|---|---|
| Docker 指令無法連線 Docker Engine | 開啟 Docker Desktop，等待它啟動後再試。 |
| `no configuration file provided` | 確認終端機目前位於第七週資料夾，而且該處有 `docker-compose.yml`。 |
| `port is already allocated` | 另一個程式或 n8n 正使用 5678。先確認並停止自己先前啟動的 n8n，再執行 `docker compose up -d`。 |
| `http://localhost:5678` 打不開 | 執行 `docker compose ps` 和 `docker compose logs --tail=80 n8n` 查看狀態及錯誤。 |
| Agent 找不到 n8n | 確認網頁可開啟，MCP 設定網址是 `http://localhost:5678`，且 API Key 有效；再重新整理 MCP Server。 |
| 停止後流程不見 | 確認啟動時使用同一個第七週資料夾和 Compose 專案，不要使用 `down -v` 或手動刪除 Docker 資料卷。 |

## 官方參考

- [Docker Desktop 下載](https://www.docker.com/products/docker-desktop/)
- [Docker Compose Quickstart：資料卷與停止服務](https://docs.docker.com/compose/gettingstarted/)
- [n8n Docker 安裝說明](https://docs.n8n.io/hosting/installation/docker/)
- [n8n MCP 與 Antigravity Agent 實作教學](00-n8n-MCP與Antigravity-Agent實作.md)
