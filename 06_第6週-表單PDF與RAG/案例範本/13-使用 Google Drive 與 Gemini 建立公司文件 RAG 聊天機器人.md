# 使用 Google Drive 與 Gemini 建立公司文件 RAG 聊天機器人

這份工作流利用 RAG（檢索增強生成）技術，讓 Google Gemini 模型能根據 Google Drive 中的公司私有文件進行精準回覆。

## 核心目標

建立一個整合 Google Drive 與 Gemini 的聊天機器人，實現對公司內部文件的即時檢索與問答，確保資訊回覆的準確性。

## 工作流來源

[RAG Chatbot for Company Documents using Google Drive and Gemini.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/RAG%20Chatbot%20for%20Company%20Documents%20using%20Google%20Drive%20and%20Gemini.json)

## 邏輯說明

1. **注入數據**：從 Google Drive 載入數據，並將文字內容進行「分塊」（Chunking）。
2. **向量化**：將分塊內容轉換為向量並存入向量資料庫（如 Pinecone 或 Memory Store）。
3. **查詢匹配**：當使用者提問時，Gemini 會先在資料庫中檢索最相關的文件片段。
4. **生成回答**：Gemini 結合檢索到的內容，生成具備語境背景的專業回答。

## 適用場景

建立高度客製化的企業客服機器人或內部員工導航系統。
