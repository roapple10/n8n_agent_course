#!/usr/bin/env bash
# Reads credentials from the project .env file (key = value format),
# then launches the n8n-mcp MCP server.

ENV_FILE="$(cd "$(dirname "$0")/.." && pwd)/.env"

if [ -f "$ENV_FILE" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
        # skip empty lines and comments
        [[ -z "$line" || "$line" == \#* ]] && continue
        # split on first '=' only
        key="${line%%=*}"
        val="${line#*=}"
        # strip whitespace
        key="${key//[[:space:]]/}"
        val="${val#"${val%%[![:space:]]*}"}"
        val="${val%"${val##*[![:space:]]}"}"
        case "$key" in
            n8n_api)  export N8N_API_KEY="$val" ;;
            ngrok)    export NGROK_AUTHTOKEN="$val" ;;
        esac
    done < "$ENV_FILE"
fi

export N8N_API_URL="http://localhost:5678"
export MCP_MODE="stdio"
export LOG_LEVEL="error"
export DISABLE_CONSOLE_OUTPUT="true"

exec npx n8n-mcp
