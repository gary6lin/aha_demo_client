import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../dashboard/dashboard_screen.dart';
import 'widgets/side_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        // key: _scaffoldKey,
        drawer: const SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Keep the menu on the side for tablets in larger screen
              if (ResponsiveBreakpoints.of(context).largerOrEqualTo(TABLET))
                const SizedBox(
                  width: 220,
                  child: SideMenu(),
                ),
              const Expanded(
                child: DashboardScreen(),
              ),
            ],
          ),
        ),
      );
}
