import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../repositories/dto/response/users_result_dto.dart';
import '../../repositories/dto/response/users_statistic_dto.dart';
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

  @override
  void initState() {
    super.initState();

    _vm.loadUsersStatistic();
    _vm.loadUserList();
  }

  @override
  Widget build(BuildContext context) => MainContentFrame(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: _vm.onUsersStatistics,
              builder: (BuildContext context, UsersStatisticDto? data, Widget? child) => UserStatisticsWidget(
                data: data,
              ),
            ),
            const SizedBox(height: defaultPadding),
            ValueListenableBuilder(
              valueListenable: _vm.onUserRecordPages,
              builder: (BuildContext context, List<List<UserRecord>> pageList, Widget? child) => AnimatedOpacity(
                opacity: pageList.isNotEmpty ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: _buildUserRecordPages(pageList),
              ),
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
                          pageList[_vm.currentPage].length,
                          (index) => _buildTableRow(pageList[_vm.currentPage][index]),
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
              onPressed: !_vm.isFirstPage
                  ? () async {
                      await _vm.loadPreviousPage();
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
                await _vm.loadMoreUserList();
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
        // DataColumn(
        //   label: Text(
        //     tr('dashboard_table_column_count'),
        //   ),
        // ),
        DataColumn(
          label: Text(
            tr('dashboard_table_column_session'),
          ),
        ),
      ];

  DataRow _buildTableRow(UserRecord userRecord) => DataRow(
        cells: [
          DataCell(
            Text(userRecord.email ?? ''),
          ),
          DataCell(
            Text(
              AppDateTime.parseDateTime(
                userRecord.creationTime,
                context.locale.toString(),
              ),
            ),
          ),
          // DataCell(
          //   Text(
          //     AppDateTime.parseDateTime(
          //       userRecord.lastRefreshTime,
          //       context.locale.toString(),
          //     ),
          //   ),
          // ),
          DataCell(
            Text(
              AppDateTime.parseDateTime(
                userRecord.lastSignInTime,
                context.locale.toString(),
              ),
            ),
          ),
        ],
      );
}
