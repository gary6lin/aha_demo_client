import 'package:easy_localization/easy_localization.dart';

import 'app_error.dart';

class WrongPasswordError extends AppError {
  WrongPasswordError() : super(tr('error_wrong_password'));
}
