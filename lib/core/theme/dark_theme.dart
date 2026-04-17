import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.tealAccent[700],        // Main app color
  primaryColorLight: Colors.teal[300],         // Lighter variant
  primaryColorDark: Colors.teal[900],          // Darker variant
  scaffoldBackgroundColor: Colors.grey[900],   // Page background
  canvasColor: Colors.grey[850],               // Drawer, cards background
  cardColor: Colors.grey[800],
  dividerColor: Colors.grey[700],
  highlightColor: Colors.tealAccent[500],
  splashColor: Colors.tealAccent[500],
  disabledColor: Colors.grey[600],
  secondaryHeaderColor: Colors.teal[700],
  hintColor: Colors.grey[400],
  focusColor: Colors.teal[400],

  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.tealAccent[700],
    foregroundColor: Colors.black87,
    elevation: 2,
    iconTheme: IconThemeData(color: Colors.black87),
    titleTextStyle: TextStyle(
      color: Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  // Floating Action Button
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.tealAccent[700],
    foregroundColor: Colors.black87,
    elevation: 4,
  ),

  // Buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.tealAccent[700],
      foregroundColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.tealAccent[700],
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.tealAccent[700],
      side: BorderSide(color: Colors.tealAccent[700]??Colors.tealAccent),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),

  // Text
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.grey[300]),
    bodySmall: TextStyle(fontSize: 12, color: Colors.grey[400]),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.tealAccent[700]),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.tealAccent[700]),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.tealAccent[700]),
  ),

  // Input fields
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[800],
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.tealAccent[700]!),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[700]!),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent),
      borderRadius: BorderRadius.circular(8),
    ),
    labelStyle: TextStyle(color: Colors.white),
    hintStyle: TextStyle(color: Colors.grey[400]),
  ),

  // Icons
  iconTheme: IconThemeData(color: Colors.tealAccent[700]),
  primaryIconTheme: IconThemeData(color: Colors.tealAccent[700]),
);
