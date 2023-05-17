import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../repositories/app_repository.dart';
import '../../repositories/errors/app_error.dart';

class VerificationViewModel {
  final _repo = GetIt.I<AppRepository>();

  void Function()? onEmailVerified;
  void Function(Object)? onError;

  Future<void> onEmailVerify(String oobCode) async {
    try {
      await _repo.emailVerification(oobCode);
      await _repo.reloadUser();
      onEmailVerified?.call();
    } on AppError catch (e) {
      if (kDebugMode) print(e);
      onError?.call(e.errorMessage);
    }
  }
}
