import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF000000); // Pure Black
  static const Color surface = Color(0xFF111111); // Dark Gray
  static const Color primary = Color(0xFF007AFF); // iOS Blue
  static const Color secondary = Color(0xFF34C759); // iOS Green
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8E8E93); // iOS System Gray

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        background: background,
      ),
      useMaterial3: true,
    );
  }
}
