import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../presentation/page_not_found_screen.dart';
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

  static final goRouter = GoRouter(
    initialLocation: main.path,
    routes: <RouteBase>[
      AppRoute.main.goRoute,
      AppRoute.login.goRoute,
      AppRoute.register.goRoute,
      AppRoute.verification.goRoute,
    ],
    errorPageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
      child: const PageNotFoundScreen(),
    ),
    redirect: AppRoute.guard,
  );

  static Future<String?> guard(BuildContext context, GoRouterState state) async {
    final accessAllowed = await GetIt.I<AppRepository>().accessAllowed();
    if (!accessAllowed) {
      // Show the login screen if not signed in
      return AppRoute.login.path;
    } else if (state.path == null || state.path == main.path) {
      // Redirect the root path to dashboard
      return AppRoute.main.dashboard.path;
    } else {
      // No redirection
      return null;
    }
  }
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
