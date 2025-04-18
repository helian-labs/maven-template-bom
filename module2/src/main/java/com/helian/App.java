package com.helian;

/** module2 的主应用程序类。 */
public final class App {

  /** 私有构造函数，用于隐藏工具类的隐式公共构造函数。 */
  private App() {
    // 防止实例化
  }

  /**
   * 应用程序的主入口点。
   *
   * @param args 命令行参数（应为 final）。
   */
  public static void main(final String[] args) {
    Speaker speaker = new Speaker();
    System.out.println(speaker.speak());
    System.out.println("Hello from Module 2!");
  }
}
