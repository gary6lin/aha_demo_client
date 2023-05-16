import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class MainContentFrame extends StatelessWidget {
  final Widget child;

  const MainContentFrame({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          children: [
            if (ResponsiveBreakpoints.of(context).smallerThan(TABLET))
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            child,
          ],
        ),
      );
}
