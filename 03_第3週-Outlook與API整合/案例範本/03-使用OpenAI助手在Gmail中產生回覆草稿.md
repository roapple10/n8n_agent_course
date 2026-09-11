# 使用 OpenAI 助手在 Gmail 中產生回覆草稿

這份工作流能幫助你大幅提升處理郵件的效率，讓 AI 為你先行構思回覆內容。

## 核心目標
當收到新郵件時，自動根據內容生成一份專業的回覆草稿並存入 Gmail 的草稿箱，讓用戶只需檢查並點擊發送。

## 工作流來源
[Compose reply draft in Gmail with OpenAI Assistant.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Gmail_and_Email_Automation/Compose%20reply%20draft%20in%20Gmail%20with%20OpenAI%20Assistant.json)

## 邏輯說明
1. **監控郵件**：節點會定期檢查 Gmail 中的新進郵件。
2. **內容提取**：提取對方的來信內容及發件人資訊。
3. **AI 生成**：使用 OpenAI Assistant 節點分析郵件語境，並根據預設的角色設定（如：專業秘書或客戶經理）編寫回覆草稿。
4. **創建草稿**：透過 Gmail 節點的 "Create Draft" 功能，將生成的文本寫入草稿箱。

## 適用場景
需要處理大量商務回覆的人士，或者是希望確保語氣專業得體的客服中心。
