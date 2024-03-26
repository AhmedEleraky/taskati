import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskati/core/utils/colors.dart';

TextStyle getTitleStyle(context,
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: fontSize ?? 20,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color ?? Theme.of(context).colorScheme.onSurface);
}

TextStyle getbodyStyle(context,
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: fontSize ?? 18,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? Theme.of(context).colorScheme.onSurface);
}

TextStyle getSmallStyle(
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.w300,
      color: color ?? ProjectColors.black);
}
