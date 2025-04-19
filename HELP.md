# 项目帮助文档

此文档包含项目中使用的主要插件的链接和简要说明。

## 插件列表

### Maven Compiler Plugin

用于编译Java代码。

- 文档链接: [Maven Compiler Plugin](https://maven.apache.org/plugins/maven-compiler-plugin/)
- 常用命令:

  ```bash
  mvn compiler:compile  # 编译主代码
  mvn compiler:testCompile  # 编译测试代码
  ```

- 配置示例:

  ```xml
  <plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.10.1</version>
    <configuration>
      <source>17</source>
      <target>17</target>
      <encoding>UTF-8</encoding>
    </configuration>
  </plugin>
  ```

### Maven Surefire Plugin

用于运行单元测试。

- 文档链接: [Maven Surefire Plugin](https://maven.apache.org/surefire/maven-surefire-plugin/)
- 常用命令:

  ```bash
  mvn test  # 运行所有测试
  mvn test -Dtest=TestClass  # 运行特定测试类
  ```

- 配置示例:

  ```xml
  <plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>3.0.0</version>
    <configuration>
      <includes>
        <include>**/*Test.java</include>
      </includes>
      <excludes>
        <exclude>**/*IntegrationTest.java</exclude>
      </excludes>
    </configuration>
  </plugin>
  ```

### Maven Enforcer Plugin

用于强制执行项目的构建规则。

- 文档链接: [Maven Enforcer Plugin](https://maven.apache.org/enforcer/maven-enforcer-plugin/)
- 常用命令:

  ```bash
  mvn enforcer:enforce  # 执行规则检查
  ```

- 配置示例:

  ```xml
  <plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-enforcer-plugin</artifactId>
    <version>3.2.1</version>
    <executions>
      <execution>
        <id>enforce-rules</id>
        <goals>
          <goal>enforce</goal>
        </goals>
        <configuration>
          <rules>
            <requireMavenVersion>
              <version>[3.8.0,)</version>
            </requireMavenVersion>
            <requireJavaVersion>
              <version>[17,)</version>
            </requireJavaVersion>
            <bannedDependencies>
              <excludes>
                <exclude>commons-logging:commons-logging</exclude>
              </excludes>
            </bannedDependencies>
          </rules>
        </configuration>
      </execution>
    </executions>
  </plugin>
  ```

### Jacoco Maven Plugin

用于生成代码覆盖率报告。

- 文档链接: [Jacoco Maven Plugin](https://www.jacoco.org/jacoco/trunk/doc/maven.html)
- 常用命令:

  ```bash
  mvn jacoco:prepare-agent test jacoco:report  # 生成覆盖率报告
  ```

- 配置示例:

  ```xml
  <plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.8.8</version>
    <executions>
      <execution>
        <id>prepare-agent</id>
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
      <execution>
        <id>check</id>
        <goals>
          <goal>check</goal>
        </goals>
        <configuration>
          <rules>
            <rule>
              <element>BUNDLE</element>
              <limits>
                <limit>
                  <counter>LINE</counter>
                  <value>COVEREDRATIO</value>
                  <minimum>0.80</minimum>
                </limit>
              </limits>
            </rule>
          </rules>
        </configuration>
      </execution>
    </executions>
  </plugin>
  ```

### Maven Source Plugin

用于生成项目的源码包。

- 文档链接: [Maven Source Plugin](https://maven.apache.org/plugins/maven-source-plugin/)
- 常用命令:

  ```bash
  mvn source:jar  # 生成源码jar包
  ```

- 配置示例:

  ```xml
  <plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-source-plugin</artifactId>
    <version>3.2.1</version>
    <executions>
      <execution>
        <id>attach-sources</id>
        <phase>verify</phase>
        <goals>
          <goal>jar-no-fork</goal>
        </goals>
      </execution>
    </executions>
  </plugin>
  ```

### Maven Javadoc Plugin

用于生成项目的Javadoc文档。

- 文档链接: [Maven Javadoc Plugin](https://maven.apache.org/plugins/maven-javadoc-plugin/)
- 常用命令:

  ```bash
  mvn javadoc:javadoc  # 生成Javadoc
  mvn javadoc:jar      # 生成Javadoc jar包
  ```

- 配置示例:

  ```xml
  <plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-javadoc-plugin</artifactId>
    <version>3.4.1</version>
    <configuration>
      <encoding>UTF-8</encoding>
      <doclint>none</doclint>
    </configuration>
    <executions>
      <execution>
        <id>attach-javadocs</id>
        <goals>
          <goal>jar</goal>
        </goals>
      </execution>
    </executions>
  </plugin>
  ```

### Spotbugs Maven Plugin

用于静态代码分析。

- 文档链接: [Spotbugs Maven Plugin](https://spotbugs.github.io/spotbugs-maven-plugin/)
- 常用命令:

  ```bash
  mvn spotbugs:check  # 检查代码
  mvn spotbugs:gui    # 启动GUI界面
  ```

- 配置示例:

  ```xml
  <plugin>
    <groupId>com.github.spotbugs</groupId>
    <artifactId>spotbugs-maven-plugin</artifactId>
    <version>4.7.3.0</version>
    <configuration>
      <effort>Max</effort>
      <threshold>Medium</threshold>
      <xmlOutput>true</xmlOutput>
      <excludeFilterFile>${project.basedir}/spotbugs-exclude.xml</excludeFilterFile>
    </configuration>
    <executions>
      <execution>
        <goals>
          <goal>check</goal>
        </goals>
      </execution>
    </executions>
  </plugin>
  ```

### Maven PMD Plugin

用于代码质量检查。

- 文档链接: [Maven PMD Plugin](https://maven.apache.org/plugins/maven-pmd-plugin/)
- 常用命令:

  ```bash
  mvn pmd:check       # 检查代码
  mvn pmd:cpd-check   # 检查重复代码
  ```

- 配置示例:

  ```xml
  <plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-pmd-plugin</artifactId>
    <version>3.19.0</version>
    <configuration>
      <linkXRef>false</linkXRef>
      <sourceEncoding>UTF-8</sourceEncoding>
      <minimumTokens>100</minimumTokens>
      <targetJdk>17</targetJdk>
      <excludes>
        <exclude>**/generated/*.java</exclude>
      </excludes>
      <rulesets>
        <ruleset>/category/java/bestpractices.xml</ruleset>
      </rulesets>
    </configuration>
  </plugin>
  ```

### Maven Checkstyle Plugin

用于代码风格检查。

- 文档链接: [Maven Checkstyle Plugin](https://maven.apache.org/plugins/maven-checkstyle-plugin/)
- 常用命令:

  ```bash
  mvn checkstyle:check  # 检查代码风格
  ```

- 配置示例:

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
        <id>validate</id>
        <phase>validate</phase>
        <goals>
          <goal>check</goal>
        </goals>
      </execution>
    </executions>
  </plugin>
  ```

### Spotless Maven Plugin

用于代码格式化。

- 文档链接: [Spotless Maven Plugin](https://github.com/diffplug/spotless/tree/main/plugin-maven)
- 常用命令:

  ```bash
  mvn spotless:check  # 检查代码格式
  mvn spotless:apply  # 自动格式化代码
  ```

- 配置示例:

  ```xml
  <plugin>
    <groupId>com.diffplug.spotless</groupId>
    <artifactId>spotless-maven-plugin</artifactId>
    <version>2.30.0</version>
    <configuration>
      <java>
        <googleJavaFormat>
          <version>1.15.0</version>
          <style>GOOGLE</style>
        </googleJavaFormat>
        <removeUnusedImports />
        <importOrder>
          <order>java,javax,org,com,</order>
        </importOrder>
      </java>
      <formats>
        <format>
          <includes>
            <include>*.md</include>
            <include>.gitignore</include>
          </includes>
          <trimTrailingWhitespace />
          <endWithNewline />
        </format>
      </formats>
    </configuration>
  </plugin>
  ```

### Versions Maven Plugin

用于管理项目依赖版本。

- 文档链接: [Versions Maven Plugin](https://www.mojohaus.org/versions-maven-plugin/)
- 常用命令:

  ```bash
  mvn versions:display-dependency-updates  # 显示依赖更新
  mvn versions:use-latest-versions        # 更新依赖到最新版本
  mvn versions:set -DnewVersion=1.0.1     # 设置项目版本
  ```

- 配置示例:

  ```xml
  <plugin>
    <groupId>org.codehaus.mojo</groupId>
    <artifactId>versions-maven-plugin</artifactId>
    <version>2.13.0</version>
    <configuration>
      <rulesUri>file://${project.basedir}/version-rules.xml</rulesUri>
      <generateBackupPoms>false</generateBackupPoms>
    </configuration>
  </plugin>
  ```

- 主要功能:
  - 显示依赖更新
  - 更新依赖版本
  - 管理属性版本
  - 版本回滚

### OWASP Dependency-Check Maven Plugin

用于检查项目依赖中的已知安全漏洞。

- 文档链接: [Dependency-Check Maven Plugin](https://jeremylong.github.io/DependencyCheck/dependency-check-maven/)
- 常用命令:

  ```bash
  mvn dependency-check:check  # 执行依赖安全检查
  mvn dependency-check:aggregate  # 对多模块项目执行聚合检查
  ```

- 配置示例:

  ```xml
  <plugin>
    <groupId>org.owasp</groupId>
    <artifactId>dependency-check-maven</artifactId>
    <version>12.1.1</version>
    <configuration>
      <formats>
        <format>HTML</format>
        <format>JSON</format>
      </formats>
      <suppressionFiles>
        <suppressionFile>${project.basedir}/owasp-suppressions.xml</suppressionFile>
      </suppressionFiles>
      <failBuildOnCVSS>8</failBuildOnCVSS> <!-- 仅在CVSS评分>=8时构建失败 -->
    </configuration>
    <executions>
      <execution>
        <goals>
          <goal>check</goal>
        </goals>
      </execution>
    </executions>
  </plugin>
  ```

### Maven Release Plugin

用于自动化项目版本发布过程。

- 文档链接: [Maven Release Plugin](https://maven.apache.org/maven-release/maven-release-plugin/)
- 常用命令:

  ```bash
  mvn release:prepare        # 准备发布
  mvn release:perform        # 执行发布
  mvn release:rollback       # 回滚发布准备
  mvn release:clean          # 清理发布文件
  ```

- 配置示例:

  ```xml
  <plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-release-plugin</artifactId>
    <version>3.1.1</version>
    <configuration>
      <tagNameFormat>v@{project.version}</tagNameFormat>
      <autoVersionSubmodules>true</autoVersionSubmodules>
      <releaseProfiles>release</releaseProfiles>
      <goals>deploy</goals>
    </configuration>
  </plugin>
  ```

请根据项目需求和插件使用情况进行调整和补充。这个文档可以帮助开发人员快速找到相关插件的详细信息和使用指南。
