# 项目配置说明

## 概述
本文档详细记录了项目的所有配置文件及其用途，帮助开发者理解项目结构和维护规范。

## 版本信息
- 项目版本：1.0.0-SNAPSHOT
- 最后更新：2025-04-19
- 维护者：Helian Labs团队

## 构建配置
### Maven Wrapper
- 来源：[Spring Initializr](https://start.spring.io/)
- 文件：`.mvn/`, `mvnw`, `mvnw.cmd`
- 用途：提供统一的 Maven 构建环境，无需预先安装 Maven
- 版本：Maven 3.9.9
- 配置说明：
  - `.mvn/wrapper/maven-wrapper.properties` 定义Maven版本
  - `.mvn/wrapper/settings.xml` 包含自定义仓库和镜像配置

## 开源协议
- 协议：[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)
- 文件：`LICENSE`
- 说明：允许商业使用、修改和分发，但需保留版权声明和许可声明

## 安全策略
- 文件：`SECURITY.md`
- 用途：提供安全漏洞报告指南和安全最佳实践
- 内容：支持的版本、漏洞报告流程、安全更新渠道

## 开发工具配置
### EditorConfig
- 来源：[EditorConfig](https://editorconfig.org/)
- 文件：`.editorconfig`
- 用途：统一不同 IDE 和编辑器的代码风格
- 主要配置：
  - 文件编码：UTF-8
  - 缩进风格：空格
  - 缩进大小：4
  - 换行符：LF
  - 文件类型处理：`*.java`, `*.xml`, `*.md`等

### IDE 配置
- 支持IDE：IntelliJ IDEA, Eclipse, VS Code
- 推荐插件：
  - Maven Integration
  - Checkstyle-IDEA
  - SonarLint
  - Git Toolbox

### Git 配置
#### 文件属性配置
- 来源：[Git - gitattributes Documentation](https://git-scm.com/docs/gitattributes)
- 文件：`.gitattributes`
- 用途：统一文件属性处理
- 主要配置：
  - 文本文件换行符自动转换
  - 二进制文件处理策略
  - 差异比较配置

#### 忽略文件配置
- 来源：[github/gitignore](https://github.com/github/gitignore)
- 文件：`.gitignore`
- 用途：排除不需要版本控制的文件
- 主要忽略：
  - 编译输出：`target/`
  - IDE 配置：`.idea/`, `.project`
  - 日志文件：`*.log`
  - 临时文件：`*.tmp`

## CI/CD 与自动化
### GitHub Actions
- 文件：`.github/workflows/maven.yml`
- 用途：自动化构建、测试和代码质量检查
- 主要触发器：`push` 到 `main` 分支, `pull_request` 到 `main` 分支, 每周定时运行, 手动触发
- 主要任务：
  - 使用 Java 17 和 21 进行构建和验证 (`./mvnw clean verify`)
  - 静态代码分析 (SpotBugs, PMD, Checkstyle)
  - 依赖项漏洞扫描 (Trivy)
  - 测试覆盖率报告 (JaCoCo)
  - 构建产物上传

### Dependabot
- 文件：`.github/dependabot.yml`
- 用途：自动更新 Maven 和 GitHub Actions 依赖
- 检查频率：Maven (每周), GitHub Actions (每月)
- 标签：`dependencies`, `security`, `ci`
- 提交信息前缀：`build(deps)` (Maven), `ci` (Actions)

## 项目结构
- `pom.xml`: 项目根 POM 文件，管理整体构建和模块
  - 父POM配置：继承自`spring-boot-starter-parent`
  - 模块管理：包含`bom`, `module1`, `module2`
- `bom/`: Bill of Materials (BOM) 模块
  - 用途：统一管理项目依赖版本
  - 包含：Spring Boot, Spring Cloud, Apache Commons等常用库
- `module1/`, `module2/`: 示例项目模块
  - 标准Maven目录结构
  - 包含：`src/main`, `src/test`
- `scripts/`: 辅助开发脚本
  - 功能：构建、测试、质量检查、版本管理
  - 架构：模块化设计，共享`lib/common.sh`库

## 辅助脚本
- 目录：`scripts/`
- 用途：提供常用的开发任务脚本，如构建、测试、版本管理等
- 脚本列表：`build.sh`, `test.sh`, `quality.sh`, `version.sh`, `dependency.sh`, `release.sh`, `init.sh`
- 共享库：`scripts/lib/common.sh` 包含通用函数

## 版本控制
所有配置文件均通过 Git 进行版本控制，建议在修改配置时：
1. 创建专门的分支
2. 提交详细的说明
3. 通过 Pull Request 进行评审
4. 合并到主分支

## 配置更新
如需更新配置，请遵循以下步骤：
1. 在本文档中添加更新说明
2. 更新相关配置文件
3. 提交变更并通知团队成员

## 注意事项
- 不要随意修改这些基础配置文件
- 如需自定义配置，请在团队内达成共识
- 保持配置文件的简洁性和可维护性