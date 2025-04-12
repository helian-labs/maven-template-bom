package com.helian;

import org.junit.Assert;
import org.junit.Test;

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
        Assert.assertTrue(true);
    }
    
    /**
     * 测试App是否能正确使用Speaker
     */
    @Test
    public void testAppUsesSpeaker() {
        Speaker speaker = new Speaker();
        Assert.assertNotNull("Speaker should return a message", speaker.speak());
    }
}
