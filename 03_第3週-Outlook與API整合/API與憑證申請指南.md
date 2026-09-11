# 第 3 週：Microsoft Outlook／Graph OAuth 與 HTTP Request

1. 登入 [Microsoft Entra admin center](https://entra.microsoft.com/)，切換到課程測試 tenant。
2. 依 Microsoft 的 [app registration guide](https://learn.microsoft.com/en-us/graph/auth-register-app-v2)，進入 **App registrations > New registration**，建立 `n8n-course-w3`。
3. 在 Authentication 新增 Web redirect URI；值必須完全等於 n8n Outlook OAuth2 credential 顯示的 Redirect URL。
4. 在 **Certificates & secrets** 建立 client secret，立即複製 Value；之後不可再讀取。
5. 在 **API permissions** 新增最小 delegated Microsoft Graph mail 權限，例如讀取／建立草稿所需的權限；若 tenant 要求，請管理員 consent。
6. n8n 建立 Microsoft Outlook OAuth2 credential，填 Tenant ID、Client ID、Client Secret 並 Sign in；先建立 draft，禁止自動寄信。
7. HTTP Request 練習先呼叫公開測試 API；需要 API key 時，一律建立 credential，不在 Header 欄位硬寫 token。

Microsoft Graph 的認證概念與權限說明見 [Authentication and authorization](https://learn.microsoft.com/en-us/graph/auth/auth-concepts)，該頁也提供管理介面截圖。
