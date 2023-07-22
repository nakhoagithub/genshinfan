import 'dart:ui';

import 'package:genshinfan/models/app/language.dart';
import 'package:genshinfan/languages/de_de.dart';
import 'package:genshinfan/languages/en_us.dart';
import 'package:genshinfan/languages/es_es.dart';
import 'package:genshinfan/languages/fr_fr.dart';
import 'package:genshinfan/languages/id_id.dart';
import 'package:genshinfan/languages/it_it.dart';
import 'package:genshinfan/languages/ja_jp.dart';
import 'package:genshinfan/languages/ko_kr.dart';
import 'package:genshinfan/languages/pt_br.dart';
import 'package:genshinfan/languages/ru_ru.dart';
import 'package:genshinfan/languages/th_th.dart';
import 'package:genshinfan/languages/tr_tr.dart';
import 'package:genshinfan/languages/vi_vn.dart';
import 'package:genshinfan/languages/zh_cn.dart';
import 'package:genshinfan/languages/zh_tw.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Localization extends Translations {
  static GetStorage box = GetStorage();
  static final locale = _getLocaleFromLanguage();
  static const fallbackLocale = Locale('en', 'US');
  static const locales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
    Locale('zh', 'CN'),
    Locale('zh', 'TW'),
    Locale('fr', 'FR'),
    Locale('tr', 'TR'),
    Locale('de', 'DE'),
    Locale("es", 'ES'),
    Locale("id", 'ID'),
    Locale("it", 'IT'),
    Locale('ja', 'JP'),
    Locale("ko", 'KR'),
    Locale("pt", 'BR'),
    Locale("ru", 'RU'),
    Locale("th", 'TH'),
  ];

  static Language getLanguageFromCode(Locale? locale) {
    if (locale == const Locale('en', 'US')) return english;
    if (locale == const Locale('vi', 'VN')) return vietnamese;
    if (locale == const Locale('zh', 'CN')) return chineseSimplified;
    if (locale == const Locale('zh', 'TW')) return chineseTraditional;
    if (locale == const Locale('fr', 'FR')) return french;
    if (locale == const Locale('tr', 'TR')) return turkish;
    if (locale == const Locale('de', 'DE')) return german;
    if (locale == const Locale('es', 'ES')) return spanish;
    if (locale == const Locale('id', 'ID')) return indonesian;
    if (locale == const Locale('it', 'IT')) return italian;
    if (locale == const Locale('ja', 'JP')) return japanese;
    if (locale == const Locale("ko", 'KR')) return korean;
    if (locale == const Locale("pt", 'BR')) return portuguese;
    if (locale == const Locale("ru", 'RU')) return russian;
    if (locale == const Locale("th", 'TH')) return thai;
    return english;
  }

  static String get language => getLanguageFromCode(Get.locale).languageCode;

  static List<String> listLanguageView = [
    'English',
    'Tiếng Việt',
    '中文(简体)',
    '中文(繁體)',
    'Français',
    'Türkçe',
    'Deutsch',
    'Español',
    'Indonesia',
    'Italiano',
    '日本語',
    '한국인',
    'Português',
    'Русский',
    'ภาษาไทย',
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
        'fr_FR': fr,
        'tr_TR': tr,
        'de_DE': de,
        'es_ES': es,
        'id_ID': id,
        'it_IT': it,
        'ja_JP': ja,
        'ko_KR': ko,
        'pt_BR': pt,
        'ru_RU': ru,
        'th_TH': th,
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
