import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blueAccent,         // Main app color
  primaryColorLight: Colors.blue[300],     // Lighter variant
  primaryColorDark: Colors.blue[800],      // Darker variant
  scaffoldBackgroundColor: Colors.grey[50], // Background of screens
  canvasColor: Colors.white,               // For Drawer, Cards, etc.
  cardColor: Colors.white,
  dividerColor: Colors.grey[300],
  highlightColor: Colors.blue[500],
  splashColor: Colors.blue[500],
  disabledColor: Colors.grey[400],
  secondaryHeaderColor: Colors.blue[100],
  hintColor: Colors.grey[500],
  focusColor: Colors.blue[200],

  // AppBar theme
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.white,
    elevation: 2,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  // Floating Action Button
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.white,
    elevation: 4,
  ),

  // Button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.blueAccent,
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.blueAccent,
      side: BorderSide(color: Colors.blueAccent),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),

  // Text theme
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Colors.black87),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.black87),
    displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black87),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.black87),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black87),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black87),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
    bodySmall: TextStyle(fontSize: 12, color: Colors.black45),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueAccent),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.blueAccent),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.blueAccent),
  ),

  // Input decoration
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[300]!),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent),
      borderRadius: BorderRadius.circular(8),
    ),
    labelStyle: TextStyle(color: Colors.black87),
    hintStyle: TextStyle(color: Colors.grey[500]),
  ),

  // Icon theme
  iconTheme: IconThemeData(color: Colors.blueAccent),
  primaryIconTheme: IconThemeData(color: Colors.blueAccent),
  
);
