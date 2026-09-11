Always verify claims with web search before presenting as fact.

For n8n-related questions (node configuration, workflow design, troubleshooting), always consult the local skill pack first:
`.claude/skills/n8n-skills/resources/` — contains node references, workflow patterns, compatibility matrix, and templates.

---

## n8n Workflow JSON Generation Rules (MANDATORY)

These rules are derived from actual bugs encountered. Follow strictly when generating n8n workflow JSON:

### 1. Never use `\u` prefix before emoji in JSON strings
- **Wrong**: `"text": "=\u🎨 Generating..."` → causes `Bad Unicode escape in JSON`
- **Correct**: `"text": "=🎨 Generating..."` → write UTF-8 emoji directly
- **Rule**: Always embed emojis as raw UTF-8 characters, never as unicode escape sequences

### 2. Workflow JSON must include a top-level `"id"` field
- **Wrong**: omitting `id` → import fails with `SQLITE_CONSTRAINT: NOT NULL constraint failed: workflow_entity.id`
- **Correct**: top-level object must contain `"id": "unique_numeric_string"`
- **Rule**: use non-conflicting numeric IDs for new workflows (e.g. `"200"`, `"201"`, incrementing)

### 3. Never use placeholder credential IDs
- **Wrong**: `"id": "credential-id"` → causes `Credential with ID "credential-id" does not exist` at runtime
- **Correct**: use real credential IDs, or omit the `credentials` block entirely so users configure manually
- **Rule**: if the user's credential ID is unknown, set both `id` and `name` to empty strings — the user will re-select in the UI after import

### 4. Switch node `value2` must not have `=` prefix
- **Wrong**: `"value2": "=/image "` → never matches (user input never starts with `=`)
- **Correct**: `"value2": "/image "`
- **Rule**: `value2` in Switch rules is a plain comparison string, NOT an n8n expression — never prefix with `=`

### 5. New OpenAI image nodes return binary data, not URLs
- **Wrong approach 1**: Send image node uses `"file": "={{ $json.url }}"` (legacy DALL-E returned a URL, new nodes do not)
- **Wrong approach 2**: `"file": "={{ $binary.data.id }}"` — this passes n8n's internal filesystem path (e.g. `filesystem-v2:workflows/177/...`) as if it were a Telegram file ID, which Telegram cannot recognize → causes `wrong remote file identifier specified: Wrong character in the string`
- **Correct**: use Telegram node's built-in binary upload mode:
  ```json
  "binaryData": true,
  "binaryPropertyName": "data"
  ```
  This sends the image as a multipart file upload directly to the Telegram API.
- **Rule**: `@n8n/n8n-nodes-langchain.openAi` typeVersion 2.x image resource returns binary data; Telegram sendPhoto MUST use `binaryData: true` + `binaryPropertyName` — never put binary IDs or internal paths in the `file` field

### 6. ngrok free dev domain format
- **Correct**: `xxx.ngrok-free.dev` (ends with `.dev`)
- **Wrong**: `xxx.ngrok-free.app` (outdated format)

### 7. Docker container name conflicts
- If `docker run` is used without `--rm`, the container persists after stop
- Must run `docker rm n8n` before restarting, otherwise: `name "/n8n" is already in use`
- **Rule**: teaching docs use `-it --rm` (foreground + auto-remove); scripts using `-d` (detached) must clean up manually