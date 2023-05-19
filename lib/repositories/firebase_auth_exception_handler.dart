import 'errors/email_already_exists_error.dart';
import 'errors/expired_action_code_error.dart';
import 'errors/invalid_action_code_error.dart';
import 'errors/invalid_page_token_error.dart';
import 'errors/user_disabled_error.dart';
import 'errors/user_not_found_error.dart';
import 'errors/wrong_password_error.dart';

class FirebaseAuthExceptionHandler {
  FirebaseAuthExceptionHandler._();

  static const _emailAlreadyExists = 'email-already-exists';
  static const _expiredActionCode = 'expired-action-code';
  static const _invalidActionCode = 'invalid-action-code';
  static const _userDisabled = 'user-disabled';
  static const _userNotFound = 'user-not-found';
  static const _wrongPassword = 'wrong-password';
  static const _invalidPageToken = 'invalid-page-token';

  static void handle(String? message) {
    if (message?.contains(_emailAlreadyExists) == true) {
      throw EmailAlreadyExistsError();
    }
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
    if (message?.contains(_wrongPassword) == true) {
      throw WrongPasswordError();
    }
    if (message?.contains(_invalidPageToken) == true) {
      throw InvalidPageTokenError();
    }
  }
}
