import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../presentation/login/login_screen.dart';
import '../presentation/login/register_screen.dart';
import '../presentation/login/verification_screen.dart';
import 'app_routes.dart';

class LoginRoute {
  static const String name = 'login';
  final String path;

  late final register = RegisterRoute(path);
  late final verification = VerificationRoute(path);

  late final goRoute = GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
      child: LoginScreen(),
    ),
    routes: <RouteBase>[
      register.goRoute,
      verification.goRoute,
    ],
  );

  LoginRoute(String parentPath) : path = makePath(parentPath, name);
}

class RegisterRoute {
  static const String name = 'register';
  final String path;

  late final goRoute = GoRoute(
    path: name,
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
    path: name,
    builder: (BuildContext context, GoRouterState state) => const VerificationScreen(),
  );

  VerificationRoute(String parentPath) : path = makePath(parentPath, name);
}
