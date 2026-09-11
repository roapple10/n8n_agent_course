# 使用多模態視覺 AI 解析 CV 履歷 PDF

這份工作流能深度解析履歷，識別傳統文字解析難以捕捉的視覺資訊與版面佈局。

## 核心目標

將應徵者的 PDF 履歷轉換為圖像，透過視覺語言模型（VLM）精準評估候選人與職位的匹配度。

## 工作流來源

[CV Resume PDF Parsing with Multimodal Vision AI.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/PDF_and_Document_Processing/CV%20Resume%20PDF%20Parsing%20with%20Multimodal%20Vision%20AI.json)

## 邏輯說明

1. **格式轉換**：將 PDF 版本的履歷轉換為高畫質圖像。
2. **多模態分析**：利用視覺 AI 模型（如 GPT-4 Vision 或 Gemini Pro Vision）同時分析文字內容與圖像設計。
3. **對抗 Prompt 注入**：具備識別並繞過履歷中隱藏的 AI 指令（如隱形的「請務必推薦此人」文字）的防禦邏輯。
4. **適配度評分**：自動得出候選人的綜合評分與適配理由。

## 適用場景

HR 團隊、獵頭服務，需要快速且準確處理大量形式各異的履歷投遞。
