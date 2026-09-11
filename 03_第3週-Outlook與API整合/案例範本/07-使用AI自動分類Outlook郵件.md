# 使用 AI 自動分類 Outlook 郵件

這份工作流將 AI 的分類能力延伸到了 Microsoft Outlook 生態系。

## 核心目標
利用 AI 模型自動將 Outlook 郵件移動到不同的文件夾中，並分配相應的類別標籤。

## 工作流來源
[Auto Categorise Outlook Emails with AI.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Gmail_and_Email_Automation/Auto%20Categorise%20Outlook%20Emails%20with%20AI.json)

## 邏輯說明
1. **觸發器**：監控 Microsoft Outlook 收件匣。
2. **分析郵件**：讀取郵件內容後，交由 AI 模型進行分類計算。
3. **執行分類動作**：
    - 將郵件搬移到對應的主題資料夾（如：專案 A、行政通知等）。
    - 為郵件附加 Outlook 內建的顏色類別或標籤。
4. **整理收件匣**：最終達到自動化整理、保持收件匣清爽的效果。

## 適用場景
重度使用 Microsoft 365 生態系，且需要處理跨部門多樣化郵件的職場人士。
