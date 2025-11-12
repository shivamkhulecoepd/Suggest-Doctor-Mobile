import 'package:flutter/material.dart';

class DarkTheme {
  static final theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF0A84FF), // Primary blue
    scaffoldBackgroundColor: const Color(0xFF0D1117), // Dark background
    canvasColor: const Color(0xFF161B22), // Surface color
    cardColor: const Color(0xFF161B22), // Surface color
    dividerColor: const Color(0xFF30363D),
    
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF0A84FF), // Primary blue
      primary: const Color(0xFF0A84FF), // Primary blue
      secondary: const Color(0xFF64D2FF), // Secondary blue
      surface: const Color(0xFF161B22), // Surface
      error: const Color(0xFFFF453A), // Error red
      brightness: Brightness.dark,
    ),
    
    // Typography
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE5E7EB), // Text primary
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE5E7EB),
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE5E7EB),
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE5E7EB),
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE5E7EB),
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE5E7EB),
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFFE5E7EB),
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF), // Text secondary
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFFE5E7EB),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFFE5E7EB),
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE5E7EB),
      ),
    ),
    
    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0D1117),
      foregroundColor: Color(0xFFE5E7EB),
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE5E7EB),
      ),
      iconTheme: IconThemeData(color: Color(0xFFE5E7EB)),
    ),
    
    // Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF0D1117),
      selectedItemColor: Color(0xFF0A84FF), // Primary
      unselectedItemColor: Color(0xFF9CA3AF), // Text secondary
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
    
    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0A84FF), // Primary
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2,
      ),
    ),
    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF0A84FF), // Primary
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF0A84FF), // Primary
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        side: const BorderSide(color: Color(0xFF0A84FF)), // Primary
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    
    // Input fields
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF161B22), // Surface
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF30363D)),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF30363D)),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF0A84FF)), // Primary
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFF453A)), // Error
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      labelStyle: TextStyle(color: Color(0xFF9CA3AF)), // Text secondary
      hintStyle: TextStyle(color: Color(0xFF6E7681)), // Hint text
    ),
    
    // Cards
    cardTheme: const CardThemeData(
      color: Color(0xFF161B22), // Surface
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    
    // Chips
    chipTheme: const ChipThemeData(
      backgroundColor: Color(0xFF161B22), // Surface
      selectedColor: Color(0xFF0A84FF), // Primary
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFFE5E7EB),
      ),
      secondaryLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: StadiumBorder(),
    ),
  );
}