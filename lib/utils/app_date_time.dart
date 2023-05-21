import 'package:easy_localization/easy_localization.dart';

class AppDateTime {
  static String parseString(String inputString, String locale) {
    final localDateTime = DateFormat('EEE, dd MMM yyyy HH:mm:ss z').parseUTC(inputString).toLocal();
    return AppDateTime.parseDateTime(localDateTime, locale);
  }

  static String parseDateTime(DateTime? dateTime, String locale) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat.yMMMMd(locale).add_jm().format(dateTime);
  }
}
