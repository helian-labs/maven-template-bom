# Module2 模块

## 模块说明

Module2 是项目的扩展业务模块，提供额外的业务功能支持，与 Module1 形成互补。

## 主要功能

- 提供扩展业务功能
- 处理外部系统集成
- 实现数据同步和转换
- 提供缓存和性能优化

## 技术栈

- Spring Boot
- Spring Cloud
- Redis
- RabbitMQ
- JUnit 5
- TestContainers

## 项目结构

```bash
module2/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/helian/module2/
│   │   │       ├── client/        # 外部服务客户端
│   │   │       ├── service/       # 业务逻辑层
│   │   │       ├── cache/         # 缓存处理
│   │   │       ├── mq/           # 消息队列处理
│   │   │       ├── model/         # 数据模型
│   │   │       └── config/        # 配置类
│   │   └── resources/
│   │       ├── application.yml    # 应用配置
│   │       └── application-dev.yml # 开发环境配置
│   └── test/
│       └── java/
│           └── com/helian/module2/
│               ├── integration/   # 集成测试
│               ├── service/       # 服务层测试
│               └── client/        # 客户端测试
```

## 开发指南

1. 环境要求：
   - JDK 17+
   - Maven 3.6.3+
   - Docker（用于集成测试）
   - IDE 推荐：IntelliJ IDEA

2. 开发流程：
   - 遵循 Git Flow 工作流
   - 使用 feature 分支进行功能开发
   - 提交前运行所有测试
   - 确保代码符合 Checkstyle 规范

3. 测试要求：
   - 单元测试覆盖率 > 80%
   - 集成测试覆盖率 > 70%
   - 所有测试必须通过

## 外部依赖

1. Redis 服务
   - 版本：6.0+
   - 用途：缓存数据
   - 配置项：`spring.redis.*`

2. RabbitMQ 服务
   - 版本：3.8+
   - 用途：消息队列
   - 配置项：`spring.rabbitmq.*`

3. 外部 API
   - 认证方式：OAuth2
   - 超时设置：5秒
   - 重试策略：指数退避

## 部署说明

1. 构建：

```bash
mvn clean package
```

2. 运行：

```bash
java -jar target/module2-${version}.jar
```

3. 环境变量：
   - `SPRING_PROFILES_ACTIVE`: 激活的配置文件
   - `SERVER_PORT`: 服务端口
   - `REDIS_URL`: Redis 连接 URL
   - `RABBITMQ_URL`: RabbitMQ 连接 URL

## 监控和日志

- 使用 Spring Boot Actuator 进行监控
- 使用 Micrometer 收集指标
- 日志使用 SLF4J + Logback
- 日志文件位置：`/var/log/module2/`

## 性能优化

1. 缓存策略
   - 使用 Redis 作为二级缓存
   - 实现本地缓存（Caffeine）
   - 缓存预热机制

2. 消息处理
   - 消息持久化
   - 死信队列处理
   - 消息重试机制

3. 并发处理
   - 线程池配置
   - 限流措施
   - 熔断机制

## 常见问题

1. 缓存问题
   - 检查 Redis 连接
   - 验证缓存配置
   - 监控缓存命中率

2. 消息队列问题
   - 检查 RabbitMQ 连接
   - 监控消息积压
   - 处理死信消息

3. 性能问题
   - 分析响应时间
   - 检查资源使用
   - 优化数据库查询

## 维护者

- 开发团队：Helian Team
- 联系方式：<larryqi.sh@gmail.com>
