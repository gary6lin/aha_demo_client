import 'package:aha_demo/values/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '404',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Text(
                tr('page_not_found_title'),
                style: AppTextStyle.titleLargeRegular,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
