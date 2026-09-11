# 透過 OpenAI GPT-4 摘要 Google Sheets 表單回饋

這份工作流能自動分析 Google 表單收集到的意見回饋，快速生成情感分析與重點摘要。

## 核心目標

當大量表單回饋（Feedback）湧入 Google Sheets 時，利用 AI 自動進行語意分析，讓管理者數秒內看懂用戶心聲。

## 工作流來源

[Summarize Google Sheets form feedback via OpenAI_s GPT-4.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/Summarize%20Google%20Sheets%20form%20feedback%20via%20OpenAI_s%20GPT-4.json)

## 邏輯說明

1. **收集數據**：工作流監控 Google Sheets 中新增的表單回覆列。
2. **文本處理**：獲取長篇的文字回饋欄位。
3. **AI 分析**：要求 GPT-4 進行總結、歸納主要痛點並判斷情緒（正向/負向/中立）。
4. **結果同步**：將 AI 的摘要與情緒分析標籤寫回同一列的指定欄位。

## 適用場景

產品問卷收集、客服意見分析、活動滿意度調查後處理工作。
