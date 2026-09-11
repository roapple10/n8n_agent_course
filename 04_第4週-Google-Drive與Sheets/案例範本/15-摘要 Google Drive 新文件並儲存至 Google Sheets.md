# 摘要 Google Drive 新文件並儲存至 Google Sheets

這份工作流能自動追蹤 Google Drive 中的新檔案，生成內容摘要後同步記錄到表格中。

## 核心目標

實現自動化文件審閱與歸檔，讓團隊不需點開檔案就能快速了解 Google Drive 內新文件的核心內容。

## 工作流來源

[Summarize the New Documents from Google Drive and Save Summary in Google Sheet.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/Summarize%20the%20New%20Documents%20from%20Google%20Drive%20and%20Save%20Summary%20in%20Google%20Sheet.json)

## 邏輯說明

1. **觸發監控**：定期檢查 Google Drive 資料夾是否有新檔案加入。
2. **文本提取**：如果是 PDF 或 Word 檔，自動讀取並提取其中的文字內容。
3. **AI 夏模**：將文字傳送給 AI 模型（如 OpenAI 或 Gemini）進行摘要生成。
4. **記錄表格**：將檔名、連結、摘要及處理日期寫入 Google Sheets 對應的欄位。

## 適用場景

項目管理、研究報告收集、或任何需要快速總結大量傳入文檔的流程。
