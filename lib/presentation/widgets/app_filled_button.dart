import 'package:flutter/material.dart';

class AppFilledButton extends StatelessWidget {
  final Color? color;
  final Widget child;

  final Future<void> Function()? onPressed;

  AppFilledButton({
    Key? key,
    this.color,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  final _onLoading = ValueNotifier(false);

  static const _loadingIndicator = SizedBox(
    width: 24,
    height: 24,
    child: CircularProgressIndicator(
      color: Colors.white,
      backgroundColor: Colors.white24,
      strokeWidth: 3.0,
    ),
  );

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _onLoading,
        builder: (BuildContext context, bool loading, Widget? child) => IgnorePointer(
          ignoring: loading,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: color,
            ),
            onPressed: onPressed != null
                ? () async {
                    _onLoading.value = true;
                    await onPressed?.call();
                    _onLoading.value = false;
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
                    child: _loadingIndicator,
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
}
