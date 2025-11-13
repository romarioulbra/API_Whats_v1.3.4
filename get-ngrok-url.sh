#!/bin/bash
# get-ngrok-url.sh
sleep 10
NGROK_URL=$(curl -s http://codechat_ngrok:4040/api/tunnels | grep -o 'https://[^"]*\.ngrok.io')
if [ -n "$NGROK_URL" ]; then
  echo "✅ URL do Ngrok: $NGROK_URL"
  echo $NGROK_URL > ./ngrok-url.txt
else
  echo "❌ Não foi possível obter a URL do Ngrok"
fi