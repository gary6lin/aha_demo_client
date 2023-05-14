import 'dart:ui';

enum SupportedLocale {
  en,
  zh,
}

class AppLocale {
  static List<Locale> supportedLocales = SupportedLocale.values
      .map(
        (e) => e.value,
      )
      .toList();

  static Locale fallbackLocale = SupportedLocale.zh.value;
}

extension AppLocalesExt on SupportedLocale {
  Locale get value => Locale(name);

  String get tr {
    switch (this) {
      case SupportedLocale.en:
        return 'English';
      case SupportedLocale.zh:
        return '中文';
      default:
        return 'Undefined value.';
    }
  }
}
