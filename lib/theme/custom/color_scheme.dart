import 'package:sandbox/theme/palette.dart';
import 'package:flutter/material.dart';

ColorScheme colorScheme(Brightness brightness) {
  final isLight = brightness == Brightness.light;

  return ColorScheme(
    brightness: brightness,
    primary: isLight ? AppPalette.p500 : AppPalette.p400,
    onPrimary: Colors.white,
    primaryContainer: isLight ? AppPalette.p100 : AppPalette.p800,
    onPrimaryContainer: isLight ? AppPalette.p800 : AppPalette.p100,
    secondary: isLight ? AppPalette.s600 : AppPalette.s400,
    onSecondary: Colors.white,
    secondaryContainer: isLight ? AppPalette.s100 : AppPalette.s800,
    onSecondaryContainer: isLight ? AppPalette.s800 : AppPalette.s100,
    tertiary: isLight ? AppPalette.a500 : AppPalette.a400,
    onTertiary: Colors.white,
    tertiaryContainer: isLight ? AppPalette.a100 : AppPalette.a800,
    onTertiaryContainer: isLight ? AppPalette.a800 : AppPalette.a100,
    error: isLight ? AppPalette.error : AppPalette.errorDark,
    onError: Colors.white,
    errorContainer: isLight ? AppPalette.errorLight : AppPalette.error,
    onErrorContainer: isLight ? AppPalette.error : Colors.white,
    surface: isLight ? AppPalette.n50 : AppPalette.n800,
    onSurface: isLight ? AppPalette.n600 : AppPalette.n200,
    surfaceContainerHighest: isLight ? AppPalette.n100 : AppPalette.n800,
    surfaceContainerHigh: isLight ? AppPalette.n100 : AppPalette.n800,
    surfaceContainer: isLight ? AppPalette.n100 : AppPalette.n800,
    surfaceContainerLow: isLight ? AppPalette.n50 : AppPalette.n900,
    surfaceContainerLowest: isLight ? AppPalette.n50 : AppPalette.n900,
    onSurfaceVariant: isLight ? AppPalette.n500 : AppPalette.n300,
    outline: isLight ? AppPalette.n300 : AppPalette.n700,
    outlineVariant: isLight ? AppPalette.n200 : AppPalette.n800,
    shadow: isLight ? Colors.black.withValues(alpha: 0.12) : Colors.black,
    scrim: isLight ? Colors.black54 : Colors.black87,
    inverseSurface: isLight ? AppPalette.n800 : AppPalette.n50,
    onInverseSurface: isLight ? AppPalette.n100 : AppPalette.n700,
    inversePrimary: isLight ? AppPalette.p300 : AppPalette.p200,
  );
}
