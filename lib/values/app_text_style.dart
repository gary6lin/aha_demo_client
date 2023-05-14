import 'package:flutter/material.dart';

import 'app_colors.dart';

const _textHeight = 1.2;

abstract class AppFontWeight {
  AppFontWeight._();

  static const FontWeight regular = FontWeight.normal;
  static const FontWeight bold = FontWeight.bold;
}

abstract class AppFontSize {
  AppFontSize._();

  static const double small = 12.0;
  static const double body = 16.0;
  static const double bodyLarge = 18.0;
  static const double title = 20.0;
  static const double titleLarge = 24.0;
  static const double titleExtraLarge = 32.0;
}

abstract class AppTextStyle {
  AppTextStyle._();

  static const fontFamily = 'TaipeiSansTC';

  /// small: 12.0
  static const smallRegular = TextStyle(
    color: AppColors.textLight,
    fontSize: AppFontSize.small,
    fontWeight: AppFontWeight.regular,
    fontFamily: fontFamily,
    height: _textHeight,
  );
  static const smallBold = TextStyle(
    color: AppColors.textLight,
    fontSize: AppFontSize.small,
    fontWeight: AppFontWeight.bold,
    fontFamily: fontFamily,
    height: _textHeight,
  );

  /// body: 16.0
  static const bodyRegular = TextStyle(
    color: AppColors.textLight,
    fontSize: AppFontSize.body,
    fontWeight: AppFontWeight.regular,
    fontFamily: fontFamily,
    height: _textHeight,
  );
  static const bodyBold = TextStyle(
    color: AppColors.textLight,
    fontSize: AppFontSize.body,
    fontWeight: AppFontWeight.bold,
    fontFamily: fontFamily,
    height: _textHeight,
  );

  /// body: 18.0
  static const bodyLargeRegular = TextStyle(
    color: AppColors.textLight,
    fontSize: AppFontSize.bodyLarge,
    fontWeight: AppFontWeight.regular,
    fontFamily: fontFamily,
    height: _textHeight,
  );
  static const bodyLargeBold = TextStyle(
    color: AppColors.textLight,
    fontSize: AppFontSize.bodyLarge,
    fontWeight: AppFontWeight.bold,
    fontFamily: fontFamily,
    height: _textHeight,
  );

  /// title: 20.0
  static const titleRegular = TextStyle(
    color: AppColors.textLight,
    fontSize: AppFontSize.title,
    fontWeight: AppFontWeight.regular,
    fontFamily: fontFamily,
    height: _textHeight,
  );
  static const titleBold = TextStyle(
    color: AppColors.textLight,
    fontSize: AppFontSize.title,
    fontWeight: AppFontWeight.bold,
    fontFamily: fontFamily,
    height: _textHeight,
  );

  /// titleLarge: 24.0
  static const titleLargeRegular = TextStyle(
    color: AppColors.textLight,
    fontSize: AppFontSize.titleLarge,
    fontWeight: AppFontWeight.regular,
    fontFamily: fontFamily,
    height: _textHeight,
  );
  static const titleLargeBold = TextStyle(
    color: AppColors.textLight,
    fontSize: AppFontSize.titleLarge,
    fontWeight: AppFontWeight.bold,
    fontFamily: fontFamily,
    height: _textHeight,
  );

  /// titleExtraLarge: 32.0
  static const titleExtraLargeRegular = TextStyle(
    color: AppColors.textLight,
    fontSize: AppFontSize.titleExtraLarge,
    fontWeight: AppFontWeight.regular,
    fontFamily: fontFamily,
    height: _textHeight,
  );
  static const titleExtraLargeBold = TextStyle(
    color: AppColors.textLight,
    fontSize: AppFontSize.titleExtraLarge,
    fontWeight: AppFontWeight.bold,
    fontFamily: fontFamily,
    height: _textHeight,
  );
}
