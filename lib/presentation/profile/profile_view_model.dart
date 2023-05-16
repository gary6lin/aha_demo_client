import 'package:aha_demo/repositories/app_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class ProfileViewModel {
  final _repo = GetIt.I<AppRepository>();

  final onUser = ValueNotifier<User?>(null);

  void Function()? onSignedOut;
  void Function(User?)? onLoaded;
  void Function(Object)? onError;

  Future<void> onLoad() async {
    try {
      onUser.value = await _repo.getCurrentUser();
    } catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e);
    }
  }

  Future<void> onSignOut() async {
    try {
      await _repo.signOut();
      onSignedOut?.call();
    } catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e);
    }
  }
}
