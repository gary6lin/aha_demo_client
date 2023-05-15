import 'package:easy_localization/easy_localization.dart';

enum EmailVerificationError {
  expiredActionCode,
  invalidActionCode,
  userDisabled,
  userNotFound,
}

extension EmailVerificationErrorExt on EmailVerificationError {
  String get message {
    switch (this) {
      case EmailVerificationError.expiredActionCode:
        return tr('verifying_email_error_expired');
      case EmailVerificationError.invalidActionCode:
        return tr('verifying_email_error_invalid');
      case EmailVerificationError.userDisabled:
        return tr('verifying_email_error_user_disabled');
      case EmailVerificationError.userNotFound:
        return tr('verifying_email_error_no_user');
    }
  }
}

class EmailVerificationErrorHandler {
  EmailVerificationErrorHandler._();

  static const expiredActionCode = 'expired-action-code';
  static const invalidActionCode = 'invalid-action-code';
  static const userDisabled = 'user-disabled';
  static const userNotFound = 'user-not-found';

  static EmailVerificationError handle(String? message) {
    if (message?.contains(expiredActionCode) == true) {
      return EmailVerificationError.expiredActionCode;
    } else if (message?.contains(invalidActionCode) == true) {
      return EmailVerificationError.invalidActionCode;
    } else if (message?.contains(userDisabled) == true) {
      return EmailVerificationError.userDisabled;
    } else if (message?.contains(userNotFound) == true) {
      return EmailVerificationError.userNotFound;
    }
    throw Exception('Unknown error');
  }
}
