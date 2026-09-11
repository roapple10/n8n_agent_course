# 使用 Claude 與 Gemini 直接從 PDF 提取與處理資訊

這份工作流整合了頂尖的 AI 模型，能以極高的對話品質處理大型 PDF 文檔。

## 核心目標

利用 Claude 的大上下文處理能力與 Gemini 的推理能力，直接處理並提取 PDF 內的複雜數據與資訊。

## 工作流來源

[Extract and process information directly from PDF using Claude and Gemini.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/PDF_and_Document_Processing/Extract%20and%20process%20information%20directly%20from%20PDF%20using%20Claude%20and%20Gemini.json)

## 邏輯說明

1. **智能路由**：根據文件大小或複雜度，路由至不同的 AI 節點（如 Claude-3.5 或 Gemini 1.5 Pro）。
2. **深度提取**：提取表格、標題、摘要及結構化欄位。
3. **交叉比對**：可用兩組模型同時處理同一份文件，確保提取出的關鍵數據的一致性。
4. **輸出處理**：轉換為 JSON 或 Markdown 供其他應用程式使用。

## 適用場景

處理幾百頁的技術白皮書、財務季報、或需要精確提取欄位的內部文檔。
