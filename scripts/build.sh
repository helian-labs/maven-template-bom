#!/bin/bash
# 项目构建脚本
# 用法: ./scripts/build.sh [clean|install|package|test]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

# 默认命令
COMMAND=${1:-"install"}

# 验证命令是否有效
VALID_COMMANDS=("clean" "install" "package" "test")
if [[ ! " ${VALID_COMMANDS[@]} " =~ " ${COMMAND} " ]]; then
  echo "错误: 无效的命令 '$COMMAND'"
  echo "用法: $0 [clean|install|package|test]"
  exit 1
fi

echo "===== 开始构建项目 ====="
echo "使用命令: $COMMAND"

# 执行Maven构建
./mvnw $COMMAND

echo "===== 构建完成 ====="