import 'package:flutter/material.dart';

class LightTheme {
  static final theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color(0xFF007AFF), // Medical blue
    scaffoldBackgroundColor: const Color(0xFFFFFFFF), // White background
    canvasColor: const Color(0xFFF6F8FA), // Surface color
    cardColor: const Color(0xFFF6F8FA), // Surface color
    dividerColor: const Color(0xFFE5E7EB),
    
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF007AFF), // Medical blue
      primary: const Color(0xFF007AFF), // Medical blue
      secondary: const Color(0xFF00C6AE), // Teal green
      surface: const Color(0xFFF6F8FA), // Surface
      error: const Color(0xFFFF3B30), // Error red
      brightness: Brightness.light,
    ),
    
    // Typography
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E1E1E), // Text primary
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E1E1E),
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E1E1E),
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E1E1E),
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E1E1E),
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E1E1E),
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF1E1E1E),
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280), // Text secondary
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF1E1E1E),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF1E1E1E),
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280),
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E1E1E),
      ),
    ),
    
    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E1E1E),
      ),
      iconTheme: IconThemeData(color: Color(0xFF1E1E1E)),
    ),
    
    // Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      selectedItemColor: Color(0xFF007AFF), // Primary
      unselectedItemColor: Color(0xFF6B7280), // Text secondary
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
    
    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF007AFF), // Primary
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
        foregroundColor: const Color(0xFF007AFF), // Primary
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF007AFF), // Primary
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        side: const BorderSide(color: Color(0xFF007AFF)), // Primary
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    
    // Input fields
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF6F8FA), // Surface
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF007AFF)), // Primary
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFF3B30)), // Error
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      labelStyle: TextStyle(color: Color(0xFF6B7280)), // Text secondary
      hintStyle: TextStyle(color: Color(0xFF9CA3AF)), // Hint text
    ),
    
    // Cards
    cardTheme: const CardThemeData(
      color: Color(0xFFF6F8FA), // Surface
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    
    // Chips
    chipTheme: const ChipThemeData(
      backgroundColor: Color(0xFFF6F8FA), // Surface
      selectedColor: Color(0xFF007AFF), // Primary
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF1E1E1E),
      ),
      secondaryLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: StadiumBorder(),
    ),
  );
}