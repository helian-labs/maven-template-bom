# 编码规范

本文档定义了 Maven BOM 模板项目的编码标准和最佳实践。

## 1. 代码风格规范

### 1.1 文件组织

#### 1.1.1 文件结构

```
src/
├── main/
│   ├── java/
│   │   └── com/helian/project/
│   │       ├── module1/
│   │       │   ├── config/       # 配置类
│   │       │   ├── service/      # 服务层
│   │       │   ├── repository/   # 数据访问层
│   │       │   ├── model/        # 数据模型
│   │       │   ├── util/         # 工具类
│   │       │   └── exception/    # 异常类
│   │       └── module2/
│   │           └── ...
│   └── resources/
│       ├── application.yml       # 主配置文件
│       ├── application-dev.yml   # 开发环境配置
│       ├── application-prod.yml  # 生产环境配置
│       └── logback-spring.xml    # 日志配置
└── test/
    ├── java/
    │   └── com/helian/project/
    │       ├── module1/
    │       │   ├── service/
    │       │   ├── repository/
    │       │   └── integration/  # 集成测试
    │       └── module2/
    │           └── ...
    └── resources/
        └── test-data/           # 测试数据
```

#### 1.1.2 包命名规范

- **根包名**: `com.helian.project`
- **模块包**: `com.helian.project.{moduleName}`
- **层级包**: 按功能划分（config, service, repository等）
- **禁止使用**: 保留关键字、特殊字符、数字开头

### 1.2 代码格式

#### 1.2.1 缩进和空格

- **缩进**: 4个空格（禁止使用Tab）
- **行长度**: 不超过120个字符
- **空行**: 方法之间空1行，逻辑块之间空1行
- **空格**: 操作符前后、逗号后、大括号前加空格

**正确示例**:
```java
public class Example {
    
    private final String name;
    
    public Example(String name) {
        this.name = name;
    }
    
    public String getName() {
        return name;
    }
    
    public void processData(List<String> dataList) {
        if (dataList == null || dataList.isEmpty()) {
            return;
        }
        
        for (String data : dataList) {
            if (isValid(data)) {
                processValidData(data);
            }
        }
    }
}
```

#### 1.2.2 大括号风格

- **K&R风格**: 左大括号不换行
- **强制使用大括号**: 即使只有一行代码

**正确示例**:
```java
if (condition) {
    doSomething();
}

for (int i = 0; i < 10; i++) {
    processItem(i);
}
```

**错误示例**:
```java
if (condition) doSomething();  // 缺少大括号

if (condition) 
    doSomething();             // 容易产生歧义
```

### 1.3 注释规范

#### 1.3.1 JavaDoc注释

- **类注释**: 描述类的作用和用法
- **方法注释**: 描述方法功能、参数、返回值、异常
- **字段注释**: 描述字段含义和约束

**示例**:
```java
/**
 * 用户服务类，提供用户相关的业务操作
 * 
 * @author Developer
 * @version 1.0
 */
@Service
public class UserService {
    
    /**
     * 用户数据访问接口
     */
    private final UserRepository userRepository;
    
    /**
     * 根据用户ID查询用户信息
     *
     * @param userId 用户ID，不能为null
     * @return 用户信息，如果不存在返回null
     * @throws IllegalArgumentException 如果userId为null
     */
    public User getUserById(Long userId) {
        if (userId == null) {
            throw new IllegalArgumentException("用户ID不能为null");
        }
        return userRepository.findById(userId);
    }
}
```

#### 1.3.2 行内注释

- **避免 obvious 注释**: 不要注释显而易见的代码
- **解释为什么**: 注释应该解释为什么这么做，而不是做什么
- **TODO/FIXME**: 使用标准标签标记待办事项

**正确示例**:
```java
// 使用二分查找提高性能，因为数据已排序
int index = Collections.binarySearch(sortedList, target);

// TODO: 需要优化数据库查询性能
// FIXME: 这里存在并发问题，需要加锁
```

