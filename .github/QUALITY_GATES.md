# 质量门禁配置

本文档定义了项目的质量门禁标准，确保代码质量符合企业级要求。

## 1. 代码质量门禁

### 1.1 静态代码分析

#### 1.1.1 Checkstyle 规则
```xml
<!-- 配置在 pom.xml 中 -->
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-checkstyle-plugin</artifactId>
    <configuration>
        <configLocation>config/checkstyle/google_checks.xml</configLocation>
        <includeTestSourceDirectory>true</includeTestSourceDirectory>
        <failOnViolation>true</failOnViolation>
        <violationSeverity>warning</violationSeverity>
    </configuration>
</plugin>
```

**通过标准**:
- 零错误（Error）级别违规
- 警告（Warning）级别违规 ≤ 10
- 信息（Info）级别违规 ≤ 20

#### 1.1.2 PMD 规则
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-pmd-plugin</artifactId>
    <configuration>
        <rulesets>
            <ruleset>category/java/bestpractices.xml</ruleset>
            <ruleset>category/java/codestyle.xml</ruleset>
            <ruleset>category/java/design.xml</ruleset>
            <ruleset>category/java/errorprone.xml</ruleset>
            <ruleset>category/java/performance.xml</ruleset>
            <ruleset>category/java/security.xml</ruleset>
        </rulesets>
        <failOnViolation>true</failOnViolation>
    </configuration>
</plugin>
```

**通过标准**:
- 零错误级别违规
- 高优先级违规 ≤ 5
- 中优先级违规 ≤ 10

#### 1.1.3 SpotBugs 规则
```xml
<plugin>
    <groupId>com.github.spotbugs</groupId>
    <artifactId>spotbugs-maven-plugin</artifactId>
    <configuration>
        <effort>Max</effort>
        <threshold>Low</threshold>
        <failOnError>true</failOnError>
    </configuration>
</plugin>
```

**通过标准**:
- 零错误级别Bug
- 高危级别Bug ≤ 3
- 中危级别Bug ≤ 8

### 1.2 代码复杂度

#### 1.2.1 Cyclomatic Complexity
```xml
<plugin>
    <groupId>org.codehaus.mojo</groupId>
    <artifactId>complexity-maven-plugin</artifactId>
    <configuration>
        <failOnError>true</failOnError>
        <maxMethodComplexity>10</maxMethodComplexity>
        <maxClassComplexity>50</maxClassComplexity>
    </configuration>
</plugin>
```

**通过标准**:
- 方法圈复杂度 ≤ 10
- 类圈复杂度 ≤ 50
- 文件圈复杂度 ≤ 100

#### 1.2.2 代码重复率
```xml
<plugin>
    <groupId>org.codehaus.mojo</groupId>
    <artifactId>jdepend-maven-plugin</artifactId>
    <configuration>
        <failOnError>true</failOnError>
        <maxDuplicateLines>5</maxDuplicateLines>
    </configuration>
</plugin>
```

**通过标准**:
- 重复代码行数 ≤ 5%
- 重复代码块 ≤ 3%

## 2. 测试质量门禁

### 2.1 测试覆盖率

#### 2.1.1 JaCoCo 配置
```xml
<plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <configuration>
        <rules>
            <rule>
                <element>BUNDLE</element>
                <limits>
                    <limit>
                        <counter>LINE</counter>
                        <value>COVEREDRATIO</value>
                        <minimum>0.70</minimum>
                    </limit>
                    <limit>
                        <counter>BRANCH</counter>
                        <value>COVEREDRATIO</value>
                        <minimum>0.60</minimum>
                    </limit>
                </limits>
            </rule>
        </rules>
    </configuration>
</plugin>
```

**通过标准**:
- 行覆盖率 ≥ 70%
- 分支覆盖率 ≥ 60%
- 方法覆盖率 ≥ 80%
- 类覆盖率 ≥ 90%

#### 2.1.2 单元测试要求
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <configuration>
        <failIfNoTests>true</failIfNoTests>
        <failOnFailure>true</failOnFailure>
        <skipTests>false</skipTests>
    </configuration>
</plugin>
```

**通过标准**:
- 单元测试通过率 100%
- 无跳过的测试用例
- 测试执行时间合理

### 2.2 集成测试

#### 2.2.1 集成测试配置
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-failsafe-plugin</artifactId>
    <configuration>
        <failIfNoTests>true</failIfNoTests>
        <failOnFailure>true</failOnFailure>
        <skipTests>false</skipTests>
    </configuration>
</plugin>
```

**通过标准**:
- 集成测试通过率 100%
- 关键业务流程覆盖完整
- API 接口测试覆盖全面

## 3. 安全质量门禁

### 3.1 依赖安全扫描

#### 3.1.1 OWASP Dependency-Check
```xml
<plugin>
    <groupId>org.owasp</groupId>
    <artifactId>dependency-check-maven</artifactId>
    <configuration>
        <failBuildOnCVSS>7</failBuildOnCVSS>
        <suppressionFiles>
            <suppressionFile>config/security/dependency-check-suppressions.xml</suppressionFile>
        </suppressionFiles>
    </configuration>
</plugin>
```

**通过标准**:
- CVSS 评分 ≥ 7 的漏洞：零容忍
- CVSS 评分 4-7 的漏洞：≤ 3个
- 所有高危漏洞必须修复或抑制

#### 3.1.2 安全抑制策略
```xml
<!-- dependency-check-suppressions.xml -->
<suppressions>
    <suppress>
        <notes>False positive, not actually vulnerable</notes>
        <cve>CVE-2023-12345</cve>
    </suppress>
