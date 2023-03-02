import 'dart:ui';

import 'package:genshinfan/objects/app/language.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../langs/en_us.dart';
import '../langs/vi_vn.dart';

class Localization extends Translations {
  static GetStorage box = GetStorage();
  static final locale = _getLocaleFromLanguage();
  static const fallbackLocale = Locale('en', 'US');
  static final langCodes = [
    'en',
    'vi',
  ];
  static const locales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];

  static Language getLanguageFromCode(String? code) {
    switch (code) {
      case "vi":
        return vietnamese;
      case "en":
        return english;
    }
    return english;
  }

  static String get language =>
      getLanguageFromCode(Get.locale?.languageCode).languageCode;

  static Map<String, dynamic> mapLanguage = Map<String, dynamic>.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
  });

  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    List<dynamic>? localeLocal = box.read(Config.languageApp);
    String? lang =
        langCode ?? localeLocal?[0] ?? Get.deviceLocale?.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) {
        box.write(Config.languageApp,
            [locales[i].languageCode, locales[i].countryCode]);
        return locales[i];
      }
    }

    // lưu ngôn ngữ lên local
    box.write(
        Config.languageApp,
        Get.locale != null
            ? [Get.locale?.languageCode, Get.locale?.countryCode]
            : ["en", "US"]);
    return Get.locale ?? const Locale("en", "US");
  }
}
