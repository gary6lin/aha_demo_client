import 'package:aha_demo/repositories/app_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../repositories/errors/app_error.dart';

class LoginViewModel {
  final _repo = GetIt.I<AppRepository>();

  final onLoading = ValueNotifier<bool>(false);

  void Function()? onSignedIn;
  void Function(Object)? onError;

  /// The scopes required by this application.
  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  Future<void> signIn(String email, String password) async {
    try {
      onLoading.value = true;
      await _repo.signIn(email, password);
      onLoading.value = false;
      onSignedIn?.call();
    } on AppError catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e.errorMessage);
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      await _repo.signInWithFacebook();
      onSignedIn?.call();
    } on AppError catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e.errorMessage);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _repo.signInWithGoogle();
      onSignedIn?.call();
    } on AppError catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e.errorMessage);
    }
  }
}
