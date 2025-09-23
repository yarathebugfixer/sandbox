import 'package:flutter/material.dart';

class Gaps extends ThemeExtension<Gaps> {
  final double xxs, xs, sm, md, lg, xl, xxl, xxxl;
  const Gaps({
    required this.xxs,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
  });
  static const def = Gaps(
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
    xxxl: 64,
  );
  @override
  Gaps copyWith({
    double? xxs,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
  }) => Gaps(
    xxs: xxs ?? this.xxs,
    xs: xs ?? this.xs,
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
    xxl: xxl ?? this.xxl,
    xxxl: xxxl ?? this.xxxl,
  );
  @override
  Gaps lerp(ThemeExtension<Gaps>? other, double t) => this;
}
