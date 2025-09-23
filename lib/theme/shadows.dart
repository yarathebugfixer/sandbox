import 'package:flutter/material.dart';

class AppShadows extends ThemeExtension<AppShadows> {
  final List<BoxShadow> smallLight, mediumLight, largeLight;
  final List<BoxShadow> smallDark, mediumDark, largeDark;

  const AppShadows({
    required this.smallLight,
    required this.mediumLight,
    required this.largeLight,
    required this.smallDark,
    required this.mediumDark,
    required this.largeDark,
  });

  static const def = AppShadows(
    smallLight: [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 6,
        spreadRadius: 0,
        offset: Offset(0, 2),
      ),
    ],
    mediumLight: [
      BoxShadow(
        color: Color(0x1F000000),
        blurRadius: 12,
        spreadRadius: 0,
        offset: Offset(0, 6),
      ),
    ],
    largeLight: [
      BoxShadow(
        color: Color(0x26000000),
        blurRadius: 24,
        spreadRadius: 0,
        offset: Offset(0, 12),
      ),
    ],
    smallDark: [
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 4,
        spreadRadius: 0,
        offset: Offset(0, 1),
      ),
    ],
    mediumDark: [
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 10,
        spreadRadius: 0,
        offset: Offset(0, 4),
      ),
    ],
    largeDark: [
      BoxShadow(
        color: Color(0x59000000),
        blurRadius: 20,
        spreadRadius: 0,
        offset: Offset(0, 10),
      ),
    ],
  );

  @override
  AppShadows copyWith({
    List<BoxShadow>? smallLight,
    List<BoxShadow>? mediumLight,
    List<BoxShadow>? largeLight,
    List<BoxShadow>? smallDark,
    List<BoxShadow>? mediumDark,
    List<BoxShadow>? largeDark,
  }) => AppShadows(
    smallLight: smallLight ?? this.smallLight,
    mediumLight: mediumLight ?? this.mediumLight,
    largeLight: largeLight ?? this.largeLight,
    smallDark: smallDark ?? this.smallDark,
    mediumDark: mediumDark ?? this.mediumDark,
    largeDark: largeDark ?? this.largeDark,
  );

  @override
  AppShadows lerp(ThemeExtension<AppShadows>? other, double t) => this;
}
