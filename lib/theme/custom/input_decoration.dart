import 'package:flutter/material.dart';
import 'package:sandbox/theme/palette.dart';
import 'package:sandbox/theme/radius.dart';

InputDecorationTheme inputDecorationTheme(Brightness brightness) {
  final isLight = brightness == Brightness.light;
  final fillColor = isLight ? AppPalette.p50 : AppPalette.n900;
  final borderColor = isLight ? AppPalette.p200 : AppPalette.n700;
  final focusColor = isLight ? AppPalette.p600 : AppPalette.p400;

  return InputDecorationTheme(
    filled: true,
    fillColor: fillColor,
    border: OutlineInputBorder(
      borderRadius: AppRadius.def.md,
      borderSide: BorderSide(color: borderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.def.md,
      borderSide: BorderSide(color: borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppRadius.def.md,
      borderSide: BorderSide(color: focusColor, width: 1.5),
    ),
  );
}
