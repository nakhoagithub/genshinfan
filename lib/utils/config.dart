import 'package:genshinfan/models/app/role_app.dart';
import 'package:get/get.dart';

class Config {
  static const String aboutApp =
      '<green><b>Genshin Fan</b></green>\n\n<orange><b>Declaration Information</b></orange>\n- The <b>Genshin Fan</b> application is a game database application </b>Genshin Impact</b>.\n- All data is extracted from the Internet and this application has no affiliation or endorsement from miHoYo - Genshin Impact.\n\n<orange><b>Permissions and Security</b></orange>\nThe application receives some information from the user when the user is logged in, such as name and email address.\n\n<orange><b>Thank you</b></orange>\nMany thanks to <b>theBowja (Github)</b> as the main source of data for the app.\n\n<orange><b>Author and Developer:</b></orange> KanThin (Nguyen Anh Khoa - Vietnam).\n\n<orange><b>Contact:</b></orange> dev.nakhoa@gmail.com\n\n<orange><b>Author translation:</b></orange>\n- Turkish: Alberivh on twitter\n- Russian: vasyasher120@gmail.com (and Google Translate)\n- German: Inkognito';

  static const String darkMode = 'darkMode';
  static const String languageApp = 'languageApp';
  static const String storageContentSHA = 'contentSHA';
  static const String deleteDataFirstInstall = 'deleteDataFirstInstall';

  static const String fileNameCharacter = 'characters';
  static const String fileNameMaterial = 'materials';
  static const String fileNameWeapon = 'weapons';
  static const String fileNameArtifact = 'artifacts';
  static const String fileNameDomain = 'domains';
  static const String fileNameEnemie = 'enemies';
  static const String fileNameAchievementGroup = 'achievementGroups';
  static const String fileNameAchievement = 'achievements';
  static const String fileNameNamecard = 'namecards';
  static const String fileNameAnimal = 'animals';
  static const String fileNameCraft = 'crafts';
  static const String fileNameOutfit = 'outfits';
  static const String fileNameGeography = 'geographies';
  static const String fileNameWindglider = 'windgliders';

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

  // Quyền người dùng mặc định
  static List<int> rolesDefault = [10];

  static List<RoleApp> menuRole = [
    RoleApp(role: 1, name: "admin".tr),
    RoleApp(role: 2, name: "user_management".tr),
    RoleApp(role: 5, name: "censor".tr),
    RoleApp(role: 10, name: "member".tr),
  ];

  static List<String> elements = [
    'Anemo',
    'Geo',
    'Electro',
    'Dendro',
    'Pyro',
    'Hydro',
    'Cryo'
  ];

  static List<String> weapons = [
    'Sword',
    'Bow',
    'Claymore',
    'Catalyst',
    'Polearm',
  ];
}
