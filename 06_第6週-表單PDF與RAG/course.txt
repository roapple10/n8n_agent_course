# n8n Agent Automation Course

這是一套七週、42 小時的實作型 n8n 自動化課程。教材以「先讓流程跑通，再理解資料、憑證、錯誤與部署」為主線；每週均有上午與下午的可匯入 JSON 練習、API／憑證申請指南與官方範本延伸。

課程表見 [2026 n8n 課程表](2026_n8n_課程表.md)。

## 開始前

1. 下載教材：

   ```bash
   git clone https://github.com/roapple10/n8n_agent_course.git
   cd n8n_agent_course
   ```

2. 從 [第一週](01_第1週-n8n啟航與AI-Agent/) 開始，依序完成 Docker、n8n 與 GitHub／Git 的準備。
3. 每週先閱讀該週的 `API與憑證申請指南.md`，再匯入 `課堂練習/` 的 JSON。
4. 所有 API Key、OAuth Client Secret、credentials 匯出與 `.env` 均不得提交到自己的作業 repo。

## 課程地圖

| 週次 | 主題 | 上午練習 | 下午練習 |
|---|---|---|---|
| 01 | n8n 啟航、AI Agent、Docker 與 RAG 概念 | 資料流與表達式 | Agent 架構與部署檢查 |
| 02 | Gmail、JSON 與 OpenAI | JSON、Gmail、OpenAI 準備 | Gmail AI 自動標記 |
| 03 | Outlook、HTTP 與控制節點 | Outlook、HTTP、If／Switch／Loop | AI 草稿與市場新聞 |
| 04 | Google Drive 與 Google Sheets | Drive 摘要寫入 Sheets | Sheets 自然語言對話 |
| 05 | Telegram 與潛在客戶分析 | Telegram 與潛客評分 | 行程對話與 Sheets 客戶分析 |
| 06 | 表單、PDF、RAG 與引用來源 | 表單回饋與 PDF 問答 | PDF RAG 與引用來源 |
| 07 | 維運、錯誤處理與期末專題 | 錯誤處理與部署檢查 | 期末專題起始骨架 |

## 資料夾結構

```text
n8n/
├── 01_第1週-n8n啟航與AI-Agent/
│   ├── Docker與n8n課程教學.md
│   ├── GitHub與Git課程教學.md
│   ├── RAG-Agent基礎概念與練習.md
│   ├── docker-compose.yml
│   ├── API與憑證申請指南.md
│   └── 課堂練習/
├── 02_第2週-Gmail與OpenAI/
├── 03_第3週-Outlook與API整合/
├── 04_第4週-Google-Drive與Sheets/
├── 05_第5週-Telegram與潛客分析/
├── 06_第6週-表單PDF與RAG/
├── 07_第7週-維運與期末專題/
├── n8n AI Automation Workshop/
│   ├── Session_1/、Session_2/       # 投影片與講義
│   ├── n8n-skills/                  # 節點索引、模式與範本參考
│   └── n8n_template/                # 額外工作流與測試資料
└── 2026_n8n_課程表.md
```

每週資料夾的慣例如下：

- `課堂練習/`：按課表安排的 JSON；先匯入，再逐節點執行與查看 Input／Output。
- `API與憑證申請指南.md`：該週所需服務的端到端申請與 n8n credential 設定步驟。
- `官方範本延伸練習.md`：對應主題的 n8n Workflow Library 範本與改造建議。
- `案例範本/`：可作為課後延伸的真實情境案例；匯入前先檢查帳號權限、寫入動作與資料範圍。

## 第一週的建議順序

1. 閱讀 [Docker 與 n8n 課程教學](01_第1週-n8n啟航與AI-Agent/Docker與n8n課程教學.md)，以 `docker compose up -d` 啟動本機 n8n。
2. 建立本機 Owner 帳號，開啟 `http://localhost:5678`。
3. 匯入並執行：
   - `課堂練習/上午-n8n啟航與資料流.json`
   - `課堂練習/下午-AI-Agent與部署檢查.json`
4. 依 [RAG Agent 基礎概念與練習](01_第1週-n8n啟航與AI-Agent/RAG-Agent基礎概念與練習.md) 匯入官方範本衍生的 RAG 加練，先辨識資料入庫與檢索回答兩條資料流。
5. 閱讀 [GitHub 與 Git 課程教學](01_第1週-n8n啟航與AI-Agent/GitHub與Git課程教學.md)，建立自己的私人作業 repo 並提交作業。

第一週的 RAG 加練不必先設定 API Key；完成第二週的 OpenAI credential 後，再執行文件上傳與聊天問答。

## 每週作業交付

每週交付下列四項：

1. 匯出的 workflow JSON，不得包含 credentials。
2. 一次成功與一次失敗／修正後的 execution 截圖。
3. 測試輸入與預期輸出。
4. 三句反思：輸入是什麼、資料如何處理、輸出如何驗收。

任何寄信、寫入資料表、發佈訊息或刪除資料的節點，都必須先以測試帳號、測試資料或停用狀態驗證。

## 教材與範本來源

- [n8n 官方文件](https://docs.n8n.io/)
- [n8n Workflow Library](https://n8n.io/workflows/)
- [n8n Community](https://community.n8n.io/)
- [n8n AI Automation Workshop](https://github.com/roapple10/n8n-ai-automation-workshop)

官方範本與社群範本都可能需要更新節點版本、憑證與資料欄位。匯入後請先閱讀節點設定，勿直接啟用。

## 安全提醒

- 不要將 API Key、OAuth Secret、Token、`.env`、`.n8n`、credentials 匯出檔或真實個資推送到 GitHub。
- 不要使用 `docker compose down -v`，否則可能刪除本機 n8n 的 volume 與資料。
- 本機 `localhost` webhook 預設無法由外部服務呼叫；課堂先以 Manual Trigger 測試。
