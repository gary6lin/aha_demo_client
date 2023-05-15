import 'package:aha_demo/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../app_locale.dart';
import '../../values/app_colors.dart';

class LanguageSwitcher extends StatelessWidget {
  final languages = SupportedLocale.values;

  const LanguageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => RichText(
        text: TextSpan(
          style: TextStyle(color: AppColors.textLight.withOpacity(0.6), fontSize: 13),
          children: <TextSpan>[
            ...languages
                .map(
                  (e) => TextSpan(
                    text: e.tr,
                    recognizer: TapGestureRecognizer()..onTap = () async => await context.setLocale(e.value),
                  ),
                )
                .superJoin(
                  separator: const TextSpan(text: '  |  '),
                ),
          ],
        ),
      );
}
