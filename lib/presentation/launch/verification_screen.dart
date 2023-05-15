import 'package:aha_demo/values/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../values/app_colors.dart';
import 'verification_view_model.dart';

class VerificationScreen extends StatefulWidget {
  final String? message;
  final String? oobCode;

  const VerificationScreen({
    Key? key,
    this.message,
    this.oobCode,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _vm = VerificationViewModel();
  final _onErrorMessage = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();

    _vm.onEmailVerified = () {
      context.go(AppRoute.main.path);
    };

    _vm.onError = (e) {
      _onErrorMessage.value = e.toString();
    };

    final oobCode = widget.oobCode;
    if (oobCode != null) {
      _vm.onEmailVerify(oobCode);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Container(
            width: 400,
            height: 300,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: ValueListenableBuilder(
              valueListenable: _onErrorMessage,
              builder: (BuildContext context, String? errorMessage, Widget? child) {
                if (widget.message != null) {
                  return _buildMessage(widget.message!);
                }
                return errorMessage == null ? _buildEmailVerifying() : _buildMessage(errorMessage);
              },
            ),
          ),
        ),
      );

  Widget _buildMessage(String errorMessage) => Center(
        child: Text(
          errorMessage,
          style: AppTextStyle.titleRegular,
          textAlign: TextAlign.center,
        ),
      );

  Widget _buildEmailVerifying() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLoadingIndicator(),
          const SizedBox(height: 32),
          Text(
            tr('verifying_email'),
            style: AppTextStyle.titleRegular,
            textAlign: TextAlign.center,
          ),
        ],
      );

  Widget _buildLoadingIndicator() => const SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: Colors.white24,
          strokeWidth: 4.0,
        ),
      );
}
