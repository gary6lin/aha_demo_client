import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'login_routes.dart';
import 'main_routes.dart';

String makePath(String path, String subPath) => '$path/$subPath'.replaceAll('//', '/');

class AppRoute {
  static final navigator = AppNavigator();

  static final main = MainRoute('/');
  static final login = LoginRoute(main.path);

  static final goRouter = GoRouter(
    initialLocation: main.path,
    routes: <RouteBase>[
      AppRoute.main.goRoute,
      AppRoute.login.goRoute,
    ],
  );
}

class AppNavigator {
  Route<T> routeFor<T>(Widget page) {
    if (kIsWeb) {
      return PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: page,
        ),
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoPageRoute<T>(builder: (BuildContext context) => page);
      default:
        return MaterialPageRoute<T>(builder: (BuildContext context) => page);
    }
  }
}
