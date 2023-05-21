import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../models/current_user.dart';
import '../../repositories/app_repository.dart';
import '../../repositories/errors/app_error.dart';

class ProfileViewModel {
  final _repo = GetIt.I<AppRepository>();

  final onUserModel = ValueNotifier<CurrentUser?>(null);

  void Function()? onUpdatedDisplayName;
  void Function()? onChangedPassword;
  void Function()? onSignedOut;
  void Function(Object)? onError;

  Future<void> loadProfile() async {
    try {
      final user = await _repo.getCurrentUser();
      onUserModel.value = CurrentUser(
        email: user?.email,
        displayName: user?.displayName,
        photoURL: user?.photoURL,
      );
    } on AppError catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e.errorMessage);
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    try {
      await _repo.updateUserInfo(
        displayName: displayName,
      );
      // Update the user model for display
      onUserModel.value = CurrentUser(
        email: onUserModel.value?.email,
        displayName: displayName,
      );
      // Triggers the updated display name event
      onUpdatedDisplayName?.call();
    } on AppError catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e.errorMessage);
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await _repo.updateUserPassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      // Triggers the changed password event
      onChangedPassword?.call();
    } on AppError catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e.errorMessage);
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
