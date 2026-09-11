# 從履歷提取數據並使用 Gotenberg 建立 PDF

這份工作流能將雜亂的履歷資訊標準化，並產生公司統一格式的人才檔案。

## 核心目標

從應聘者的非結構化履歷中提取關鍵數據，轉換為 HTML 模板，最後生成專業的 PDF 文件。

## 工作流來源

[Extract data from resume and create PDF with Gotenberg.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/PDF_and_Document_Processing/Extract%20data%20from%20resume%20and%20create%20PDF%20with%20Gotenberg.json)

## 邏輯說明

1. **結構化提取**：使用 AI 識別履歷中的姓名、技能、工作經驗及學歷。
2. **HTML 模板填入**：將提取出的內容動態填入預設的 HTML 佈局代碼中。
3. **PDF 生成**：調用 Gotenberg 服務（高效的 PDF 工具）將 HTML 轉換為視覺統一的 PDF 報告。
4. **自動傳送**：將生成的統一格式 PDF 存回資料夾或發信給招聘主管。

## 適用場景

建立企業內部人才資料庫、或是外包服務商需要為客戶提供統一格式的候選人簡報。
