import 'package:flutter/material.dart';
import 'package:sandbox/theme/gaps.dart';
import 'package:sandbox/theme/gradients.dart';
import 'package:sandbox/theme/radius.dart';
import 'package:sandbox/theme/semantic.dart';
import 'package:sandbox/theme/shadows.dart';
extension AppThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
  AppGradients get gradients => Theme.of(this).extension<AppGradients>()!;
  AppRadius get radius => Theme.of(this).extension<AppRadius>()!;
  AppShadows get shadows => Theme.of(this).extension<AppShadows>()!;
  Gaps get gaps => Theme.of(this).extension<Gaps>()!;
  SemanticColors get semantic => Theme.of(this).extension<SemanticColors>()!;
}
