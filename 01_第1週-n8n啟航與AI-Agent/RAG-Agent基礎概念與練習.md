# 第一週加練：RAG Agent 基礎概念與練習

本加練用官方 n8n Template 5010 的結構，讓學生在第一週先看懂 RAG Agent 的工作方式。目標是認識架構與資料流；完整 API 設定與正式文件問答會在第六週深入實作。

## 先用一句話理解 RAG

RAG（Retrieval-Augmented Generation）是讓模型先從指定知識庫找出相關內容，再根據那些內容回答問題。它不是重新訓練模型，也不保證答案永遠正確；它的價值是讓回答能依據可更新的資料，而不是只依賴模型既有知識。

## RAG 與 AI Agent 的差異

- **RAG** 是資料取得與補充上下文的方法：找資料、把資料交給模型。
- **AI Agent** 是工作流中的決策者：收到問題後，決定是否及如何使用工具。
- **RAG Agent** 是 Agent 使用「查詢知識庫」工具來回答問題的組合。

## 這份官方範本的兩條資料流

```text
資料入庫：上傳檔案 → Data Loader → Embeddings → Simple Vector Store
提問回答：Chat Trigger → AI Agent → 查詢知識庫工具 → Chat Model
```

1. **資料入庫**：將 PDF 或 CSV 讀成文字，轉為 embedding，再放入向量庫。
2. **檢索**：把使用者問題也轉為 embedding，找出語意最接近的內容片段。
3. **生成**：AI Agent 把問題與找回的內容交給 Chat Model，產生回答。

寫入與查詢一定要使用相同的 embedding 模型與設定；否則兩邊的向量無法可靠比較。

## 匯入官方範本

匯入檔案：[課堂練習/加練-官方RAG-Agent基礎概念-5010.json](課堂練習/加練-官方RAG-Agent基礎概念-5010.json)。此檔案以 n8n Team 維護的 [RAG Starter Template 5010](https://n8n.io/workflows/5010-rag-starter-template-using-simple-vector-stores-form-trigger-and-openai/) 為來源，已中文化節點名稱並移除上游 instance metadata。

1. 在 n8n 選 **More actions** → **Import** → **From file**。
2. 匯入 JSON 後，不要先啟用 workflow。
3. 在畫布上用不同顏色圈出「資料入庫」與「檢索回答」兩個區域。
4. 說明 `查詢知識庫工具` 為何連到 AI Agent 的 **Tool** 端，而不是一般 main 資料線。

## 基礎實作任務

### 必做：架構閱讀，不需 API key

完成下列問題並在課堂上口頭說明：

1. 哪個節點負責把檔案內容交給向量庫？
2. 哪個節點負責產生 embedding？
3. 哪個節點讓 Agent 能查知識庫？
4. 為什麼不能直接把整份長 PDF 放進每次的 prompt？
5. 若知識庫沒有答案，Agent 應如何回覆才安全？

### 延伸：可執行的最小 RAG，需 OpenAI credential

完成第二週的 OpenAI API 設定後，再執行此段：

1. 在 **Embeddings OpenAI** 與 **OpenAI Chat Model** 選擇自己的 OpenAI credential。
2. 按 **Execute Workflow**，在表單上傳一份不含個資的 PDF 或 CSV。
3. 開啟 Chat，問一個答案只存在於該檔案中的問題。
4. 再問一個檔案沒有答案的問題，記錄 Agent 是否承認不知道。

Simple Vector Store 只適合概念驗證；它不應作為 production 知識庫。第六週會比較可持久化的向量資料庫、文件切分、來源引用與評估。

## 驗收與反思

- 截圖標註兩條資料流與 AI Tool 連線。
- 寫出一題「可由文件回答」與一題「文件無法回答」的問題。
- 用三句話說明：資料來源是什麼、Agent 查了什麼、為什麼回答可信或不可信。

## 延伸閱讀

- [n8n 官方 RAG Starter Template](https://n8n.io/workflows/5010-rag-starter-template-using-simple-vector-stores-form-trigger-and-openai/)
- [n8n 官方 RAG pipeline guide](https://blog.n8n.io/rag-pipeline/)
- [n8n RAG 文件](https://docs.n8n.io/advanced-ai/rag-in-n8n/)
