import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      selectedColor: Color(0xFF2f3542),

      labelStyle: TextStyle(color: Colors.black),
      iconTheme: null,
      secondaryLabelStyle: TextStyle(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.transparent),
      ),
    ),
  );
}
