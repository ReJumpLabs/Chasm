#!/bin/bash

# Banner REJUMP
echo "====================================================="
echo "                  Welcome to REJUMP                  "
echo "====================================================="

clear

echo "DIEN THONG TIN"
echo "---------------------------"
read -p "Chasm Scout: " SCOUTNAME
read -p "UID Scout: " SCOUTUID
read -p "API Webhook: " WEBHOOKAPI
read -p "API Groq: " GROQAPI

echo "Mengatur direktori Chasm..."
mkdir -p ~/chasm
cd ~/chasm

cat > .env <<EOF
PORT=3001
LOGGER_LEVEL=debug
ORCHESTRATOR_URL=https://orchestrator.chasm.net
SCOUT_NAME=$SCOUTNAME
SCOUT_UID=$SCOUTUID
WEBHOOK_API_KEY=$WEBHOOKAPI
WEBHOOK_URL=http://$(hostname -I | awk '{print $1}'):3001/
PROVIDERS=groq
MODEL=gemma2-9b-it
GROQ_API_KEY=$GROQAPI
OPENROUTER_API_KEY=
OPENAI_API_KEY=
EOF

echo "XONG CONFIG..."
docker pull chasmtech/chasm-scout:latest
docker run -d --restart=always --env-file ./.env -p 3001:3001 --name scout chasmtech/chasm-scout
echo "DA CHAY XONG..."

echo "CHAY LENH " cat ./chasm/.env  " ROI UPDATE VO SHEET DI ..."
