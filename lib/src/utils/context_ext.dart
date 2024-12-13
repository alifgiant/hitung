import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  // padding
  double get topPadding => MediaQuery.of(this).padding.top;

  // size
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  // configuration
  bool get isLandscape => width > height;
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
}
