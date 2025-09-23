import 'package:sandbox/theme/palette.dart';
import 'package:sandbox/theme/radius.dart';
import 'package:sandbox/theme/sizes.dart';
import 'package:flutter/material.dart';


DropdownMenuThemeData dropDownMenuTheme(Brightness brightness) {
  final isLight = brightness == Brightness.light;
  final fillColor = isLight ? AppPalette.p50 : AppPalette.n900;
  final borderColor = isLight ? AppPalette.p200 : AppPalette.n700;
  final focusColor = isLight ? AppPalette.p600 : AppPalette.p400;
  return DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: AppRadius.def.pill,
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.def.pill,
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.def.pill,
        borderSide: BorderSide(color: focusColor, width: 1.5),
      ),
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(fillColor),
      maximumSize: WidgetStateProperty.all(
        Size.fromWidth(Sizes.dropdownMenuMaxWidth),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppRadius.def.lg),
      ),
    ),
  );
}
