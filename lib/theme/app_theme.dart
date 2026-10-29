
import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF151311);
  static const Color surface = Color(0xFF29211C);
  static const Color bronze = Color(0xFFB68A5A);
  static const Color cream = Color(0xFFF1E7D9);
  static const Color muted = Color(0xFFD0C0AF);
  static const Color border = Color(0xFF6B5543);
  static const Color error = Color(0xFFFF7777);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,

      colorScheme: const ColorScheme.dark(
        primary: bronze,
        secondary: cream,
        surface: surface,
        onPrimary: background,
        onSecondary: background,
        onSurface: cream,
        error: error,
        onError: background,
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: cream,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: cream,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: cream,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: cream,
          fontWeight: FontWeight.w600,
        ),
        bodySmall: TextStyle(
          color: muted,
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          color: cream,
          fontWeight: FontWeight.bold,
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: cream,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: cream,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: border),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        labelStyle: const TextStyle(
          color: cream,
          fontWeight: FontWeight.bold,
        ),
        floatingLabelStyle: const TextStyle(
          color: bronze,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(
          color: muted,
          fontWeight: FontWeight.w500,
        ),
        prefixIconColor: bronze,
        errorStyle: const TextStyle(
          color: error,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: bronze,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: error,
            width: 2,
          ),
        ),
      ),

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: bronze,
        selectionColor: Color(0x66B68A5A),
        selectionHandleColor: bronze,
      ),

      dialogTheme: const DialogThemeData(
        backgroundColor: surface,
        titleTextStyle: TextStyle(
          color: cream,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(
          color: cream,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: bronze,
          foregroundColor: background,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(
        backgroundColor: bronze,
        foregroundColor: background,
      ),

      dividerColor: border,
    );
  }
}
