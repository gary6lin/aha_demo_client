import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'errors/email_already_exists_error.dart';
import 'errors/expired_action_code_error.dart';
import 'errors/firebase_auth_error.dart';
import 'errors/invalid_action_code_error.dart';
import 'errors/invalid_page_token_error.dart';
import 'errors/user_disabled_error.dart';
import 'errors/user_not_found_error.dart';
import 'errors/wrong_password_error.dart';

class FirebaseAuthExceptionHandler {
  FirebaseAuthExceptionHandler._();

  static const _accountExistsWithDifferentCredential = 'account-exists-with-different-credential';
  static const _emailAlreadyExists = 'email-already-exists';
  static const _expiredActionCode = 'expired-action-code';
  static const _invalidActionCode = 'invalid-action-code';
  static const _userDisabled = 'user-disabled';
  static const _userNotFound = 'user-not-found';
  static const _wrongPassword = 'wrong-password';
  static const _invalidPageToken = 'invalid-page-token';

  static void handleException(FirebaseAuthException exception) {
    handle(exception.toString());
    throw FirebaseAuthError(exception.message ?? exception.code);
  }

  static void handleString(String? error) {
    handle(error);
    throw FirebaseAuthError(error);
  }

  static void handle(String? error) {
    if (kDebugMode) print(error);
    if (error?.contains(_accountExistsWithDifferentCredential) == true) {
      throw EmailAlreadyExistsError();
    }
    if (error?.contains(_emailAlreadyExists) == true) {
      throw EmailAlreadyExistsError();
    }
    if (error?.contains(_expiredActionCode) == true) {
      throw ExpiredActionCodeError();
    }
    if (error?.contains(_invalidActionCode) == true) {
      throw InvalidActionCodeError();
    }
    if (error?.contains(_userDisabled) == true) {
      throw UserDisabledError();
    }
    if (error?.contains(_userNotFound) == true) {
      throw UserNotFoundError();
    }
    if (error?.contains(_wrongPassword) == true) {
      throw WrongPasswordError();
    }
    if (error?.contains(_invalidPageToken) == true) {
      throw InvalidPageTokenError();
    }
  }
}
