#!/bin/bash
# 版本管理脚本
# 用法: ./scripts/version.sh [current|set <version>|release|next]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

function current_version() {
  ./mvnw help:evaluate -Dexpression=project.version -q -DforceStdout
}

function set_version() {
  if [ -z "$1" ]; then
    echo "错误: 请提供版本号"
    exit 1
  fi
  
  echo "设置版本为: $1"
  ./mvnw versions:set -DnewVersion="$1" -DgenerateBackupPoms=false
}

function release_version() {
  CURRENT=$(current_version)
  if [[ $CURRENT == *-SNAPSHOT ]]; then
    RELEASE_VERSION=${CURRENT%-SNAPSHOT}
    echo "从 $CURRENT 创建发布版本 $RELEASE_VERSION"
    set_version "$RELEASE_VERSION"
  else
    echo "当前版本 $CURRENT 已经是发布版本"
  fi
}

function next_version() {
  CURRENT=$(current_version)
  if [[ $CURRENT == *-SNAPSHOT ]]; then
    echo "当前版本 $CURRENT 已经是快照版本"
  else
    # 简单版本号增加
    MAJOR=$(echo $CURRENT | cut -d. -f1)
    MINOR=$(echo $CURRENT | cut -d. -f2)
    PATCH=$(echo $CURRENT | cut -d. -f3)
    
    NEXT_PATCH=$((PATCH + 1))
    NEXT_VERSION="$MAJOR.$MINOR.$NEXT_PATCH-SNAPSHOT"
    
    echo "从 $CURRENT 创建下一个开发版本 $NEXT_VERSION"
    set_version "$NEXT_VERSION"
  fi
}

# 验证命令是否有效
VALID_COMMANDS=("current" "set" "release" "next")
if [[ ! " ${VALID_COMMANDS[@]} " =~ " $1 " ]]; then
  echo "错误: 无效的命令 '$1'"
  echo "用法: $0 [current|set <version>|release|next]"
  echo "  current  - 显示当前版本"
  echo "  set      - 设置指定版本"
  echo "  release  - 从快照版本创建发布版本"
  echo "  next     - 从发布版本创建下一个开发版本"
  exit 1
fi

case "$1" in
  current)
    echo "当前版本: $(current_version)"
    ;;
  set)
    set_version "$2"
    ;;
  release)
    release_version
    ;;
  next)
    next_version
    ;;
esac