# JavaDoc 注释规范指南

## 基本原则

1. 所有公共 API 必须包含完整的 JavaDoc 注释
2. 注释应该清晰、准确、完整
3. 使用中文编写注释，保持语言一致性
4. 遵循 JavaDoc 标准格式

## 注释模板

### 类注释

```java
/**
 * 类的功能描述
 *
 * @author 作者名
 * @since 版本号
 * @see 相关类
 */
```

### 接口注释

```java
/**
 * 接口的功能描述
 *
 * @author 作者名
 * @since 版本号
 * @see 相关接口
 */
```

### 方法注释

```java
/**
 * 方法的功能描述
 *
 * @param 参数名 参数说明
 * @return 返回值说明
 * @throws 异常类型 异常说明
 * @since 版本号
 */
```

### 字段注释

```java
/** 字段说明 */
```

## 注释要求

### 1. 类注释

- 必须说明类的用途和职责
- 说明类的使用场景
- 标注作者和版本信息
- 列出重要的依赖关系

### 2. 方法注释

- 必须说明方法的功能
- 详细描述参数含义
- 说明返回值
- 列出可能抛出的异常
- 提供使用示例（如需要）

### 3. 字段注释

- 说明字段的用途
- 标注字段的约束条件
- 说明字段的单位（如适用）

### 4. 参数注释

- 说明参数的含义
- 标注参数的取值范围
- 说明参数的单位（如适用）
- 标注参数是否可以为 null

### 5. 返回值注释

- 说明返回值的含义
- 标注返回值的取值范围
- 说明返回值的单位（如适用）
- 标注返回值是否可以为 null

### 6. 异常注释

- 说明异常发生的原因
- 说明异常的处理方式
- 标注异常的使用场景

## 示例

### 类示例

```java
/**
 * 用户服务类，提供用户相关的业务操作
 *
 * 主要功能：
 * - 用户注册
 * - 用户认证
 * - 用户信息管理
 *
 * @author Helian Team
 * @since 1.0.0
 * @see UserRepository
 * @see UserController
 */
public class UserService {
    // ...
}
```

### 方法示例

```java
/**
 * 创建新用户
 *
 * 该方法会执行以下操作：
 * 1. 验证用户信息的合法性
 * 2. 检查用户名是否已存在
 * 3. 对密码进行加密
 * 4. 保存用户信息
 *
 * @param user 用户信息，不能为 null
 * @return 创建成功的用户信息，包含用户ID
 * @throws IllegalArgumentException 当用户信息不合法时
 * @throws UserAlreadyExistsException 当用户名已存在时
 * @since 1.0.0
 */
public User createUser(User user) {
    // ...
}
```

### 字段示例

```java
/** 用户状态：1-正常，2-禁用，3-删除 */
private Integer status;

/** 密码加密器，使用 BCrypt 算法 */
private final PasswordEncoder passwordEncoder;
```

## 最佳实践

1. 保持注释的及时更新
2. 使用统一的术语和表述
3. 避免重复的注释
4. 注释要简洁明了
5. 适当使用 HTML 标签格式化注释
6. 使用 @see 标签建立类之间的关联
7. 使用 @since 标签标注版本信息
8. 使用 @deprecated 标签标注废弃的 API

## 工具支持

1. IDE 配置
   - 启用 JavaDoc 自动生成
   - 配置 JavaDoc 模板
   - 启用 JavaDoc 检查

2. 构建工具
   - 使用 maven-javadoc-plugin 生成文档
   - 配置 JavaDoc 检查规则

3. 代码检查
   - 使用 Checkstyle 检查 JavaDoc
   - 使用 SonarQube 检查文档质量
