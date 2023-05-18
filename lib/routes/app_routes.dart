import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/page_not_found_screen.dart';
import '../presentation/privacy_screen.dart';
import 'launch_routes.dart';
import 'main_routes.dart';

String makePath(String path, String subPath) => '$path/$subPath'.replaceAll('//', '/');

class AppRoute {
  static final navigator = AppNavigator();

  static final main = MainRoute('/');
  static final login = LoginRoute(main.path);
  static final register = RegisterRoute(main.path);
  static final verification = VerificationRoute(main.path);
  static final privacy = PrivacyRoute(main.path);

  static final goRouter = GoRouter(
    initialLocation: main.path,
    routes: <RouteBase>[
      AppRoute.main.goRoute,
      AppRoute.login.goRoute,
      AppRoute.register.goRoute,
      AppRoute.verification.goRoute,
      AppRoute.privacy.goRoute,
    ],
    errorPageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
      child: const PageNotFoundScreen(),
    ),
    redirect: (BuildContext context, GoRouterState state) async {
      // Redirects the root path to the dashboard
      if (state.location == main.path) {
        return main.dashboard.path;
      }

      // No redirection
      return null;
    },
  );
}

class PrivacyRoute {
  static const String name = 'privacy';
  final String path;

  late final goRoute = GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) => const DefaultTransitionPage(
      child: PrivacyScreen(),
    ),
  );

  PrivacyRoute(String parentPath) : path = makePath(parentPath, name);
}

class DefaultTransitionPage extends NoTransitionPage {
  const DefaultTransitionPage({required super.child});
}

class FadeTransitionPage extends CustomTransitionPage {
  FadeTransitionPage({required Widget child})
      : super(
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: child,
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
