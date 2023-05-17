import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../presentation/launch/login_screen.dart';
import '../presentation/launch/register_screen.dart';
import '../presentation/launch/verification_screen.dart';
import '../repositories/app_repository.dart';
import 'app_routes.dart';

class LoginRoute {
  static const String name = 'login';
  final String path;

  late final goRoute = GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
      child: const LoginScreen(),
    ),
    redirect: _guard,
  );

  LoginRoute(String parentPath) : path = makePath(parentPath, name);
}

class RegisterRoute {
  static const String name = 'register';
  final String path;

  late final goRoute = GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) => const DefaultTransitionPage(
      child: RegisterScreen(),
    ),
    redirect: _guard,
  );

  RegisterRoute(String parentPath) : path = makePath(parentPath, name);
}

class VerificationRoute {
  static const String name = 'verification';
  final String path;

  late final goRoute = GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) => DefaultTransitionPage(
      child: VerificationScreen(
        message: state.extra as String?,
        oobCode: state.queryParameters['oobCode'],
      ),
    ),
    redirect: (BuildContext context, GoRouterState state) async {
      // Redirect to an unidentified page if no required parameters specified
      if (state.extra == null && state.queryParameters['oobCode'] == null) {
        return '/nothing';
      }

      // Redirect to the login if not signed in
      final accessAllowed = await GetIt.I<AppRepository>().accessAllowed();
      if (!accessAllowed) {
        return AppRoute.login.path;
      }

      // No redirection
      return null;
    },
  );

  VerificationRoute(String parentPath) : path = makePath(parentPath, name);
}

Future<String?> _guard(BuildContext context, GoRouterState state) async {
  // Redirect to the dashboard if already signed in
  final accessAllowed = await GetIt.I<AppRepository>().accessAllowed();
  if (accessAllowed) {
    return AppRoute.main.dashboard.path;
  }

  // No redirection
  return null;
}
