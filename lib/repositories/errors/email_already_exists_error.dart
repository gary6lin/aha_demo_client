import 'package:easy_localization/easy_localization.dart';

import 'app_error.dart';

class EmailAlreadyExistsError extends AppError {
  EmailAlreadyExistsError() : super(tr('error_email_already_exists'));
}
