import 'package:easy_localization/easy_localization.dart';

import 'errors/invalid_password_format_error.dart';

class PasswordFormatErrorHandler {
  PasswordFormatErrorHandler._();

  static const _pwdNoLower = 'pwd-no-lower';
  static const _pwdNoUpper = 'pwd-no-upper';
  static const _pwdNoNumber = 'pwd-no-number';
  static const _pwdNoSpecial = 'pwd-no-special';
  static const _pwdLength = 'pwd-length';
  static const _pwdWhitespace = 'pwd-whitespace';

  static void handle(String? message) {
    final errors = <String>[];
    if (message?.contains(_pwdNoLower) == true) {
      errors.add(tr('error_password_no_lower'));
    }
    if (message?.contains(_pwdNoUpper) == true) {
      errors.add(tr('error_password_no_upper'));
    }
    if (message?.contains(_pwdNoNumber) == true) {
      errors.add(tr('error_password_no_number'));
    }
    if (message?.contains(_pwdNoSpecial) == true) {
      errors.add(tr('error_password_no_special'));
    }
    if (message?.contains(_pwdLength) == true) {
      errors.add(tr('error_password_length'));
    }
    if (message?.contains(_pwdWhitespace) == true) {
      errors.add(tr('error_password_whitespace'));
    }
    if (errors.isNotEmpty) {
      throw InvalidPasswordFormatError(errors.join('\n'));
    }
  }
}
