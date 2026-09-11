# 自動移除 Google Drive 中圖片的背景

這份工作流能幫助你自動處理存放在 Google Drive 中的圖片，快速移除背景並儲存處理後的結果。

## 核心目標

監控或手動觸發後，自動下載 Google Drive 圖片，透過第三方 API 移除背景，並將透明背景的 `.png` 檔存回指定資料夾。

## 工作流來源

[Automatic Background Removal for Images in Google Drive.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/Automatic%20Background%20Removal%20for%20Images%20in%20Google%20Drive.json)

## 邏輯說明

1. **設定參數**：定義輸出資料夾、背景顏色（如白色或透明）以及 API 金鑰。
2. **圖片處理**：透過 HTTP Request 節點調用 PhotoRoom API，將圖片二進位資料發送並獲取移除背景後的結果。
3. **自動存檔**：將處理好的圖片重新命名（如加上 `BG-Removed-` 前綴）並上傳回 Google Drive。

## 適用場景

電商賣家、社群小編或美編人員，需要大量且快速處理產品去背圖的需求。