## 2. 命名规范

### 2.1 通用命名规则

- **英文命名**: 使用英文单词，禁止使用拼音
- **见名知意**: 名称应该清晰表达其用途
- **避免缩写**: 除非是广泛接受的缩写（如HTTP、URL）
- **一致性**: 在整个项目中保持命名风格一致

### 2.2 具体命名规范

#### 2.2.1 包命名

- **全小写**: `com.helian.project.module1.service`
- **反向域名**: 使用公司域名反转
- **模块化**: 按功能模块划分包结构

#### 2.2.2 类/接口命名

- **PascalCase**: `UserService`, `AbstractFactory`
- **名词**: 使用名词或名词短语
- **接口**: 可以使用`I`前缀或`able`后缀（可选）

**示例**:
```java
// 服务类
public class UserService {}

// 接口
public interface UserRepository {}
public interface Runnable {}

// 抽象类
public abstract class AbstractService {}

// 异常类
public class UserNotFoundException extends RuntimeException {}
```

#### 2.2.3 方法命名

- **camelCase**: `getUserById`, `processData`
- **动词开头**: 使用动词描述操作
- **布尔方法**: 使用`is`, `has`, `can`等前缀

**示例**:
```java
// 查询方法
public User findUserById(Long id) {}
public List<User> getAllUsers() {}

// 操作方法
public void saveUser(User user) {}
public void deleteUser(Long id) {}

// 布尔方法
public boolean isUserActive(Long id) {}
public boolean hasPermission(String permission) {}
```

#### 2.2.4 变量命名

- **camelCase**: `userName`, `itemCount`
- **描述性**: 避免使用无意义的名称
- **集合变量**: 使用复数形式或说明类型

**示例**:
```java
// 好的变量名
String userName;
int itemCount;
List<User> userList;
Map<String, User> userMap;

// 不好的变量名
String str;      // 无意义
int cnt;         // 缩写不清晰
List<User> list; // 类型不明确
```

#### 2.2.5 常量命名

- **UPPER_SNAKE_CASE**: `MAX_RETRY_COUNT`, `DEFAULT_TIMEOUT`
- **static final**: 必须使用`static final`修饰
- **描述性**: 清晰表达常量的含义

**示例**:
```java
public static final int MAX_RETRY_COUNT = 3;
public static final String DEFAULT_TIMEZONE = "UTC";
public static final long CONNECTION_TIMEOUT = 5000L;
```

#### 2.2.6 枚举命名

- **PascalCase**: `UserStatus`, `ErrorCode`
- **枚举值**: 全大写，下划线分隔

**示例**:
```java
public enum UserStatus {
    ACTIVE,
    INACTIVE,
    SUSPENDED
}

public enum ErrorCode {
    USER_NOT_FOUND,
    PERMISSION_DENIED,
    INVALID_PARAMETER
}
```

## 3. 面向对象规范

### 3.1 类设计原则

#### 3.1.1 SOLID 原则

1. **单一职责原则**: 一个类只负责一个功能领域
2. **开闭原则**: 对扩展开放，对修改关闭
3. **里氏替换原则**: 子类可以替换父类
4. **接口隔离原则**: 使用多个特定接口而不是一个通用接口
5. **依赖倒置原则**: 依赖抽象而不是具体实现

#### 3.1.2 封装性

- **字段私有**: 所有字段都应该是private
- **提供访问方法**: 通过getter/setter访问字段
- **不可变对象**: 优先使用final字段和不可变集合

**示例**:
```java
// 好的封装
public class User {
    private final Long id;
    private String name;
    private final LocalDateTime createTime;
    
    public User(Long id, String name) {
        this.id = id;
        this.name = name;
        this.createTime = LocalDateTime.now();
    }
    
    public Long getId() {
        return id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public LocalDateTime getCreateTime() {
        return createTime;
    }
}
```

### 3.2 接口设计

