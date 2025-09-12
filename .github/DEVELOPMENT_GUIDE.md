# 项目开发规范指南

本文档详细描述了 Maven BOM 模板项目的开发规范、最佳实践和标准流程。

## 1. 项目结构规范

### 1.1 目录结构标准

```
maven-template-bom/
├── .github/                 # GitHub 配置
│   ├── workflows/          # CI/CD 工作流
│   └── ISSUE_TEMPLATE/     # Issue 模板
├── .mvn/                   # Maven 配置
│   └── wrapper/           # Maven Wrapper
├── bom/                    # BOM 模块
│   └── pom.xml            # BOM 配置
├── module1/                # 核心模块
│   ├── src/
│   │   ├── main/java/      # 主代码
│   │   ├── main/resources/ # 资源文件
│   │   └── test/java/      # 测试代码
│   └── pom.xml
├── module2/                # 业务模块
│   └── (结构同 module1)
├── config/                  # 配置目录
│   ├── checkstyle/         # 代码检查配置
│   └── styleguide/        # IDE 样式配置
├── scripts/                # 脚本工具
│   ├── lib/                # 脚本库
│   └── *.sh               # 功能脚本
└── docs/                   # 项目文档
```

### 1.2 包命名规范

- **根包名**: `com.helian.项目名.模块名`
- **子包结构**:
  - `api`: 接口定义
  - `service`: 服务实现
  - `repository`: 数据访问
  - `model`: 数据模型
  - `config`: 配置类
  - `util`: 工具类
  - `exception`: 异常类

## 2. 代码编写规范

### 2.1 Java 编码规范

#### 2.1.1 基本规范
- 遵循 Google Java Style Guide
- 使用 UTF-8 编码
- 每行不超过 100 个字符
- 使用 4 个空格缩进
- 使用 Unix 行结束符 (LF)

#### 2.1.2 命名约定
```java
// 类名 - 大驼峰
public class UserService {
    
    // 常量 - 全大写+下划线
    public static final int MAX_RETRY_COUNT = 3;
    
    // 变量/方法 - 小驼峰
    private String userName;
    
    public void getUserInfo() {
        // 局部变量 - 小驼峰
        int retryCount = 0;
    }
}
```

#### 2.1.3 注释规范
- 类注释：说明类职责和使用方法
- 方法注释：使用 Javadoc 格式
- 复杂逻辑：添加必要的行内注释
- 使用英文注释，保持简洁清晰

### 2.2 异常处理规范

#### 2.2.1 异常分类
- **检查异常**: 必须处理或声明抛出
- **运行时异常**: 程序错误，需要修复代码
- **自定义异常**: 继承 RuntimeException

#### 2.2.2 异常处理原则
```java
// 好的实践
try {
    // 业务逻辑
} catch (SpecificException e) {
    log.error("具体异常处理", e);
    throw new BusinessException("业务异常", e);
} finally {
    // 资源清理
}

// 避免的做法
catch (Exception e) {
    // 过于宽泛的异常捕获
}
```

### 2.3 日志规范

#### 2.3.1 日志级别使用
- **ERROR**: 系统错误，需要立即处理
- **WARN**: 警告信息，可能的问题
- **INFO**: 重要业务流程信息
- **DEBUG**: 调试信息
- **TRACE**: 详细跟踪信息

#### 2.3.2 日志格式
```java
// 使用参数化日志
log.info("用户 {} 登录成功", userId);

// 避免字符串拼接
log.info("用户 " + userId + " 登录成功"); // 不推荐
```

## 3. 依赖管理规范

### 3.1 BOM 使用规范

#### 3.1.1 依赖声明
```xml
<!-- 在子模块中 -->
<dependencies>
    <dependency>
        <groupId>com.helian</groupId>
        <artifactId>module1</artifactId>
        <!-- 版本由 BOM 管理 -->
    </dependency>
</dependencies>
```

#### 3.1.2 版本管理原则
- 所有依赖版本在 BOM 中统一管理
- 禁止在子模块中硬编码版本号
- 定期更新依赖版本
- 使用版本范围时谨慎处理

### 3.2 依赖冲突解决

#### 3.2.1 冲突检测
```bash
# 查看依赖树
./mvnw dependency:tree

# 分析依赖冲突
./mvnw dependency:analyze-duplicate
```

