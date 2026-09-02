#!/bin/bash

# --- Настройки ---
SOURCE_DIR="/root/linux-lab"               # Что бэкапим
BACKUP_DIR="/root/backups"                 # Куда сохраняем
DATE=$(date +%Y-%m-%d_%H-%M-%S)            # Дата и время
MAX_BACKUPS=5                              # Хранить только 5 последних
BACKUP_FILE="backup_${DATE}.tar.gz"        # Имя архива

# --- Создаём папку для бэкапов, если её нет ---
mkdir -p "$BACKUP_DIR"

# --- Архивация ---
echo "Creating backup: $BACKUP_FILE"
tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$SOURCE_DIR" . 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Backup created successfully: $BACKUP_DIR/$BACKUP_FILE"
else
    echo "❌ Backup failed!"
    exit 1
fi

# --- Ротация: удаляем старые бэкапы, оставляя только последние $MAX_BACKUPS ---
cd "$BACKUP_DIR"
ls -tp | grep -v '/$' | tail -n +$((MAX_BACKUPS+1)) | xargs -I {} rm -f {} 2>/dev/null

echo "✅ Old backups cleaned. Only last $MAX_BACKUPS backups kept."
