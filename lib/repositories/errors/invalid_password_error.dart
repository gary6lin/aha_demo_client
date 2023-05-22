import 'package:easy_localization/easy_localization.dart';

import 'app_error.dart';

class InvalidPasswordError extends AppError {
  InvalidPasswordError() : super(tr('error_invalid_password'));
}
