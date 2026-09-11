# 第 2 週：Gmail OAuth 與 OpenAI API

## Gmail OAuth（端到端）

1. 到 [Google Cloud Console](https://console.cloud.google.com/) 建立專案。
2. 在 **APIs & Services > Library** 啟用 Gmail API；Google 官方 OAuth 指南說明，必須先啟用要使用的 API 才能選擇 scope：[OAuth 2.0 setup](https://support.google.com/googleapi/answer/6158849)。
3. 在 OAuth consent screen 填寫應用名稱與支援 email；課堂測試請把自己的 Gmail 加入 Test users。
4. 在 **Credentials > Create credentials > OAuth client ID** 建立 Web application；將 n8n credential 畫面顯示的 OAuth Redirect URL 原樣貼入 Authorized redirect URIs。
5. 複製 Client ID 和 Client Secret。n8n：**Credentials > New > Gmail OAuth2**，填入兩值後按 Sign in with Google。
6. 最小測試只用 Gmail node 的 Get Many，限制一封且以測試 label 篩選；確認讀取成功後才做 Add Label，絕不先用 Delete。

## OpenAI API key

1. 登入 [OpenAI Platform](https://platform.openai.com/)，建立或選取課程 project，依帳戶需求完成 billing 設定。
2. 在 project 的 API keys 建立新 key，命名 `n8n-course-w2`；只顯示一次，立刻存入 n8n credential。官方 [Project API keys](https://platform.openai.com/docs/api-reference/project-api-keys) 說明 project key 的管理方式。
3. n8n：**Credentials > New > OpenAI**，貼入 key 後測試一個低成本、非敏感的分類輸入。
4. key 外洩時立刻在 Platform revoke，再在 n8n 更新 credential；不要把 key 交作業或 commit 到 Git。
