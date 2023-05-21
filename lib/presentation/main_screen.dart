import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import 'widgets/side_menu.dart';

class MainScreen extends StatefulWidget {
  final Widget child;

  const MainScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Keep the menu on the side for tablets and larger screen
              if (ResponsiveBreakpoints.of(context).largerOrEqualTo(TABLET))
                const SizedBox(
                  width: 220,
                  child: SideMenu(),
                ),
              Expanded(
                child: widget.child,
              ),
            ],
          ),
        ),
      );
}
