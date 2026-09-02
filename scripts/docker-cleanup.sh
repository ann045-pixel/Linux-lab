#!/bin/bash

echo "🧹 Docker cleanup started..."

# Останавливаем все запущенные контейнеры (если нужно)
# docker stop $(docker ps -q) 2>/dev/null

# Удаляем все остановленные контейнеры
docker container prune -f

# Удаляем все неиспользуемые образы
docker image prune -f

# Удаляем все неиспользуемые тома
docker volume prune -f

# Удаляем все неиспользуемые сети
docker network prune -f

echo "✅ Docker cleanup completed."
