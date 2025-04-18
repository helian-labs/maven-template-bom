# 贡献指南

感谢您考虑为 Maven BOM 模板项目做出贡献！以下是参与本项目的一些指导原则。

## 行为准则

我们希望所有贡献者都能遵循我们的行为准则，以确保项目的健康发展。请参阅[行为准则](./CODE_OF_CONDUCT.md)以了解更多信息。

## 开发流程

1. Fork 本仓库
2. 同步您的 Fork 仓库 (`git fetch upstream` 和 `git rebase upstream/main`)  # 更新为main
3. 创建您的特性分支 (`git checkout -b feature/amazing-feature`)
4. 提交您的更改 (`git commit -m 'Add some amazing feature'`)
5. 推送到分支 (`git push origin feature/amazing-feature`)
6. 开启一个 Pull Request 到 main 分支  # 添加明确的目标分支

## 代码风格

- 遵循 Java 代码规范
- 使用 4 空格缩进
- 类和方法需要添加 Javadoc 注释
- 使用 `Checkstyle` 或 `SpotBugs` 进行代码质量检查

## 提交信息规范

提交信息应遵循以下格式：

```
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

```
feat: 添加用户登录功能

实现了基本的用户登录功能，包括表单验证和错误处理。
关闭 #123
```

## 测试要求

- 所有新功能必须包含单元测试
- 测试覆盖率不应下降
- 使用 `JUnit` 或 `Mockito` 编写测试
- 运行测试命令： `./mvnw test`

## 许可证

通过贡献您的代码，您同意将其授权给本项目使用 Apache License 2.0。