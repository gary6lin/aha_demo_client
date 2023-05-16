import 'package:flutter/material.dart';

import '../../values/constants.dart';
import '../widgets/main_content_frame.dart';
import 'widgets/user_statistics_widget.dart';
import 'widgets/users_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => const MainContentFrame(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserStatisticsWidget(),
              SizedBox(height: defaultPadding),
              UsersWidget(),
            ],
          ),
        ),
      );
}
