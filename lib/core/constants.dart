import 'package:flutter/material.dart';

/// Design system constants for the Suggest Doctor app
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  /// Spacing constants based on 4dp grid
  static const double spacingXxs = 4.0;
  static const double spacingXs = 8.0;
  static const double spacingSm = 12.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 20.0;
  static const double spacingXl = 24.0;
  static const double spacingXxl = 32.0;
  static const double spacingXxxl = 40.0;

  /// Border radius constants
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusXxl = 24.0;

  /// Icon sizes
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 40.0;

  /// Avatar sizes
  static const double avatarXs = 24.0;
  static const double avatarSm = 32.0;
  static const double avatarMd = 40.0;
  static const double avatarLg = 56.0;
  static const double avatarXl = 72.0;

  /// Button heights
  static const double buttonHeightSm = 36.0;
  static const double buttonHeightMd = 48.0;
  static const double buttonHeightLg = 56.0;

  /// Card elevations
  static const double elevationXs = 1.0;
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;

  /// Max width for responsive design
  static const double maxWidthMobile = 480.0;
  static const double maxWidthTablet = 768.0;
  static const double maxWidthDesktop = 1024.0;
}

/// Light theme color palette
class LightColors {
  // Prevent instantiation
  LightColors._();

  static const Color primary = Color(0xFF007AFF); // Medical blue
  static const Color secondary = Color(0xFF00C6AE); // Teal green
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color surface = Color(0xFFF6F8FA); // Light gray
  static const Color textPrimary = Color(0xFF1E1E1E); // Dark gray
  static const Color textSecondary = Color(0xFF6B7280); // Medium gray
  static const Color accent = Color(0xFFFFD700); // Gold
  static const Color error = Color(0xFFFF3B30); // Red
  static const Color success = Color(0xFF34C759); // Green
  static const Color warning = Color(0xFFFF9500); // Orange
  static const Color info = Color(0xFF5AC8FA); // Light blue
}

/// Dark theme color palette
class DarkColors {
  // Prevent instantiation
  DarkColors._();

  static const Color primary = Color(0xFF0A84FF); // Blue
  static const Color secondary = Color(0xFF64D2FF); // Light blue
  static const Color background = Color(0xFF0D1117); // Very dark
  static const Color surface = Color(0xFF161B22); // Dark
  static const Color textPrimary = Color(0xFFE5E7EB); // Light gray
  static const Color textSecondary = Color(0xFF9CA3AF); // Medium gray
  static const Color accent = Color(0xFFFFD479); // Light gold
  static const Color error = Color(0xFFFF453A); // Red
  static const Color success = Color(0xFF30D158); // Green
  static const Color warning = Color(0xFFFF9F0A); // Orange
  static const Color info = Color(0xFF5AC8FA); // Light blue
}

/// Typography styles
class AppTypography {
  // Prevent instantiation
  AppTypography._();

  /// Display styles
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  /// Headline styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  /// Title styles
  static const TextStyle titleLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// Body styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  /// Label styles
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    height: 1.5,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    height: 1.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    height: 1.5,
  );
}