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

---

## 三、【最推薦】免重啟解決步驟

**不需要重啟 Docker 容器！** 只要將檔案放到 n8n 的預設合法目錄 `/home/node/.n8n-files`，並修改節點路徑即可。

### 步驟 1：將檔案複製到 n8n 允許的白名單目錄
在 Windows PowerShell 執行：
```powershell
docker cp "course.txt" n8n-course:/home/node/.n8n-files/course.txt
```

### 步驟 2：確保容器內檔案擁有者正確（選擇性但推薦）
透過 `docker cp` 複製進去的檔案預設擁有者可能是 `root`。為了避免執行身分權限問題，可執行一行指令將權限修正為 n8n 運行的使用者 `node`：
```powershell
docker exec -u 0 n8n-course chown -R node:node /home/node/.n8n-files
```

### 步驟 3：修改 n8n 節點設定
1. 開啟 n8n 畫布，點開 **`Read/Write Files from Disk`** 節點。
2. 將 **File Selector**（或 **File Path**）修改為：
   ```text
   /home/node/.n8n-files/course.txt
   ```
3. 點擊 **「Test step」**。

👉 **立即執行成功！完全不影響正在運行的 n8n，無須重新啟動容器。**

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
    container_name: n8n-course
    restart: unless-stopped
    ports:
      - "127.0.0.1:5678:5678"
    environment:
      - TZ=Asia/Taipei
      - GENERIC_TIMEZONE=Asia/Taipei
      # ... 其他既有環境變數 ...
    volumes:
      - n8n_data:/home/node/.n8n
      # 👇 新增這一行：將專案的 files 目錄掛載到容器的允許路徑
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
* 再也不需要手動下 `docker cp`，重開機也不會遺失檔案！

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
| **節點路徑格式** | `C:\Users\User\...\course.txt` | `/home/node/.n8n-files/course.txt` | n8n 跑在 Linux 容器內，不能直接填寫 Windows 本機路徑。 |
| **預設允許路徑** | `/tmp/course.txt` | `/home/node/.n8n-files/course.txt` | 預設只有 `/home/node/.n8n-files` 在白名單內。 |
| **容器內檔案檢查** | 猜測檔案有沒有進去 | `docker exec n8n-course ls -la /home/node/.n8n-files` | 用此指令確認檔案是否存在於容器內。 |
| **檔案權限** | `root` 獨佔無讀取權限 | `docker exec -u 0 n8n-course chown -R node:node /home/node/.n8n-files` | 確保執行 n8n 的 `node` 帳號有讀取權限。 |

