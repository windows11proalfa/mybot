#!/bin/bash

# --- KONFIGURASI GITHUB ---
TOKEN="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"
REPO="github.com/windows11proalfa/mybot.git"
BRANCH="master"
# Path folder bot lu sekarang sudah fix
FOLDER_PATH="/root/hitori"

# --- KONFIGURASI TELEGRAM ---
TELE_TOKEN="8335747370:AAG9O0f3R3KLOKKW7PQnT2DEhrS11vYFFVM"
CHAT_ID="5888076846"

# Pindah ke folder bot
cd $FOLDER_PATH || exit

# Pastikan git menganggap folder ini aman (penting untuk root)
git config --global --add safe.directory $FOLDER_PATH

# Set timezone untuk log
export TZ="Asia/Jakarta"
CURRENT_TIME=$(date +"%Y-%m-%d %H:%M:%S")

# Proses Git
git add .
git push --set-upstream origin master

git commit -m "Auto push: $CURRENT_TIME (WIB)"

# Eksekusi Push
PUSH_OUTPUT=$(git push https://$TOKEN@$REPO $BRANCH 2>&1)

if [ $? -eq 0 ]; then
    MESSAGE="✅ Push Berhasil (root)!%0A📅 Waktu: $CURRENT_TIME WIB%0A🚀 Folder: $FOLDER_PATH"
    curl -s -X POST "https://api.telegram.org/bot$TELE_TOKEN/sendMessage" \
         -d "chat_id=$CHAT_ID" \
         -d "text=$MESSAGE" \
         -d "parse_mode=Markdown" > /dev/null
else
    MESSAGE="❌ Push GAGAL (root)!%0A📅 Waktu: $CURRENT_TIME WIB%0A⚠️ Error: ${PUSH_OUTPUT:0:100}..."
    curl -s -X POST "https://api.telegram.org/bot$TELE_TOKEN/sendMessage" \
         -d "chat_id=$CHAT_ID" \
         -d "text=$MESSAGE" \
         -d "parse_mode=Markdown" > /dev/null
fi
