#!/bin/bash
# 代码格式化脚本
# 用法: ./scripts/format.sh [check|apply]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

# 验证命令是否有效
VALID_COMMANDS=("check" "apply")
if [[ ! " ${VALID_COMMANDS[@]} " =~ " $1 " ]]; then
  echo "错误: 无效的命令 '$1'"
  echo "用法: $0 [check|apply]"
  echo "  check  - 检查代码格式"
  echo "  apply  - 应用代码格式"
  exit 1
fi

case "$1" in
  check)
    echo "===== 检查代码格式 ====="
    ./mvnw spotless:check
    ;;
  apply)
    echo "===== 应用代码格式 ====="
    ./mvnw spotless:apply
    ;;
esac