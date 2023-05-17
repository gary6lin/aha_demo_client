import 'package:aha_demo/presentation/dashboard/dashboard_view_model.dart';
import 'package:aha_demo/repositories/dto/response/users_result_dto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../values/app_text_style.dart';
import '../../values/constants.dart';
import '../widgets/app_card.dart';
import '../widgets/main_content_frame.dart';
import 'widgets/user_statistics_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _vm = DashboardViewModel();

  int page = 0;

  @override
  void initState() {
    super.initState();

    _vm.loadDashboard();
  }

  @override
  Widget build(BuildContext context) => MainContentFrame(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserStatisticsWidget(),
            const SizedBox(height: defaultPadding),
            Text(
              tr('registered_users'),
              style: AppTextStyle.titleRegular,
            ),
            const SizedBox(height: defaultPadding),
            _buildUserRecords(),
          ],
        ),
      );

  Widget _buildUserRecords() => AppCard(
        width: null,
        padding: defaultPadding,
        child: ValueListenableBuilder(
          valueListenable: _vm.onUserRecords,
          builder: (BuildContext context, List<List<UserRecord>> list, Widget? child) => SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              columns: _buildTableTitles(),
              rows: List.generate(
                list.length,
                (index) => _buildTableRow(list[page][index]),
              ),
            ),
          ),
        ),
      );

  List<DataColumn> _buildTableTitles() => [
        DataColumn(
          label: Text(
            tr('dashboard_table_column_email'),
          ),
        ),
        DataColumn(
          label: Text(
            tr('dashboard_table_column_created'),
          ),
        ),
        DataColumn(
          label: Text(
            tr('dashboard_table_column_count'),
          ),
        ),
        DataColumn(
          label: Text(
            tr('dashboard_table_column_session'),
          ),
        ),
      ];

  DataRow _buildTableRow(UserRecord userRecord) => DataRow(
        cells: [
          DataCell(
            Text(userRecord.email),
          ),
          DataCell(
            Text(userRecord.metadata.creationTime),
          ),
          DataCell(
            Text(userRecord.metadata.lastRefreshTime),
          ),
          DataCell(
            Text(userRecord.metadata.lastSignInTime),
          ),
        ],
      );
}
