import 'dart:ui';

import 'package:genshinfan/objects/app/language.dart';
import 'package:genshinfan/resources/langs/zh_cn.dart';
import 'package:genshinfan/resources/langs/zh_tw.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../langs/en_us.dart';
import '../langs/vi_vn.dart';

class Localization extends Translations {
  static GetStorage box = GetStorage();
  static final locale = _getLocaleFromLanguage();
  // static const localeSupport = [
  //   Locale('en', 'US'),
  //   Locale('vi', 'VN'),
  //   Locale('zh', 'CN'),
  // ];
  static const fallbackLocale = Locale('en', 'US');
  static const locales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
    Locale('zh', 'CN'),
    Locale('zh', 'TW'),
  ];

  static Language getLanguageFromCode(Locale? locale) {
    if (locale == const Locale('en', 'US')) return english;
    if (locale == const Locale('vi', 'VN')) return vietnamese;
    if (locale == const Locale('zh', 'CN')) return chineseSimplified;
    if (locale == const Locale('zh', 'TW')) return chineseTraditional;
    return english;
  }

  static String get language => getLanguageFromCode(Get.locale).languageCode;

  static List<String> listLanguageView = [
    'English',
    'Tiếng Việt',
    '简体中文',
    '中國傳統的',
  ];

  static Future<void> changeLocale(
      String languageCode, String? countryCode) async {
    Locale locale = _getLocaleFromLanguage(
        langCode: languageCode, countryCode: countryCode);
    await Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
        'zh_CN': zhCN,
        'zh_TW': zhTW,
      };

  static Locale _getLocaleFromLanguage(
      {String? langCode, String? countryCode}) {
    List<dynamic>? localeLocal = box.read(Config.languageApp);
    String? lang =
        langCode ?? localeLocal?[0] ?? Get.deviceLocale?.languageCode;
    String? country =
        countryCode ?? localeLocal?[1] ?? Get.deviceLocale?.countryCode;
    for (int i = 0; i < locales.length; i++) {
      if (lang == locales[i].languageCode &&
          country == locales[i].countryCode) {
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
