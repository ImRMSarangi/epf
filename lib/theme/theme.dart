import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary Palette Colors
  static const Color primaryMaroon = Color(0xFF800000); // Maroon
  static const Color primaryBurgundy = Color(0xFF800020); // Burgundy variant

  // Secondary & Accent Colors
  static const Color accentBurntSienna = Color(0xFFE97451); // Burnt Sienna
  static const Color accentChestnut = Color(0xFF954535); // Warm medium brown
  static const Color accentBeige = Color(0xFFF0E68C); // Light beige background
  static const Color accentCream = Color(0xFFF3E9DC); // Cream surface

  /// Dark Theme with Brown & Maroon Accessible Palette
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: primaryMaroon,
    primaryColor: primaryMaroon,

    colorScheme: const ColorScheme.dark().copyWith(
      primary: primaryMaroon,
      primaryContainer: primaryBurgundy,
      secondary: accentBurntSienna,
      secondaryContainer: accentChestnut,
      surface: Color(0xFF2C1B18), // Deep brown surface shade
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white70,
    ),

    // App Bar Styling
    appBarTheme: AppBarTheme(
      backgroundColor: primaryBurgundy,
      elevation: 3,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Text Styling
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme.copyWith(
        titleLarge: const TextStyle(
            fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
        titleMedium: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: const TextStyle(
            fontSize: 16, color: Colors.white70),
        bodyMedium: const TextStyle(
            fontSize: 14, color: Colors.white70),
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 6,
      shadowColor: Colors.black54,
    ),

    // Button Style
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentBurntSienna,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
  );
}
