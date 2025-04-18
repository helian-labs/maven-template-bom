package com.helian;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Tests for the {@link Speaker} class.
 */
public class SpeakerTest {

    /**
     * Tests the {@link Speaker#speak()} method.
     * Ensures that the speak method returns a non-null value.
     */
    @Test
    public void speak() {
        assertNotNull(new Speaker().speak(), "He really speaks");
    }
}