# 用 Docker Compose 在本機啟動 n8n

本教學用 Docker Desktop 在自己的電腦啟動 n8n，之後可匯入第五週的 LINE、Telegram 和 Groq 工作流。一般啟動不需要建立 `.env`，也不必自行產生或填入任何服務金鑰。

> 這份設定供個人電腦與課堂練習使用。n8n 僅綁定本機 `127.0.0.1`，不要自行改成公開連線設定。

## 第 1 步：安裝 Docker Desktop

1. 從 [Docker Desktop 官方下載頁](https://www.docker.com/products/docker-desktop/)下載並安裝適合自己電腦的版本。
2. 開啟 Docker Desktop，等待畫面顯示 Docker 已啟動。先不要關閉 Docker Desktop。
3. 開啟終端機（Windows 可用 PowerShell），執行：

   ```sh
   docker --version
   docker compose version
   ```

   兩行都應顯示版本號。若出現 Docker Engine 無法連線的訊息，回到 Docker Desktop 等它啟動完成。

## 第 2 步：進入第五週資料夾

在終端機切換到自己的第五週資料夾。路徑請換成課程檔案實際存放的位置：

```sh
cd "/你的課程資料夾/05_第5週-Telegram與潛客分析"
```

Windows PowerShell：

```powershell
Set-Location "你的課程資料夾\05_第5週-Telegram與潛客分析"
```

輸入 `ls`（PowerShell 也可輸入 `dir`），確認清單裡有 `docker-compose.yml`。

## 第 3 步：啟動 n8n

直接執行：

```sh
docker compose up -d
```

第一次啟動會下載 n8n 映像檔，請等待下載與啟動完成。`-d` 代表在背景執行，完成後終端機會回到提示符號。

檢查容器狀態：

```sh
docker compose ps
```

看到 `n8n-course` 狀態為 `Up` 後，在瀏覽器開啟 [`http://localhost:5678`](http://localhost:5678)。第一次使用時，依畫面建立自己的 n8n 帳號與密碼。

### 金鑰和資料如何保存？

不必在 `.env` 填金鑰。n8n 第一次啟動時會自行產生 Credentials 加密金鑰，連同工作流、帳號和 Credentials 一起保存在 Docker 的 `n8n_data` 資料卷中。Docker Compose 不會把金鑰寫進 `.env`。

不要執行 `docker compose down -v`，因為 `-v` 會刪除資料卷及其中的 n8n 資料。一般停止或重新啟動請使用下方指令。

## 測試 LINE 或 Telegram Webhook（選做）

一般本機練習不用 `.env`。若要讓 LINE 或 Telegram 連到你的 n8n，需先依[Cloudflare Quick Tunnel 教學](Cloudflare%20Quick%20Tunnel%20安裝與%20n8n%20設定教學.md)取得臨時 HTTPS 網址。

在第五週資料夾建立 `.env`：

```sh
cp .env.example .env
```

用文字編輯器開啟 `.env`，把 `N8N_WEBHOOK_URL` 改成 Quick Tunnel 提供的 HTTPS 網址並保留最後的 `/`，例如 `https://你的隨機網址.trycloudflare.com/`。接著重新套用設定：

```sh
docker compose up -d
```

Tunnel 網址停止或重新啟動後可能改變；網址改變時，也要更新 `.env` 並再次執行 `docker compose up -d`。`.env` 只放在自己的電腦，不要上傳或傳給同學。

## 停止和重新啟動

停止容器但保留工作流和 Credentials：

```sh
docker compose down
```

之後回到同一個資料夾，再執行 `docker compose up -d` 即可重新啟動。要確認 n8n 啟動訊息，可執行：

```sh
docker compose logs -f n8n
```

按 **Ctrl+C** 會停止顯示紀錄，不會停止背景容器。

## 常見問題

| 情況 | 處理方式 |
|---|---|
| Docker 指令無法連線 Docker Engine | 開啟 Docker Desktop，等它顯示已啟動後再試。 |
| `port is already allocated` | 另一個 n8n 正在使用 5678。先停止另一個服務，再執行 `docker compose up -d`。 |
| 瀏覽器打不開 `localhost:5678` | 執行 `docker compose ps` 查看狀態，再用 `docker compose logs --tail=80 n8n` 查看啟動訊息。 |
| n8n 要求建立帳號 | 第一次開啟時依畫面建立自己的 Owner 帳號；此帳號不需要預先寫入 `.env`。 |

## 官方參考

- [Docker Desktop for Mac 安裝](https://docs.docker.com/desktop/setup/install/mac-install/)
- [Docker Desktop for Windows 安裝](https://docs.docker.com/desktop/setup/install/windows-install/)
- [Docker Compose Quickstart](https://docs.docker.com/compose/gettingstarted/)
