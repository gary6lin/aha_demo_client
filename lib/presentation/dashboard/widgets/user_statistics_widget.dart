import 'package:aha_demo/values/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:responsive_framework/responsive_value.dart';

import '../../../repositories/dto/response/users_statistic_dto.dart';
import '../../../values/constants.dart';
import '../../widgets/app_card.dart';

class UserStatisticsWidget extends StatelessWidget {
  final UsersStatisticDto? data;

  const UserStatisticsWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => Container(
          child: ResponsiveValue<Widget>(
            context,
            conditionalValues: [
              Condition.equals(
                name: MOBILE,
                value: _buildUserStatistics(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                ),
              ),
              Condition.equals(
                name: TABLET,
                value: _buildUserStatistics(
                  childAspectRatio: 1.2,
                ),
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
            title: tr('dashboard_total_users'),
            value: data?.totalUsers,
          ),
          _buildCard(
            title: tr('dashboard_active_users'),
            value: data?.activeUsers,
          ),
          _buildCard(
            title: tr('dashboard_average_active_users'),
            value: data?.averageActiveUsers,
          ),
        ],
      );

  Widget _buildCard({
    required String title,
    required int? value,
  }) =>
      AppCard(
        padding: defaultPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value == null ? '' : '$value',
              style: AppTextStyle.titleExtraLargeBold,
            ),
            const SizedBox(height: 32),
            Text(
              title,
              style: AppTextStyle.bodyRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
