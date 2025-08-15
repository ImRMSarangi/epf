import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Core Colors
  static const Color backgroundBlack = Color(0xFF000000); // Pitch black
  static const Color cardGrey = Color(0xFF181A20); // Dark card
  static const Color accentGreen = Color(0xFF4ADE80); // Success/positive
  static const Color accentRed = Color(0xFFF87171); // Negative
  static const Color accentOrange = Color(0xFFFFB86C);
  static const Color accentGrey = Color(0xFFB0B6BE);

  // Dark Theme
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: backgroundBlack,
    primaryColor: backgroundBlack,
    cardColor: cardGrey,
    canvasColor: backgroundBlack,
    colorScheme: ColorScheme.dark(
      primary: backgroundBlack,
      surface: cardGrey,
      background: backgroundBlack,
      onPrimary: Colors.white,
      secondary: accentOrange,
      onSurface: Colors.white70,
      onSecondary: Colors.white,
      error: accentRed,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundBlack,
      elevation: 1,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme.copyWith(
        titleLarge: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        titleMedium: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white),
        bodyLarge: const TextStyle(
            fontSize: 16, color: Colors.white70),
        bodyMedium: const TextStyle(
            fontSize: 14, color: Colors.white70),
      ),
    ),
    cardTheme: CardThemeData(
      color: cardGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 6,
      shadowColor: Colors.black38,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentOrange,
        foregroundColor: Colors.black,
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
