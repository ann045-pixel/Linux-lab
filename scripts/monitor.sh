#!/bin/bash

echo "========================================="
echo "         SYSTEM STATUS REPORT"
echo "========================================="

# --- 1. Аптайм и загрузка CPU ---
echo "📟 Uptime & Load Average:"
uptime | awk -F'load average:' '{print $2}'
echo ""

# --- 2. Использование памяти ---
echo "🧠 Memory Usage:"
free -h | grep -E "Mem|Swap"
echo ""

# --- 3. Использование дисков ---
echo "💾 Disk Usage:"
df -h | grep -E "Filesystem|/dev/sd|/dev/vd"
echo ""

# --- 4. Проверка Nginx ---
if systemctl is-active --quiet nginx 2>/dev/null; then
    echo "✅ Nginx: running"
else
    echo "❌ Nginx: stopped"
fi

# --- 5. Проверка Docker ---
if command -v docker &> /dev/null; then
    echo ""
    echo "🐳 Docker containers:"
    docker ps --format "table {{.Names}}\t{{.Status}}"
else
    echo ""
    echo "🐳 Docker: not installed"
fi

echo "========================================="
