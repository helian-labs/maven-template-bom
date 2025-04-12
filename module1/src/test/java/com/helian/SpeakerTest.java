package com.helian;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class SpeakerTest {

    @Test
    public void speak() {
        assertNotNull(new Speaker().speak(), "He really speaks");
    }
}