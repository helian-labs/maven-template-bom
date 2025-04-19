# 贡献指南

感谢您考虑为 Maven BOM 模板项目做出贡献！以下是参与本项目的一些指导原则。

## 行为准则

我们希望所有贡献者都能遵循我们的行为准则，以确保项目的健康发展。请参阅[行为准则](./CODE_OF_CONDUCT.md)以了解更多信息。

## 开发流程

我们采用基于 Gitflow 的分支模型，但简化为以下主要分支：

- **main**: 用于发布稳定版本，此分支的代码应始终处于可发布状态。
- **feature/xxx**: 用于开发新功能。从 `main` 分支创建，完成后合并回 `main`。
- **fix/xxx**: 用于修复 `main` 分支上的 bug。从 `main` 分支创建，修复后合并回 `main`。
- **release/vx.y.z**: 用于准备新版本发布。从 `main` 分支创建，进行版本相关的最后调整和测试，完成后合并回 `main` 并打上版本标签。

**开发步骤：**

1. Fork 本仓库
2. 同步您的 Fork 仓库 (`git fetch upstream` 和 `git rebase upstream/main`)
3. 创建您的特性分支 (`git checkout -b feature/amazing-feature`)
4. 提交您的更改 (`git commit -m 'Add some amazing feature'`)
5. 推送到分支 (`git push origin feature/amazing-feature`)
6. 开启一个 Pull Request 到 `main` 分支，请求代码评审。

## 代码评审流程

1. **发起评审**：当您的特性开发或 bug 修复完成后，请向上游仓库的 `main` 分支发起 Pull Request (PR)。
2. **评审人**：项目维护者或其他核心贡献者将负责评审您的代码。
3. **评审标准**：
    - 代码是否符合项目目标和需求？
    - 代码风格是否遵循规范？
    - 是否包含必要的单元测试且测试通过？
    - 是否存在潜在的 bug 或性能问题？
    - 文档（Javadoc、README 等）是否已更新？
4. **反馈与修改**：评审人可能会在 PR 中提出修改建议。请及时响应并根据反馈进行修改，然后再次推送更新。
5. **合并**：一旦代码通过评审，维护者会将您的 PR 合并到 `main` 分支。

## 代码风格

- 遵循 Java 代码规范
- 使用 4 空格缩进
- 类和方法需要添加 Javadoc 注释
- 使用 `Checkstyle` 或 `SpotBugs` 进行代码质量检查

## 提交信息规范

提交信息应遵循以下格式：

```markdown
<类型>: <描述>

[可选的详细描述]
[可选的关闭问题引用]
```

类型可以是：

- feat: 新功能
- fix: 修复bug
- docs: 文档更新
- style: 代码风格调整
- refactor: 代码重构
- test: 测试相关
- chore: 构建过程或辅助工具变动

示例：

```markdown
feat: 添加用户登录功能

实现了基本的用户登录功能，包括表单验证和错误处理。
关闭 #123
```

## 测试要求

- **编写测试**: 所有新功能和 bug 修复必须包含相应的单元测试或集成测试。请使用 `JUnit 5` 和 `Mockito`（或其他合适的测试库）。
- **运行测试**: 在提交 Pull Request 之前，请确保所有测试都通过。运行本地测试命令：`./mvnw test`。
- **测试覆盖率**: 确保您的更改不会导致测试覆盖率下降。鼓励编写测试以提高覆盖率。
- **保持测试通过**: 确保您的更改不会破坏现有的测试。

## 设置开发环境

1. **先决条件**: 确保您已安装兼容版本的 JDK 和 Apache Maven。
2. **克隆仓库**: `git clone https://github.com/YOUR_USERNAME/maven-template-bom.git`
3. **构建项目**: 在项目根目录运行 `./mvnw clean install` 以确保项目可以成功构建并下载所有依赖。

## 报告问题

如果您发现 bug 或有功能建议，请通过 GitHub Issues 提交。

- **搜索现有问题**: 在创建新问题之前，请先搜索是否已存在类似的问题。
- **提供详细信息**: 清晰地描述问题，包括复现步骤、预期行为和实际行为。如果可能，请提供相关的日志或截图。

## 发布流程

项目遵循 [语义化版本](https://semver.org/lang/zh-CN/) 规范。

1. **准备发布**：
    - 从 `main` 分支创建一个 `release/vx.y.z` 分支。
    - 更新 `pom.xml` 文件中的版本号。
    - 更新 `CHANGELOG.md`，整理该版本的所有变更。
    - 执行 `./mvnw clean install` 确保构建成功。
2. **最终测试**：在 `release` 分支上进行最后的集成测试和验证。
3. **合并与打标**：
    - 将 `release/vx.y.z` 分支合并回 `main` 分支。
    - 在 `main` 分支上为此次提交打上版本标签，例如 `git tag -a v1.0.0 -m "Release version 1.0.0"`。
    - 将 `main` 分支和标签推送到远程仓库：`git push origin main --tags`。
4. **发布构建** (可选，根据项目配置)：可能需要手动触发 CI/CD 流水线或执行 `./scripts/release.sh` (如果存在) 来构建和发布 Maven Artifacts 到仓库 (如 Maven Central)。

## 许可证

通过贡献您的代码，您同意将其授权给本项目使用 Apache License 2.0。
