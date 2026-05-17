import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- COLORS ---
  static const Color background = Color(0xFF000000); // Pure Black
  static const Color surface = Color(0xFF111111); // Dark Gray
  static const Color primary = Color(0xFF007AFF); // iOS Blue
  static const Color secondary = Color(0xFF34C759); // iOS Green
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8E8E93); // iOS System Gray
  static const Color accentBlue = Color(0xFF5AC8FA);
  static const Color accentPink = Color(0xFFFF2D55);
  static const Color accentPurple = Color(0xFF5856D6);

  // --- GRADIENTS ---
  static Gradient get auroraGradient => LinearGradient(
    colors: [
      primary.withValues(alpha: 0.2),
      accentPurple.withValues(alpha: 0.2),
      accentPink.withValues(alpha: 0.2),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // --- LIGHT THEME DATA ---
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primary,
      scaffoldBackgroundColor: const Color(0xFFF5F5F7), // Apple Off-White
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        onSurface: Color(0xFF1D1D1F),
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(
          fontSize: 96,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF1D1D1F),
          letterSpacing: -3,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 64,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF1D1D1F),
          letterSpacing: -2,
        ),
        displaySmall: GoogleFonts.outfit(
          fontSize: 48,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF1D1D1F),
          letterSpacing: -1,
        ),
        headlineLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1D1D1F),
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1D1D1F),
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 18,
          color: const Color(0xFF1D1D1F),
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16,
          color: const Color(0xFF86868B),
          height: 1.5,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1D1D1F),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1D1D1F),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      iconTheme: const IconThemeData(
        color: Color(0xFF1D1D1F),
      ),
    );
  }

  // --- DARK THEME DATA ---
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(
          fontSize: 96,
          fontWeight: FontWeight.w900,
          color: textPrimary,
          letterSpacing: -3,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 64,
          fontWeight: FontWeight.w900,
          color: textPrimary,
          letterSpacing: -2,
        ),
        displaySmall: GoogleFonts.outfit(
          fontSize: 48,
          fontWeight: FontWeight.w900,
          color: textPrimary,
          letterSpacing: -1,
        ),
        headlineLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 18,
          color: textPrimary,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16,
          color: textSecondary,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: textPrimary,
          foregroundColor: background,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      iconTheme: const IconThemeData(
        color: textPrimary,
      ),
    );
  }
}
