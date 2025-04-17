# 脚本工具使用指南

本目录包含了项目开发和维护过程中常用的脚本工具。这些脚本设计用于简化项目的初始化、构建、测试、版本管理和发布等操作。

## 脚本列表

### init.sh - 项目初始化

初始化项目环境，设置Git钩子，安装依赖。

```bash
./scripts/init.sh
```

功能：
- 确保所有脚本具有可执行权限
- 设置Git pre-commit钩子，在提交前自动运行测试
- 安装项目依赖

### format.sh - 代码格式化

检查和应用代码格式。

```bash
./scripts/format.sh [check|apply]
```

参数：
- `check` - 检查代码格式
- `apply` - 应用代码格式

### build.sh - 项目构建

构建项目，支持多种构建命令。

```bash
./scripts/build.sh [clean|install|package|test]
```

参数：
- `clean` - 清理项目
- `install` - 构建并安装到本地仓库（默认）
- `package` - 打包项目
- `test` - 运行测试

### check.sh - 代码质量检查

运行测试和代码覆盖率检查。

```bash
./scripts/check.sh [all|test|coverage]
```

参数：
- `all` - 运行所有检查
- `test` - 仅运行测试
- `coverage` - 生成代码覆盖率报告

### version.sh - 版本管理

管理项目版本号。

```bash
./scripts/version.sh [current|set <version>|release|next]
```

参数：
- `current` - 显示当前版本
- `set <version>` - 设置指定版本
- `release` - 从快照版本创建发布版本（移除-SNAPSHOT后缀）
- `next` - 从发布版本创建下一个开发版本（增加补丁版本号并添加-SNAPSHOT后缀）

### analyze-deps.sh - 依赖分析

分析项目依赖关系。

```bash
./scripts/analyze-deps.sh [tree|updates|conflicts]
```

参数：
- `tree` - 显示依赖树
- `updates` - 检查依赖和插件更新
- `conflicts` - 检查依赖冲突

### release.sh - 项目发布

执行项目发布流程。

```bash
./scripts/release.sh [prepare|perform]
```

参数：
- `prepare` - 准备发布（运行测试，创建发布版本）
- `perform` - 执行发布（提交更改，创建标签，部署，创建下一个开发版本）

## 使用建议

1. 项目初次克隆后，首先运行 `./scripts/init.sh` 进行初始化
2. 日常开发中使用 `./scripts/build.sh` 构建项目
3. 提交代码前可手动运行 `./scripts/check.sh all` 进行全面检查
4. 发布新版本时，按顺序执行：
   ```bash
   ./scripts/release.sh prepare
   # 检查版本更改
   ./scripts/release.sh perform
   ```

## 注意事项

- 所有脚本都应在项目根目录下执行
- 脚本依赖于Maven Wrapper，无需本地安装Maven
- 发布操作需要适当的仓库权限