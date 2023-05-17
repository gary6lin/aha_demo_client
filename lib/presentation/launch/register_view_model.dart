import 'package:aha_demo/repositories/app_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class RegisterViewModel {
  final _repo = GetIt.I<AppRepository>();

  final onLoading = ValueNotifier<bool>(false);

  void Function()? onRegistered;
  void Function(Object)? onError;

  Future<void> register(String email, String password, String displayName) async {
    try {
      onLoading.value = true;
      await _repo.register(email, password, displayName);
      onLoading.value = false;
      onRegistered?.call();
    } catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e);
    }
  }
}
