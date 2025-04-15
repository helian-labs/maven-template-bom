# Maven BOM 模板项目

[![Java CI with Maven](https://github.com/helian-labs/maven-template-bom/actions/workflows/maven.yml/badge.svg)](https://github.com/helian-labs/maven-template-bom/actions/workflows/maven.yml)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![Maven Central](https://img.shields.io/maven-central/v/com.helian/bom-example-project.svg)](https://search.maven.org/search?q=g:com.helian)

这是一个多模块 Maven 项目的模板/示例，演示如何使用和提供物料清单(BOM)来管理项目依赖。

## 项目特点

- 使用 BOM 进行依赖版本统一管理
- 支持多模块项目结构
- 兼容 Maven 版本管理和发布工具
- 提供完整的测试和代码质量检查配置

## 项目结构

```
maven-template-bom
├── bom                 # BOM 模块（无父 POM）
│   └── pom.xml
├── module1             # 基础功能模块
│   ├── pom.xml
│   └── src
├── module2             # 应用模块（依赖 module1）
│   ├── pom.xml
│   └── src
├── pom.xml             # 父 POM（聚合器）
├── README.md
├── CHANGELOG.md
└── SECURITY.md
```

## 设计原理

该项目采用特殊的 BOM 设计模式：

1. `bom` 模块不继承父 POM，避免版本循环依赖
2. 父 POM 导入 BOM 模块来管理所有内部模块版本
3. 子模块继承父 POM，并可以无需指定版本引用其他内部模块

这种设计的优势：

- 避免了版本号重复声明
- 确保项目内部依赖版本一致性
- 支持标准的 Maven 版本管理工具

## 快速开始

### 前提条件

- JDK 11+
- Maven 3.6.3+（或使用包含的 Maven Wrapper）

### 构建项目

```bash
# 使用 Maven Wrapper
./mvnw clean install

# 或使用本地安装的 Maven
mvn clean install
```

### 运行测试

```bash
./mvnw test
```

### 生成报告

```bash
./mvnw site
```

## 版本管理

当使用 versions 插件更新版本时，需要处理所有模块：

```bash
./mvnw versions:set -DnewVersion=1.1-SNAPSHOT -DprocessAllModules=true
```

使用 release 插件时，BOM 版本会自动更新：

```bash
./mvnw release:prepare -DdryRun=true -B
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

## 最佳实践

- 所有版本号统一在 BOM 中管理
- 子模块间依赖不指定版本号
- 使用 `./mvnw` 确保 Maven 版本一致性
- 遵循 [语义化版本](https://semver.org/lang/zh-CN/)

## 贡献指南

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

## 许可证

本项目采用 [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) 许可证。

## 相关资源

- [Maven 依赖机制介绍](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html)
- [Maven BOM 最佳实践](https://www.baeldung.com/spring-maven-bom)
- [Maven Release Plugin](https://maven.apache.org/maven-release/maven-release-plugin/index.html)