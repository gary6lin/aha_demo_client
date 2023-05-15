import 'dart:developer';

import 'package:aha_demo/repositories/app_repository.dart';
import 'package:get_it/get_it.dart';

class VerificationViewModel {
  final _repo = GetIt.I<AppRepository>();

  void Function()? onEmailVerified;
  void Function(Object)? onError;

  Future<void> onEmailVerify(String oobCode) async {
    try {
      await _repo.emailVerification(oobCode);
      onEmailVerified?.call();
    } catch (e) {
      log('$e');
      onError?.call(e);
    }
  }
}
