package com.helian;

/**
 * 应用程序入口类。
 *
 * <p>
 * 作为module2的主入口点，演示对module1组件的使用。
 */
public final class App {

  /** 私有构造函数，防止工具类被实例化。 */
  private App() {
    // 工具类不应被实例化
  }

  /**
   * 应用程序主方法。
   *
   * @param args 命令行参数
   */
  public static void main(final String[] args) {
    Speaker speaker = new Speaker();
    System.out.println(speaker.speak());
    System.out.println("Hello from Module 2!");
  }
}
