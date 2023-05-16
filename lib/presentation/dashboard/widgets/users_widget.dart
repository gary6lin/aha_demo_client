import 'package:aha_demo/presentation/widgets/app_card.dart';
import 'package:aha_demo/values/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../repositories/dto/user_dto.dart';
import '../../../values/constants.dart';

class UsersWidget extends StatelessWidget {
  static const list = [
    UserDto(
      'a@gmail.com',
      '12 May 2024',
      '234',
      '23 June 2024',
    ),
    UserDto(
      'a@gmail.com',
      '12 May 2024',
      '234',
      '23 June 2024',
    ),
    UserDto(
      'a@gmail.com',
      '12 May 2024',
      '234',
      '23 June 2024',
    ),
  ];

  const UsersWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AppCard(
        width: null,
        padding: defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Users',
              style: AppTextStyle.titleRegular,
            ),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: defaultPadding,
                // minWidth: 600,
                columns: const [
                  DataColumn(
                    label: Text('Email'),
                  ),
                  DataColumn(
                    label: Text('Created'),
                  ),
                  DataColumn(
                    label: Text('Login count'),
                  ),
                  DataColumn(
                    label: Text('Last logged in'),
                  ),
                ],
                rows: List.generate(
                  list.length,
                  (index) {
                    final item = list[index];
                    return recentFileDataRow(
                      email: item.email,
                      created: item.created,
                      count: item.count,
                      lastLoggedIn: item.lastLoggedIn,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
}

DataRow recentFileDataRow({
  required String email,
  required String created,
  required String count,
  required String lastLoggedIn,
}) =>
    DataRow(
      cells: [
        DataCell(
          Text(email),
        ),
        DataCell(
          Text(created),
        ),
        DataCell(
          Text(count),
        ),
        DataCell(
          Text(count),
        ),
      ],
    );
