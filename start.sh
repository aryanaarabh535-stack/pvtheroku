#!/bin/bash
set -e
cd "$(dirname "$0")"
mkdir -p "${DATA_DIR:-accstore_data}"

# Heroku / container: bind PORT and run foreground
if [ -n "$PORT" ] || [ -n "$DYNO" ]; then
  echo "Starting on Heroku/dyno (PORT=${PORT:-8080})..."
  exec python main.py
fi

# Local / VPS with screen (original behaviour preserved)
if command -v screen >/dev/null 2>&1; then
  pkill -f "python.*main\.py" 2>/dev/null || true
  screen -X -S session_manager quit 2>/dev/null || true
  sleep 1
  echo "Starting Private Session Manager in screen session..."
  screen -dmS session_manager bash -c 'while true; do python main.py 2>&1 | tee -a "${DATA_DIR:-accstore_data}/bot.log"; echo "exited — restart in 3s"; sleep 3; done'
  sleep 2
  echo "Running in screen: session_manager"
  echo "Logs: tail -f ${DATA_DIR:-accstore_data}/bot.log"
  echo "Attach: screen -r session_manager"
  exit 0
fi

exec python main.py
