#!/bin/bash
# 项目初始化脚本
# 用法: ./scripts/init.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

echo "===== 初始化项目环境 ====="

# 确保脚本可执行
chmod +x "$SCRIPT_DIR"/*.sh

# 初始化 Git 钩子
if [ -d "$PROJECT_ROOT/.git" ]; then
  echo "设置 Git 钩子..."
  
  # 创建 pre-commit 钩子
  mkdir -p "$PROJECT_ROOT/.git/hooks"
  cat > "$PROJECT_ROOT/.git/hooks/pre-commit" << 'EOF'
#!/bin/bash
# 运行测试确保代码可以构建
./scripts/check.sh test

# 如果测试失败，阻止提交
if [ $? -ne 0 ]; then
  echo "测试失败，提交被阻止"
  exit 1
fi
EOF
  chmod +x "$PROJECT_ROOT/.git/hooks/pre-commit"
  
  echo "Git 钩子设置完成"
fi

# 安装依赖
echo "构建项目..."
./mvnw clean install -DskipTests

echo "===== 项目初始化完成 ====="
echo "您可以使用以下脚本:"
echo "  ./scripts/build.sh     - 构建项目"
echo "  ./scripts/check.sh     - 运行代码质量检查"
echo "  ./scripts/version.sh   - 管理项目版本"
echo "  ./scripts/analyze-deps.sh - 分析项目依赖"
echo "  ./scripts/release.sh   - 发布项目"