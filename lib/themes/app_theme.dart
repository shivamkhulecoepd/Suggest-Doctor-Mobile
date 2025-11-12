import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class AppThemes {
  static ThemeData get light => LightTheme.theme;
  static ThemeData get dark => DarkTheme.theme;
}