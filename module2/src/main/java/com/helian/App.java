package com.helian;

/** Main application class for module2. */
public final class App {

  /** Private constructor to hide the implicit public one for utility classes. */
  private App() {
    // Prevent instantiation
  }

  /**
   * Main entry point of the application.
   *
   * @param args Command line arguments (should be final).
   */
  public static void main(final String[] args) {
    Speaker speaker = new Speaker();
    System.out.println(speaker.speak());
    System.out.println("Hello from Module 2!");
  }
}
