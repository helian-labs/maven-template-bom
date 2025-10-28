# 贡献指南

感谢您考虑为 **Maven Template BOM** 项目做出贡献！

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

### 前置要求

- JDK 11 或更高版本
- Maven 3.6+ (项目使用 Maven 构建)
- Git 2.20+

### 环境设置

1. 克隆仓库：`git clone https://github.com/your-org/maven-template-bom.git`
2. 进入项目目录：`cd maven-template-bom`
3. 验证环境：`mvn --version`
4. 编译项目：`mvn clean compile`
5. 运行测试：`mvn test`

### IDE 配置

- **IntelliJ IDEA**: 导入为 Maven 项目
- **Eclipse**: 使用 M2Eclipse 插件
- **VS Code**: 安装 Java Extension Pack

## 代码审查流程

### Pull Request 要求

- 代码必须通过所有测试和代码质量检查
- 遵循 Conventional Commits 规范
- 包含适当的测试用例
- 更新相关文档（如需要）

### 审查标准

- 代码符合 Google Java Style Guide
- 功能实现正确且高效
- 测试覆盖充分
- 文档更新完整

## 发布流程

### 版本发布

1. 从 `develop` 分支创建 `release/x.y.z` 分支
2. 更新版本号和 CHANGELOG.md
3. 运行完整测试套件
4. 合并到 `main` 分支并打标签
5. 发布到 Maven Central（如适用）

## 报告问题

通过 [GitHub Issues](https://github.com/your-org/maven-template-bom/issues) 报告问题，请提供：

### 必需信息

- **问题标题**: 清晰描述问题
- **重现步骤**: 详细的重现步骤
- **预期行为**: 期望的结果
- **实际行为**: 实际观察到的结果
- **环境信息**:
  - Java 版本
  - Maven 版本
  - 操作系统
  - 相关配置

### 可选信息

- 错误日志截图
- 相关代码片段
- 可能的解决方案建议

## 成为核心贡献者

对项目有持续贡献的开发者可能被邀请成为核心贡献者，拥有：

- 代码合并权限
- 版本发布权限
- 项目决策参与权