</suppressions>
```

**要求**:
- 每个抑制必须有详细说明
- 定期审查抑制条目
- 抑制时间不超过90天

### 3.2 代码安全扫描

#### 3.2.1 SonarQube 安全规则
```properties
# sonar-project.properties
sonar.security=high
sonar.security.review=required
```

**通过标准**:
- 零高危安全漏洞
- 中危安全漏洞 ≤ 5
- 安全热点必须审查

## 4. 构建质量门禁

### 4.1 构建稳定性

#### 4.1.1 Maven Enforcer 规则
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-enforcer-plugin</artifactId>
    <configuration>
        <rules>
            <requireMavenVersion>
                <version>3.6.3</version>
            </requireMavenVersion>
            <requireJavaVersion>
                <version>17</version>
            </requireJavaVersion>
            <dependencyConvergence/>
            <banDuplicatePomDependencies/>
            <requireReleaseDeps/>
        </rules>
    </configuration>
</plugin>
```

**通过标准**:
- Maven 版本 ≥ 3.6.3
- Java 版本 = 17
- 无依赖冲突
- 无重复依赖
- 禁止使用 SNAPSHOT 依赖（开发期除外）

### 4.2 构建性能

#### 4.2.1 构建时间要求
```bash
# 本地构建时间
./mvnw clean install -T 1C < 5分钟

# CI 构建时间
./mvnw clean verify -T 2C < 10分钟
```

**通过标准**:
- 本地完整构建 < 5分钟
- CI 完整构建 < 10分钟
- 增量构建 < 2分钟

## 5. 文档质量门禁

### 5.1 API 文档

#### 5.1.1 Swagger/OpenAPI 规范
```xml
<plugin>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-maven-plugin</artifactId>
    <configuration>
        <apiDocsUrl>http://localhost:8080/v3/api-docs</apiDocsUrl>
        <outputDir>${project.build.directory}/api-docs</outputDir>
        <failOnError>true</failOnError>
    </configuration>
</plugin>
```

**通过标准**:
- API 文档覆盖率 ≥ 95%
- 参数描述完整
- 响应示例齐全
- 错误码定义清晰

### 5.2 Javadoc 覆盖率

#### 5.2.1 Javadoc 检查
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-javadoc-plugin</artifactId>
    <configuration>
        <failOnError>true</failOnError>
        <detectJavaApiLink>true</detectJavaApiLink>
    </configuration>
</plugin>
```

**通过标准**:
- 公共类和方法 Javadoc 覆盖率 ≥ 90%
- 参数和返回值文档完整
- 无 broken link

## 6. 发布质量门禁

### 6.1 版本发布检查

#### 6.1.1 版本号规范
```bash
# 版本格式: 主版本.次版本.修订号-预发布标识
# 示例: 1.2.3, 2.0.0-RC1, 3.1.0-SNAPSHOT
```

**要求**:
- 遵循语义化版本规范
- 发布版本不能包含 SNAPSHOT
- 预发布版本明确标识

### 6.2 制品检查

#### 6.2.1 制品签名验证
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-gpg-plugin</artifactId>
    <configuration>
        <skip>false</skip>
        <passphrase>${gpg.passphrase}</passphrase>
    </configuration>
</plugin>
```

**要求**:
- 所有发布制品必须签名
- 签名密钥安全存储
- 签名验证通过

## 7. CI/CD 集成

### 7.1 GitHub Actions 配置

#### 7.1.1 质量门禁工作流
```yaml
# .github/workflows/quality-gates.yml
name: Quality Gates

on:
  pull_request:
    branches: [ main, develop ]
  push:
    branches: [ main ]

jobs:
  quality-gates:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Set up JDK 17
      uses: actions/setup-java@v3
      with:
        java-version: '17'
        distribution: 'temurin'
    - name: Run Quality Gates
      run: ./mvnw verify -P quality
    - name: Check Test Coverage
      run: ./mvnw jacoco:check
    - name: Security Scan
      run: ./mvnw dependency-check:check
```

### 7.2 门禁失败处理

#### 7.2.1 失败策略
- **阻断性失败**: 阻止合并/发布
- **警告性失败**: 允许合并但需要记录
- **信息性失败**: 仅提供信息，不影响流程

## 8. 监控与报告

### 8.1 质量指标监控

#### 8.1.1 SonarQube 仪表盘
```properties
# 关键质量指标
- 代码重复率
- 测试覆盖率
- 技术债务
- 安全评级
- 可靠性评级
- 维护性评级
```

### 8.2 质量趋势分析

#### 8.2.1 历史数据对比
- 每周质量指标变化
- 每月技术债务变化
- 季度安全态势分析

## 9. 豁免流程

### 9.1 临时豁免申请

**申请条件**:
- 紧急修复需要
- 第三方依赖限制
- 技术可行性问题

**审批流程**:
1. 提交豁免申请说明
2. 技术负责人审批
3. 记录豁免原因和时间
4. 制定整改计划

### 9.2 永久豁免

**条件**:
- 架构限制
- 性能权衡
- 业务特殊要求

**要求**:
- 团队共识
- 文档记录
- 定期复审

---

## 附录：质量门禁检查表

### 代码提交前检查
- [ ] 代码格式化检查（spotless:check）
- [ ] 单元测试通过
- [ ] 静态代码分析
- [ ] 代码复杂度检查
- [ ] 重复代码检查

### PR 合并前检查
- [ ] 集成测试通过
- [ ] 测试覆盖率达标
- [ ] 安全扫描通过
- [ ] 文档更新完整
- [ ] 代码审查通过

### 发布前检查
- [ ] 所有质量门禁通过
- [ ] 版本号规范
- [ ] 制品签名验证
- [ ] 变更日志更新

*本文档会根据项目发展和最佳实践持续更新，请定期查看最新版本。*