import 'package:flutter/material.dart';

class AppColors {
  // --- New Modern Palette ---
  static const Color primary = Color(0xFF007AFF); // A bright, modern blue
  static const Color secondary = Color(
    0xFFE5E5EA,
  ); // Light grey for backgrounds
  static const Color textPrimary = Color(
    0xFF1C1C1E,
  ); // Near-black for main text
  static const Color textSecondary = Color(0xFF8A8A8E); // Grey for subtitles
  static const Color border = Color(0xFFDCDCE0); // Subtle border color
  static const Color inputBackground = Color(
    0xFFF2F2F7,
  ); // Light background for inputs
  static const Color success = Color(0xFF34C759);
  static const Color error = Color(0xFFFF3B30);

  // --- Legacy Colors (kept for compatibility) ---
  static const Color primaryRed = Color(0xFFD32F2F);
  static const Color primaryGold = Color(0xFFFFA000);
  static const Color warmCream = Color(0xFFFDFBF5);
  static const Color darkBrown = Color(0xFF3E2723);
  static const Color charcoal = Color(0xFF424242);
  static const Color lightGold = Color(0xFFFED7AA); // For loading indicator
  static const Color softBeige = Color(0xFFF5F5DC); // For background
}
