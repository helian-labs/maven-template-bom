# 项目配置说明

## 概述
本文档详细记录了项目的配置文件来源及其用途，以帮助开发者更好地理解项目结构。

## 构建配置
### Maven Wrapper
- 来源：[Spring Initializr](https://start.spring.io/)
- 文件：`.mvn/`, `mvnw`, `mvnw.cmd`
- 用途：提供统一的 Maven 构建环境，无需预先安装 Maven
- 版本：Maven 3.9.9

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