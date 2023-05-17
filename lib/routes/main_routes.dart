import 'package:aha_demo/presentation/dashboard/dashboard_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../presentation/main_screen.dart';
import '../presentation/profile/profile_screen.dart';
import '../repositories/app_repository.dart';
import 'app_routes.dart';

class MainRoute {
  final String path;

  late final dashboard = DashboardRoute(path);
  late final profile = ProfileRoute(path);

  late final goRoute = ShellRoute(
    pageBuilder: (BuildContext context, GoRouterState state, Widget child) => FadeTransitionPage(
      child: MainScreen(child: child),
    ),
    routes: <RouteBase>[
      dashboard.goRoute,
      profile.goRoute,
    ],
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
    redirect: _guard,
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
    redirect: _guard,
  );

  ProfileRoute(String parentPath) : path = makePath(parentPath, name);
}

Future<String?> _guard(BuildContext context, GoRouterState state) async {
  // Redirects to the login if not signed in
  final accessAllowed = await GetIt.I<AppRepository>().accessAllowed();
  if (!accessAllowed) {
    return AppRoute.login.path;
  }

  // No redirection
  return null;
}
