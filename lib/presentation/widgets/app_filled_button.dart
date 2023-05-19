import 'dart:async';

import 'package:flutter/material.dart';

import '../../values/app_colors.dart';
import '../../values/app_text_style.dart';

class AppFilledButton extends StatelessWidget {
  final Color foregroundColor;
  final Color backgroundColor;
  final Widget child;
  final Future<void> Function()? onPressed;

  final Color indicatorColor;

  final _onLoading = ValueNotifier(false);

  AppFilledButton({
    Key? key,
    this.foregroundColor = AppColors.textLight,
    this.backgroundColor = AppColors.primary,
    required this.child,
    this.onPressed,
  })  : indicatorColor = backgroundColor.computeLuminance() > 0.6 ? Colors.black : Colors.white,
        super(key: key);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _onLoading,
        builder: (BuildContext context, bool loading, Widget? child) => IgnorePointer(
          ignoring: loading,
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: AppTextStyle.titleRegular,
              foregroundColor: foregroundColor,
              backgroundColor: backgroundColor,
              padding: const EdgeInsets.all(24),
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
              width: double.infinity,
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
