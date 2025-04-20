package com.helian;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/** Speaker类的单元测试 */
public class SpeakerTest {

  /** 测试speak方法是否返回非空值 */
  @Test
  @DisplayName("测试speak方法是否返回非空值")
  public void speak() {
    assertNotNull(new Speaker().speak(), "speak方法应返回非空值");
  }
}
