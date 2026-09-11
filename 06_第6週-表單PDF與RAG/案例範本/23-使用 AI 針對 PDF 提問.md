# 使用 AI 針對 PDF 提問

這份工作流能讓你透過 AI 深度讀取 PDF 文件內容，並以對話方式獲取解答。

## 核心目標

從 Google Drive 獲取 PDF 檔案，將其拆分為碎片後進行向量化，建立一個可以針對該文件內容進行問答的聊天介面。

## 工作流來源

[Ask questions about a PDF using AI.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/PDF_and_Document_Processing/Ask%20questions%20about%20a%20PDF%20using%20AI.json)

## 邏輯說明

1. **文件讀取**：從 Google Drive 下載指定的 PDF 檔案。
2. **文字分塊**：使用 Text Splitter 將長文本拆分成適度大小的區塊。
3. **嵌入與存儲**：透過 OpenAI Embeddings 將文字轉為向量，並存入向量資料庫。
4. **即時問答**：使用者輸入問題，AI 檢索相關區塊並結合上下文生成精確回答。

## 適用場景

客戶服務、知識管理，或需要快速從長篇報告中找尋特定資訊的人員。
