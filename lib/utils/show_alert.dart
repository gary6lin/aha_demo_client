import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../values/app_colors.dart';
import '../values/app_text_style.dart';

Future<T?> showAlert<T>({
  required BuildContext context,
  required String title,
}) {
  return showDialog(
    context: context,
    barrierColor: Colors.transparent,
    barrierDismissible: false,
    builder: (BuildContext context) => Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500,
        ),
        child: SimpleDialog(
          title: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
          titleTextStyle: AppTextStyle.bodyRegular.copyWith(
            color: AppColors.textDark,
          ),
          contentPadding: const EdgeInsets.all(16),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          children: [
            Center(
              child: TextButton(
                child: Text(
                  tr('confirmation'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
