# Maven BOM 模板项目

[![Java CI with Maven](https://github.com/helian-labs/maven-template-bom/actions/workflows/maven.yml/badge.svg)](https://github.com/helian-labs/maven-template-bom/actions/workflows/maven.yml)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

## 项目背景

这是一个多模块 Maven 项目的模板/示例，旨在演示如何使用和提供物料清单(BOM)来管理项目依赖。通过统一的版本管理和模块化设计，帮助开发者更高效地管理复杂项目。

## 项目特点

- 使用 BOM 进行依赖版本统一管理
- 支持多模块项目结构
- 兼容 Maven 版本管理和发布工具
- 提供完整的测试和代码质量检查配置

## 快速开始

### 前提条件

- JDK 17+
- Maven 3.6.3+（或使用包含的 Maven Wrapper）

### 安装步骤

1. 克隆项目到本地：
   ```bash
   git clone https://github.com/helian-labs/maven-template-bom.git
   cd maven-template-bom
   ```

2. 构建项目：
   ```bash
   ./mvnw clean install
   ```

3. 运行测试：
   ```bash
   ./mvnw test
   ```

4. 生成报告：
   ```bash
   ./mvnw site
   ```

## 模块分层结构

项目采用清晰的分层架构，各模块职责和依赖关系如下：

### 模块职责

1. **bom 模块**
   - 作为版本管理中心，统一管理所有内部模块的版本
   - 不包含实际代码，仅包含依赖版本声明
   - 独立于父POM，避免版本循环依赖

2. **module1 模块**
   - 基础功能模块，提供核心业务逻辑和基础服务
   - 不依赖其他业务模块，可独立部署和使用
   - 继承父POM以获取通用配置

3. **module2 模块**
   - 应用层模块，依赖module1提供的基础功能
   - 实现特定业务场景的应用逻辑
   - 继承父POM以获取通用配置

### 依赖关系

```
┌─────────┐     ┌─────────┐     ┌─────────┐
│   bom   │◄────┤  父POM  │────►│ module1 │
└─────────┘     └─────────┘     └─────────┘
                     ▲               ▲
                     │               │
                     │           ┌─────────┐
                     └───────────┤ module2 │
                                 └─────────┘
```

## 在其他项目中使用此 BOM

在您的项目中添加以下依赖管理配置：

```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>com.helian</groupId>
            <artifactId>bom</artifactId>
            <version>1.0-SNAPSHOT</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

然后，您可以添加依赖而无需指定版本：

```xml
<dependencies>
    <dependency>
        <groupId>com.helian</groupId>
        <artifactId>module1</artifactId>
    </dependency>
</dependencies>
```

## 贡献指南

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

## 常见问题解答（FAQ）

- **如何更新依赖版本？**
  使用 `./mvnw versions:set` 命令更新版本。

- **如何处理依赖冲突？**
  使用 `./mvnw dependency:analyze` 检查并解决冲突。

## 许可证

本项目采用 [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) 许可证。

## 相关资源

- [Maven 依赖机制介绍](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html)
- [Maven BOM 最佳实践](https://www.baeldung.com/spring-maven-bom)
- [Maven Release Plugin](https://maven.apache.org/maven-release/maven-release-plugin/index.html)