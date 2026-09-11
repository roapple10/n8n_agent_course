# Docker 與 n8n 課程教學

本指南將教你如何使用 **Docker Compose** 在本地（Windows/Mac/Linux）或伺服器上部署 n8n。
相比簡單的 `docker run`，使用 Docker Compose 是**最佳實踐**，因為它能更方便地管理配置、數據持久化和網路設置。

---

## Docker 概念

- **Image**：可重複使用的軟體封裝；本課程使用 `n8nio/n8n` image。
- **Container**：image 啟動後的執行個體；學生的 n8n 就是一個 container。
- **Volume**：將 n8n 資料持久化。刪除 container 不等於刪除資料；但 `docker compose down -v` 會刪除 volume，課程中不要使用。
- **Docker Compose**：用一份 YAML 檔描述與啟動服務。Docker Desktop 已包含 Compose。[Docker 官方介紹](https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-docker-compose/)提供操作畫面與概念圖。

## 課前安裝 Docker Desktop

1. 到 [Docker Desktop 官方下載頁](https://www.docker.com/products/docker-desktop/) 依 Windows、macOS 或 Linux 安裝；首次啟動後登入或完成必要權限。
2. 開啟 Terminal（Windows 使用 PowerShell），執行：

```bash
docker --version
docker compose version
```

兩行都有版本號才繼續。Docker 官方建議使用 Docker Desktop 安裝 Compose，請勿安裝已屬舊版相容用途的 standalone Compose。[安裝說明](https://docs.docker.com/compose/install/)

## 用課程設定檔啟動 n8n

1. 開啟本週資料夾，複製 `docker-compose.yml` 中的 `N8N_ENCRYPTION_KEY` 設定值，改成自己的長隨機字串。不要交出、不要上傳到 GitHub。
2. 在此資料夾執行：

```bash
docker compose up -d
docker compose ps
```

3. 瀏覽器開啟 `http://localhost:5678`，完成 n8n 的 owner 帳號設定。
4. 若看不到網頁，執行：

```bash
docker compose logs -f
```

按 `Ctrl+C` 離開 log 畫面；container 仍會在背景執行。

## 每週使用與結束

```bash
# 停止，但保留 workflow 與 credentials 資料
docker compose down

# 下次回到這個資料夾後重新啟動
docker compose up -d

# 更新 image 後重新建立 container；先確認 n8n 已備份
docker compose pull
docker compose up -d
```

`docker compose up -d` 會以背景方式啟動服務；`docker compose logs -f` 用來看即時錯誤，這些行為可對照 [Docker Compose CLI 文件](https://docs.docker.com/reference/cli/docker/compose/up/)。

---

##  前置準備

### 1. 安裝 Docker 和 Docker Compose

確保你的電腦已經安裝了 Docker Desktop (Mac/Windows) 或 Docker Engine (Linux)。

- **驗證安裝**：打開終端機 (Terminal/PowerShell)，輸入 `docker --version` 和 `docker-compose --version`。

---

##  部署步驟

### 第一步：創建專案文件夾

在你的電腦上創建一個目錄，用於存放 n8n 的配置數據。

# Mac/Linux

mkdir n8n-docker
cd n8n-docker

# Windows (PowerShell)

mkdir n8n-docker
cd n8n-docker

# Windows

# 在資源管理器中新建一個文件夾，然後進入

````

### 第二步：創建 docker-compose.yml

本週資料夾已提供可直接複製的 [docker-compose.yml](docker-compose.yml)。啟動前，請將 `N8N_ENCRYPTION_KEY` 改為自己的長隨機字串；此值遺失後，既有的 credentials 將無法解密。

在該目錄下，創建一個名為 `docker-compose.yml` 的文件，並貼上以下內容：

```yaml
version: '3.8'

services:
  n8n:
    image: docker.n8n.io/n8nio/n8n
    container_name: n8n
    restart: always
    ports:
      - "5678:5678"
    environment:
      - N8N_HOST=localhost
      - N8N_PORT=5678
      - N8N_PROTOCOL=http
      - NODE_ENV=production
      - WEBHOOK_URL=http://localhost:5678/
      # 如果需要時區設置 (例如台北時間)
      - GENERIC_TIMEZONE=Asia/Taipei
      - TZ=Asia/Taipei
    volumes:
      - n8n_data:/home/node/.n8n

volumes:
  n8n_data:
````

### 第三步：啟動服務

在終端機中，確保你位於 `docker-compose.yml` 所在目錄，運行：

```bash
docker-compose up -d
```

- `-d` 表示在後台運行 (Detached mode)。
- 第一次運行會下載鏡像，可能需要幾分鐘。

### 第四步：訪問 n8n

打開瀏覽器，訪問：
 [http://localhost:5678](http://localhost:5678)

你需要註冊一個管理員帳號（數據僅保存在本地，不會上傳到 n8n 雲端）。

---

##  如何更新 n8n？

n8n 更新頻率很高 (每週都有新功能)，使用 Docker Compose 更新非常簡單：

```bash
# 1. 拉取最新鏡像
docker-compose pull

# 2. 重啟容器 (會自動使用新鏡像並保留數據)
docker-compose up -d
```

![1767849404537](image/本地安裝指南/1767849404537.png)

## ![1767849166595](image/本地安裝指南/1767849166595.png)

##  常見問題 (FAQ)

### Q1: 為什麼不推薦使用 n8n Desktop App？

n8n 官方曾經推出過桌面版 App，但目前維護力度較小，且功能不如 Docker 版完整（例如在處理二進制文件、Python 環境依賴時可能受限）。Docker 版是官方推薦的生產環境部署方式，也更接近伺服器上的真實環境。

### Q2: 既然是本地部署，我的 Webhook 能被外部訪問嗎？

默認情況下，**不能**。

- `http://localhost:5678` 只有你自己能訪問。
- 如果你需要接收外部 (如 GitHub, Slack) 的 Webhook，你需要將本地服務暴露到公網。
- **解決方案**：
  1. 使用 n8n 內置的 Tunnel 功能 (測試用)：
     在 `docker-compose.yml` 的 `environment` 中添加 `- N8N_TUNNEL_SUBDOMAIN=mytunnel123` (需配合 npm 安裝 tunnel，較複雜，不推薦長期用)。
  2. **使用 Cloudflare Tunnel (推薦)**：安全且免費，適合長期使用。

### Q3: 數據存在哪裡？

所有工作流程和憑證都保存在 Docker Volume `n8n_data` 中。只要你不刪除這個 Volume，數據就是安全的。

---

##  參考影片

- **Docker 部署基礎教程**: [YouTube 搜尋 "n8n docker install"](https://www.youtube.com/results?search_query=n8n+docker+install)
- **歷史教程 (僅供參考)**: [https://www.youtube.com/watch?v=ucCamELP8UY](https://www.youtube.com/watch?v=ucCamELP8UY)
