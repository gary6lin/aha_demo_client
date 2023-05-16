import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../presentation/main_screen.dart';
import '../presentation/profile/profile_screen.dart';
import 'app_routes.dart';

class MainRoute {
  final String path;

  late final profile = ProfileRoute(path);

  late final goRoute = GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
      child: const MainScreen(),
    ),
    routes: <RouteBase>[
      profile.goRoute,
    ],
    redirect: AppRoute.guard,
  );

  MainRoute(this.path);
}

class ProfileRoute {
  static const String name = 'profile';
  final String path;

  late final goRoute = GoRoute(
    path: name,
    pageBuilder: (BuildContext context, GoRouterState state) => const DefaultTransitionPage(
      child: ProfileScreen(),
    ),
  );

  ProfileRoute(String parentPath) : path = makePath(parentPath, name);
}
