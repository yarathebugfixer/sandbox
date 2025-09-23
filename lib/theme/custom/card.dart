import 'package:sandbox/theme/radius.dart';
import 'package:flutter/material.dart';

CardThemeData cardTheme(ColorScheme colorScheme) {
  return CardThemeData(
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: AppRadius.def.lg),
    color: colorScheme.surface,
  );
}
