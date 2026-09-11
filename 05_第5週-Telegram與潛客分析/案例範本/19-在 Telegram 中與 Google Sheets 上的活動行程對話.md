# 在 Telegram 中與 Google Sheets 上的活動行程對話

這份工作流能將你的 Google Sheets 行程表變成一個可對話的 Telegram 機器人，隨時隨地查詢你的 Schedule。

## 核心目標

實現移動端的活動查詢，讓使用者能透過 Telegram 機器人即時獲取 Google Sheets 中的活動詳情。

## 工作流來源

[Chat with your event schedule from Google Sheets in Telegram.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/Chat%20with%20your%20event%20schedule%20from%20Google%20Sheets%20in%20Telegram.json)

## 邏輯說明

1. **Telegram 介面**：監聽 Telegram 傳入的消息。
2. **AI 路由**：使用 AI Agent 判斷使用者的意圖（如：查詢具體日期的活動）。
3. **表格檢索**：AI 調用 Google Sheets 讀取工具，搜尋符合條件的活動列。
4. **訊息回傳**：將查找到的行程時間、內容以格式化的訊息傳回 Telegram。

## 適用場景

活動主辦方為參加者提供行程諮詢、或個人管理繁忙的會議安排。
