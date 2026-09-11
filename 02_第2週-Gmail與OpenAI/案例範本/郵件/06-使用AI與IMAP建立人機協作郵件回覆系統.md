# 使用 AI 與 IMAP 建立人機協作郵件回覆系統

這是一套實踐 "Human-in-the-Loop"（人機協作）理念的範例。

## 核心目標
建立一個並非完全自動、而是由 AI 輔助人工決策的郵件處理流程，確保回覆的準確性與專業度。

## 工作流來源
[A Very Simple "Human in the Loop" Email Response System Using AI and IMAP.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Gmail_and_Email_Automation/A%20Very%20Simple%20_Human%20in%20the%20Loop_%20Email%20Response%20System%20Using%20AI%20and%20IMAP.json)

## 邏輯說明
1. **IMAP 擷取**：透過標準 IMAP 協議（不僅限於 Gmail）獲取任意電子郵件。
2. **AI 摘要與擬稿**：AI 會先將長篇郵件進行重點摘要，並產出一份初步的回覆初稿。
3. **人工審核機制**：流程會暫停或將草稿存放在待審核區域，等待人類確認。
4. **發送執行**：待人類修改或確認後，再執行最終的郵件發送。

## 適用場景
對回覆質量要求極高、不能容許 AI 出現幻覺錯誤的商務洽談場景。
