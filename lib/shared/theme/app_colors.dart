import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Palette
  static const Color primary = Color(0xFFFCB803); // Vibrant Indigo
  static const Color primaryDark = Color(0xFFE39104);
  static const Color primaryLight = Color(0xFFFCB803);

  // Secondary Palette
  static const Color secondary = Color(0xFF00D2D3); // Bright Teal
  static const Color secondaryDark = Color(0xFF009B9C);

  // Neutral / Surface
  static const Color background = Color(0xFF121212);
  static const Color surface = Color.fromARGB(255, 233, 233, 233);
  static const Color surfaceLight = Color(0xFF2C2C2C);

  static const Color textPrimary = Color(0xFFEDEDED);
  static const Color textSecondary = Color(0xFFAAAAAA);

  // Status
  static const Color success = Color(0xFF2ECC71);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF1C40F);
  static const Color info = Color(0xFF3498DB);
}
