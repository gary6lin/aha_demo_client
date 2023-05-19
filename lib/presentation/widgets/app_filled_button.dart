import 'dart:async';

import 'package:flutter/material.dart';

import '../../values/app_colors.dart';
import '../../values/app_text_style.dart';

enum AppFilledButtonSize {
  normal,
  small,
}

class AppFilledButton extends StatelessWidget {
  final bool shrink;
  final AppFilledButtonSize buttonSize;
  final Color foregroundColor;
  final Color backgroundColor;
  final Widget child;
  final Future<void> Function()? onPressed;

  final Color indicatorColor;

  final _onLoading = ValueNotifier(false);

  AppFilledButton({
    Key? key,
    this.shrink = false,
    this.buttonSize = AppFilledButtonSize.normal,
    this.foregroundColor = AppColors.textLight,
    this.backgroundColor = AppColors.primary,
    required this.child,
    this.onPressed,
  })  : indicatorColor = backgroundColor.computeLuminance() > 0.6 ? Colors.black54 : Colors.white,
        super(key: key);

  TextStyle get textStyle {
    switch (buttonSize) {
      case AppFilledButtonSize.normal:
        return AppTextStyle.titleRegular;
      case AppFilledButtonSize.small:
        return AppTextStyle.bodyRegular;
    }
  }

  EdgeInsets get padding {
    switch (buttonSize) {
      case AppFilledButtonSize.normal:
        return const EdgeInsets.all(24);
      case AppFilledButtonSize.small:
        return const EdgeInsets.all(16);
    }
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _onLoading,
        builder: (BuildContext context, bool loading, Widget? child) => IgnorePointer(
          ignoring: loading,
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: textStyle,
              foregroundColor: foregroundColor,
              disabledForegroundColor: foregroundColor.withOpacity(0.2),
              backgroundColor: backgroundColor,
              disabledBackgroundColor: backgroundColor.withOpacity(0.2),
              padding: padding.add(
                const EdgeInsets.only(bottom: 2),
              ),
            ),
            onPressed: onPressed != null
                ? () async {
                    try {
                      _onLoading.value = true;
                      await onPressed?.call();
                    } finally {
                      _onLoading.value = false;
                    }
                  }
                : null,
            child: Container(
              width: shrink ? null : double.infinity,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: loading ? 1 : 0,
                    child: _buildLoadingIndicator(),
                  ),
                  Opacity(
                    opacity: loading ? 0 : 1,
                    child: child!,
                  ),
                ],
              ),
            ),
          ),
        ),
        child: child,
      );

  Widget _buildLoadingIndicator() => SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: indicatorColor,
          backgroundColor: indicatorColor.withOpacity(0.24),
          strokeWidth: 3.0,
        ),
      );
}