#### 3.2.2 冲突解决策略
- 使用 `<exclusions>` 排除冲突依赖
- 在 BOM 中统一版本
- 使用依赖调解规则

## 4. 测试规范

### 4.1 单元测试规范

#### 4.1.1 测试结构
```java
public class UserServiceTest {
    
    @Mock
    private UserRepository userRepository;
    
    @InjectMocks
    private UserService userService;
    
    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }
    
    @Test
    void getUserById_WhenUserExists_ShouldReturnUser() {
        // Arrange
        Long userId = 1L;
        User expectedUser = new User(userId, "test");
        when(userRepository.findById(userId)).thenReturn(Optional.of(expectedUser));
        
        // Act
        User result = userService.getUserById(userId);
        
        // Assert
        assertThat(result).isEqualTo(expectedUser);
        verify(userRepository).findById(userId);
    }
}
```

#### 4.1.2 测试命名
- 测试方法名：`方法名_测试场景_预期结果`
- 测试类名：`被测试类名 + Test`
- 包结构：与主代码对应

### 4.2 集成测试规范

#### 4.2.1 测试分类
- **RepositoryTest**: 数据库集成测试
- **ServiceTest**: 服务层集成测试
- **ControllerTest**: Web 层集成测试
- **ComponentTest**: 组件集成测试

#### 4.2.2 测试配置
```java
@SpringBootTest
@ActiveProfiles("test")
@AutoConfigureMockMvc
public class UserControllerIntegrationTest {
    
    @Autowired
    private MockMvc mockMvc;
    
    @Test
    void createUser_ShouldReturnCreated() throws Exception {
        mockMvc.perform(post("/api/users")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"name\":\"test\"}"))
                .andExpect(status().isCreated());
    }
}
```

### 4.3 测试覆盖率要求

- **行覆盖率**: ≥ 70%
- **分支覆盖率**: ≥ 60%
- **方法覆盖率**: ≥ 80%

## 5. 构建与部署规范

### 5.1 Maven 生命周期

#### 5.1.1 常用命令
```bash
# 清理构建
./mvnw clean

# 编译代码
./mvnw compile

# 运行测试
./mvnw test

# 打包项目
./mvnw package

# 安装到本地仓库
./mvnw install

# 部署到远程仓库
./mvnw deploy
```

#### 5.1.2 质量检查
```bash
# 代码格式检查
./mvnw spotless:check

# 静态代码分析
./mvnw spotbugs:check

# 代码规范检查
./mvnw checkstyle:check

# 安全漏洞扫描
./mvnw dependency-check:check
```

### 5.2 CI/CD 流程

#### 5.2.1 流水线阶段
1. **代码检查**: 格式、规范、静态分析
2. **编译构建**: 编译代码和资源
3. **单元测试**: 运行单元测试并收集覆盖率
4. **集成测试**: 运行集成测试
5. **安全扫描**: 依赖漏洞检查
6. **打包部署**: 构建制品并部署

#### 5.2.2 环境配置
- **开发环境**: 本地开发
- **测试环境**: 功能测试
- **预发布环境**: 集成测试
- **生产环境**: 线上运行

## 6. 版本管理规范

### 6.1 语义化版本

格式：`主版本号.次版本号.修订号-预发布标识`

- **主版本号**: 不兼容的 API 修改
- **次版本号**: 向下兼容的功能性新增
- **修订号**: 向下兼容的问题修正
- **预发布标识**: alpha, beta, rc 等

### 6.2 分支策略

#### 6.2.1 Git Flow
```
main     - 生产版本
└── release/x.y.z - 发布分支
    └── develop   - 开发分支
        └── feature/xxx - 功能分支
        └── fix/xxx     - 修复分支
```

#### 6.2.2 提交信息规范
```
<类型>(<作用域>): <主题>

<正文>

<页脚>
```

类型：feat, fix, docs, style, refactor, test, chore

## 7. 文档规范

### 7.1 代码文档

#### 7.1.1 Javadoc 规范
```java
/**
 * 用户服务类
 * 
 * <p>提供用户相关的业务逻辑处理</p>
 * 
 * @author 作者
 * @since 1.0.0
 */
public class UserService {
    
    /**
     * 根据用户ID获取用户信息
     * 
     * @param userId 用户ID
     * @return 用户信息，如果不存在返回null
     * @throws UserNotFoundException 当用户不存在时抛出
     */
    public User getUserById(Long userId) {
        // 实现
    }
}
```

