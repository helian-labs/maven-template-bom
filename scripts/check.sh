#!/bin/bash
# 代码质量检查脚本
# 用法: ./scripts/check.sh [all|test|coverage]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

function run_tests() {
  echo "===== 运行测试 ====="
  ./mvnw test
}

function check_coverage() {
  echo "===== 检查代码覆盖率 ====="
  ./mvnw clean verify
  echo "覆盖率报告生成在: target/site/jacoco/"
}

case "$1" in
  test)
    run_tests
    ;;
  coverage)
    check_coverage
    ;;
  all)
    run_tests
    check_coverage
    ;;
  *)
    echo "用法: $0 [all|test|coverage]"
    echo "  all      - 运行所有检查"
    echo "  test     - 仅运行测试"
    echo "  coverage - 生成代码覆盖率报告"
    exit 1
    ;;
esac