import 'package:flutter/material.dart';

class AppGradients extends ThemeExtension<AppGradients> {
  final Gradient bgLight;
  final Gradient bgDark;
  final Gradient cardLight;
  final Gradient cardDark;
  final Gradient button;

  const AppGradients({
    required this.bgLight,
    required this.bgDark,
    required this.cardLight,
    required this.cardDark,
    required this.button,
  });

  static const def = AppGradients(
    bgLight: LinearGradient(
      colors: [Color(0xFFE5E9FF), Color(0xFFF8F9FB)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    bgDark: LinearGradient(
      colors: [Color(0xFF2E3A47), Color(0xFF1A212C)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    cardLight: LinearGradient(
      colors: [Color(0xFFF3F5FF), Color(0xFFF2F4FF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    cardDark: LinearGradient(
      colors: [Color(0xFF2E3A47), Color(0xFF1A212C)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    button: LinearGradient(
      colors: [Color(0xFF546BEE), Color(0xFF8F61FF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );

  @override
  AppGradients copyWith({
    Gradient? bgLight,
    Gradient? bgDark,
    Gradient? cardLight,
    Gradient? cardDark,
    Gradient? button,
  }) => AppGradients(
    bgLight: bgLight ?? this.bgLight,
    bgDark: bgDark ?? this.bgDark,
    cardLight: cardLight ?? this.cardLight,
    cardDark: cardDark ?? this.cardDark,
    button: button ?? this.button,
  );

  @override
  AppGradients lerp(ThemeExtension<AppGradients>? other, double t) => this;

  Gradient backgroundGradient(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? bgDark : bgLight;
  }

  Gradient cardGradient(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? cardDark
        : cardLight;
  }
}
