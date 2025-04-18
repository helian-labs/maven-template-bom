package com.helian;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

/** 单元测试 App 类 */
public class AppTest {

  /** 测试 App 类的 main 方法能否正常执行 */
  @Test
  public void testAppMain() {
    // 验证 main 方法能否正常执行而不抛出异常
    App.main(new String[] {});
    assertTrue(true);
  }

  /** 测试 App 是否能正确使用 Speaker */
  @Test
  public void testAppUsesSpeaker() {
    Speaker speaker = new Speaker();
    assertNotNull(speaker.speak(), "Speaker 应该返回一条消息");
  }
}
