#!/bin/bash
set -e

BACKUP_DIR="/opt/cloud-suite/backups/local"
DATA_DIR="/opt/cloud-suite/mc118/data"
TIMESTAMP=$(date +"%Y%m%d_%H%M")
BACKUP_FILE="${BACKUP_DIR}/world_backup_${TIMESTAMP}.tar.gz"

mkdir -p "$BACKUP_DIR"

# 打包地图与插件配置/数据库
tar -czf "$BACKUP_FILE" -C "$DATA_DIR" world world_nether world_the_end plugins 2>/dev/null || true

# 自动清理 3 天 (72 小时) 前的旧本地快照
find "$BACKUP_DIR" -name "world_backup_*.tar.gz" -mtime +3 -delete

echo "[$(date)] Local backup created: $BACKUP_FILE"
