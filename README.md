# Maven BOM 模板

这是一个多模块Maven项目的模板/示例，用于使用和提供物料清单(BOM)来管理项目依赖。

## 结构

    maven-template-bom
    ├── bom
    │   └── pom.xml (no parent)
    ├── module1
    │   ├── pom.xml
    │   └── src
    ├── module2
    │   ├── pom.xml
    │   └── src
    ├── pom.xml (aggregator)


该结构很简单。每个子模块都是聚合器的一部分，但是，`bom`模块不使用（也不能使用）父pom。

项目自身的版本是通过在父级/顶层导入BOM来处理的。因此，`module2`不必为其声明的对`module1`的依赖设置版本。所有内部版本都将从BOM中获取，并解析为`${project.version}`。


### 为什么要这样做

使用BOM的原因应该是显而易见的。在[依赖机制介绍](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html)中描述的方法，如果你（或你的组织）不使用"超级"父pom，这种方法是可行的。

我使用的这种设置旨在提供一个解决方案，该方案可以与用于版本操作的插件一起工作，并允许在顶层pom上使用父pom。

#### Versions插件

当使用versions插件时，处理所有模块很重要，因为`bom`模块由于没有父子关系而会被跳过。请注意，此选项仅从2.5版本开始可用。

    mvn versions:set -DnewVersion=1.1-SNAPSHOT -DprocessAllModules=true
    
### Release插件

当使用[maven-release-plugin](https://maven.apache.org/maven-release/maven-release-plugin/index.html)时，我们也希望`bom`版本能够正确滚动，这是可行的，因为我们将其添加到了聚合器的`modules`部分。

    mvn release:prepare -DdryRun=true -B

以演练模式运行`release:prepare`，并检查下一个版本和标签版本的生成的pom文件。

## 快速开始

1. 克隆项目
```bash
git clone https://github.com/helian-labs/maven-template-bom.git
cd maven-template-bom

## Trae AI
参考了 26 个上下文

# Maven 项目中 JUnit 依赖检查与替换
通过分析当前项目，我发现项目中使用的是 JUnit 4，而在父 POM 中已经配置了 JUnit 5 的依赖管理。下面我将帮您检查并替换 module 中的 JUnit 依赖。

## 当前 JUnit 依赖情况
1. 在父 POM 中已配置了 JUnit 5 (Jupiter) 的依赖管理：
   
   - org.junit.jupiter:junit-jupiter:5.9.3
   - org.junit.jupiter:junit-jupiter-api:5.9.3
   - org.junit.jupiter:junit-jupiter-engine:5.9.3
2. 但在子模块中仍然使用的是 JUnit 4：
   
   - module1 和 module2 中都依赖 junit:junit
## 替换步骤
### 1. 修改 module1 的 POM 文件
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <!-- 继承父项目配置 -->
    <parent>
        <groupId>com.helian</groupId>
        <artifactId>bom-example-project</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>

    <!-- 模块基本信息 -->
    <artifactId>module1</artifactId>
    <name>Project Module 1</name>

    <!-- 模块依赖配置 -->
    <dependencies>
        <!-- 替换为JUnit 5 -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

</project>
 ```
```

### 2. 修改 module2 的 POM 文件
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <!-- 继承父项目配置 -->
    <parent>
        <groupId>com.helian</groupId>
        <artifactId>bom-example-project</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>

    <!-- 模块基本信息 -->
    <artifactId>module2</artifactId>
    <name>Project Module 2</name>

    <!-- 模块依赖配置 -->
    <dependencies>
        <dependency>
            <groupId>com.helian</groupId>
            <artifactId>module1</artifactId>
        </dependency>
        <!-- 替换为JUnit 5 -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

</project>
 ```
```

### 3. 更新 module1 中的测试代码
```java
package com.helian;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class SpeakerTest {

    @Test
    public void speak() {
        assertNotNull(new Speaker().speak(), "He really speaks");
    }
}
 ```
```

### 4. 更新 module2 中的测试代码
```java
package com.helian;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit test for App class
 */
public class AppTest {

    /**
     * 测试App类的main方法能否正常执行
     */
    @Test
    public void testAppMain() {
        // 验证main方法能否正常执行而不抛出异常
        App.main(new String[]{});
        assertTrue(true);
    }
    
    /**
     * 测试App是否能正确使用Speaker
     */
    @Test
    public void testAppUsesSpeaker() {
        Speaker speaker = new Speaker();
        assertNotNull(speaker.speak(), "Speaker should return a message");
    }
}
 ```
```

### 5. 在 BOM 中添加 JUnit 5 依赖管理
为了确保 BOM 模块也包含 JUnit 5 的版本管理，建议在 BOM 的 POM 文件中也添加相应的依赖管理：

```xml
<!-- 在 dependencyManagement/dependencies 部分添加 -->
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>5.9.3</version>
</dependency>
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter-api</artifactId>
    <version>5.9.3</version>
</dependency>
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter-engine</artifactId>
    <version>5.9.3</version>
</dependency>
 ```

## 验证替换
完成上述修改后，您可以运行以下命令来验证替换是否成功：

```bash
cd /Users/Coder/helian-labs/maven-template-bom
./mvnw clean test
 ```

这将使用 JUnit 5 运行所有测试，确保项目能够正常构建和测试。

## 总结
1. 已将 module1 和 module2 中的 JUnit 4 依赖替换为 JUnit 5
2. 更新了测试类，使用 JUnit 5 的断言方法和注解
3. 建议在 BOM 中也添加 JUnit 5 的依赖管理
4. 提供了验证命令以确保替换成功
这样，整个项目就完成了从 JUnit 4 到 JUnit 5 的迁移。

## Qi Larry
复制

删除

Workspace 作为一名高级程序员，为这个项目提供一套更完整的配置方案。

## Trae AI
参考了 25 个上下文

Workspace

maven.yml 12-12

pom.xml 39-49

pom.xml 2-38

.gitignore 2-36

pom.xml 143-179

... 更多 ( 19 +)

# Maven BOM 项目完整配置方案
作为高级程序员，我为这个 Maven BOM 项目提供以下完整配置方案，以提升项目的质量、可维护性和构建效率。

## 1. 更新 GitHub Actions 工作流配置
当前的 GitHub Actions 配置使用了较旧版本的 actions，且构建命令可以优化。建议更新如下：

```yaml
# This workflow will build a Java project with Maven, and cache/restore any dependencies to improve the workflow execution time
# For more information see: https://help.github.com/actions/language-and-framework-guides/building-and-testing-java-with-maven

name: Java CI with Maven

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]
  # 添加定时构建，确保项目持续可构建
  schedule:
    - cron: '0 2 * * 1' # 每周一凌晨2点运行

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        java: [ '11', '17' ]
    name: Java ${{ matrix.java }} build
    
    steps:
    - uses: actions/checkout@v3
    - name: Set up JDK ${{ matrix.java }}
      uses: actions/setup-java@v3
      with:
        java-version: ${{ matrix.java }}
        distribution: 'temurin'
        cache: maven
        
    - name: Build with Maven
      run: ./mvnw clean verify -B -DprocessAllModules=true
      
    - name: Run tests with coverage
      run: ./mvnw test jacoco:report -B
      
    - name: Upload test results
      if: always()
      uses: actions/upload-artifact@v3
      with:
        name: test-results-java-${{ matrix.java }}
        path: '**/target/surefire-reports/*.xml'
        
    - name: Upload coverage report
      if: success() && matrix.java == '11'
      uses: actions/upload-artifact@v3
      with:
        name: coverage-report
        path: '**/target/site/jacoco/'
 ```
```

