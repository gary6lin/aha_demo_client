import 'package:aha_demo/repositories/app_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../model/user_model.dart';

class ProfileViewModel {
  final _repo = GetIt.I<AppRepository>();

  final onUser = ValueNotifier<UserModel?>(null);

  void Function()? onUpdatedDisplayName;
  void Function()? onChangedPassword;
  void Function()? onSignedOut;
  void Function(Object)? onError;

  Future<void> onLoad() async {
    try {
      final user = await _repo.getCurrentUser();
      onUser.value = UserModel(
        email: user?.email,
        displayName: user?.displayName,
        photoURL: user?.photoURL,
      );
    } catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e);
    }
  }

  Future<void> onUpdateDisplayName(String displayName) async {
    try {
      await _repo.updateProfile(
        displayName: displayName,
      );
      final user = onUser.value;
      onUser.value = UserModel(
        email: user?.email,
        displayName: user?.displayName,
      );
      onUpdatedDisplayName?.call();
    } catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e);
    }
  }

  Future<void> onChangePassword(String currentPassword, String newPassword) async {
    try {
      await _repo.updateProfile(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
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
