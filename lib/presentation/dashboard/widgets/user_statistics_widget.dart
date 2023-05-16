import 'package:aha_demo/values/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:responsive_framework/responsive_value.dart';

import '../../../values/constants.dart';
import '../../widgets/app_card.dart';

class UserStatisticsWidget extends StatelessWidget {
  const UserStatisticsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => Container(
          child: ResponsiveValue<Widget>(
            context,
            conditionalValues: [
              Condition.equals(
                name: MOBILE,
                value: _buildUserStatistics(),
              ),
              Condition.equals(
                name: TABLET,
                value: _buildUserStatistics(),
              ),
              Condition.equals(
                name: DESKTOP,
                value: _buildUserStatistics(
                  childAspectRatio: constraints.maxWidth < 1400 ? 1.1 : 1.4,
                ),
              ),
            ],
          ).value,
        ),
      );

  Widget _buildUserStatistics({
    int crossAxisCount = 4,
    double childAspectRatio = 1,
  }) =>
      GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        children: [
          _buildCard(
            title: 'DAU',
            value: 78,
          ),
          _buildCard(
            title: 'DAU',
            value: 78,
          ),
          _buildCard(
            title: 'DAU',
            value: 78,
          ),
        ],
      );

  Widget _buildCard({
    required String title,
    required int value,
  }) =>
      AppCard(
        padding: defaultPadding,
        radius: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$value',
              style: AppTextStyle.titleLargeBold,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTextStyle.bodyBold,
            ),
          ],
        ),
      );
}
