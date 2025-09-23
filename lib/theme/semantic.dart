import 'package:flutter/material.dart';
import 'package:sandbox/theme/palette.dart';

class SemanticColors extends ThemeExtension<SemanticColors> {
  final Color disabledLight,
      disabledDark,
      warnLight,
      warning,
      warnDark,
      successLight,
      success,
      successDark;

  const SemanticColors({
    required this.disabledLight,
    required this.disabledDark,

    required this.warnLight,
    required this.warning,
    required this.warnDark,
    required this.successLight,
    required this.success,
    required this.successDark,
  });

  static const def = SemanticColors(
    disabledLight: AppPalette.disabledLight,
    disabledDark: AppPalette.disabledDark,

    warnDark: AppPalette.warnDark,
    warning: AppPalette.warn,
    warnLight: AppPalette.warnLight,
    successDark: AppPalette.successDark,
    success: AppPalette.success,
    successLight: AppPalette.successLight,
  );

  @override
  SemanticColors copyWith({
    Color? disabledLight,
    Color? disabledDark,

    Color? warnLight,
    Color? warning,
    Color? warnDark,
    Color? successLight,
    Color? success,
    Color? successDark,
  }) {
    return SemanticColors(
      disabledLight: disabledLight ?? this.disabledLight,
      disabledDark: disabledDark ?? this.disabledDark,
      warnLight: warnLight ?? this.warnLight,
      warning: warning ?? this.warning,
      warnDark: warnDark ?? this.warnDark,
      successLight: successLight ?? this.successLight,
      success: success ?? this.success,
      successDark: successDark ?? this.successDark,
    );
  }

  @override
  SemanticColors lerp(ThemeExtension<SemanticColors>? other, double t) => this;
}
