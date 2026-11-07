---
name: n8n-course-workflow-design
description: Design or review n8n workflows for this course when a learner needs node selection, compatible connections, a safe exercise progression, or a maintainable workflow pattern. Do not use for general infrastructure administration.
---

# n8n 課程工作流設計

先釐清觸發器、輸入契約、處理規則、輸出、失敗處理與驗收方式。由簡入繁：先使用內建節點與可重現的測試資料，再接憑證、外部 API 和 AI。

## 工作流品質要求

- 用明確且可讀的節點名稱；每個外部副作用（寫入、發送、刪除）要能在測試時停用或改接測試目標。
- 優先用表達式、Edit Fields、Filter、If、Switch、Merge 等節點；只有在專用節點不適合時才用 Code 或 HTTP Request。
- AI 工作流要定義輸出欄位與失敗處理，不把模型的自由文字直接當成寫入或發送指令。需要外部動作時加入人工覆核或明確的安全閘門。
- RAG 的教學必須拆成載入、切塊、嵌入、儲存、檢索、回答與評估；回答引用來源，低信心或無來源時拒答。
- JSON 範本不可包含任何密鑰、個資、正式 webhook 網址或已啟用的危險操作。

## 查找節點與模式

- 當需求是未知 API 或非內建整合，從 HTTP Request 開始，先用可重現的公開或測試 API 驗證輸入與認證。
- 當流程要跨多個可重用步驟，採用 Execute Sub-workflow，讓主工作流只負責編排。
- 當任務需要模型選擇工具或多輪狀態，才使用 AI Agent；一次性轉換、抽取、分類先使用 chain 或結構化輸出。
- 參考 [課程模式](references/course-patterns.md) 來選擇最小可行架構與驗收條件。
