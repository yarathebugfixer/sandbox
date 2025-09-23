import 'package:flutter/material.dart';
import 'package:sandbox/theme/palette.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme({required Brightness base}) {
  final onSurface = base == Brightness.light
      ? AppPalette.n600
      : AppPalette.n200;
  final nunito = GoogleFonts.nunito;
  final poppins = GoogleFonts.poppins;

  return TextTheme(
    displayLarge: nunito(
      fontSize: 48,
      height: 56 / 48,
      fontWeight: FontWeight.w600,
      color: onSurface,
    ),
    headlineLarge: nunito(
      fontSize: 36,
      height: 44 / 36,
      fontWeight: FontWeight.w600,
      color: onSurface,
    ),
    headlineMedium: nunito(
      fontSize: 30,
      height: 38 / 30,
      fontWeight: FontWeight.w600,
      color: onSurface,
    ),
    titleLarge: nunito(
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w500,
      color: onSurface,
    ),
    titleMedium: nunito(
      fontSize: 20,
      height: 28 / 20,
      fontWeight: FontWeight.w500,
      color: onSurface,
    ),
    titleSmall: nunito(
      fontSize: 18,
      height: 28 / 18,
      fontWeight: FontWeight.w400,
      color: onSurface,
    ),
    bodyLarge: poppins(
      fontSize: 18,
      height: 28 / 18,
      fontWeight: FontWeight.w400,
      color: onSurface,
    ),
    bodyMedium: poppins(
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      color: onSurface,
    ),
    bodySmall: poppins(
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
      color: onSurface,
    ),
    labelLarge: poppins(
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w500,
      color: onSurface,
    ),
    labelMedium: poppins(
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w500,
      color: onSurface,
    ),
    labelSmall: poppins(
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w400,
      color: onSurface,
    ),
  );
}
