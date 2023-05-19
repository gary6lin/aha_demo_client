import 'package:aha_demo/repositories/app_repository.dart';
import 'package:aha_demo/repositories/errors/app_error.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class RegisterViewModel {
  final _repo = GetIt.I<AppRepository>();

  void Function()? onRegistered;
  void Function(AppError)? onError;

  Future<void> register(String email, String password, String displayName) async {
    try {
      await _repo.register(email, password, displayName);
      onRegistered?.call();
    } on AppError catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e);
    }
  }
}
