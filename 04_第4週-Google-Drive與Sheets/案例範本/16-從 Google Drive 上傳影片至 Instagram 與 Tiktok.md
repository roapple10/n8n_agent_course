# 從 Google Drive 上傳影片至 Instagram 與 Tiktok

這份工作流能幫助你在 Google Drive 中準備好影片後，直接自動發布到多個社群媒體平台。

## 核心目標

簡化短影音創作者的發布流程，實現從儲存空間到社群平台的自動化同步。

## 工作流來源

[Upload to Instagram and Tiktok from Google Drive.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/Upload%20to%20Instagram%20and%20Tiktok%20from%20Google%20Drive.json)

## 邏輯說明

1. **獲取內容**：從 Google Drive 節點獲取影片檔案及相應的文案（可從檔名或關聯的文字檔讀取）。
2. **多平台分發**：
   - 使用 Instagram 節點的 `Upload Media` 功能上傳至 Reels。
   - 使用 TikTok 節點的上傳 API 進行發布。
3. **自動化發布**：設定好標籤與描述，完成一鍵或定時分發。

## 適用場景

短影音創作者、社群媒體經營者，需要同時管理多個帳號並節省手動上傳時間。
