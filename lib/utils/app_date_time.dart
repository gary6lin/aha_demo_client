import 'package:easy_localization/easy_localization.dart';

class AppDateTime {
  static String convert(String inputString, [locale]) {
    final localDateTime = DateFormat('EEE, dd MMM yyyy HH:mm:ss z').parseUTC(inputString).toLocal();
    return DateFormat.yMMMMd(locale).add_jm().format(localDateTime);
  }
}
