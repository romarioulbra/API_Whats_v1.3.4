#!/bin/sh
echo '🔄 Configurando Ngrok...'
ngrok config add-authtoken ${NGROK_AUTHTOKEN}

echo '⏳ Aguardando API ficar disponível...'
for i in $(seq 1 60); do
  if nc -z api 8084; then
    echo "✅ API disponível!"
    break
  fi
  echo "⏳ Tentando conectar... ($i/60)"
  sleep 3
done

echo '🚀 Iniciando túnel Ngrok...'
ngrok http api:8084 --log=stdout > /tmp/ngrok.log &

# Aguarda o ngrok gerar a URL
sleep 10
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | grep -o 'https://[^"]*\.ngrok.io')
echo "✅ URL do Ngrok: $NGROK_URL"
echo $NGROK_URL > /tmp/ngrok-url.txt

tail -f /tmp/ngrok.log
