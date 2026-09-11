# Assistant 與 Sandbox 部署包

此資料夾集中第一週啟用 n8n Assistant、n8n Sandbox 與 SearXNG 所需的全部檔案。

請由 [n8n-Assistant與Sandbox部署教學.md](n8n-Assistant與Sandbox部署教學.md) 從頭操作，不要直接將 `.env` 提交到 Git。

| 檔案 | 用途 |
| --- | --- |
| `docker-compose.yml` | 啟動 n8n、Sandbox API、runner、憑證初始化與 SearXNG。 |
| `.env.example` | 私密環境變數欄位範本。複製為 `.env` 後再填入自己產生的值。 |
| `searxng-settings.yml` | SearXNG 搜尋服務設定。 |
| `n8n-Assistant與Sandbox部署教學.md` | 安裝、瀏覽器設定、驗證、截圖畫面核對與排錯。 |
| `n8n-AI-Assistant功能與應用情境.md` | Assistant 功能、JSON 草稿規則、課堂情境、示範提示詞與使用界線。 |

快速開始：

```bash
cd "01_第1週-n8n啟航與AI-Agent/Assistant與Sandbox部署"
cp .env.example .env
# 依教學填入四組不同的隨機密鑰後再執行：
docker compose config --quiet
docker compose up -d
```
