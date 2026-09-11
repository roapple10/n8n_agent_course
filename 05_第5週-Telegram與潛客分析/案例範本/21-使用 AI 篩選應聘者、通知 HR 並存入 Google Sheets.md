# 使用 AI 篩選應聘者、通知 HR 並存入 Google Sheets

這份工作流能自動處理應徵者投遞的履歷，初步篩選後將合適的人選記錄在表格中。

## 核心目標

優化招募流程，自動完成履歷篩選、資料歸檔及 HR 通知，減少人工作業時間。

## 工作流來源

[Screen Applicants With AI, notify HR and save them in a Google Sheet.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/Screen%20Applicants%20With%20AI,%20notify%20HR%20and%20save%20them%20in%20a%20Google%20Sheet.json)

## 邏輯說明

1. **履歷接收**：獲取應聘者的履歷（可能是從 Gmail 附件或 Google Drive 載入）。
2. **AI 解析與篩選**：AI 模型（如 OpenAI）提取履歷中的關鍵技能，並將其與職位要求進行比對。
3. **合格決策**：如果應聘者符合要求，執行後續步驟。
4. **歸檔與通知**：
   - 將合格者的資訊存入 Google Sheets 招聘進度表。
   - 透過 Slack 或 Email 自動通知 HR 團隊有新的合適候選人。

## 適用場景

初創企業招募、HR 團隊處理大量應徵郵件或文件時的輔助工具。
