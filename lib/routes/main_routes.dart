import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../presentation/main/main_screen.dart';
import '../presentation/profile_screen.dart';
import 'app_routes.dart';

class MainRoute {
  final String path;

  late final profile = ProfileRoute(path);

  late final goRoute = GoRoute(
    path: path,
    builder: (BuildContext context, GoRouterState state) => const MainScreen(),
    routes: <RouteBase>[
      profile.goRoute,
    ],
    // redirect: (BuildContext context, GoRouterState state) async {
    //   final repo = GetIt.I<AppRepository>();
    //   final accessToken = await repo.getAccessToken();
    //   if (accessToken == null) {
    //     return AppRoute.login.path;
    //   } else {
    //     return null;
    //   }
    // },
  );

  MainRoute(this.path);
}

class ProfileRoute {
  static const String name = 'profile';
  final String path;

  late final goRoute = GoRoute(
    path: name,
    builder: (BuildContext context, GoRouterState state) => const ProfileScreen(),
  );

  ProfileRoute(String parentPath) : path = makePath(parentPath, name);
}
