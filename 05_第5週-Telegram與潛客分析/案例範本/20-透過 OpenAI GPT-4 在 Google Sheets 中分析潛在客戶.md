# 透過 OpenAI GPT-4 在 Google Sheets 中分析潛在客戶

這份工作流能自動分析 Google Sheets 中的潛在客戶（Leads）資料，給出品質評分或開發建議。

## 核心目標

利用 AI 為你的銷售名單進行自動化「資格鑑定」（Qualification），過濾掉低價值的內容，集中精力於潛在客戶。

## 工作流來源

[Qualify new leads in Google Sheets via OpenAI_s GPT-4.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/Qualify%20new%20leads%20in%20Google%20Sheets%20via%20OpenAI_s%20GPT-4.json)

## 邏輯說明

1. **獲取新 Lead**：觸發工作流讀取 Google Sheets 中剛加入的客戶資料。
2. **AI 評估**：將公司名稱、預算、需求等資訊傳給 GPT-4，並附上評分準則。
3. **產出結果**：AI 回傳評分、分析報告及建議採取的行動（如：立即聯繫、再觀察）。
4. **填回表格**：將 AI 的評分與與分析結果寫回 Google Sheets 對應的欄位，方便銷售團隊查看。

## 適用場景

行銷自動化流程、B2B 銷售團隊初步篩選客戶名單。
