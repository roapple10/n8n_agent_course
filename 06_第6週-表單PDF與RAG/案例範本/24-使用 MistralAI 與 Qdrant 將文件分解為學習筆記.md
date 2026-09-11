# 使用 MistralAI 與 Qdrant 將文件分解為學習筆記

這份工作流能自動將繁雜的 PDF 文件轉化為結構化的學習筆記。

## 核心目標

監控新文件上傳，自動將內容處理為易於吸收的學習筆記格式，並存入向量資料庫以供後續檢索。

## 工作流來源

[Breakdown Documents into Study Notes using Templating MistralAI and Qdrant.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/PDF_and_Document_Processing/Breakdown%20Documents%20into%20Study%20Notes%20using%20Templating%20MistralAI%20and%20Qdrant.json)

## 邏輯說明

1. **觸發監控**：當有新文件加入時啟動工作流。
2. **語義嵌入**：使用 MistralAI 的 Embedding 模型進行向量化。
3. **資料存儲**：將轉化後的資料存入 Qdrant 向量資料庫。
4. **筆記生成**：利用 AI 模板將長篇內容濃縮為重點明確的學習筆記。

## 適用場景

教育研究、學生整理課堂資料、或企業內部員工的專業知識學習。
