import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../repositories/app_repository.dart';
import 'launch_routes.dart';
import 'main_routes.dart';

String makePath(String path, String subPath) => '$path/$subPath'.replaceAll('//', '/');

class AppRoute {
  static final navigator = AppNavigator();

  static final main = MainRoute('/');
  static final login = LoginRoute(main.path);
  static final register = RegisterRoute(main.path);
  static final verification = VerificationRoute(main.path);

  static final _signInNotifier = ValueNotifier<bool?>(null);
  static bool get _signedIn => _signInNotifier.value ?? false;

  static final goRouter = GoRouter(
    initialLocation: main.path,
    routes: <RouteBase>[
      AppRoute.main.goRoute,
      AppRoute.login.goRoute,
      AppRoute.register.goRoute,
      AppRoute.verification.goRoute,
    ],
    refreshListenable: _signInNotifier,
  );

  static Future<void> checkSignInAndUpdateRoute() async {
    final repo = GetIt.I<AppRepository>();
    final accessToken = await repo.getAccessToken();
    _signInNotifier.value = accessToken != null;
  }

  static Future<String?> guard(BuildContext context, GoRouterState state) async {
    if (_signInNotifier.value == null) {
      await checkSignInAndUpdateRoute();
    }
    if (!_signedIn) {
      // Show the login screen if not signed in
      return AppRoute.login.path;
    } else {
      // No redirection
      return null;
    }
  }
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