#### 7.1.2 README 文档
- 项目简介和特性
- 快速开始指南
- 环境要求和依赖
- 使用示例
- 开发指南链接

### 7.2 API 文档

#### 7.2.1 Swagger/OpenAPI
```java
@RestController
@RequestMapping("/api/users")
@Tag(name = "用户管理", description = "用户相关的API接口")
public class UserController {
    
    @Operation(summary = "获取用户列表")
    @GetMapping
    public List<User> getUsers() {
        return userService.getUsers();
    }
}
```

## 8. 安全规范

### 8.1 代码安全

#### 8.1.1 输入验证
```java
// 使用验证框架
@NotBlank
@Size(max = 50)
private String username;

// 自定义验证
public void validateInput(String input) {
    if (input == null || input.trim().isEmpty()) {
        throw new ValidationException("输入不能为空");
    }
}
```

#### 8.1.2 SQL 注入防护
```java
// 使用预编译语句
@Query("SELECT u FROM User u WHERE u.username = :username")
User findByUsername(@Param("username") String username);

// 避免字符串拼接
String sql = "SELECT * FROM users WHERE username = '" + username + "'"; // 危险！
```

### 8.2 依赖安全

#### 8.2.1 漏洞扫描
```bash
# 检查依赖漏洞
./mvnw dependency-check:check

# 更新有漏洞的依赖
./mvnw versions:use-latest-versions
```

#### 8.2.2 安全更新策略
- 定期检查依赖漏洞
- 及时更新有安全问题的依赖
- 使用可信的依赖源

## 9. 性能优化规范

### 9.1 代码性能

#### 9.1.1 避免重复计算
```java
// 好的做法
public void processData(List<Data> dataList) {
    int size = dataList.size(); // 缓存大小
    for (int i = 0; i < size; i++) {
        // 处理数据
    }
}
```

#### 9.1.2 使用合适的数据结构
```java
// 根据需求选择数据结构
Set<String> uniqueNames = new HashSet<>(); // 快速查找
List<String> orderedList = new ArrayList<>(); // 顺序访问
Map<String, User> userMap = new HashMap<>(); // 键值对
```

### 9.2 数据库性能

#### 9.2.1 查询优化
```java
// 使用分页查询
Page<User> users = userRepository.findAll(PageRequest.of(0, 20));

// 避免 N+1 查询问题
@Query("SELECT u FROM User u JOIN FETCH u.orders")
List<User> findUsersWithOrders();
```

#### 9.2.2 索引优化
- 为常用查询字段添加索引
- 避免全表扫描
- 定期分析查询性能

## 10. 监控与日志规范

### 10.1 应用监控

#### 10.1.1 健康检查
```java
@Component
public class CustomHealthIndicator implements HealthIndicator {
    
    @Override
    public Health health() {
        // 检查应用健康状态
        return Health.up().build();
    }
}
```

#### 10.1.2 性能指标
- 响应时间监控
- 错误率监控
- 吞吐量监控
- 资源使用监控

### 10.2 日志管理

#### 10.2.1 结构化日志
```java
// 使用 JSON 格式日志
log.info("{}", Map.of(
    "event", "user_login",
    "userId", userId,
    "timestamp", Instant.now()
));
```

#### 10.2.2 日志级别配置
- 生产环境: WARN+ 
- 测试环境: INFO+
- 开发环境: DEBUG+

---

## 附录

### A. 常用工具

- **IDE**: IntelliJ IDEA, Eclipse
- **构建工具**: Maven Wrapper
- **代码质量**: Checkstyle, PMD, SpotBugs
- **测试框架**: JUnit 5, Mockito, AssertJ
- **文档工具**: Swagger, Asciidoctor

### B. 参考资源

- [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- [Maven Documentation](https://maven.apache.org/guides/)
- [JUnit 5 User Guide](https://junit.org/junit5/docs/current/user-guide/)
- [Spring Boot Reference](https://docs.spring.io/spring-boot/docs/current/reference/html/)

### C. 更新记录

| 版本 | 日期 | 描述 |
|------|------|------|
| 1.0.0 | 2024-01-01 | 初始版本 |

---

*本文档会根据项目发展持续更新，请定期查看最新版本。*