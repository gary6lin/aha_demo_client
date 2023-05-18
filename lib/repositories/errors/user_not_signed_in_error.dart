import 'package:easy_localization/easy_localization.dart';

import 'app_error.dart';

class UserNotSignedInError extends AppError {
  UserNotSignedInError() : super(tr('error_user_not_signed_in'));
}