#### 3.2.1 接口命名

- 使用形容词描述能力: `Runnable`, `Serializable`
- 或者使用名词描述角色: `UserRepository`, `PaymentService`

#### 3.2.2 接口方法

- 定义明确的行为契约
- 避免过于庞大的接口
- 使用默认方法提供基础实现

**示例**:
```java
public interface UserRepository {
    
    User findById(Long id);
    
    List<User> findAll();
    
    User save(User user);
    
    void deleteById(Long id);
    
    default boolean existsById(Long id) {
        return findById(id) != null;
    }
}
```

### 3.3 继承与组合

#### 3.3.1 优先使用组合

- **组合优于继承**: 使用组合来实现代码复用
- **谨慎使用继承**: 只有在确实是"is-a"关系时才使用继承

**示例**:
```java
// 使用组合
public class OrderService {
    private final PaymentService paymentService;
    private final NotificationService notificationService;
    
    public OrderService(PaymentService paymentService, 
                       NotificationService notificationService) {
        this.paymentService = paymentService;
        this.notificationService = notificationService;
    }
}

// 谨慎使用继承
public abstract class AbstractService {
    protected final Logger logger = LoggerFactory.getLogger(getClass());
    
    protected void logError(String message, Throwable cause) {
        logger.error(message, cause);
    }
}

public class UserService extends AbstractService {
    // 可以使用父类的logger
}
```

## 4. 异常处理规范

### 4.1 异常分类

#### 4.1.1 检查异常 vs 非检查异常

- **检查异常**: 必须捕获或声明抛出的异常（IOException等）
- **非检查异常**: RuntimeException及其子类
- **错误**: Error及其子类，通常不捕获

#### 4.1.2 业务异常

- 定义明确的业务异常层次结构
- 提供有意义的错误信息和错误码

**示例**:
```java
// 业务异常基类
public abstract class BusinessException extends RuntimeException {
    private final String errorCode;
    
    protected BusinessException(String errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
    }
    
    public String getErrorCode() {
        return errorCode;
    }
}

// 具体的业务异常
public class UserNotFoundException extends BusinessException {
    public UserNotFoundException(Long userId) {
        super("USER_NOT_FOUND", "用户不存在: " + userId);
    }
}

public class PermissionDeniedException extends BusinessException {
    public PermissionDeniedException(String permission) {
        super("PERMISSION_DENIED", "权限不足: " + permission);
    }
}
```

### 4.2 异常处理最佳实践

#### 4.2.1 不要捕获通用异常

**错误示例**:
```java
try {
    // 业务代码
} catch (Exception e) {
    // 捕获所有异常，难以调试
}
```

#### 4.2.2 提供有意义的错误信息

**正确示例**:
```java
try {
    userRepository.save(user);
} catch (DataAccessException e) {
    throw new BusinessException("SAVE_USER_FAILED", 
        "保存用户失败: " + user.getName(), e);
}
```

#### 4.2.3 使用 try-with-resources

**正确示例**:
```java
try (FileInputStream input = new FileInputStream("file.txt");
     BufferedReader reader = new BufferedReader(new InputStreamReader(input))) {
    String line;
    while ((line = reader.readLine()) != null) {
        processLine(line);
    }
} catch (IOException e) {
    throw new BusinessException("FILE_READ_ERROR", "读取文件失败", e);
}
```

## 5. 集合使用规范

### 5.1 集合初始化

#### 5.1.1 使用钻石操作符

**正确示例**:
```java
// Java 7+ 使用钻石操作符
List<String> names = new ArrayList<>();
Map<String, User> userMap = new HashMap<>();

// 指定初始容量（如果知道大概大小）
List<User> userList = new ArrayList<>(100);
Map<String, Integer> countMap = new HashMap<>(50);
```

#### 5.1.2 使用工具方法初始化

