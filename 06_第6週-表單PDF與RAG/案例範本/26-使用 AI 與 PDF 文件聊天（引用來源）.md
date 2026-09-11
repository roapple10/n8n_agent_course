# 使用 AI 與 PDF 文件聊天（引用來源）

這份工作流能在回答問題的同時，精確指出答案來源於 PDF 的哪個章節。

## 核心目標

建立一個具備「引用機制」的 PDF 聊天機器人，增加回答的透明度與可信度。

## 工作流來源

[Chat with PDF docs using AI (quoting sources).json](<https://github.com/roapple10/awesome-n8n-templates/blob/main/PDF_and_Document_Processing/Chat%20with%20PDF%20docs%20using%20AI%20(quoting%20sources).json>)

## 邏輯說明

1. **互動介面**：開啟聊天視窗供使用者輸入。
2. **語境檢索**：AI 從向量化的 PDF 資料中找到最相關的片段。
3. **帶引用回覆**：AI 生成答案時，會標註出處（例如：根據第三頁第二段所述），讓使用者可以回頭檢核。
4. **來源展示**：連帶顯示被引用的原文內容。

## 適用場景

學術研究、法律條文查詢、官方政策解讀，對答案準確性要求極高的場景。
