# 第 1 週：Docker 與 n8n 管理憑證

本週不必申請外部 API。先完成 Docker Desktop 與本機 n8n；不要把 API key 寫進 JSON、Code node 或截圖。

1. 安裝 Docker Desktop，建立並啟動課程的 n8n instance。
2. 以自己的帳號登入 n8n，至 **Credentials** 建立一筆名稱為 `課程-測試用` 的憑證作練習，不共享給其他同學。
3. 在 workflow 中使用 Manual Trigger 執行；確認 execution 只含測試資料。
4. 設定固定的 encryption key 與持久化 volume 後重啟，確認 workflow 和 credential 仍存在。

部署與 credential 管理請看 [n8n hosting documentation](https://docs.n8n.io/hosting/)；第 2 週才建立 OpenAI API key。
