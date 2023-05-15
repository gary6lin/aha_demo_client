import 'package:easy_localization/easy_localization.dart';

enum FirebaseAuthError {
  invalidEmail,
  invalidPassword,
  invalidDisplayName,
  emailAlreadyExists,
}

extension RegisterErrorHandler on FirebaseAuthError {
  static const invalidEmail = 'invalid-email';
  static const invalidPassword = 'invalid-password';
  static const invalidDisplayName = 'invalid-display-name';
  static const emailAlreadyExists = 'email-already-exists';

  static FirebaseAuthError handle(String? message) {
    if (message?.contains(invalidEmail) == true) {
      return FirebaseAuthError.invalidEmail;
    } else if (message?.contains(invalidPassword) == true) {
      return FirebaseAuthError.invalidPassword;
    } else if (message?.contains(invalidDisplayName) == true) {
      return FirebaseAuthError.invalidDisplayName;
    } else if (message?.contains(emailAlreadyExists) == true) {
      return FirebaseAuthError.emailAlreadyExists;
    }
    throw Exception('Unknown error');
  }

  String get message {
    switch (this) {
      case FirebaseAuthError.invalidEmail:
        return tr('');
      case FirebaseAuthError.invalidPassword:
        return tr('');
      case FirebaseAuthError.invalidDisplayName:
        return tr('');
      case FirebaseAuthError.emailAlreadyExists:
        return tr('');
    }
  }
}
