import 'dart:developer';

import 'package:aha_demo/repositories/app_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

import '../../values/constants.dart';

class RegisterViewModel {
  final _repo = GetIt.I<AppRepository>();

  void Function()? onRegistered;
  void Function(Object)? onError;

  Future<void> onRegister(String email, String password, String displayName) async {
    try {
      await _repo.register(email, password, displayName);
      onRegistered?.call();
    } catch (e) {
      log('$e');
      onError?.call(e);
    }
  }

  String? validatePassword(String value) {
    final errors = <String>[];
    if (!AppRegex.pwdLowerChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_no_lower'));
    }
    if (!AppRegex.pwdLowerChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_no_upper'));
    }
    if (!AppRegex.pwdLowerChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_no_number'));
    }
    if (!AppRegex.pwdLowerChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_no_special'));
    }
    if (!AppRegex.pwdLowerChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_length'));
    }
    if (!AppRegex.pwdLowerChar.hasMatch(value ?? '')) {
      errors.add(tr('error_password_whitespace'));
    }
    return errors.isNotEmpty ? errors.join('\n') : null;
  }
}
