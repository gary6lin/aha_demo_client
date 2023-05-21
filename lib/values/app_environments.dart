abstract class AppEnvironments {
  AppEnvironments._();

  static const host = bool.hasEnvironment('HOST') ? String.fromEnvironment('HOST') : 'http://localhost:3000/';
}
