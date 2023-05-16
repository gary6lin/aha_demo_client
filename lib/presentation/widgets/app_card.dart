import 'package:flutter/widgets.dart';

import '../../values/app_colors.dart';

class AppCard extends StatelessWidget {
  final double? width;
  final double? height;
  final double padding;
  final double radius;
  final Widget child;

  const AppCard({
    Key? key,
    this.width = 400,
    this.height,
    this.padding = 24,
    this.radius = 10,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      );
}
