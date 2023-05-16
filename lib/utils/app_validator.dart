import 'package:easy_localization/easy_localization.dart';

final emailValidation = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');

final pwdLowerChar = RegExp(r'^(?=.*[a-z]).*$');
final pwdUpperChar = RegExp(r'^(?=.*[A-Z]).*$');
final pwdNumberChar = RegExp(r'^(?=.*\d).*$');
final pwdSpecialChar = RegExp(r'^(?=.*[^a-zA-Z0-9\d\s]).*$');
final pwdLength = RegExp(r'^.{8,}$');
final pwdNoWhitespace = RegExp(r'^\S*$');

class AppValidator {
  AppValidator._();

  static String? email(String? value) {
    final validated = emailValidation.hasMatch(value ?? '');
    return validated ? null : tr('invalid_email_address');
  }

  static String? password(String? value) {
    final errors = <String>[];
    if (!pwdLowerChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_no_lower'));
    }
    if (!pwdLowerChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_no_upper'));
    }
    if (!pwdLowerChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_no_number'));
    }
    if (!pwdLowerChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_no_special'));
    }
    if (!pwdLowerChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_length'));
    }
    if (!pwdLowerChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_whitespace'));
    }
    return errors.isNotEmpty ? errors.join('\n') : null;
  }
}
