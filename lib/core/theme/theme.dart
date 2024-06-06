import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: color,
      ));

  static final lightThemeMode = ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      appBarTheme:
          const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(12),
          enabledBorder: _border(AppPallete.gradient2),
          focusedBorder: _border(AppPallete.gradient2),
          errorBorder: _border(AppPallete.errorColor)));

  static const textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  );

  static const sapdos = Text(
    "SAPDOS",
    style: TextStyle(
        fontFamily: 'Schyler',
        color: AppPallete.gradient1,
        fontSize: 30,
        letterSpacing: 2,
        fontWeight: FontWeight.w800),
  );
  static double defaultpadding = 15;
}
