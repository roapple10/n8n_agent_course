# 從 Google Sheets 撰寫與發布部落格文章

這份工作流讓你可以直接在 Google Sheets 中填寫內容，然後自動將其發布到 WordPress 或其他部落格平台。

## 核心目標

建立一個基於 Google Sheets 的內容管理系統（CMS），讓撰寫、排程與發布流程變得簡單且自動化。

## 工作流來源

[Author and Publish Blog Posts From Google Sheets.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/Author%20and%20Publish%20Blog%20Posts%20From%20Google%20Sheets.json)

## 邏輯說明

1. **讀取列資料**：從 Google Sheets 讀取狀態為「待發布」或已填寫完成的列。
2. **內容優化（選配）**：可串接 AI 節點來自動生成摘要、SEO 關鍵字或修正標點。
3. **發布至網站**：使用 WordPress 節點將標題、內文、分類等資訊推送至網站。
4. **狀態更新**：發布成功後，將 Google Sheets 該列的狀態更新為「已發布」。

## 適用場景

內容行銷團隊、SEO 專家，需要管理大量文章發布流程。
