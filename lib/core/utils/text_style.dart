import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:taskati/core/utils/colors.dart';

final box = Hive.box('user');
var darkMode = box.get('darkMode');
TextStyle getTitleStyle(
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: fontSize ?? 20,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color ?? ProjectColors.primary);
}

TextStyle getbodyStyle(
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: fontSize ?? 18,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? ProjectColors.black);
}

TextStyle getSmallStyle(
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.w300,
      color: color ?? ProjectColors.black);
}
