# 第 6 週：OpenAI、Pinecone 與 PDF RAG 憑證

1. 使用第 2 週 OpenAI project，另建立本週專用 key，例如 `n8n-course-w6-rag`；不要重用個人正式專案 key。
2. 至 [Pinecone](https://www.pinecone.io/) 建立測試專案與 index，選擇與 embedding 模型維度相符的設定；建立權限最小化的 API key。
3. n8n 建立 OpenAI 與 Pinecone credential，key 僅貼入 Credentials 頁面。
4. 先建立不含個資的三份測試 PDF，依序測試 loader、splitter、embeddings、vector store 與 retriever。
5. 問兩個文件內有答案的問題與兩個沒有答案的問題；後者必須拒答並回傳沒有足夠來源。
6. 成本控制：限制測試文件大小、chunk 數與執行次數；完成課堂後刪除測試 index 或旋轉 key。

RAG 節點架構請對照 n8n 的 [Advanced AI documentation](https://docs.n8n.io/advanced-ai/)。
