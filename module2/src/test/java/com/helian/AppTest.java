package com.helian;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/** App类的单元测试 */
public class AppTest {

  /** 测试main方法能否正常执行 */
  @Test
  @DisplayName("测试main方法能否正常执行")
  public void testAppMain() {
    // 验证main方法能正常执行不抛出异常
    App.main(new String[] {});
    assertTrue(true);
  }

  /** 测试App对Speaker的使用 */
  @Test
  @DisplayName("测试App对Speaker的使用")
  public void testAppUsesSpeaker() {
    Speaker speaker = new Speaker();
    assertNotNull(speaker.speak(), "Speaker应该返回一条消息");
  }
}
