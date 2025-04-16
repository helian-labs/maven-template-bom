#!/bin/bash
# 依赖分析脚本
# 用法: ./scripts/analyze-deps.sh [tree|updates|conflicts]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

case "$1" in
  tree)
    echo "===== 显示依赖树 ====="
    ./mvnw dependency:tree
    ;;
  updates)
    echo "===== 检查依赖更新 ====="
    ./mvnw versions:display-dependency-updates
    echo "===== 检查插件更新 ====="
    ./mvnw versions:display-plugin-updates
    ;;
  conflicts)
    echo "===== 检查依赖冲突 ====="
    ./mvnw dependency:analyze
    ;;
  *)
    echo "用法: $0 [tree|updates|conflicts]"
    echo "  tree      - 显示依赖树"
    echo "  updates   - 检查依赖和插件更新"
    echo "  conflicts - 检查依赖冲突"
    exit 1
    ;;
esac