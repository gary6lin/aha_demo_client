import 'package:easy_localization/easy_localization.dart';

import 'app_error.dart';

class InvalidActionCodeError extends AppError {
  InvalidActionCodeError() : super(tr('error_invalid_action_code'));
}
