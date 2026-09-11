# 將 URL HTML 轉換為 Markdown 格式並獲取頁面連結

這份工作流是網頁爬蟲與資料清理的利器，能將混亂的網頁轉為乾淨的 Markdown。

## 核心目標

抓取特定網址的 HTML 內容，去除廣告與雜項，轉化為易於閱讀且適合 AI 處理的 Markdown，並列出頁面中的所有連結。

## 工作流來源

[Convert URL HTML to Markdown Format and Get Page Links.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/PDF_and_Document_Processing/Convert%20URL%20HTML%20to%20Markdown%20Format%20and%20Get%20Page%20Links.json)

## 邏輯說明

1. **網頁抓取**：使用 HTTP Request 或 Browser 節點獲取原始 HTML。
2. **格式清理**：利用內容提取工具過濾掉非正文元素。
3. **Markdown 轉換**：將過濾後的結果轉為標準 Markdown 語法。
4. **連結提取**：額外解析所有 `<a>` 標籤，提供結構化的頁面內外連結清單。

## 適用場景

內容農場搬運、SEO 競品分析、自動化網頁內容摘要、構建 AI 訓練數據集。
