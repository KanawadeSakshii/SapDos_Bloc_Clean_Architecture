import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  static final sapdos = Text(
    "SAPDOS", //amethysta
    style: GoogleFonts.playfairDisplaySc(
        textStyle: const TextStyle(
            color: AppPallete.gradient1,
            fontSize: 30,
            fontWeight: FontWeight.w800)),
  );

  static double defaultpadding = 15;
}
