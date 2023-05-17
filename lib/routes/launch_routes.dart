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
      final user = await GetIt.I<AppRepository>().getCurrentUser();

      // No redirection if required parameters are specified
      if (state.extra != null || state.queryParameters['oobCode'] != null) {
        return null;
      }

      // Redirects to the login if not signed in
      if (user == null) {
        return AppRoute.login.path;
      }

      // Redirects to the dashboard if the email is verified
      if (user.emailVerified) {
        return AppRoute.main.dashboard.path;
      }

      // Redirects to an unidentified page
      return '/nothing';
    },
  );

  VerificationRoute(String parentPath) : path = makePath(parentPath, name);
}

Future<String?> _guard(BuildContext context, GoRouterState state) async {
  final accessAllowed = await GetIt.I<AppRepository>().accessAllowed();

  // Redirects to the dashboard if already signed in
  if (accessAllowed) {
    return AppRoute.main.dashboard.path;
  }

  // No redirection
  return null;
}
