import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:taskati/core/utils/colors.dart';

final box = Hive.box('user');
var darkMode = box.get('darkMode');

class AppThemes {
  static ThemeData appLightTheme = ThemeData(
    scaffoldBackgroundColor: ProjectColors.white,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
        backgroundColor: ProjectColors.white,
        foregroundColor: ProjectColors.primary),
    colorScheme: ColorScheme.fromSeed(
      primary: ProjectColors.primary,
      background: ProjectColors.white,
      onSurface: ProjectColors.black,
      seedColor: ProjectColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ProjectColors.primary, width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ProjectColors.primary, width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ProjectColors.red, width: 2)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ProjectColors.red, width: 2)),
    ),
  );

  static ThemeData appDarkTheme = ThemeData(
    scaffoldBackgroundColor: ProjectColors.black,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
        backgroundColor: ProjectColors.black,
        foregroundColor: ProjectColors.primary),
    colorScheme: ColorScheme.fromSeed(
      primary: ProjectColors.primary,
      background: ProjectColors.black,
      onSurface: ProjectColors.white,
      seedColor: ProjectColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ProjectColors.primary, width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ProjectColors.primary, width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ProjectColors.red, width: 2)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ProjectColors.red, width: 2)),
    ),
  );
}
