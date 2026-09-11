# 建立整合 Google Drive 的 OpenAI 助手

這份工作流能讓你的 OpenAI 助手（Assistant）具備讀取 Google Drive 文件的能力。

## 核心目標

將 Google Drive 中的文件自動同步並掛載到 OpenAI Assistant，使其能基於你的專屬文件（如專案手冊、公司規定）回答問題。

## 工作流來源

[Build an OpenAI Assistant with Google Drive Integration.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/Build%20an%20OpenAI%20Assistant%20with%20Google%20Drive%20Integration.json)

## 邏輯說明

1. **文件獲取**：從 Google Drive 節點抓取最新的 PDF 或文件檔。
2. **上傳至 OpenAI**：透過 OpenAI 節點將檔案上傳至 OpenAI 的檔案系統。
3. **助手連結**：將上傳的檔案 ID 關接（Attach）到指定的 OpenAI Assistant。
4. **即時互動**：使用者可以透過聊天介面與該助手對話，助手會檢索 Drive 中的內容來回覆。

## 適用場景

建立企業內部的知識庫助理，或需要頻繁更新參考資料的 AI 專案。
