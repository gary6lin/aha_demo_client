import 'package:aha_demo/presentation/dashboard/dashboard_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../presentation/main_screen.dart';
import '../presentation/profile/profile_screen.dart';
import 'app_routes.dart';

class MainRoute {
  final String path;

  late final dashboard = DashboardRoute(path);
  late final profile = ProfileRoute(path);

  late final goRoute = ShellRoute(
    // path: path,
    // pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
    //   child: const MainScreen(),
    // ),
    pageBuilder: (BuildContext context, GoRouterState state, Widget child) => FadeTransitionPage(
      child: MainScreen(child: child),
    ),
    routes: <RouteBase>[
      dashboard.goRoute,
      profile.goRoute,
    ],
    // redirect: AppRoute.guard,
  );

  MainRoute(this.path);
}

class DashboardRoute {
  static const String name = 'dashboard';
  final String path;

  late final goRoute = GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) => const DefaultTransitionPage(
      child: DashboardScreen(),
    ),
  );

  DashboardRoute(String parentPath) : path = makePath(parentPath, name);
}

class ProfileRoute {
  static const String name = 'profile';
  final String path;

  late final goRoute = GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) => const DefaultTransitionPage(
      child: ProfileScreen(),
    ),
  );

  ProfileRoute(String parentPath) : path = makePath(parentPath, name);
}
