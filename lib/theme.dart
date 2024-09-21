// lib/theme.dart
import 'package:flutter/material.dart';

ThemeData buildTheme() {
  return ThemeData(
    primarySwatch: Colors.red, // Primary color throughout the app
    primaryColor: Colors.red.shade700, // Stronger red for primary accents

    // Use colorScheme for overall theming
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.red,
      accentColor: Colors.orangeAccent, // Define the accent color here
      brightness:
          Brightness.light, // You can switch between light or dark theme
    ),

    // Customize the AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.red, // Red AppBar background
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white, // White text for titles
      ),
      iconTheme: IconThemeData(color: Colors.white), // White icons
      elevation: 2, // Add a slight shadow under the AppBar
    ),

    // Customize buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade600, // Slightly lighter red
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12), // Rounded corners for buttons
        ),
      ),
    ),

    // Customize TextFields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.red.shade50, // Slight red tint for input background
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            BorderSide(color: Colors.red.shade300), // Border with red tone
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.red.shade600), // Stronger red border on focus
      ),
      labelStyle: const TextStyle(color: Colors.red),
    ),

    // Updated text theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.red, // Red headlines
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black87, // General body text color
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black54, // Lighter body text
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white, // Button text in white
      ),
    ),

    // Customize floating action button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.red, // Red FAB
      foregroundColor: Colors.white, // White icon on FAB
    ),

    // Customize divider
    dividerTheme: const DividerThemeData(
      color: Colors.red,
      thickness: 1.5,
    ),

    // Customize icon themes
    iconTheme: IconThemeData(color: Colors.red.shade600),

    // Add some global padding for convenience
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
