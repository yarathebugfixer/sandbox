import 'package:sandbox/theme/sizes.dart';

class Breakpoints {
  static const double compact = Sizes.mobileBreakpoint;
  static const double medium  = Sizes.tabletBreakpoint;
  static const double expanded = double.infinity; 
}

enum LayoutSize { compact, medium, expanded }

LayoutSize layoutSizeForWidth(double width) {
  if (width < Breakpoints.compact) return LayoutSize.compact;
  if (width < Breakpoints.medium)  return LayoutSize.medium;
  return LayoutSize.expanded;
}