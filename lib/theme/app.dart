import 'package:flutter/material.dart';
import 'package:sandbox/theme/custom/index.dart';
import 'package:sandbox/theme/gaps.dart';
import 'package:sandbox/theme/gradients.dart';
import 'package:sandbox/theme/radius.dart';
import 'package:sandbox/theme/semantic.dart';
import 'package:sandbox/theme/shadows.dart';

class AppTheme {
  static ThemeData light = _theme(brightness: Brightness.light);
  static ThemeData dark = _theme(brightness: Brightness.dark);

  static ThemeData _theme({required Brightness brightness}) {
    final color = colorScheme(brightness);
    return ThemeData(
      useMaterial3: true,
      colorScheme: color,
      canvasColor: color.surface,
      scaffoldBackgroundColor: color.surface,
      appBarTheme: appBarTheme(color),
      cardTheme: cardTheme(color),
      dropdownMenuTheme: dropDownMenuTheme(brightness),
      elevatedButtonTheme: elevatedButtonTheme(brightness),
      inputDecorationTheme: inputDecorationTheme(brightness),
      textTheme: textTheme(base: brightness),
      extensions: const [
        AppGradients.def,
        AppRadius.def,
        AppShadows.def,
        Gaps.def,
        SemanticColors.def,
      ],
    );
  }
}
