# 第 5 週：Telegram Bot Token 與 OpenAI

1. 在 Telegram 搜尋並開啟官方 [@BotFather](https://t.me/botfather)，輸入 `/newbot`，依序設定名稱與以 `bot` 結尾的 username。
2. BotFather 會回傳 token；官方 [Bot tutorial](https://core.telegram.org/bots/tutorial) 指出 token 可隨時撤銷，必須如密碼保存。
3. n8n：**Credentials > New > Telegram API**，貼入 token，儲存後新增 Telegram Trigger。
4. 先在私訊對 bot 按 Start 並傳送 `test`；執行 Trigger，確認只收到自己的 chat ID。群組測試時設定 allowed chat ID，未授權訊息直接結束。
5. 潛客評分沿用第 2 週 OpenAI credential；建立結構化輸出與分數門檻，低分或低信心不可自動通知客戶。
6. token 外洩時在 BotFather revoke，再更新 n8n credential。