**正确示例**:
```java
// 使用Arrays.asList初始化小列表
List<String> fixedList = Arrays.asList("a", "b", "c");

// 使用List.of（Java 9+）
List<String> immutableList = List.of("a", "b", "c");

// 使用Set.of
Set<String> immutableSet = Set.of("a", "b", "c");

// 使用Map.of
Map<String, Integer> immutableMap = Map.of("a", 1, "b", 2);
```

### 5.2 集合遍历

#### 5.2.1 使用增强for循环

**正确示例**:
```java
for (String name : nameList) {
    processName(name);
}

for (Map.Entry<String, User> entry : userMap.entrySet()) {
    processUser(entry.getKey(), entry.getValue());
}
```

#### 5.2.2 使用Stream API（Java 8+）

**正确示例**:
```java
// 过滤和转换
List<String> activeUserNames = userList.stream()
    .filter(User::isActive)
    .map(User::getName)
    .collect(Collectors.toList());

// 分组
Map<Department, List<User>> usersByDept = userList.stream()
    .collect(Collectors.groupingBy(User::getDepartment));

// 统计
long activeUserCount = userList.stream()
    .filter(User::isActive)
    .count();
```

### 5.3 不可变集合

#### 5.3.1 使用不可变集合

**正确示例**:
```java
// 创建不可变集合
List<String> immutableList = Collections.unmodifiableList(new ArrayList<>(originalList));
Set<String> immutableSet = Collections.unmodifiableSet(new HashSet<>(originalSet));
Map<String, User> immutableMap = Collections.unmodifiableMap(new HashMap<>(originalMap));

// Java 9+ 使用工厂方法
List<String> immutableList = List.of("a", "b", "c");
Set<String> immutableSet = Set.of("a", "b", "c");
Map<String, Integer> immutableMap = Map.of("a", 1, "b", 2);
```

## 6. 并发编程规范

### 6.1 线程安全

#### 6.1.1 使用并发集合

**正确示例**:
```java
// 使用并发集合
Map<String, User> userCache = new ConcurrentHashMap<>();
List<String> sharedList = Collections.synchronizedList(new ArrayList<>());

// 使用CopyOnWriteArrayList用于读多写少的场景
List<String> eventListeners = new CopyOnWriteArrayList<>();
```

#### 6.1.2 使用原子类

**正确示例**:
```java
// 使用原子类进行计数器操作
private final AtomicInteger counter = new AtomicInteger(0);

public int increment() {
    return counter.incrementAndGet();
}

public int getCount() {
    return counter.get();
}
```

### 6.2 线程池使用

#### 6.2.1 使用ExecutorService

**正确示例**:
```java
// 创建线程池
ExecutorService executor = Executors.newFixedThreadPool(10);

// 提交任务
Future<String> future = executor.submit(() -> {
    return processData(data);
});

// 优雅关闭
executor.shutdown();
try {
    if (!executor.awaitTermination(60, TimeUnit.SECONDS)) {
        executor.shutdownNow();
    }
} catch (InterruptedException e) {
    executor.shutdownNow();
    Thread.currentThread().interrupt();
}
```

#### 6.2.2 使用CompletableFuture（Java 8+）

**正确示例**:
```java
// 异步执行
CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> {
    return processData(data);
}, executor);

// 组合多个异步任务
CompletableFuture<String> combinedFuture = future1
    .thenCombine(future2, (result1, result2) -> result1 + result2)
    .exceptionally(ex -> {
        log.error("处理失败", ex);
        return "default";
    });
```

## 7. 资源管理规范

### 7.1 IO资源管理

#### 7.1.1 使用try-with-resources

**正确示例**:
```java
// 自动关闭资源
try (FileInputStream fis = new FileInputStream("file.txt");
     BufferedReader reader = new BufferedReader(new InputStreamReader(fis))) {
    String line;
    while ((line = reader.readLine()) != null) {
        processLine(line);
    }
} catch (IOException e) {
    throw new BusinessException("FILE_READ_ERROR", "读取文件失败", e);
}
```

