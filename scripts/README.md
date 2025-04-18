# Maven项目脚本工具集

本目录包含了Maven项目开发和维护过程中常用的脚本工具，遵循大厂最佳实践设计，提供模块化、可维护的脚本结构。

## 脚本架构

脚本工具集采用以下架构设计：

```
scripts/
├── lib/                    # 共享库目录
│   └── common.sh           # 通用函数库
├── build.sh                # 构建脚本
├── test.sh                 # 测试脚本
├── quality.sh              # 质量检查脚本
├── version.sh              # 版本管理脚本
├── dependency.sh           # 依赖管理脚本
├── release.sh              # 发布管理脚本
└── init.sh                 # 项目初始化脚本
```

## 设计原则

1. **模块化设计**：每个脚本专注于单一职责
2. **代码复用**：通用函数和变量集中在`lib/common.sh`中
3. **一致的接口**：所有脚本遵循统一的命令行参数格式
4. **完善的错误处理**：提供清晰的错误信息和日志输出
5. **自文档化**：每个脚本包含详细的帮助信息

## 使用方法

### 项目初始化

_初始化项目环境，设置Git钩子，安装依赖。_

```bash
./scripts/init.sh
```

### 构建项目

_构建项目，支持多种构建命令。_

```bash
./scripts/build.sh [clean|compile|package|install]

## 帮助信息
./scripts/build.sh -h
构建Maven项目
用法: ./scripts/build.sh [clean|compile|package|install]
命令:
  clean   - 清理项目构建产物
  compile - 编译项目代码
  package - 打包项目
  install - 构建并安装到本地仓库（默认）
```

### 测试项目

_运行测试和代码覆盖率检查。_

```bash
./scripts/test.sh [unit|integration|coverage]

## 帮助信息
./scripts/test.sh -h 
运行项目测试
用法: ./scripts/test.sh [unit|integration|coverage|all]
命令:
  unit        - 运行单元测试（默认）
  integration - 运行集成测试
  coverage    - 生成代码覆盖率报告
  all         - 运行所有测试并生成覆盖率报告
```

### 质量检查

_运行代码质量检查工具。_

```bash
./scripts/quality.sh [all|format|spotbugs|pmd|checkstyle]

## 帮助信息
./scripts/quality.sh -h
运行代码质量检查工具
用法: ./scripts/quality.sh [all|format|spotbugs|pmd|checkstyle]
命令:
  all       - 运行所有质量检查
  format    - 运行代码格式检查
  spotbugs  - 运行静态代码分析
  pmd       - 运行PMD代码分析
  checkstyle - 运行代码规范检查
```

### 版本管理

_管理项目版本。_

```bash
./scripts/version.sh [current|set <version>|release|next]

## 帮助信息
./scripts/version.sh -h
管理项目版本
用法: ./scripts/version.sh [current|set <version>|release|next]
命令:
  current       - 显示当前版本
  set <version> - 设置指定版本
  release       - 从快照版本创建发布版本（移除-SNAPSHOT后缀）
  next          - 从发布版本创建下一个开发版本（增加补丁版本号并添加-SNAPSHOT后缀）
```

### 依赖管理

_管理和分析项目依赖。_

```bash
./scripts/dependency.sh [list|tree|update|analyze]

## 帮助信息
./scripts/dependency.sh -h
管理和分析项目依赖
用法: ./scripts/dependency.sh [list|tree|update|analyze|revert]
命令:
  list    - 列出所有依赖的版本信息
  tree    - 显示依赖树结构
  update  - 更新依赖到最新版本
  analyze - 分析依赖冲突和使用情况
  revert  - 撤销依赖版本更改
```

### 发布项目

_准备和执行项目发布。_

```bash
./scripts/release.sh [prepare|perform]

## 帮助信息
./scripts/release.sh -h
准备和执行项目发布
用法: ./scripts/release.sh [prepare|perform]
命令:
  prepare - 准备发布（运行测试，创建发布版本）
  perform - 执行发布（提交更改，创建标签，部署，创建下一个开发版本）
```

## 最佳实践

1. **使用初始化脚本**：新克隆项目后，首先运行`./scripts/init.sh`
2. **定期质量检查**：提交代码前运行`./scripts/quality.sh all`
3. **依赖分析**：定期运行`./scripts/dependency.sh analyze`检查依赖冲突
4. **版本管理流程**：使用`version.sh`和`release.sh`管理版本发布周期

## 扩展脚本

如需添加新脚本，请遵循以下规范：

1. 引入通用库：`source "$(dirname "$0")/lib/common.sh"`
2. 使用通用函数进行日志输出和错误处理
3. 提供完整的帮助信息
4. 遵循一致的命令行参数格式