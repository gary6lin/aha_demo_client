import 'package:aha_demo/repositories/app_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../repositories/errors/app_error.dart';

class LoginViewModel {
  final _repo = GetIt.I<AppRepository>();

  final onLoading = ValueNotifier<bool>(false);

  void Function()? onSignedIn;
  void Function(Object)? onError;

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
}
