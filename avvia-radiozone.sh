#!/bin/bash
echo ""
echo " ============================================="
echo "  RadioZone - Server Locale"
echo " ============================================="
echo ""

PORT=8765
DIR="$(cd "$(dirname "$0")" && pwd)"

# Avvia server Python in background
cd "$DIR"
python3 -m http.server $PORT --bind 127.0.0.1 &
SERVER_PID=$!
echo " [OK] Server avviato su http://localhost:$PORT (PID: $SERVER_PID)"
sleep 1

URL="http://localhost:$PORT/radio-zone-splitter.html"

# Apri browser
if command -v google-chrome &>/dev/null; then
    google-chrome "$URL" &
elif command -v chromium-browser &>/dev/null; then
    chromium-browser "$URL" &
elif command -v chromium &>/dev/null; then
    chromium "$URL" &
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS - prova Chrome prima
    open -a "Google Chrome" "$URL" 2>/dev/null || open "$URL"
else
    xdg-open "$URL" 2>/dev/null || echo " Apri manualmente: $URL"
fi

echo " [OK] Browser aperto su $URL"
echo ""
echo " Premi CTRL+C per fermare il server"
echo ""

# Aspetta CTRL+C
trap "kill $SERVER_PID 2>/dev/null; echo ' Server fermato.'; exit" INT
wait $SERVER_PID