### 7.2 数据库连接管理

#### 7.2.1 使用连接池

**正确示例**:
```java
// 配置连接池
@Bean
public DataSource dataSource() {
    HikariConfig config = new HikariConfig();
    config.setJdbcUrl("jdbc:mysql://localhost:3306/mydb");
    config.setUsername("user");
    config.setPassword("password");
    config.setMaximumPoolSize(10);
    config.setMinimumIdle(5);
    return new HikariDataSource(config);
}
```

## 8. 测试规范

### 8.1 单元测试规范

#### 8.1.1 测试类命名

- **测试类**: `被测试类名 + Test`，如`UserServiceTest`
- **测试方法**: `被测试方法名 + 测试场景 + 预期结果`，如`getUserById_withValidId_returnsUser`

#### 8.1.2 测试结构

**正确示例**:
```java
class UserServiceTest {
    
    @Mock
    private UserRepository userRepository;
    
    @InjectMocks
    private UserService userService;
    
    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }
    
    @Test
    void getUserById_withValidId_returnsUser() {
        // Arrange
        Long userId = 1L;
        User expectedUser = new User(userId, "testUser");
        when(userRepository.findById(userId)).thenReturn(expectedUser);
        
        // Act
        User result = userService.getUserById(userId);
        
        // Assert
        assertThat(result).isEqualTo(expectedUser);
        verify(userRepository).findById(userId);
    }
    
    @Test
    void getUserById_withNullId_throwsException() {
        // Arrange
        Long userId = null;
        
        // Act & Assert
        assertThatThrownBy(() -> userService.getUserById(userId))
            .isInstanceOf(IllegalArgumentException.class)
            .hasMessage("用户ID不能为null");
        
        verifyNoInteractions(userRepository);
    }
}
```

### 8.2 集成测试规范

#### 8.2.1 测试类命名

- **集成测试**: `被测试类名 + IT`，如`UserServiceIT`

#### 8.2.2 使用Testcontainers

**正确示例**:
```java
@SpringBootTest
@Testcontainers
class UserServiceIT {
    
    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:13");
    
    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
    }
    
    @Test
    void testUserPersistence() {
        // 测试数据库操作
    }
}
```

## 9. 日志规范

### 9.1 日志级别使用

#### 9.1.1 正确使用日志级别

- **ERROR**: 系统错误，需要立即处理
- **WARN**: 警告信息，可能有问题但不影响系统运行
- **INFO**: 重要的业务操作信息
- **DEBUG**: 调试信息，开发时使用
- **TRACE**: 非常详细的调试信息

**正确示例**:
```java
public class UserService {
    private static final Logger logger = LoggerFactory.getLogger(UserService.class);
    
    public User getUserById(Long userId) {
        logger.debug("根据ID查询用户: {}", userId);
        
        try {
            User user = userRepository.findById(userId);
            if (user == null) {
                logger.warn("用户不存在: {}", userId);
                throw new UserNotFoundException(userId);
            }
            
            logger.info("成功查询用户: {}, {}", userId, user.getName());
            return user;
            
        } catch (DataAccessException e) {
            logger.error("数据库查询失败: {}", userId, e);
            throw new BusinessException("DB_QUERY_ERROR", "数据库查询失败", e);
        }
    }
}
```

### 9.2 日志格式

#### 9.2.1 使用参数化日志

**正确示例**:
```java
// 使用参数化日志，避免字符串拼接
logger.debug("Processing user: {}, age: {}", userName, userAge);

// 错误示例：字符串拼接
logger.debug("Processing user: " + userName + ", age: " + userAge);
```

## 10. 安全编码规范

### 10.1 输入验证

#### 10.1.1 验证所有输入

