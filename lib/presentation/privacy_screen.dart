import 'package:aha_demo/values/app_text_style.dart';
import 'package:flutter/material.dart';

import '../values/privacy_policy.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(64),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: const Text(
                privacyPolicy,
                style: AppTextStyle.bodyRegular,
              ),
            ),
          ),
        ),
      );
}
