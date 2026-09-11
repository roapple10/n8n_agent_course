# 整合 Monday 與 Airtable 的 Outlook AI 郵件助手

這是一個與企業現有管理系統高度連動的高階自動化方案。

## 核心目標
建立一個結合了聯絡人數據（Airtable/Monday.com）的高級郵件助手，讓郵件處理不僅是文字分析，還能參考外部的業務背景。

## 工作流來源
[Microsoft Outlook AI Email Assistant with contact support from Monday and Airtable.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Gmail_and_Email_Automation/Microsoft%20Outlook%20AI%20Email%20Assistant%20with%20contact%20support%20from%20Monday%20and%20Airtable.json)

## 邏輯說明
1. **讀取郵件**：獲取 Outlook 的新信件。
2. **外部查詢**：
    - 從 Airtable 中比對發件人的身份與級別。
    - 從 Monday.com 中調取與該客戶相關的最新專案狀態。
3. **AI 智慧處理**：結合前述的聯絡人歷史與業務數據，讓 AI 生成更有針對性的總結或回覆建議。
4. **管理更新**：同步更新 Monday.com 的通訊記錄。

## 適用場景
企業內部的客戶服務（CS）或客戶關係管理（CRM）流程，实现真正的系統自動化。
