import 'dart:developer';

import 'package:aha_demo/repositories/app_repository.dart';
import 'package:get_it/get_it.dart';

class LoginViewModel {
  final _repo = GetIt.I<AppRepository>();

  void Function()? onSignedIn;
  void Function(Object)? onError;

  Future<void> onSignIn(String email, String password) async {
    try {
      await _repo.signIn(email, password);
      onSignedIn?.call();
    } catch (e) {
      log('$e');
      onError?.call(e);
    }
  }
}
