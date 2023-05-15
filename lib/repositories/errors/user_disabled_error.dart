import 'package:easy_localization/easy_localization.dart';

import 'app_error.dart';

class UserDisabledError extends AppError {
  UserDisabledError() : super(tr('error_user_disabled'));
}
