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