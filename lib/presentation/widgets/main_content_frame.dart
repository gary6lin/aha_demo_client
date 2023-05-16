import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../../values/constants.dart';

class MainContentFrame extends StatelessWidget {
  final Widget child;

  const MainContentFrame({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveBreakpoints.of(context).smallerThan(TABLET))
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                primary: false,
                padding: const EdgeInsets.all(defaultPadding),
                child: child,
              ),
            ),
          ],
        ),
      );
}
