import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../models/current_user.dart';
import '../../repositories/app_repository.dart';

class DashboardViewModel {
  final _repo = GetIt.I<AppRepository>();

  final onUser = ValueNotifier<CurrentUser?>(null);

  void Function()? onUpdatedDisplayName;
  void Function()? onChangedPassword;
  void Function()? onSignedOut;
  void Function(Object)? onError;

  Future<void> loadProfile() async {
    try {
      final user = await _repo.getCurrentUser();
      onUser.value = CurrentUser(
        email: user?.email,
        displayName: user?.displayName,
        photoURL: user?.photoURL,
      );
    } catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e);
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    try {
      await _repo.updateProfile(
        displayName: displayName,
      );
      // Update the user model for display
      onUser.value = CurrentUser(
        email: onUser.value?.email,
        displayName: displayName,
      );
      // Triggers the updated display name event
      onUpdatedDisplayName?.call();
    } catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e);
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await _repo.updateProfile(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      // Triggers the changed password event
      onChangedPassword?.call();
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
