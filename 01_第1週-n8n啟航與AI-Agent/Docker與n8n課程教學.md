# Docker 與 n8n 課程教學

本週使用 Docker Compose 在自己的電腦啟動 n8n，適合課堂練習與原型驗證，不等同公開服務的 production 部署。

## Docker 基本概念

- **Image**：可重複使用的軟體封裝；本課程使用 `n8nio/n8n`。
- **Container**：image 啟動後的執行個體；你的 n8n 就是一個 container。
- **Volume**：保存 workflows 與 credentials。刪除 container 不會刪除 volume；但 `docker compose down -v` 會刪除，課程中不要使用。
- **Docker Compose**：用 `docker-compose.yml` 描述與啟動服務。Docker Desktop 已內建 Compose。

概念圖與官方說明見 [Docker Compose introduction](https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-docker-compose/)。

## 課前安裝 Docker Desktop

1. 到 [Docker Desktop 官方下載頁](https://www.docker.com/products/docker-desktop/) 安裝適用於 Windows、macOS 或 Linux 的版本，並完成首次啟動需要的權限。
2. 開啟 Terminal；Windows 可使用 PowerShell。執行：

```bash
docker --version
docker compose version
```

兩行都顯示版本號才繼續。請使用目前的 `docker compose` 指令，不要使用舊式的 `docker-compose`。安裝細節見 [Docker Compose install](https://docs.docker.com/compose/install/)。

## 啟動課程 n8n

1. 在本週資料夾開啟 `docker-compose.yml`。
2. 將 `N8N_ENCRYPTION_KEY` 的示範值換成自己的長隨機字串。此值用來加密 credentials；遺失後既有 credentials 將無法解密。不要把它交作業或上傳 GitHub。
3. 在 `docker-compose.yml` 所在資料夾執行：

```bash
docker compose up -d
docker compose ps
```

第一次會下載 image，可能需要數分鐘。看到 `n8n` 狀態為 `Up` 後，在瀏覽器開啟 [http://localhost:5678](http://localhost:5678)。

4. 依畫面建立自己的 Owner 帳號（email、姓名、密碼）。這是本機 n8n 的登入帳號，不是 n8n Cloud 帳號。

## 匯入並執行第一週練習

1. 在 n8n 建立空白 workflow，點上方 **More actions** → **Import** → **From file**。
2. 匯入 `課堂練習/上午-n8n啟航與資料流.json`，按 **Execute workflow**，檢查每個節點都有 1 item，最後輸出有 `passed` 與 `lesson_summary`。
3. 匯入 `課堂練習/下午-AI-Agent與部署檢查.json`，同樣執行一次。它不需要 API key；目標是理解 Agent 所需的 Model、Tool、Memory 與人工覆核點。
4. 匯入的 workflow 預設維持停用；課堂上不要發布或啟用。

## 每週使用、停止與更新

```bash
# 查看服務與最近日誌
docker compose ps
docker compose logs --tail=100

# 停止服務，但保留 workflows 與 credentials
docker compose down

# 下次重新啟動
docker compose up -d

# 更新 image；先確認已有備份才執行
docker compose pull
docker compose up -d
```

`docker compose up -d` 在背景啟動服務；`docker compose logs` 用於排查錯誤。參考 [Docker Compose CLI](https://docs.docker.com/reference/cli/docker/compose/up/)。

## 常見問題

**無法開啟 `localhost:5678`**：先執行 `docker compose ps`，再看 `docker compose logs --tail=100`。若 5678 被其他程式佔用，先停止該程式或修改 compose 檔中左側的 port。

**外部服務無法呼叫本機 Webhook**：`localhost` 只在自己的電腦可見。課堂先以 Manual Trigger 測試；需要公開 webhook 時，另行規劃安全的 tunnel 或部署環境。

**重啟後資料是否還在**：依序執行 `docker compose down`、`docker compose up -d`，重新登入後確認 workflow 仍存在。不要使用 `docker compose down -v`。
