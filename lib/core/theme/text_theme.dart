import 'package:flutter/material.dart';
import 'package:pepper_cloud_test/core/theme/text_style.dart';

sealed class TextThemes {
  TextThemes._();

  /// Main text theme

  static TextTheme get textTheme {
    return const TextTheme(
        headlineSmall: AppTextStyles.h2,
        headlineLarge: AppTextStyles.h3,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedidum,
        titleSmall: AppTextStyles.titleSmall);
  }
}
