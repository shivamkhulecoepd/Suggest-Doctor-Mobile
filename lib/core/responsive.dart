import 'package:flutter/material.dart';

/// Utility class for responsive design
class Responsive {
  /// Returns a scaled font size based on screen width
  static double fontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Base design width (iPhone 14 Pro Max)
    const baseWidth = 430.0;
    
    // Scale factor between 0.8 and 1.2 to prevent extreme scaling
    final scaleFactor = (screenWidth / baseWidth).clamp(0.8, 1.2);
    return baseSize * scaleFactor;
  }

  /// Returns a scaled spacing value based on screen width
  static double spacing(BuildContext context, double baseSpacing) {
    final screenWidth = MediaQuery.of(context).size.width;
    const baseWidth = 430.0;
    
    final scaleFactor = (screenWidth / baseWidth).clamp(0.9, 1.1);
    return baseSpacing * scaleFactor;
  }

  /// Returns a scaled size value based on screen width
  static double size(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    const baseWidth = 430.0;
    
    final scaleFactor = (screenWidth / baseWidth).clamp(0.9, 1.1);
    return baseSize * scaleFactor;
  }

  /// Returns true if the device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Returns true if the screen is considered small
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 350;
  }

  /// Returns true if the screen is considered large
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 500;
  }

  /// Returns padding that adapts to screen size
  static EdgeInsets adaptivePadding(BuildContext context, 
      {double horizontal = 16.0, double vertical = 16.0}) {
    final screenWidth = MediaQuery.of(context).size.width;
    const baseWidth = 430.0;
    
    final scaleFactor = (screenWidth / baseWidth).clamp(0.8, 1.2);
    return EdgeInsets.symmetric(
      horizontal: horizontal * scaleFactor,
      vertical: vertical * scaleFactor,
    );
  }

  /// Returns a responsive card with adaptive padding and border radius
  static Widget responsiveCard(BuildContext context, {
    required Widget child,
    double? width,
    double? height,
    EdgeInsets? margin,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? EdgeInsets.all(spacing(context, 16.0)),
      padding: padding ?? EdgeInsets.all(spacing(context, 16.0)),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(size(context, 16.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: size(context, 10.0),
            offset: Offset(0, size(context, 2.0)),
          ),
        ],
      ),
      child: child,
    );
  }
}