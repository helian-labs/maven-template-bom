package com.helian;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

/** 测试 {@link Speaker} 类。 */
public class SpeakerTest {

  /** 测试 {@link Speaker#speak()} 方法。确保 speak 方法返回非空值。 */
  @Test
  public void speak() {
    assertNotNull(new Speaker().speak(), "He really speaks");
  }
}
