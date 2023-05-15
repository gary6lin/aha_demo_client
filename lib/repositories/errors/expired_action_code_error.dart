import 'package:easy_localization/easy_localization.dart';

import 'app_error.dart';

class ExpiredActionCodeError extends AppError {
  ExpiredActionCodeError() : super(tr('error_expired_action_code'));
}
