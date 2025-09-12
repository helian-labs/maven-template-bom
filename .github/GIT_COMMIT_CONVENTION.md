# Git 提交信息规范

本文档定义了项目的 Git 提交信息格式规范，确保提交历史的清晰性和可维护性。

## 1. 提交信息格式

### 1.1 基本格式

```
<类型>(<作用域>): <主题>

<正文>

<页脚>
```

### 1.2 各部分说明

#### 1.2.1 类型（Type）

| 类型 | 说明 | 示例 |
|------|------|------|
| feat | 新功能 | feat(user): 添加用户注册功能 |
| fix | Bug修复 | fix(auth): 修复登录验证问题 |
| docs | 文档更新 | docs(readme): 更新安装说明 |
| style | 代码格式 | style: 格式化代码 |
| refactor | 代码重构 | refactor(service): 重构用户服务 |
| test | 测试相关 | test(controller): 添加API测试 |
| chore | 构建过程或辅助工具变动 | chore(deps): 更新依赖版本 |
| perf | 性能优化 | perf(db): 优化数据库查询 |
| ci | CI配置相关 | ci(github): 添加workflow配置 |
| build | 构建系统相关 | build(maven): 更新插件配置 |
| revert | 回退提交 | revert: 回退某次错误提交 |

#### 1.2.2 作用域（Scope）

作用域表示修改的影响范围，通常是模块或组件名称：

- `bom`: BOM模块相关
- `module1`: 模块1相关  
- `module2`: 模块2相关
- `config`: 配置相关
- `scripts`: 脚本相关
- `docs`: 文档相关
- `deps`: 依赖相关
- `ci`: CI/CD相关
- `build`: 构建相关

#### 1.2.3 主题（Subject）

- 使用祈使句，现在时态
- 首字母小写
- 不加句号
- 简明扼要（50字符以内）

#### 1.2.4 正文（Body）

- 描述修改的动机和细节
- 使用现在时态
- 每行72字符以内
- 解释"为什么"而不是"是什么"

#### 1.2.5 页脚（Footer）

- 引用相关Issue: `Closes #123`
- 破坏性变更: `BREAKING CHANGE: 描述变更影响`
- 关联PR: `Related to PR #456`

## 2. 示例

### 2.1 功能开发

```
feat(user): 添加用户密码重置功能

- 实现密码重置邮件发送
- 添加密码重置API端点
- 包含相关的验证逻辑

Closes #123
```

### 2.2 Bug修复

```
fix(auth): 修复JWT令牌过期验证

修复了JWT令牌过期时间验证逻辑错误，
现在会正确检查令牌是否过期。

Fixes #456
```

### 2.3 文档更新

```
docs(readme): 更新快速开始指南

添加了Docker部署说明和常见问题解答，
使新用户能够更快上手项目。
```

### 2.4 重构

```
refactor(service): 重构用户服务层

- 提取用户验证逻辑到独立类
- 使用策略模式处理不同用户类型
- 提高代码可测试性和可维护性
```

### 2.5 依赖更新

```
chore(deps): 更新Spring Boot到3.2.0

- spring-boot-starter-parent: 3.1.0 → 3.2.0
- spring-boot-starter-web: 3.1.0 → 3.2.0
- 相关依赖版本同步更新
```

### 2.6 破坏性变更

```
feat(api): 重构用户API端点

- 将 `/api/v1/users` 改为 `/api/v2/users`
- 请求参数格式变更
- 响应数据结构优化

BREAKING CHANGE: 旧版本API不再兼容，
需要更新客户端代码。
```

## 3. 提交规范检查

### 3.1 使用 Commitlint

项目配置了 Commitlint 来验证提交信息格式：

```bash
# 安装 commitlint
npm install --save-dev @commitlint/config-conventional @commitlint/cli

# 创建配置文件
echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js
```

### 3.2 Git Hook 配置

配置 Git Hook 自动检查提交信息：

```bash
# 安装 husky
npm install --save-dev husky

# 启用 husky
npx husky init

# 添加 commit-msg hook
echo 'npx --no -- commitlint --edit "$1"' > .husky/commit-msg

# 设置权限
chmod +x .husky/commit-msg
```

### 3.3 手动验证

也可以使用以下命令手动验证：

```bash
# 验证最后一次提交
npx commitlint --from=HEAD~1 --to=HEAD --verbose

# 验证特定提交
npx commitlint --edit .git/COMMIT_EDITMSG
```

## 4. 常见问题

### 4.1 提交信息过长

**错误示例**:
```
fix: 修复了一个在用户管理模块中当用户尝试使用特殊字符作为用户名时系统会抛出NullPointerException的问题
```

**正确示例**:
```
fix(user): 处理用户名特殊字符导致的NPE

当用户名包含特殊字符时，用户服务会抛出
NullPointerException，现已修复此问题。
```

### 4.2 作用域不明确

**错误示例**:
```
fix: 修复问题
```

**正确示例**:
```
fix(auth): 修复登录令牌验证问题
```

### 4.3 类型使用错误

**错误示例**:
```
update: 更新依赖版本
```

**正确示例**:
```
chore(deps): 更新Spring Boot到3.2.0
```

## 5. 工具集成

### 5.1 IDE 插件

推荐使用以下 IDE 插件辅助提交：

- **IntelliJ IDEA**: Git Commit Template 插件
- **VSCode**: Conventional Commits 插件
- **Eclipse**: EGit 内置支持

### 5.2 命令行工具

```bash
# 使用 commitizen 进行交互式提交
npm install -g commitizen
npm install --save-dev cz-conventional-changelog

# 配置 package.json
{
  "config": {
    "commitizen": {
      "path": "./node_modules/cz-conventional-changelog"
    }
  }
}

# 使用 git cz 代替 git commit
git cz
```

## 6. 变更日志生成

规范的提交信息可以自动生成变更日志：

```bash
# 安装 conventional-changelog
npm install --save-dev conventional-changelog-cli

# 生成变更日志
npx conventional-changelog -p angular -i CHANGELOG.md -s
```

## 7. 团队协作建议

### 7.1 代码审查

- 在代码审查中检查提交信息规范
- 使用 squash merge 保持提交历史整洁
- 确保每个PR有清晰的描述

### 7.2 分支策略

```
feat/xxx     - 功能开发分支
fix/xxx      - Bug修复分支  
docs/xxx     - 文档更新分支
release/x.y.z - 发布分支
```

### 7.3 提交频率

- 频繁提交，每次提交一个完整功能
- 避免巨大的提交（超过500行）
- 使用 `git add -p` 进行精细提交

## 8. 参考资源

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Angular Commit Message Guidelines](https://github.com/angular/angular/blob/main/CONTRIBUTING.md#commit)
- [Commitlint](https://commitlint.js.org/)
- [Husky](https://typicode.github.io/husky/)

---

**最后更新**: 2024-01-01

*请所有开发人员严格遵守此规范，以确保项目提交历史的清晰和可维护性。*