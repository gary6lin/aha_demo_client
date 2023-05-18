import 'package:aha_demo/presentation/widgets/app_filled_button.dart';
import 'package:aha_demo/values/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../utils/show_alert.dart';
import '../widgets/app_card.dart';
import 'verification_view_model.dart';

class VerificationScreen extends StatefulWidget {
  final String? oobCode;

  const VerificationScreen({
    Key? key,
    this.oobCode,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _vm = VerificationViewModel();
  final _onErrorMessage = ValueNotifier<String?>(null);
  final _onMessage = ValueNotifier<String>(tr('email_verification_sent'));

  @override
  void initState() {
    super.initState();

    _vm.onEmailVerified = () {
      context.go(AppRoute.main.path);
    };

    _vm.onEmailVerificationResent = () {
      _onMessage.value = tr('email_verification_resent');
    };

    _vm.onError = (e) {
      if (widget.oobCode == null) {
        showAlert(
          context: context,
          title: e.toString(),
        );
      } else {
        _onErrorMessage.value = e.toString();
      }
    };

    final oobCode = widget.oobCode;
    if (oobCode != null) {
      _vm.onEmailVerify(oobCode);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: AppCard(
            height: 280,
            radius: 16,
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: _onErrorMessage,
                builder: (BuildContext context, String? errorMessage, Widget? child) {
                  if (widget.oobCode == null) {
                    return _buildMessageWithResend();
                  }
                  return errorMessage == null ? _buildEmailVerifying() : _buildErrorMessage(errorMessage);
                },
              ),
            ),
          ),
        ),
      );

  Widget _buildMessageWithResend() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: _onMessage,
            builder: (BuildContext context, String message, Widget? child) => Text(
              message,
              style: AppTextStyle.titleRegular,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 64),
          AppFilledButton(
            child: Text(
              tr('email_resend'),
            ),
            onPressed: () async {
              await _vm.onResendEmailVerification();
            },
          ),
        ],
      );

  Widget _buildErrorMessage(String errorMessage) => Center(
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
