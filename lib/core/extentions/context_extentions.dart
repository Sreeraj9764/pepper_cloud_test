import 'package:flutter/material.dart';

extension ThemeExtention on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
