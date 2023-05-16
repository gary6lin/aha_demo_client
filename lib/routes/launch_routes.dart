import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../presentation/launch/login_screen.dart';
import '../presentation/launch/register_screen.dart';
import '../presentation/launch/verification_screen.dart';
import 'app_routes.dart';

class LoginRoute {
  static const String name = 'login';
  final String path;

  late final goRoute = GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
      child: const LoginScreen(),
    ),
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
    redirect: (BuildContext context, GoRouterState state) {
      if (state.extra == null && state.queryParameters['oobCode'] == null) {
        return '/nothing';
      }
      return null;
    },
  );

  VerificationRoute(String parentPath) : path = makePath(parentPath, name);
}
