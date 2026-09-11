# 第 7 週：n8n API、告警憑證與專題交付

1. 為專題另建測試 credential；不要沿用教師、同學或正式環境的 token。
2. 若專題要呼叫 n8n API，請至 n8n Settings 的 API 頁建立個人測試 API key，限制用途並記錄建立者與輪替日期。
3. 告警可沿用第 5 週 Telegram token；先將告警送到私人測試 chat，確認 Error Trigger 內容不包含 password、authorization header、完整個資或 API key。
4. 在部署前測試備份、還原、失敗重跑與 idempotency；需要水平擴展時才評估 queue mode／worker。
5. 以 n8n 的 [security audit](https://docs.n8n.io/hosting/securing/security-audit/) 產出檢查結果；修正未保護 webhook、未使用 credential 與高風險 node 後才交付。
6. 交作業前匯出不含 credentials 的 workflow JSON，並在 README 列出每項 API 的申請者、最小權限、成本與撤銷方式。
