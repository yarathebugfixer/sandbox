import 'package:flutter/material.dart';
import 'package:sandbox/theme/palette.dart';
import 'package:sandbox/theme/radius.dart';

ElevatedButtonThemeData elevatedButtonTheme(Brightness brightness) {
  final isLight = brightness == Brightness.light;
  final backgroundColor = isLight ? AppPalette.p500 : AppPalette.p400;

  return ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: AppRadius.def.pill),
      ),
      backgroundColor: WidgetStateProperty.all(backgroundColor),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      elevation: WidgetStateProperty.all(0),
    ),
  );
}
