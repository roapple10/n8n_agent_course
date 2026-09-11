# 文字處理的 ETL 管道

這份工作流展示了如何建立完整的數據「提取、轉換、加載」管道，用於處理多來源的文本資訊。

## 核心目標

從 Twitter/X 提取數據，進行情感分析與清洗，最終載入 MongoDB 與 PostgreSQL 向量資料庫，並向團隊發送警報。

## 工作流來源

[ETL pipeline for text processing.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/PDF_and_Document_Processing/ETL%20pipeline%20for%20text%20processing.json)

## 邏輯說明

1. **提取 (Extract)**：定時從 Twitter 抓取特定關鍵字的最新貼文。
2. **轉換 (Transform)**：
   - 使用 AI 進行情感分析（正向、負向）。
   - 數據格式修正與主體辨識。
3. **加載 (Load)**：
   - 將原始數據存入 PostgreSQL。
   - 將向量化後的內容存入向量資料庫。
4. **警報 (Alert)**：若偵測到極端負向評論，立即發送 Slack 訊息給公關部門。

## 適用場景

輿情監控、社群媒體動態追蹤、動態市場情報收集。
