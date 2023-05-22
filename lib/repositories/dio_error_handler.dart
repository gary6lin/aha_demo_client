import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'errors/invalid_password_error.dart';
import 'firebase_auth_exception_handler.dart';
import 'password_format_error_handler.dart';

class DioErrorHandler {
  DioErrorHandler._();

  static const _invalidPassword = 'invalid-password';

  static void handle(DioError e) {
    if (kDebugMode) print(e.toString());

    final errorString = e.response?.data.toString();

    FirebaseAuthExceptionHandler.handle(errorString);
    PasswordFormatErrorHandler.handle(errorString);

    if (errorString?.contains(_invalidPassword) == true) {
      throw InvalidPasswordError();
    }
  }
}
