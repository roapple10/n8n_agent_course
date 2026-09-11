# Google Drive 到 Pinecone 的語境感知分塊 RAG 工作流

這份工作流專注於提升 RAG 的品質，透過語境感知（Context-Aware）的分塊策略，將高品質的索引數據從 Google Drive 載入 Pinecone。

## 核心目標

優化 RAG 流程中的數據處置環節，使 AI 檢索時能更準確地找到相關內容。

## 工作流來源

[RAG*Context-Aware Chunking * Google Drive to Pinecone via OpenRouter & Gemini.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/RAG_Context-Aware%20Chunking%20_%20Google%20Drive%20to%20Pinecone%20via%20OpenRouter%20&%20Gemini.json)

## 邏輯說明

1. **智能分塊**：不同於傳統的固定長度分塊，此流程會考慮文本的語義完整性。
2. **多模型協作**：使用 OpenRouter 介接不同的 LLM（如 Gemini 或 Llama 3）來進行語境總結或 Embedding。
3. **高效存儲**：將帶有豐富後設資料（Metadata）的向量存入 Pinecone，方便後續精確檢索。

## 適用場景

需要對超長文檔進行精細檢索的場景，如法律文件分析或技術手冊查詢。
