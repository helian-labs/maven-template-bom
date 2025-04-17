#!/bin/bash
# 项目发布脚本
# 用法: ./scripts/release.sh [prepare|perform]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

function prepare_release() {
  echo "===== 准备发布 ====="
  
  # 检查工作区是否干净
  if [ -n "$(git status --porcelain)" ]; then
    echo "错误: 工作区不干净，请先提交或暂存更改"
    exit 1
  fi
  
  # 更新到最新代码
  git pull
  
  # 运行测试
  ./mvnw clean test
  
  # 从快照版本创建发布版本
  "$SCRIPT_DIR/version.sh" release
  
  echo "发布版本已准备就绪"
  echo "请检查更改，然后运行 './scripts/release.sh perform' 完成发布"
}

function perform_release() {
  echo "===== 执行发布 ====="
  
  VERSION=$(./mvnw help:evaluate -Dexpression=project.version -q -DforceStdout)
  
  # 提交版本更改
  git add .
  git commit -m "Release version $VERSION"
  
  # 创建标签
  git tag -a "v$VERSION" -m "Release version $VERSION"
  
  # 构建并部署
  ./mvnw clean deploy -P release
  
  # 创建下一个开发版本
  "$SCRIPT_DIR/version.sh" next
  
  # 提交新的开发版本
  NEW_VERSION=$(./mvnw help:evaluate -Dexpression=project.version -q -DforceStdout)
  git add .
  git commit -m "Prepare for next development iteration $NEW_VERSION"
  
  # 自动推送更改和标签到远程仓库
  git push origin main
  git push origin v$VERSION
}

# 验证命令是否有效
VALID_COMMANDS=("prepare" "perform")
if [[ ! " ${VALID_COMMANDS[@]} " =~ " $1 " ]]; then
  echo "错误: 无效的命令 '$1'"
  echo "用法: $0 [prepare|perform]"
  echo "  prepare - 准备发布（创建发布版本）"
  echo "  perform - 执行发布（创建标签、部署、准备下一个版本）"
  exit 1
fi

case "$1" in
  prepare)
    prepare_release
    ;;
  perform)
    perform_release
    ;;
esac