**正确示例**:
```java
public User createUser(UserCreateRequest request) {
    // 验证输入
    if (request == null) {
        throw new IllegalArgumentException("请求不能为null");
    }
    
    if (StringUtils.isBlank(request.getUsername())) {
        throw new IllegalArgumentException("用户名不能为空");
    }
    
    if (request.getUsername().length() > 50) {
        throw new IllegalArgumentException("用户名长度不能超过50");
    }
    
    // 防止SQL注入
    if (!isValidInput(request.getUsername())) {
        throw new IllegalArgumentException("用户名包含非法字符");
    }
    
    // 业务逻辑
    User user = new User();
    user.setUsername(request.getUsername().trim());
    return userRepository.save(user);
}

private boolean isValidInput(String input) {
    // 使用白名单验证
    return input.matches("^[a-zA-Z0-9_\-\.@]+$");
}
```

### 10.2 密码安全

#### 10.2.1 使用BCrypt加密

**正确示例**:
```java
public class PasswordService {
    
    private static final int BCRYPT_STRENGTH = 12;
    
    public String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_STRENGTH));
    }
    
    public boolean verifyPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
```

## 11. 性能优化规范

### 11.1 字符串操作

#### 11.1.1 使用StringBuilder

**正确示例**:
```java
// 使用StringBuilder进行字符串拼接
public String buildMessage(List<String> parts) {
    StringBuilder builder = new StringBuilder();
    for (String part : parts) {
        builder.append(part).append(", ");
    }
    
    if (builder.length() > 0) {
        builder.setLength(builder.length() - 2); // 移除最后的", "
    }
    
    return builder.toString();
}

// 错误示例：使用+操作符拼接
String result = "";
for (String part : parts) {
    result += part + ", ";  // 创建多个临时字符串
}
```

### 11.2 避免不必要的对象创建

#### 11.2.1 重用对象

**正确示例**:
```java
// 重用SimpleDateFormat（注意线程安全）
private static final ThreadLocal<SimpleDateFormat> DATE_FORMAT = 
    ThreadLocal.withInitial(() -> new SimpleDateFormat("yyyy-MM-dd"));

public String formatDate(Date date) {
    return DATE_FORMAT.get().format(date);
}

// 错误示例：每次创建新对象
public String formatDate(Date date) {
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); // 频繁创建对象
    return format.format(date);
}
```

## 12. 代码审查清单

### 12.1 通用审查项

- [ ] 代码是否符合编码规范
- [ ] 命名是否清晰有意义
- [ ] 注释是否充分且准确
- [ ] 异常处理是否恰当
- [ ] 测试覆盖是否充分
- [ ] 性能考虑是否周到
- [ ] 安全风险是否处理
- [ ] 代码是否可读可维护

### 12.2 技术特定审查项

#### 12.2.1 Java特定

- [ ] 是否使用了合适的集合类型
- [ ] 是否正确处理了并发问题
- [ ] 资源是否正确关闭
- [ ] 是否避免了内存泄漏
- [ ] 是否使用了最新的语言特性

#### 12.2.2 Spring特定

- [ ] 依赖注入使用是否恰当
- [ ] 事务管理是否正确
- [ ] AOP配置是否合理
- [ ] 配置管理是否清晰

---

## 附录：代码规范检查工具配置

### Checkstyle 配置

项目已集成Checkstyle，使用Google Java Style规则：

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-checkstyle-plugin</artifactId>
    <version>3.2.0</version>
    <configuration>
        <configLocation>google_checks.xml</configLocation>
        <encoding>UTF-8</encoding>
        <consoleOutput>true</consoleOutput>
        <failsOnError>true</failsOnError>
        <linkXRef>false</linkXRef>
    </configuration>
    <executions>
        <execution>
            <phase>verify</phase>
            <goals>
                <goal>check</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

### 代码格式化

推荐使用IDE的代码格式化功能：

- **IntelliJ IDEA**: 使用Google Java Style方案
- **Eclipse**: 使用Google Java Format插件
- **VS Code**: 使用Google Java Format扩展

*本文档将持续更新以反映编码最佳实践的演进。*