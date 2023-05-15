import 'package:flutter/material.dart';

class AppFilledButton extends StatelessWidget {
  final Widget child;
  final Future<void> Function()? onPressed;

  AppFilledButton({
    Key? key,
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
            child: Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              alignment: Alignment.center,
              child: loading ? _loadingIndicator : this.child,
            ),
            onPressed: () async {
              _onLoading.value = true;
              await onPressed?.call();
              _onLoading.value = false;
            },
          ),
        ),
      );
}
