# 使用 AI 節點自動標記 Gmail 郵件

這份工作流範本旨在展示如何利用 AI 能力來優化 Gmail 郵件管理。

## 核心目標
自動為進入 Gmail 的新郵件添加標籤。透過 AI 讀取郵件內容並判斷其類別（例如：合作洽談、一般詢問等），省去手動分類的時間。

## 工作流來源
[Auto-label incoming Gmail messages with AI nodes.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Gmail_and_Email_Automation/Auto-label%20incoming%20Gmail%20messages%20with%20AI%20nodes.json)

## 邏輯說明
1. **觸發器**：監控 Gmail 收件匣中的新郵件。
2. **獲取內容**：提取郵件的主旨與內文全文。
3. **AI 判斷**：將郵件內容發送至 AI 節點。提示詞（Prompt）會要求 AI 根據預設的標籤列表進行分類。
4. **執行標記**：根據 AI 返回的分類結果，使用 Gmail 節點為該郵件添加對應的標籤。

## 適用場景
適用於每日接收大量非結構化郵件的用戶，幫助快速篩選重要資訊。
