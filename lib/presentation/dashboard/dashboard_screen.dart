import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../repositories/dto/response/users_result_dto.dart';
import '../../utils/app_date_time.dart';
import '../../values/app_text_style.dart';
import '../../values/constants.dart';
import '../widgets/app_card.dart';
import '../widgets/app_filled_button.dart';
import '../widgets/main_content_frame.dart';
import 'dashboard_view_model.dart';
import 'widgets/user_statistics_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _vm = DashboardViewModel();

  int currentPage = 0;
  bool get isFirstPage => currentPage == 0;

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
            ValueListenableBuilder(
              valueListenable: _vm.onUserRecordPages,
              builder: (BuildContext context, List<List<UserRecord>> pageList, Widget? child) =>
                  _buildUserRecordPages(pageList),
            ),
          ],
        ),
      );

  Widget _buildUserRecordPages(List<List<UserRecord>> pageList) => Container(
        child: pageList.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('registered_users'),
                    style: AppTextStyle.titleRegular,
                  ),
                  const SizedBox(height: defaultPadding),
                  AppCard(
                    width: null,
                    padding: defaultPadding,
                    child: SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        columnSpacing: defaultPadding,
                        columns: _buildTableTitles(),
                        rows: List.generate(
                          pageList[currentPage].length,
                          (index) => _buildTableRow(pageList[currentPage][index]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  _buildPageControls(),
                ],
              )
            : null,
      );

  Widget _buildPageControls() => Row(
        children: [
          SizedBox(
            width: 128,
            child: AppFilledButton(
              buttonSize: AppFilledButtonSize.small,
              onPressed: !isFirstPage
                  ? () async {
                      // TODO
                    }
                  : null,
              child: Text(
                tr('dashboard_table_control_previous'),
              ),
            ),
          ),
          const SizedBox(width: defaultPadding),
          SizedBox(
            width: 128,
            child: AppFilledButton(
              buttonSize: AppFilledButtonSize.small,
              child: Text(
                tr('dashboard_table_control_next'),
              ),
              onPressed: () async {
                // TODO
              },
            ),
          ),
        ],
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
            Text(
              AppDateTime.convert(
                userRecord.metadata.creationTime,
                context.locale.toString(),
              ),
            ),
          ),
          DataCell(
            Text(
              AppDateTime.convert(
                userRecord.metadata.lastRefreshTime,
                context.locale.toString(),
              ),
            ),
          ),
          DataCell(
            Text(
              AppDateTime.convert(
                userRecord.metadata.lastSignInTime,
                context.locale.toString(),
              ),
            ),
          ),
        ],
      );
}
