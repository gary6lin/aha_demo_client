import 'dart:developer';

import 'package:aha_demo/repositories/app_repository.dart';
import 'package:get_it/get_it.dart';

class RegisterViewModel {
  final _repo = GetIt.I<AppRepository>();

  void Function()? onRegistered;
  void Function(Object)? onError;

  Future<void> onRegister(String email, String password, String displayName) async {
    try {
      await _repo.register(email, password, displayName);
      onRegistered?.call();
    } catch (e) {
      log('$e');
      onError?.call(e);
    }
  }
}
