# n8n Docker 本地檔案讀寫教學：解決「Access to the file is not allowed」

本指南專為使用 Docker 運行 n8n 的學員撰寫，詳細說明在「Read/Write Files from Disk」節點中遭遇 **`Access to the file is not allowed`** 的底層原因，並提供從 `docker cp` 到**免重啟快速修復**與**長期 Volume 掛載**的完整實戰步驟。

---

## 一、問題現象與情境重現

在第 6 週 RAG 或檔案處理練習中，通常需要讀取本機文件（例如 `course.txt` 或 PDF）。常見的操作流程如下：

1. **在 Windows 終端機執行檔案複製到 Docker 容器**：
   ```powershell
   docker cp "course.txt" n8n-course:/tmp/course.txt
   ```
   > 終端機提示：`Successfully copied 5.09kB to n8n-course:/tmp/course.txt`

2. **在 n8n 的「Read/Write Files from Disk」節點中設定**：
   - **Operation**：Read
   - **File Path / File Selector**：`/tmp/course.txt`

3. **點擊「Test step」後報錯**：
   ```text
   Problem in node 'Read/Write Files from Disk'
   Access to the file is not allowed.
   ```

---

## 二、為什麼會報錯？底層原理剖析

這個錯誤**不是因為檔案不存在**，也**不是 Linux 系統層級的 chmod 權限問題**，而是 **n8n 內建的安全沙箱機制**：

### 1. n8n 的檔案存取白名單機制 (`N8N_RESTRICT_FILE_ACCESS_TO`)
為了防止在自託管環境中被惡意工作流程任意讀取主機敏感檔案（如 `/etc/passwd`、Docker Socket 或系統金鑰），n8n 預設限制了本機檔案節點能存取的目錄範圍：
* **預設安全白名單目錄**：**`/home/node/.n8n-files`**
* **不在白名單內的目錄**：例如 `/tmp`、`/root`、`/etc` 等，即使檔案存在且具有讀取權限，n8n 也會直接攔截並拋出 `Access to the file is not allowed`。

### 2. 為什麼放到 `/tmp` 不行？
雖然 Linux 的 `/tmp` 常被用作暫存資料夾，但在 n8n 的安全策略中，`/tmp` 預設是不允許被工作流程直接讀寫的。

### 3. 為什麼直接複製到 `.n8n-files` 會出現 `Could not find the file`？
全新啟動的 n8n 容器內預設**尚未建立** `/home/node/.n8n-files` 資料夾。如果直接執行 `docker cp` 指向不存在的目錄，Docker 會出現：
```text
Error response from daemon: Could not find the file /home/node/.n8n-files in container ...
```
因此必須**先建立資料夾，再執行複製**。

---

## 三、【最推薦】免重啟解決步驟（標準兩行指令）

> [!IMPORTANT]
> **⚠️ 核心前提：確認你的容器名稱 (Container Name)**
> 本教材範例容器名稱為 `n8n-course`。**每位同學的容器名稱可能不一樣**（例如可能叫 `n8n`、`06_6-pdfrag-n8n-1` 等）。
> 
> 請透過以下任一種方式確認你的真實容器名稱：
> 
> #### 🖥️ 方式 A：在 Docker Desktop 圖形介面查看（最直覺推薦）
> 1. 打開 Windows 桌面上的 **Docker Desktop** 應用程式。
> 2. 點擊左側選單的 **「Containers」**（方塊圖示）。
> 3. 在中間清單中尋找正在運行的容器（狀態為綠色圖示 `Running`）：
>    * 💡 **注意**：若是透過 docker-compose 啟動，容器會被收納在專案資料夾內（例如顯示為 `06_6-pdfrag`），**請點擊左側箭頭 展開**。
>    * 展開後，查看第一欄 **「Name」** 顯示的文字（例如 `n8n-course` 或 `n8n`）。
>    * 可以將滑鼠移上去點擊右側的 **複製圖示**，即可複製完整的容器名稱！
> 
> #### 💻 方式 B：在 PowerShell 終端機查看
> 在終端機輸入：
> ```powershell
> docker ps
> ```
> 觀察輸出結果最右側的 **`NAMES`** 欄位。
> 
> ⚠️ **請將後續所有指令中的 `<你的容器名稱>`（或 `n8n-course`）替換為你實際查到的名稱！**

---

### 標準解決流程：先建資料夾，再複製檔案

#### 步驟 1：先在容器內建立白名單資料夾
```powershell
docker exec -u node <你的容器名稱> mkdir -p /home/node/.n8n-files
```
*(範例：`docker exec -u node n8n-course mkdir -p /home/node/.n8n-files`)*

#### 步驟 2：再將本機檔案複製進白名單目錄
請在目前存放檔案的目錄下（例如 `06_第6週-表單PDF與RAG`）執行：
```powershell
docker cp .\course.txt <你的容器名稱>:/home/node/.n8n-files/course.txt
```
*(範例：`docker cp .\course.txt n8n-course:/home/node/.n8n-files/course.txt`)*

