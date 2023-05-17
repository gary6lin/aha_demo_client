import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../values/app_text_style.dart';
import 'app_card.dart';

class ExpandingDropdownTile extends StatelessWidget {
  final ExpandableController? controller;
  final String titleText;
  final Widget body;

  const ExpandingDropdownTile({
    Key? key,
    this.controller,
    required this.titleText,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ExpandableNotifier(
        child: Expandable(
          controller: controller,
          collapsed: ExpandableButton(
            theme: ExpandableThemeData(
              inkWellBorderRadius: BorderRadius.circular(10),
            ),
            child: AppCard(
              width: null,
              child: _buildExpandableItem(
                title: titleText,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 28,
                ),
              ),
            ),
          ),
          expanded: ExpandableButton(
            theme: ExpandableThemeData(
              inkWellBorderRadius: BorderRadius.circular(10),
            ),
            child: AppCard(
              width: null,
              child: _buildExpandableItem(
                title: titleText,
                icon: const Icon(
                  Icons.close_rounded,
                  size: 28,
                ),
                body: body,
              ),
            ),
          ),
        ),
      );

  Widget _buildExpandableItem({required String title, required Widget icon, Widget? body}) => SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bodyRegular,
                ),
                icon,
              ],
            ),
            if (body != null)
              Padding(
                padding: const EdgeInsets.only(top: 28),
                child: body,
              ),
          ],
        ),
      );
}
