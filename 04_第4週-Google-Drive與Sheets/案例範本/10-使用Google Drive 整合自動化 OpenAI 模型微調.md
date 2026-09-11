# 使用 Google Drive 整合自動化 OpenAI 模型微調

這份工作流能幫助你自動化 OpenAI 模型的微調（Fine-tuning）流程，從資料獲取到啟動訓練一氣呵成。

## 核心目標

從 Google Drive 下載訓練用的 `.jsonl` 資料檔，自動上傳至 OpenAI 並啟動微調任務，大幅簡化手動操作流程。

## 工作流來源

[Automated End-to-End Fine-Tuning of OpenAI Models with Google Drive Integration.json](https://github.com/roapple10/awesome-n8n-templates/blob/main/Google_Drive_and_Google_Sheets/Automated%20End-to-End%20Fine-Tuning%20of%20OpenAI%20Models%20with%20Google%20Drive%20Integration.json)

## 邏輯說明

1. **資料獲取**：透過 Google Drive 節點下載指定的 `.jsonl` 訓練數據。
2. **上傳資料**：使用 OpenAI 節點將下載的檔案上傳至 OpenAI 存儲空間，並將用途設定為 `fine-tune`。
3. **啟動任務**：透過 HTTP Request 節點調用 OpenAI API (`/v1/fine_tuning/jobs`) 啟動模型微調。
4. **模型測試**：一旦訓練完成，可以在工作流中使用 AI Agent 加上微調後的模型 ID 進行測試。

## 適用場景

需要頻繁根據最新資料優化 AI 模型表現的開發者或企業。
