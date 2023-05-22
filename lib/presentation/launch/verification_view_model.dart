import 'package:get_it/get_it.dart';

import '../../repositories/app_repository.dart';
import '../../repositories/errors/app_error.dart';

class VerificationViewModel {
  final _repo = GetIt.I<AppRepository>();

  void Function()? onEmailVerified;
  void Function()? onEmailVerificationResent;
  void Function(Object)? onError;

  Future<void> onEmailVerify(String oobCode) async {
    try {
      await _repo.verifyEmail(oobCode);
      await _repo.reloadUser();
      onEmailVerified?.call();
    } on AppError catch (e) {
      onError?.call(e.errorMessage);
    }
  }

  Future<void> onResendEmailVerification() async {
    try {
      await _repo.sendEmailVerification();
      onEmailVerificationResent?.call();
    } on AppError catch (e) {
      onError?.call(e.errorMessage);
    }
  }
}
