# 第 4 週：Google Drive 與 Google Sheets OAuth

1. 使用第 2 週的 Google Cloud project，或另建 `n8n-course-w4` 專案。
2. 在 API Library 啟用 **Google Drive API** 與 **Google Sheets API**。
3. 在 OAuth consent screen 加入測試者；範圍只選本週需要的 Drive／Sheets scopes。Google 的 [OAuth 設定指引](https://support.google.com/googleapi/answer/6158849) 有 consent screen 與 scope 的官方畫面與流程。
4. 建立 Web OAuth client，將 n8n 顯示的 redirect URL 加入 Authorized redirect URIs。
5. n8n 建立 Google Drive OAuth2 和 Google Sheets OAuth2 credential（可使用同一 Client ID／Secret），各自按 Sign in 授權。
6. 建一份 `n8n-course-test` 試算表與一個測試 Drive 資料夾；只分享自己的帳號。
7. 最小測試：Drive List 一個檔案、Sheets Read 一列、Append 一列測試資料；確認後刪除測試列，不對正式資料夾執行批次操作。
