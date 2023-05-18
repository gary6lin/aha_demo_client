import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../models/auth_state.dart';
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
        oobCode: state.queryParameters['oobCode'],
      ),
    ),
    redirect: (BuildContext context, GoRouterState state) async {
      final authState = await GetIt.I<AppRepository>().getAuthState();
      switch (authState) {
        case AuthState.emailVerified:
          // Redirects to the dashboard if signed in and email verified
          return AppRoute.main.dashboard.path;
        case AuthState.emailNotVerified:
          // No redirection
          return null;
        case AuthState.noAuth:
          // Redirects to the login
          return AppRoute.login.path;
      }
    },
  );

  VerificationRoute(String parentPath) : path = makePath(parentPath, name);
}

Future<String?> _guard(BuildContext context, GoRouterState state) async {
  final authState = await GetIt.I<AppRepository>().getAuthState();
  switch (authState) {
    case AuthState.emailVerified:
      // Redirects to the dashboard if signed in and email verified
      return AppRoute.main.dashboard.path;
    case AuthState.emailNotVerified:
      // Redirects to the verification if signed in but have not verified email
      return AppRoute.verification.path;
    case AuthState.noAuth:
      // No redirection
      return null;
  }
}