#### 步驟 3：確保容器內檔案擁有者正確（推薦補充）
避免複製進去的檔案權限受限，執行以下指令修正為 `node` 使用者權限：
```powershell
docker exec -u 0 <你的容器名稱> chown -R node:node /home/node/.n8n-files
```
*(範例：`docker exec -u 0 n8n-course chown -R node:node /home/node/.n8n-files`)*

#### 步驟 4：修改 n8n 節點設定並測試
1. 開啟 n8n 畫布，點開 **`Read/Write Files from Disk`** 節點。
2. 將 **File Selector**（或 **File Path**）修改為白名單絕對路徑：
   ```text
   /home/node/.n8n-files/course.txt
   ```
3. 點擊 **「Test step」**。

👉 **立即執行成功！完全不需要重啟 Docker 容器。**

---

## 四、【長期解法】透過 Docker Compose 掛載本地目錄（免每次 docker cp）

手動 `docker cp` 的缺點是：**一旦執行 `docker compose down` 重建容器，放入容器內的檔案就會遺失**。

建議在專案中透過目錄掛載（Volume Bind Mount），讓 Windows 本機資料夾與容器同步：

### 1. 修改 `docker-compose.yml`
在 `services.n8n.volumes` 底下加入本機資料夾映射：

```yaml
services:
  n8n:
    image: n8nio/n8n:latest
    container_name: n8n-course   # 👈 這裡可自訂固定容器名稱
    restart: unless-stopped
    ports:
      - "127.0.0.1:5678:5678"
    environment:
      - TZ=Asia/Taipei
      - GENERIC_TIMEZONE=Asia/Taipei
      # ... 其他既有環境變數 ...
    volumes:
      - n8n_data:/home/node/.n8n
      # 👇 新增這一行：將本機專案的 files 目錄掛載到容器的允許路徑
      - ./files:/home/node/.n8n-files

volumes:
  n8n_data:
```

### 2. 套用新設定（此時需重啟一次）
```powershell
# 建立本機 files 資料夾
mkdir files

# 重啟容器以套用 volume 設定
docker compose down
docker compose up -d
```

### 3. 未來使用方式
之後只要在 Windows 本機把 `course.txt` 丟進專案下的 `files/` 資料夾：
* 檔案會**自動同步**進容器的 `/home/node/.n8n-files/`。
* n8n 節點直接讀取 `/home/node/.n8n-files/course.txt`。
* 再也不需要手動下 `docker cp`，重開機或重新建立容器也不會遺失檔案！

---

## 五、【備用解法】放寬 n8n 路徑限制（需重啟 Docker）

如果你因特殊需求，一定要讀取 `/tmp` 或其他指定路徑，可以透過環境變數放寬限制：

### 方法 A：將 `/tmp` 加入白名單
編輯 `docker-compose.yml`，在 `environment:` 區塊加入：
```yaml
    environment:
      - N8N_RESTRICT_FILE_ACCESS_TO=/tmp;/home/node/.n8n-files
```

### 方法 B：完全解除路徑限制（僅限本地個人測試環境）
若設為空字串，n8n 就能存取容器內所有使用者 `node` 有權限的路徑：
```yaml
    environment:
      - N8N_RESTRICT_FILE_ACCESS_TO=""
```

修改完成後重啟容器套用：
```powershell
docker compose down
docker compose up -d
```

---

## 六、常見排查清單 (Checklist)

| 檢查項目 | 常見錯誤寫法 | 正確寫法 | 說明 |
| :--- | :--- | :--- | :--- |
| **容器名稱不符** | 盲目照抄 `n8n-course` | 開啟 Docker Desktop 查看「Name」欄位，或執行 `docker ps` | 每個同學的 container 名稱可能依 `docker-compose` 設定而異。 |
| **容器內尚未建目錄** | 直接 `docker cp` 報錯 `Could not find the file` | 先執行 `docker exec -u node <容器名> mkdir -p /home/node/.n8n-files` | 容器內需先有目錄才能複製檔案。 |
| **節點路徑格式** | `C:\Users\User\...\course.txt` | `/home/node/.n8n-files/course.txt` | n8n 跑在 Linux 容器內，不能直接填寫 Windows 本機路徑。 |
| **預設允許路徑** | `/tmp/course.txt` | `/home/node/.n8n-files/course.txt` | 預設只有 `/home/node/.n8n-files` 在安全白名單內。 |
| **容器內檔案檢查** | 猜測檔案有沒有進去 | `docker exec <容器名> ls -la /home/node/.n8n-files` | 用此指令確認檔案是否存在於容器內。 |
| **檔案權限** | `root` 獨佔無讀取權限 | `docker exec -u 0 <容器名> chown -R node:node /home/node/.n8n-files` | 確保執行 n8n 的 `node` 帳號有讀取權限。 |
