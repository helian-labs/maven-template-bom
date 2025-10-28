# 项目配置中心

本目录包含项目的代码质量检查和 IDE 格式化配置。

## 📁 目录结构

```bash
config/
├── README.md                    # 配置说明文档
├── checkstyle/                 # Checkstyle 代码检查配置
│   ├── checkstyle-suppressions.xml  # 检查抑制规则
│   ├── google_checks.xml       # Google Java Style Guide 检查规则
│   └── sun_checks.xml          # Sun/Oracle 代码风格检查规则
└── styleguide/                 # IDE 代码格式化配置
    ├── eclipse-java-google-style.xml  # Eclipse Google 风格配置
    └── intellij-java-google-style.xml  # IntelliJ Google 风格配置
```

## 🔧 配置说明

### Checkstyle 配置

**google_checks.xml** - Google Java Style Guide 检查规则

- 基于 Google 官方 Java 代码规范
- 包含 470 条详细的代码检查规则
- 支持现代 Java 特性（记录类、文本块等）

**sun_checks.xml** - Sun/Oracle 代码风格检查规则

- 遵循 Oracle 官方 Java 编码规范
- 包含 198 条基础检查规则
- 适合传统 Java 项目

**checkstyle-suppressions.xml** - 检查抑制规则

- 当前抑制了 Javadoc 检查
- 可根据项目需求灵活调整

### IDE 格式化配置

**eclipse-java-google-style.xml** - Eclipse IDE 格式化配置

- 包含 337 条格式化规则
- 支持 Eclipse 代码格式化器
- 与 Google 代码风格保持一致

**intellij-java-google-style.xml** - IntelliJ IDEA 格式化配置

- IntelliJ IDEA 专属格式化配置
- 确保多 IDE 环境代码风格统一

## 🚀 使用指南

### 在 Maven 项目中启用

项目已通过父 POM 配置了 Checkstyle 插件，默认使用 `google_checks.xml` 配置。

### IDE 配置导入

**Eclipse 用户：**

1. 打开 Preferences → Java → Code Style → Formatter
2. 导入 `eclipse-java-google-style.xml`
3. 设置为活动配置文件

**IntelliJ 用户：**

1. 打开 Settings → Editor → Code Style → Java
2. 点击 Scheme 设置 → Import Scheme → IntelliJ IDEA code style XML
3. 选择 `intellij-java-google-style.xml`

## 🔗 相关资源

### Google Style Guide

- <https://github.com/google/styleguide>
- <https://google.github.io/styleguide/>
- <https://google.github.io/styleguide/javaguide.html>

### Checkstyle

- <https://github.com/checkstyle/checkstyle>
- <https://checkstyle.org/>

### Spotless

- <https://github.com/diffplug/spotless>

## 📝 最佳实践

1. **团队统一**：所有团队成员使用相同的 IDE 配置，确保代码风格一致
2. **持续集成**：确保 CI/CD 流水线中启用代码检查
3. **渐进采用**：新项目建议使用 Google 风格，现有项目可根据情况选择
4. **定期更新**：关注配置工具的版本更新，及时调整配置
