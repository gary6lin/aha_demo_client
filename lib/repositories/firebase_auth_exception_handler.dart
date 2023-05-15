import 'package:aha_demo/repositories/errors/user_disabled_error.dart';

import 'errors/email_already_exists_error.dart';
import 'errors/expired_action_code_error.dart';
import 'errors/invalid_action_code_error.dart';
import 'errors/user_not_found_error.dart';

class FirebaseAuthExceptionHandler {
  FirebaseAuthExceptionHandler._();

  // User auth
  static const _emailAlreadyExists = 'email-already-exists';

  // Email verification
  static const _expiredActionCode = 'expired-action-code';
  static const _invalidActionCode = 'invalid-action-code';
  static const _userDisabled = 'user-disabled';
  static const _userNotFound = 'user-not-found';

  static void handle(String? message) {
    // User auth
    if (message?.contains(_emailAlreadyExists) == true) {
      throw EmailAlreadyExistsError();
    }

    // Email verification
    if (message?.contains(_expiredActionCode) == true) {
      throw ExpiredActionCodeError();
    }
    if (message?.contains(_invalidActionCode) == true) {
      throw InvalidActionCodeError();
    }
    if (message?.contains(_userDisabled) == true) {
      throw UserDisabledError();
    }
    if (message?.contains(_userNotFound) == true) {
      throw UserNotFoundError();
    }
  }
}
