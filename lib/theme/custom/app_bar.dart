import 'package:flutter/material.dart';

AppBarTheme appBarTheme(ColorScheme colorScheme) {
  return AppBarTheme(
    backgroundColor: colorScheme.surface,
    foregroundColor: colorScheme.onSurface,
    elevation: 0,
  );
}