## 2. 完善 BOM 模块配置
BOM 模块需要添加 JUnit 5 和其他常用依赖的版本管理：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <!-- 此模块不能使用父POM，以避免版本循环依赖 -->

    <!-- 项目基本信息 -->
    <groupId>com.helian</groupId>
    <artifactId>bom</artifactId>
    <!-- 打包类型为POM，用于依赖管理 -->
    <packaging>pom</packaging>
    <version>1.0-SNAPSHOT</version>

    <!-- 项目名称 -->
    <name>Project Bill of Materials</name>

    <!-- 属性定义 -->
    <properties>
        <junit.version>5.9.3</junit.version>
        <mockito.version>5.3.1</mockito.version>
        <assertj.version>3.24.2</assertj.version>
        <slf4j.version>2.0.7</slf4j.version>
        <logback.version>1.4.8</logback.version>
    </properties>

    <!--
        版本管理说明：
        1. 使用maven-release插件或versions-maven-plugin处理所有子模块时，版本号会自动更新
        2. 使用显式版本号而不是${project.version}，以确保在发布的pom文件中正确反映版本信息
        3. 这种方式可以更好地管理项目依赖的版本一致性
    -->
    <dependencyManagement>
        <dependencies>
            <!-- 项目内部模块 -->
            <dependency>
                <groupId>com.helian</groupId>
                <artifactId>module1</artifactId>
                <version>1.0-SNAPSHOT</version>
            </dependency>
            <dependency>
                <groupId>com.helian</groupId>
                <artifactId>module2</artifactId>
                <version>1.0-SNAPSHOT</version>
            </dependency>
            
            <!-- 测试依赖 -->
            <dependency>
                <groupId>org.junit.jupiter</groupId>
                <artifactId>junit-jupiter</artifactId>
                <version>${junit.version}</version>
            </dependency>
            <dependency>
                <groupId>org.junit.jupiter</groupId>
                <artifactId>junit-jupiter-api</artifactId>
                <version>${junit.version}</version>
            </dependency>
            <dependency>
                <groupId>org.junit.jupiter</groupId>
                <artifactId>junit-jupiter-engine</artifactId>
                <version>${junit.version}</version>
            </dependency>
            <dependency>
                <groupId>org.mockito</groupId>
                <artifactId>mockito-core</artifactId>
                <version>${mockito.version}</version>
            </dependency>
            <dependency>
                <groupId>org.assertj</groupId>
                <artifactId>assertj-core</artifactId>
                <version>${assertj.version}</version>
            </dependency>
            
            <!-- 日志依赖 -->
            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>slf4j-api</artifactId>
                <version>${slf4j.version}</version>
            </dependency>
            <dependency>
                <groupId>ch.qos.logback</groupId>
                <artifactId>logback-classic</artifactId>
                <version>${logback.version}</version>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <!--
        注意：由于此模块不继承父POM，需要在此处添加其他必要的配置节点，例如：
        - distributionManagement（分发管理）
        - repositories（仓库配置）
        - 其他项目所需的配置信息
    -->
    
    <!-- 分发管理配置 -->
    <distributionManagement>
        <repository>
            <id>github</id>
            <name>GitHub Packages</name>
            <url>https://maven.pkg.github.com/helian-labs/maven-template-bom</url>
        </repository>
    </distributionManagement>

