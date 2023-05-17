import 'package:easy_localization/easy_localization.dart';

final _emailValidation = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');

final _hasLowercase = RegExp(r'^(?=.*[a-z]).*$');
final _hasUppercase = RegExp(r'^(?=.*[A-Z]).*$');
final _hasNumber = RegExp(r'^(?=.*\d).*$');
final _hasSpecialChar = RegExp(r'^(?=.*[^a-zA-Z0-9\d\s]).*$');
final _moreThanEightChar = RegExp(r'^.{8,}$');
final _noWhitespace = RegExp(r'^\S*$');

class AppValidator {
  AppValidator._();

  static String? email(String? value) {
    final validated = _emailValidation.hasMatch(value ?? '');
    return validated ? null : tr('invalid_email_address');
  }

  static String? name(String? value) {
    if (_hasNumber.hasMatch(value ?? '') || _hasSpecialChar.hasMatch(value ?? '') || value?.isNotEmpty != true) {
      return tr('error_name_invalid_characters');
    }
    return null;
  }

  static String? passwordConfirm(String? value1, String? value2) {
    if (value1?.isNotEmpty != true || value2?.isNotEmpty != true) {
      return tr('error_empty');
    }
    return value1 != value2 ? tr('confirm_password_error') : null;
  }

  static String? password(String? value) {
    final errors = <String>[];
    if (!_hasLowercase.hasMatch(value ?? '')) {
      errors.add(tr('error_password_no_lower'));
    }
    if (!_hasUppercase.hasMatch(value ?? '')) {
      errors.add(tr('error_password_no_upper'));
    }
    if (!_hasNumber.hasMatch(value ?? '')) {
      errors.add(tr('error_password_no_number'));
    }
    if (!_hasSpecialChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_no_special'));
    }
    if (!_moreThanEightChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_length'));
    }
    if (!_noWhitespace.hasMatch(value ?? '')) {
      errors.add(tr('error_password_whitespace'));
    }
    return errors.isNotEmpty ? errors.join('\n') : null;
  }
}
