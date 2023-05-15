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
    pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
      child: LoginScreen(),
    ),
  );

  LoginRoute(String parentPath) : path = makePath(parentPath, name);
}

class RegisterRoute {
  static const String name = 'register';
  final String path;

  late final goRoute = GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
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
    builder: (BuildContext context, GoRouterState state) => VerificationScreen(
      message: state.extra as String?,
      oobCode: state.queryParameters['oobCode'],
    ),
  );

  VerificationRoute(String parentPath) : path = makePath(parentPath, name);
}
