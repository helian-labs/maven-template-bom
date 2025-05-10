# BOM (Bill of Materials) 模块

## 模块说明

BOM 模块是项目的依赖版本管理模块，用于统一管理所有依赖的版本号，确保项目依赖版本的一致性。

## 主要功能

- 集中管理所有依赖的版本号
- 提供统一的依赖版本控制
- 简化依赖版本升级流程
- 确保多模块项目依赖版本的一致性

## 使用方式

1. 在父 POM 中导入 BOM：

```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>com.helian</groupId>
            <artifactId>bom</artifactId>
            <version>${revision}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

1. 在子模块中使用依赖时，无需指定版本号：

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
</dependencies>
```

## 版本管理

- 版本号格式：`主版本号.次版本号.修订号-SNAPSHOT`
- 版本更新原则：
  - 主版本号：不兼容的 API 修改
  - 次版本号：向下兼容的功能性新增
  - 修订号：向下兼容的问题修正

## 维护指南

1. 添加新依赖：
   - 在 `pom.xml` 的 `dependencyManagement` 部分添加依赖声明
   - 确保版本号符合项目规范

2. 更新依赖版本：
   - 使用 `versions-maven-plugin` 检查更新
   - 更新后进行全面测试
   - 更新 CHANGELOG.md

3. 发布新版本：
   - 更新版本号
   - 更新 CHANGELOG.md
   - 执行发布流程

## 注意事项

- 所有依赖版本变更必须经过测试
- 保持版本号的语义化
- 定期检查依赖的安全漏洞
- 及时更新过时的依赖版本
