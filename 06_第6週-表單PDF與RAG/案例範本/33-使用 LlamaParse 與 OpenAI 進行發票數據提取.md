# 使用 LlamaParse 與 OpenAI 進行發票數據提取

這份工作流專注於對排版複雜的文件（如發票、合約）進行高精度的結構化數據提取。

## 核心目標

結合 LlamaParse 的先進文件解析能力與 OpenAI 的推理能力，自動從發票圖像或 PDF 中獲取完整的品項、金額與商家資訊。

## 工作流來源

[Invoice data extraction with LlamaParse and OpenAI.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/PDF_and_Document_Processing/Invoice%20data%20extraction%20with%20LlamaParse%20and%20OpenAI.json)

## 邏輯說明

1. **深度解析**：使用 LlamaParse 處理文件，它比一般 OCR 更能保留表格結構與複雜版面。
2. **結構化解析器**：利用 OpenAI 搭配結構化輸出解析器，確保每個金額、日期均能對應到正確的 JSON 格式。
3. **明細處理**：能逐行提取發票中的商品清單、單價與稅率。
4. **輸出錄入**：最終將精確的資料傳送至會計系統或資料夾。

## 適用場景

財務部門自動對帳、採購流程自動化、報帳 App 或是自動化報表處理。
