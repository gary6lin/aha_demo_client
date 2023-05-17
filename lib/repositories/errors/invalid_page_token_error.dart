import 'package:easy_localization/easy_localization.dart';

import 'app_error.dart';

class InvalidPageTokenError extends AppError {
  InvalidPageTokenError() : super(tr('error_user_not_found'));
}
