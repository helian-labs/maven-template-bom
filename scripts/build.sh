#!/bin/bash
# 项目构建脚本
# 用法: ./scripts/build.sh [clean|install|package|test]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

# 默认命令
COMMAND=${1:-"install"}

echo "===== 开始构建项目 ====="
echo "使用命令: $COMMAND"

# 执行Maven构建
./mvnw $COMMAND

echo "===== 构建完成 ====="