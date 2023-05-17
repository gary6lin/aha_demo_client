import 'package:aha_demo/repositories/errors/user_disabled_error.dart';

import 'errors/email_already_exists_error.dart';
import 'errors/expired_action_code_error.dart';
import 'errors/invalid_action_code_error.dart';
import 'errors/user_not_found_error.dart';

class FirebaseAuthExceptionHandler {
  FirebaseAuthExceptionHandler._();

  // User auth
  static const _emailAlreadyExists = 'email-already-exists';

  // **invalid-email**:
  // Thrown if the email address is not valid.
  // **user-disabled**:
  // Thrown if the user corresponding to the given email has been disabled.
  // **user-not-found**:
  // Thrown if there is no user corresponding to the given email.
  // **wrong-password**:
  // Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set.
  // **email-already-in-use**:
  // Thrown if there already exists an account with the given email address.
  // **invalid-email**:
  // Thrown if the email address is not valid.
  // **operation-not-allowed**:
  // Thrown if email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.
  // **weak-password**:
  // Thrown if the password is not strong enough.

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
