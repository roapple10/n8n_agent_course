# GitHub 與 Git 課程教學

本課程只使用 GitHub 保存自己的作業與取得教材更新。學生不直接推送到講師的原始 repo。

## 1. 申請 GitHub 帳號與安裝 Git

1. 到 [GitHub](https://github.com/signup) 建立個人帳號並驗證 email。
2. 安裝 [Git](https://git-scm.com/downloads)。Windows 安裝後開啟 Git Bash 或 PowerShell；macOS 用 Terminal。
3. 首次設定自己的提交身分（email 請使用 GitHub 已驗證的 email）：

```bash
git config --global user.name "你的英文姓名或 GitHub 名稱"
git config --global user.email "你的GitHub驗證email@example.com"
git --version
```

## 2. 下載本課程教材

在自己想放教材的資料夾執行：

```bash
git clone https://github.com/roapple10/n8n_agent_course.git
cd n8n_agent_course
```

教材已放在獨立的公開 repo：[roapple10/n8n_agent_course](https://github.com/roapple10/n8n_agent_course)，因此不需要再使用 sparse clone。GitHub 對 `git clone` 與 `git pull` 的說明見 [Getting changes from a remote repository](https://docs.github.com/en/get-started/using-git/getting-changes-from-a-remote-repository)。

## 3. 取得講師教材更新

每次上課前，進入來源教材資料夾：

```bash
cd n8n_agent_course
git pull
```

若畫面顯示本機有修改，先將個人筆記／作業移到下一節的個人作業 repo；不要直接在來源教材資料夾修改後再 pull。

## 4. 建立自己的作業 repo 並首次 push

1. 在 GitHub 右上角選 **New repository**，名稱例如 `n8n-course-homework`，選 **Private**。建立空 repo 時不要勾選 README、`.gitignore` 或 license，避免第一次 push 產生合併衝突。官方畫面與選項見 [Creating a new repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository)。
2. 將教材中要改的 JSON 或筆記複製到一個新的 `n8n-course-homework` 資料夾；不要整個複製 credentials、execution data 或 `.n8n` 資料。
3. 進入自己的作業資料夾，執行下列指令，將 `GITHUB_USERNAME` 改成自己的帳號：

```bash
git init
git add .
git commit -m "建立 n8n 課程作業"
git branch -M main
git remote add origin https://github.com/GITHUB_USERNAME/n8n-course-homework.git
git push -u origin main
```

## 5. 每次完成作業的最小 Git 流程

```bash
git status
git add 課堂練習/你的檔案.json
git commit -m "完成第2週 Gmail 標記練習"
git push
```

`git push` 會將本機 commit 上傳到自己的 GitHub repo；[GitHub 的 push 文件](https://docs.github.com/en/get-started/using-git/pushing-commits-to-a-remote-repository)說明 `git push origin main` 的含義。

## 不要上傳的資料

- OpenAI、Telegram、Google、Microsoft、Pinecone API key 或 OAuth Client Secret。
- n8n credential 匯出、`.n8n` 資料夾、execution data、真實客戶／同學資料。
- 含 token 的 `.env`。若作業需要設定值，改交 `.env.example`，只保留欄位名稱。
