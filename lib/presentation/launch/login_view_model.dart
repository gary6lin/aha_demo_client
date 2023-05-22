import 'package:aha_demo/repositories/app_repository.dart';
import 'package:get_it/get_it.dart';

import '../../repositories/errors/app_error.dart';

class LoginViewModel {
  final _repo = GetIt.I<AppRepository>();

  void Function()? onSignedIn;
  void Function(Object)? onError;

  Future<void> signIn(String email, String password) async {
    try {
      await _repo.signIn(email, password);
      onSignedIn?.call();
    } on AppError catch (e) {
      onError?.call(e.errorMessage);
    } catch (e) {
      onError?.call('$e');
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      await _repo.signInWithFacebook();
      onSignedIn?.call();
    } on AppError catch (e) {
      onError?.call(e.errorMessage);
    } catch (e) {
      onError?.call('$e');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _repo.signInWithGoogle();
      onSignedIn?.call();
    } on AppError catch (e) {
      onError?.call(e.errorMessage);
    } catch (e) {
      onError?.call('$e');
    }
  }
}
