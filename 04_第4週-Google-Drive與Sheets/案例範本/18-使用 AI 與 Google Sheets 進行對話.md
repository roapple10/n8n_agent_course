# 使用 AI 與 Google Sheets 進行對話

這份工作流讓你可以用自然語言直接「詢問」你的 Google Sheets 資料，不需撰寫複雜的 Excel 公式。

## 核心目標

建立一個對話式界面，讓使用者能透過 AI 輕鬆查詢、分析或加總 Google Sheets 中的數據。

## 工作流來源

[Chat with a Google Sheet using AI.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/Chat%20with%20a%20Google%20Sheet%20using%20AI.json)

## 邏輯說明

1. **資料連結**：AI Agent 具備讀取指定 Google Sheets 的權限。
2. **工具調用**：為 AI 配置 Google Sheets 工具，使其能執行搜尋（Search）、讀取列（Read Rows）或寫入（Append）等動作。
3. **自然語言處理**：AI 解析使用者的問題（如：「上個月總銷售額是多少？」），並決定呼叫哪個工具來獲取表格數據。
4. **回答與反饋**：AI 解析表格結果後，以口語或表格格式回覆使用者。

## 適用場景

不熟悉 Excel 公式的業務人員、需要快速從大型報表中抓取數據的管理者。
