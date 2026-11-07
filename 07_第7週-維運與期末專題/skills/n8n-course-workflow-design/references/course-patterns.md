# 課程工作流模式

| 需求 | 最小模式 | 驗收方式 |
|---|---|---|
| API 資料取得 | Trigger → HTTP Request → Edit Fields | 保存一筆成功、一筆非 2xx 的結果 |
| 規則分流 | Trigger → If/Switch → 各分支輸出 | 每條分支有至少一筆測資 |
| 人工覆核 | 產生草稿 → Wait/核可 → 外部動作 | 拒絕時不會造成副作用 |
| AI 分類 | 測資 → Chat Model/Chain → Structured Output → If | 格式錯誤與低信心均被處理 |
| RAG | Loader → Splitter → Embeddings → Store → Retriever → Model → Evaluation | 每一回答可回溯來源，無來源拒答 |
| 可維運服務 | Trigger → 子工作流 → 結果/告警；另接 Error Trigger | 可識別 execution、錯誤與回復步驟 |

## 連接檢查

1. 先檢查前一節點輸出的 item 數與 JSON 欄位，再寫表達式。
2. 多輸入或多分支時，明確檢查 item linking；不要假設相同索引永遠代表同一筆資料。
3. AI 子節點的表達式解析可能與一般 root node 不同；以一筆與多筆資料各測一次。
4. 需要重跑時，對寫入操作加入唯一鍵、upsert 或 idempotency key。

## 版本與官方文件

課程以 n8n 官方文件為最高準則。每次升版前，要重新驗證節點名稱、參數與 export JSON；關鍵主題包括 Data Table、Evaluation、MCP Client/MCP Server Trigger、AI workflow builder、task runners、queue mode、execution data 與 error workflows。
