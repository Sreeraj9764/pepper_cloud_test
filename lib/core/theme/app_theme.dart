import 'package:flutter/material.dart';
import 'package:pepper_cloud_test/core/theme/app_pallete.dart';
import 'package:pepper_cloud_test/core/theme/text_style.dart';
import 'package:pepper_cloud_test/core/theme/text_theme.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
      appBarTheme: appbarTheme,
      fontFamily: AppTextStyles.defaultFontFamily,
      textTheme: TextThemes.textTheme);
}

const appbarTheme = AppBarTheme(
  color: AppPallete.appBarColor,
  centerTitle: false,
);
