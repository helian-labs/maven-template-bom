# 贡献指南

感谢您考虑为本项目做出贡献！

## 行为准则

所有贡献者请遵循我们的[行为准则](CODE_OF_CONDUCT.md)。

## 开发流程

### 分支策略

- **main**: 稳定版本分支
- **develop**: 开发分支
- **feature/xxx**: 新功能开发分支
- **fix/xxx**: Bug修复分支
- **release/x.y.z**: 版本发布分支

### 开发步骤

1. Fork 本仓库
2. 创建特性分支：`git checkout -b feature/amazing-feature`
3. 提交更改：`git commit -m 'Add some amazing feature'`
4. 推送分支：`git push origin feature/amazing-feature`
5. 提交 Pull Request

## 代码规范

### Java 代码风格

- 遵循 Google Java Style Guide
- 使用 2 空格缩进
- 类和方法必须添加 Javadoc 注释
- 使用 Checkstyle 检查代码质量

### 提交信息规范

遵循 Conventional Commits 规范：

  ```markdown
  <类型>: <描述>
  [可选的详细描述]
  [可选的关闭问题引用]
  ```

常用类型：
- feat: 新功能
- fix: 修复 bug
- docs: 文档更新
- style: 代码格式
- refactor: 代码重构
- test: 测试相关
- chore: 构建过程或辅助工具变动

## 测试要求

- 新功能和 bug 修复必须包含相应测试
- 确保测试覆盖率不降低
- 运行所有测试：`mvn test` 或 `gradle test`

## 设置开发环境

1. 安装 JDK 11+
2. 克隆仓库：`git clone https://github.com/your-repo.git`
3. 导入 IDE 或运行：`mvn compile` / `gradle build`

## 报告问题

通过 GitHub Issues 报告问题，请提供：
- 详细的重现步骤
- 预期行为 vs 实际行为
- 相关日志和环境信息
