# 使用 Vertex AI (Gemini) 將 PDF 和圖像中的文字提取為 CSV

這份工作流能將各種媒體格式的非結構化數據，快速整合成結構化的表格。

## 核心目標

從 PDF 或圖片中自動提取特定欄位的文字資訊，並根據文件類型自動分類，最後彙整成 CSV 格式。

## 工作流來源

[Extract text from PDF and image using Vertex AI (Gemini) into CSV.json](<https://github.com/roapple10/awesome-n8n-templates/blob/main/PDF_and_Document_Processing/Extract%20text%20from%20PDF%20and%20image%20using%20Vertex%20AI%20(Gemini)%20into%20CSV.json>)

## 邏輯說明

1. **媒體準備**：收集各種來源的 PDF 或是照片檔。
2. **條件分發**：根據副檔名自動判斷處理路徑。
3. **Google Vertex AI 處理**：利用 Gemini 模型強大的多模態文字提取技術獲取內容。
4. **CSV 轉換**：將提取出的數據對應到標題列，轉換為 CSV 格式檔案，方便在 Excel 中開啟。

## 適用場景

處理紙本掃描收據、多頁 PDF 報告轉為分析表格、數據採集與清洗工作。
