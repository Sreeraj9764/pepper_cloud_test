import 'package:flutter/material.dart';

class AppTextStyles {
  static const String defaultFontFamily = 'SF-Pro';
  static const String sfProDispalyBold = 'SF-Pro-Dispaly-Bold';
  static const String sfProDispalyRegular = 'SF-Pro-Dispaly-Regular';
  static const String sfProTextRegular = 'SF-Pro-Dispaly-Regular';

  /// Text style for body
  static const TextStyle bodyLg = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodySm = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle bodyXs = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
  );

  /// Text style for heading

  static const TextStyle h1 = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w200,
      fontFamily: sfProDispalyRegular);

  static const TextStyle h2 = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      fontFamily: sfProDispalyRegular);

  static const TextStyle h3 = TextStyle(
      fontSize: 28, fontWeight: FontWeight.w700, fontFamily: sfProDispalyBold);

  //titles

  static const TextStyle titleLarge = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    fontFamily: sfProTextRegular,
  );

  static const TextStyle titleMedidum = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    fontFamily: sfProTextRegular,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontFamily: sfProTextRegular,
  );
}
