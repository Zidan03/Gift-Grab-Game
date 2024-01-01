import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  static final Color _primaryColor = Colors.blue.shade900;
  static final Color _secondaryColor = Colors.orange.shade700;

  /// Fonts
  static const String fontFamily = 'Montserrat';

  /// Display Large
  static const TextStyle _displayLarge = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 26,
    fontFamily: fontFamily,
  );

  /// Display Medium
  static const TextStyle _displayMedium = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    fontFamily: fontFamily,
  );

  /// Display Small
  static const TextStyle _displaySmall = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    fontFamily: fontFamily,
  );

  /// Headline Medium
  static const TextStyle _headlineMedium = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    fontFamily: fontFamily,
  );

  /// Headline Small
  static const TextStyle _headlineSmall = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    fontFamily: fontFamily,
  );

  /// Title Large
  static const TextStyle _titleLarge = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 12,
    fontFamily: fontFamily,
  );

  /// Body Large
  static const TextStyle _bodyLarge = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.5,
    fontFamily: fontFamily,
  );

  /// Body Medium
  static const TextStyle _bodyMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.5,
    fontFamily: fontFamily,
  );

  /// Title Medium
  static const TextStyle _titleMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    fontFamily: fontFamily,
  );

  /// Title Small
  static const TextStyle _titleSmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    fontFamily: fontFamily,
  );

  /// Light theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: _primaryColor,
    brightness: Brightness.light,
    canvasColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: _secondaryColor),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.green.shade700,
    ),
    textTheme: TextTheme(
      displayLarge: _displayLarge.copyWith(color: Colors.black),
      displayMedium: _displayMedium.copyWith(color: Colors.black),
      displaySmall: _displaySmall.copyWith(color: Colors.black),
      headlineMedium: _headlineMedium.copyWith(color: Colors.black),
      headlineSmall: _headlineSmall.copyWith(color: Colors.black),
      titleLarge: _titleLarge.copyWith(color: Colors.black),
      bodyLarge: _bodyLarge.copyWith(color: Colors.grey),
      bodyMedium: _bodyMedium.copyWith(color: Colors.grey),
      titleMedium: _titleMedium.copyWith(color: Colors.black),
      titleSmall: _titleSmall.copyWith(color: Colors.grey),
    ),
  );

  /// Dark theme
  static ThemeData darkTheme = ThemeData(
    primaryColor: _primaryColor,
    brightness: Brightness.dark,
    canvasColor: Colors.grey.shade900,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: _secondaryColor),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.green.shade300,
    ),
    textTheme: TextTheme(
      displayLarge: _displayLarge.copyWith(color: Colors.white),
      displayMedium: _displayMedium.copyWith(color: Colors.white),
      displaySmall: _displaySmall.copyWith(color: Colors.white),
      headlineMedium: _headlineMedium.copyWith(color: Colors.white),
      headlineSmall: _headlineSmall.copyWith(color: Colors.white),
      titleLarge: _titleLarge.copyWith(color: Colors.white),
      bodyLarge: _bodyLarge.copyWith(color: Colors.grey),
      bodyMedium: _bodyMedium.copyWith(color: Colors.grey),
      titleMedium: _titleMedium.copyWith(color: Colors.white),
      titleSmall: _titleSmall.copyWith(color: Colors.grey),
    ),
  );
}
