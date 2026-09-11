# 使用 OpenAI 與 Gmail API 進行基礎郵件標記

這是一個基礎且實用的郵件自動化方案，結合了強大的大語言模型與官方 Gmail API。

## 核心目標
利用 OpenAI 的分析能力，根據郵件的語境自動對新郵件進行標註，實現自動化的分類管理系統。

## 工作流來源
[Basic Automatic Gmail Email Labelling with OpenAI and Gmail API.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Gmail_and_Email_Automation/Basic%20Automatic%20Gmail%20Email%20Labelling%20with%20OpenAI%20and%20Gmail%20API.json)

## 邏輯說明
1. **Gmail 觸發**：當 Gmail 收到新郵件時啟動流程。
2. **OpenAI 分析**：將郵件的正文數據傳送給 OpenAI。系統會解析信件內容，判斷是屬於「緊急」、「工作相關」還是「垃圾訊息」。
3. **標籤處理**：
    - 若指定的標籤已存在，則直接套用。
    - 若標籤不存在，系統可選擇自動創建該標籤。
4. **結果反饋**：最終在 Gmail 介面中可以看到被正確分類的郵件。

## 適用場景
初次嘗試將 AI 引入郵件管理流程的個人或小團隊，建立基本的優先級管理機制。
