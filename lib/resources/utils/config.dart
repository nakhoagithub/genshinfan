import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// config role
/// 1: Admin
/// 2:
/// 3:
/// 4:
/// 5: Duyệt đóng góp

class Config {
  static const String darkMode = 'darkMode';
  static const String languageApp = 'languageApp';
  static const String storageDataContentLength = 'dataContentLength';
  static const String storageContentSHA512 = 'contentSHA512';

  static const String gmailSchema = 'com.google.android.gm';
  static const String mailDeveloper = 'dev.nakhoa@gmail.com';

  static const String linkJoinDiscord = 'https://discord.gg/C8PZaRFsTq';
  static const String keyLinkDiscord = 'link_discord';
  static const String keyLinkContributeTranslation =
      'link_contribute_translation';

  static String urlData =
      "https://github.com/theBowja/genshin-db/raw/main/src/min/data.min.json.gzip";

  static String apiData =
      'https://api.github.com/repos/theBowja/genshin-db/contents/src/min/data.min.json.gzip';

  static String urlImage(String? nameImage) {
    return "https://res.cloudinary.com/genshin/image/upload/sprites/$nameImage.png";
  }

  static String get urlGenshinMap =>
      "https://act.hoyolab.com/ys/app/interactive-map/index.html";

  static const double marginText = 4;

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
}
