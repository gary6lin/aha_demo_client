import 'package:easy_localization/easy_localization.dart';

import 'app_error.dart';

class UserNotFoundError extends AppError {
  UserNotFoundError() : super(tr('error_user_not_found'));
}
