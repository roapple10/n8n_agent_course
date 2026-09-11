# 使用 ChatGPT 分析與分類可疑郵件內容

這是一套針對資安防護設計的自動化流程，用於識別潛在的威脅郵件。

## 核心目標
自動識別並分類可能存有風險、詐騙或惡意程式的可疑郵件。

## 工作流來源
[Analyze & Sort Suspicious Email Contents with ChatGPT.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Gmail_and_Email_Automation/Analyze%20&%20Sort%20Suspicious%20Email%20Contents%20with%20ChatGPT.json)

## 邏輯說明
1. **收集數據**：獲取新郵件的所有文本內容、主旨及發件人地址。
2. **安全分析**：將數據發送至 ChatGPT，模型會根據已知的釣魚手法、語氣模式和可疑特徵進行評分或分類。
3. **截圖輔助**（可選）：部分進階版本會生成網頁截圖以供人工二次核對。
4. **分類動作**：根據分析結果（如：安全、疑似釣魚、高度危險）將郵件移動到特定的文件匣或標記風險提醒。

## 適用場景
企業內部資訊安全部門（IT Support）或對系統安全有高度需求的個人用戶。
