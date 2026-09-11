# 使用 ChatGPT 視覺功能分析可疑郵件內容

相較於純文本分析，本工作流引入了視覺識別技術來提高釣魚郵件的識別率。

## 核心目標
結合文本解析與視覺影像分析（ChatGPT Vision），偵測郵件中的視覺偽裝（如：伪裝成知名品牌的按鈕或圖示）以防範釣魚攻擊。

## 工作流來源
[Analyze Suspicious Email Contents with ChatGPT Vision.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Gmail_and_Email_Automation/Analyze%20Suspicious%20Email%20Contents%20with%20ChatGPT%20Vision.json)

## 邏輯說明
1. **影像擷取**：自動擷取郵件內容的畫面或附件中的圖形資訊。
2. **多模態分析**：將郵件的 Header 資訊、文本內容及擷取的影像同時發送給 ChatGPT Vision。
3. **特徵識別**：AI 會檢查影像中的網址鏈接與顯示文本是否不匹配，或是是否存在模仿官方網頁的視覺特徵。
4. **警示提醒**：一旦判定為高風險，系統會立即進行標記或發送通知。

## 適用場景
需要高密度過濾金融、支付類釣魚郵件的使用者。
