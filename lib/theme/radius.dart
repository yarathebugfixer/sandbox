import 'package:flutter/material.dart';

class AppRadius extends ThemeExtension<AppRadius> {
  final BorderRadius sm, md, lg, pill;

  const AppRadius({
    required this.sm,
    required this.md,
    required this.lg,
    required this.pill,
  });

  static const def = AppRadius(
    sm: BorderRadius.all(Radius.circular(8)),
    md: BorderRadius.all(Radius.circular(12)),
    lg: BorderRadius.all(Radius.circular(16)),
    pill: BorderRadius.all(Radius.circular(999)),
  );
  @override
  AppRadius copyWith({
    BorderRadius? sm,
    BorderRadius? md,
    BorderRadius? lg,
    BorderRadius? pill,
  }) => AppRadius(
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    pill: pill ?? this.pill,
  );

  @override
  AppRadius lerp(ThemeExtension<AppRadius>? other, double t) => this;
}