</project>
 ```
```

## 3. 更新父 POM 添加更多插件和配置
为父 POM 添加更多实用插件和配置，提升项目质量：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <!-- 项目基本信息 -->
    <groupId>com.helian</groupId>
    <artifactId>bom-example-project</artifactId>
    <packaging>pom</packaging>
    <version>1.0-SNAPSHOT</version>

    <!-- 项目模块结构 -->
    <modules>
        <!-- BOM模块：首先运行，不使用父POM但是作为聚合器的一部分 -->
        <module>bom</module>
        <!-- 模块1：使用父POM -->
        <module>module1</module>
        <!-- 模块2：使用父POM，依赖模块1 -->
        <module>module2</module>
    </modules>

    <!-- 项目基本信息 -->
    <name>Project Top Level</name>
    <description>
        Maven多模块项目，采用与Maven依赖管理介绍中描述的不同方法来使用BOM（物料清单）。
        这种方法提供了更灵活的依赖版本管理方式。
    </description>
    <url>https://github.com/helian-labs/maven-template-bom</url>

    <!-- 项目属性配置 -->
    <properties>
        <java.version>11</java.version>
        <maven.compiler.source>${java.version}</maven.compiler.source>
        <maven.compiler.target>${java.version}</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <maven.min.version>3.6.3</maven.min.version>
        <junit.version>5.9.3</junit.version>
        
        <!-- 插件版本 -->
        <jacoco.version>0.8.10</jacoco.version>
        <spotbugs.version>4.7.3.5</spotbugs.version>
        <checkstyle.version>3.3.0</checkstyle.version>
        <pmd.version>3.21.0</pmd.version>
    </properties>

    <!-- 依赖管理配置 -->
    <dependencyManagement>
        <dependencies>
            <!-- 引入BOM模块来统一管理项目版本 -->
            <dependency>
                <groupId>com.helian</groupId>
                <artifactId>bom</artifactId>
                <version>${project.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!-- 管理所有非项目制品的依赖版本 -->
            <dependency>
                <groupId>org.junit.jupiter</groupId>
                <artifactId>junit-jupiter</artifactId>
                <version>${junit.version}</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.junit.jupiter</groupId>
                <artifactId>junit-jupiter-api</artifactId>
                <version>${junit.version}</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.junit.jupiter</groupId>
                <artifactId>junit-jupiter-engine</artifactId>
                <version>${junit.version}</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.mockito</groupId>
                <artifactId>mockito-core</artifactId>
                <version>5.3.1</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.assertj</groupId>
                <artifactId>assertj-core</artifactId>
                <version>3.24.2</version>
                <scope>test</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <!-- 项目直接依赖配置 -->
    <dependencies>
        <!-- 无直接依赖！所有依赖都在子模块中声明 -->
    </dependencies>

    <!-- 构建配置管理 -->
    <build>
        <pluginManagement>
            <plugins>
                <!-- Maven编译插件配置 -->
                <plugin>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>3.11.0</version>
                    <configuration>
                        <source>${java.version}</source>
                        <target>${java.version}</target>
                        <parameters>true</parameters>
                    </configuration>
                </plugin>
                <!-- 测试插件配置 -->
                <plugin>
                    <artifactId>maven-surefire-plugin</artifactId>
                    <version>3.1.2</version>
                </plugin>
                <!-- JAR包打包插件配置 -->
                <plugin>
                    <artifactId>maven-jar-plugin</artifactId>
                    <version>3.3.0</version>
                </plugin>
                
                <!-- 在 build/pluginManagement/plugins 部分添加 -->
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-enforcer-plugin</artifactId>
                    <version>3.3.0</version>
                    <executions>
                        <execution>
                            <id>enforce-maven</id>
                            <goals>
                                <goal>enforce</goal>
                            </goals>
                            <configuration>
                                <rules>
                                    <requireMavenVersion>
                                        <version>${maven.min.version}</version>
                                    </requireMavenVersion>
                                    <requireJavaVersion>
                                        <version>${java.version}</version>
                                    </requireJavaVersion>
                                    <dependencyConvergence/>
                                </rules>
                            </configuration>
                        </execution>
                    </executions>
                </plugin>
                
                <!-- 版本管理插件 -->
                <plugin>
                    <groupId>org.codehaus.mojo</groupId>
                    <artifactId>versions-maven-plugin</artifactId>
                    <version>2.15.0</version>
                    <configuration>
                        <generateBackupPoms>false</generateBackupPoms>
                    </configuration>
                </plugin>
                
                <!-- 代码覆盖率插件 -->
                <plugin>
                    <groupId>org.jacoco</groupId>
                    <artifactId>jacoco-maven-plugin</artifactId>
                    <version>${jacoco.version}</version>
                    <executions>
                        <execution>
                            <goals>
                                <goal>prepare-agent</goal>
                            </goals>
                        </execution>
                        <execution>
                            <id>report</id>
                            <phase>test</phase>
                            <goals>
                                <goal>report</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
                
                <!-- 静态代码分析插件 -->
                <plugin>
                    <groupId>com.github.spotbugs</groupId>
                    <artifactId>spotbugs-maven-plugin</artifactId>
                    <version>${spotbugs.version}</version>
                    <configuration>
                        <effort>Max</effort>
                        <threshold>Low</threshold>
                        <xmlOutput>true</xmlOutput>
                    </configuration>
                </plugin>
                
                <!-- 代码风格检查插件 -->
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-checkstyle-plugin</artifactId>
                    <version>${checkstyle.version}</version>
                    <configuration>
                        <configLocation>google_checks.xml</configLocation>
                        <encoding>UTF-8</encoding>
                        <consoleOutput>true</consoleOutput>
                        <failsOnError>true</failsOnError>
                        <linkXRef>false</linkXRef>
                    </configuration>
                </plugin>
                
                <!-- PMD代码分析插件 -->
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-pmd-plugin</artifactId>
                    <version>${pmd.version}</version>
                    <configuration>
                        <linkXRef>false</linkXRef>
                        <sourceEncoding>UTF-8</sourceEncoding>
                        <minimumTokens>100</minimumTokens>
                        <targetJdk>${java.version}</targetJdk>
                    </configuration>
                </plugin>
                
                <!-- 源码打包插件 -->
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-source-plugin</artifactId>
                    <version>3.3.0</version>
                    <executions>
                        <execution>
                            <id>attach-sources</id>
                            <goals>
                                <goal>jar-no-fork</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
                
                <!-- Javadoc插件 -->
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-javadoc-plugin</artifactId>
                    <version>3.5.0</version>
                    <executions>
                        <execution>
                            <id>attach-javadocs</id>
                            <goals>
                                <goal>jar</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
            </plugins>
        </pluginManagement>
        
        <!-- 默认启用的插件 -->
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-enforcer-plugin</artifactId>
            </plugin>
            <plugin>
                <groupId>org.jacoco</groupId>
                <artifactId>jacoco-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
    
    <!-- 报告配置 -->
    <reporting>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-project-info-reports-plugin</artifactId>
                <version>3.4.5</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-checkstyle-plugin</artifactId>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-pmd-plugin</artifactId>
            </plugin>
            <plugin>
                <groupId>com.github.spotbugs</groupId>
                <artifactId>spotbugs-maven-plugin</artifactId>
            </plugin>
            <plugin>
                <groupId>org.jacoco</groupId>
                <artifactId>jacoco-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </reporting>

    <licenses>
        <license>
            <name>Apache License 2.0</name>
            <url>https://www.apache.org/licenses/LICENSE-2.0</url>
        </license>
    </licenses>

    <developers>
        <developer>
            <name>zhycn</name>
            <url>https://github.com/zhycn</url>
            <timezone>Asia/Shanghai</timezone>
            <roles>
                <role>developer</role>
            </roles>
        </developer>
    </developers>

    <scm>
        <url>https://github.com/helian-labs/maven-template-bom</url>
        <connection>scm:git:git@github.com:helian-labs/maven-template-bom.git</connection>
        <developerConnection>scm:git:git@github.com:helian-labs/maven-template-bom.git</developerConnection>
        <tag>HEAD</tag>
    </scm>

    <!-- 配置项目发布到Maven中央仓库 -->
    <profiles>
        <profile>
            <id>release</id>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-source-plugin</artifactId>
                    </plugin>
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-javadoc-plugin</artifactId>
                    </plugin>
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-gpg-plugin</artifactId>
                        <version>3.1.0</version>
                        <executions>
                            <execution>
                                <id>sign-artifacts</id>
                                <phase>verify</phase>
                                <goals>
                                    <goal>sign</goal>
                                </goals>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </profile>
    </profiles>
</project>
 ```
```

## 4. 添加日志配置文件
为项目添加 Logback 配置文件：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>
    
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>logs/application.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>logs/application.%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>30</maxHistory>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>
    
    <root level="INFO">
        <appender-ref ref="CONSOLE" />
        <appender-ref ref="FILE" />
    </root>
    
    <!-- 项目日志级别 -->
    <logger name="com.helian" level="DEBUG" />
</configuration>
 ```
```

## 5. 添加 Maven Wrapper 配置
更新 Maven Wrapper 配置，确保使用固定版本的 Maven：

```properties
# 指定Maven版本
distributionUrl=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.5/apache-maven-3.9.5-bin.zip
wrapperUrl=https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.2.0/maven-wrapper-3.2.0.jar
distributionSha256Sum=ca59380b839c6bade946c3e5e556af3e4ecd65af6c2a05dc21e4afe2baba2d6c
 ```
```

## 6. 完善 README.md 文档
更新项目文档，提供更详细的使用说明：

```markdown
# Maven BOM 模板

这是一个多模块Maven项目的模板/示例，用于使用和提供物料清单(BOM)来管理项目依赖。

## 项目结构

 ```
```

maven-template-bom
├── bom
│   └── pom.xml (无父pom)
├── module1
│   ├── pom.xml
│   └── src
├── module2
│   ├── pom.xml
│   └── src
├── pom.xml (聚合器)

```plaintext

该结构很简单。每个子模块都是聚合器的一部分，但是，`bom`模块不使用（也不能使用）父pom。

项目自身的版本是通过在父级/顶层导入BOM来处理的。因此，`module2`不必为其声明的对`module1`的依赖设置版本。所有内部版本都将从BOM中获取，并解析为`${project.version}`。

## 为什么要这样做

使用BOM的原因应该是显而易见的。在[依赖机制介绍](https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html)中描述的方法，如果你（或你的组织）不使用"超级"父pom，这种方法是可行的。

我使用的这种设置旨在提供一个解决方案，该方案可以与用于版本操作的插件一起工作，并允许在顶层pom上使用父pom。

### Versions插件

当使用versions插件时，处理所有模块很重要，因为`bom`模块由于没有父子关系而会被跳过。请注意，此选项仅从2.5版本开始可用。

 ```
```

mvn versions:set -DnewVersion=1.1-SNAPSHOT -DprocessAllModules=true

```plaintext

### Release插件

当使用[maven-release-plugin](https://maven.apache.org/maven-release/maven-release-plugin/index.html)时，我们也希望`bom`版本能够正确滚动，这是可行的，因为我们将其添加到了聚合器的`modules`部分。

 ```
```

mvn release:prepare -DdryRun=true -B

```plaintext

以演练模式运行`release:prepare`，并检查下一个版本和标签版本的生成的pom文件。

## 快速开始

1. 克隆项目
```bash
git clone https://github.com/helian-labs/maven-template-bom.git
cd maven-template-bom
 ```

2. 构建项目
```bash
./mvnw clean install
 ```

3. 运行测试
```bash
./mvnw test
 ```

4. 生成报告
```bash
./mvnw site
 ```

 ## 如何在其他项目中使用此BOM
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