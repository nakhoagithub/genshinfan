import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// config role
/// 1: Admin
/// 2:
/// 3:
/// 4:
/// 5: Duyệt đóng góp

class Config {
  static const String aboutApp =
      '<green><b>Genshin Fan</b></green>\n\n<orange><b>Declaration Information</b></orange>\n- The <b>Genshin Fan</b> application is a game database application </b>Genshin Impact</b>.\n- All data is extracted from the Internet and this application has no affiliation or endorsement from miHoYo - Genshin Impact.\n\n<orange><b>Permissions and Security</b></orange>\nThe application receives some information from the user when the user is logged in, such as name and email address.\n\n<orange><b>Thank you</b></orange>\nMany thanks to <b>theBowja (Github)</b> as the main source of data for the app.\n\n<orange><b>Author and Developer:</b></orange> KanThin (Nguyen Anh Khoa - Vietnam).\n\n<orange><b>Contact:</b></orange> dev.nakhoa@gmail.com\n\n<orange><b>Author translation:</b></orange>\n- Turkish: Alberivh on twitter\n- Russian: vasyasher120@gmail.com (and Google Translate)\n- German: Inkognito';

  static const String darkMode = 'darkMode';
  static const String languageApp = 'languageApp';
  static const String storageContentSHA = 'contentSHA';

  // character
  static const String storageListElementCharacterFilter =
      'listElementCharacterFilter';
  static const String storageListWeaponCharacterFilter =
      'listWeaponCharacterFilter';
  static const String storageListRarityCharacterFilter =
      'listRarityCharacterFilter';
  static const String storageSortCharacterFilter = 'sortCharacterFilter';

  // weapon
  static const String storageListWeaponWeaponFilter = 'listWeaponWeaponFilter';
  static const String storageListRarityWeaponFilter = 'listRarityWeaponFilter';
  static const String storageListSubstatWeaponFilter =
      'listSubstatWeaponFilter';
  static const String storageSortWeaponFilter = 'sortWeaponFilter';

  // weapon
  static const String storageListRarityResourceFilter =
      'listRarityResourceFilter';
  static const String storageListSubstatResourceFilter =
      'listSubstatResourceFilter';
  static const String storageSortResourceFilter = 'sortResourceFilter';

  static const String gmailSchema = 'com.google.android.gm';
  static const String mailDeveloper = 'dev.nakhoa@gmail.com';

  static const String linkJoinDiscord = 'https://discord.gg/C8PZaRFsTq';
  static const String keyLinkDiscord = 'link_discord';
  static const String keyLinkContributeTranslation =
      'link_contribute_translation';

  static const String keyLinkUrlData = 'urlData';
  static const String keyLinkApiData = 'apiData';

  // contribute
  static const String keyAuthContribute = 'keyAuthContribute';

  static String urlData =
      "https://github.com/theBowja/genshin-db/raw/main/src/min/data.min.json.gzip";

  static String apiData =
      'https://api.github.com/repos/theBowja/genshin-db/contents/src/min/data.min.json.gzip';

  static String urlImage(String? nameImage) {
    return "https://res.cloudinary.com/genshin/image/upload/sprites/$nameImage.png";
  }

  static String get urlGenshinMap =>
      "https://act.hoyolab.com/ys/app/interactive-map/index.html";

  static double widthCenter = Get.width - 104;
  static double sizeItem3 = (Get.width - 104 - 12) / 3;
  static double sizeItem2 = (Get.width - 104 - 8) / 2;

  static const double marginText = 8;

  static const int seccondTimeout = 8;

  // quản lý ứng dụng và quyền
  static const List<int> roleAdminLV1 = [1, 2];
  // quản lý khác
  static const List<int> roleAdminLV2 = [3, 4];
  static const List<int> roleAdmins = [1, 2, 3, 4, 5];

  static List<DropdownMenuItem> menuRole = [
    DropdownMenuItem(value: 1, child: Text("admin".tr)),
    DropdownMenuItem(value: 5, child: Text("censor".tr)),
    DropdownMenuItem(value: 10, child: Text("member".tr)),
  ];

  static List<String> elements = [
    'ELEMENT_ANEMO',
    'ELEMENT_GEO',
    'ELEMENT_ELECTRO',
    'ELEMENT_DENDRO',
    'ELEMENT_PYRO',
    'ELEMENT_HYDRO',
    'ELEMENT_CRYO'
  ];

  static List<String> weapons = [
    'WEAPON_SWORD_ONE_HAND',
    'WEAPON_BOW',
    'WEAPON_CLAYMORE',
    'WEAPON_CATALYST',
    'WEAPON_POLE',
  ];
}
