import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/achievement_controller.dart';
import 'package:genshinfan/controllers/animal_controller.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/controllers/character_controller.dart';
import 'package:genshinfan/controllers/craft_controller.dart';
import 'package:genshinfan/controllers/domain_controller.dart';
import 'package:genshinfan/controllers/enemy_controller.dart';
import 'package:genshinfan/controllers/geography_controller.dart';
import 'package:genshinfan/controllers/namecard_controller.dart';
import 'package:genshinfan/controllers/outfit_controller.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/controllers/weapon_controller.dart';
import 'package:genshinfan/objects/achievement.dart';
import 'package:genshinfan/objects/animal.dart';
import 'package:genshinfan/objects/app/user.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/objects/craft.dart';
import 'package:genshinfan/objects/domain.dart';
import 'package:genshinfan/objects/enemy.dart';
import 'package:genshinfan/objects/geography.dart';
import 'package:genshinfan/objects/namecard.dart';
import 'package:genshinfan/objects/outfit.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/objects/weapon.dart';
import 'package:genshinfan/resources/utils/localization.dart';
import 'package:genshinfan/resources/utils/theme.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:genshinfan/services/achievement_service.dart';
import 'package:genshinfan/services/animal_service.dart';
import 'package:genshinfan/services/app_service.dart';
import 'package:genshinfan/services/artifact_service.dart';
import 'package:genshinfan/services/character_service.dart';
import 'package:genshinfan/services/craft_service.dart';
import 'package:genshinfan/services/domain_service.dart';
import 'package:genshinfan/services/enemy_service.dart';
import 'package:genshinfan/services/geography_service.dart';
import 'package:genshinfan/services/namecard_service.dart';
import 'package:genshinfan/services/outfit_service.dart';
import 'package:genshinfan/services/resource_service.dart';
import 'package:genshinfan/services/weapon_service.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  // theme app
  Rx<ThemeData> themeData = ThemeData().obs;

  // user
  Rx<User?> user = Rx(null);
  Rx<UserApp?> userApp = Rx(null);

  // internet
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _streamConnect;
  RxBool hasInternet = false.obs;

  // data
  RxList<Character> characters = <Character>[].obs;
  RxList<Weapon> weapons = <Weapon>[].obs;
  RxList<Resource> resources = <Resource>[].obs;
  RxList<Artifact> artifacts = <Artifact>[].obs;
  RxList<Domain> domains = <Domain>[].obs;
  RxList<Enemy> enemies = <Enemy>[].obs;
  RxList<AchievementGroup> achievementGroups = <AchievementGroup>[].obs;
  RxList<Achievement> achievements = <Achievement>[].obs;
  RxList<Namecard> namecards = <Namecard>[].obs;
  RxList<Animal> animals = <Animal>[].obs;
  RxList<Craft> crafts = <Craft>[].obs;
  RxList<Outfit> outfits = <Outfit>[].obs;
  RxList<Geography> geographies = <Geography>[].obs;

  Future<bool> getData() async {
    try {
      // nhân vật
      characters.value =
          await CharacterService().getCharacters(Localization.language) ?? [];
      characters.sort(
        (a, b) {
          int rarity = b.rarity.compareTo(a.rarity);
          if (rarity != 0) {
            return rarity;
          }
          return a.id.compareTo(b.id);
        },
      );

      // vk
      weapons.value =
          await WeaponService().getWeapons(Localization.language) ?? [];
      weapons.sort(
        (a, b) {
          int rarity = b.rarity.compareTo(a.rarity);
          if (rarity != 0) {
            return rarity;
          }
          return a.id.compareTo(b.id);
        },
      );

      // tài nguyên
      resources.value =
          await ResourceService().getResources(Localization.language) ?? [];
      resources.sort(
        (a, b) {
          return a.sortorder.compareTo(b.sortorder);
        },
      );

      // tdv
      artifacts.value =
          await ArtifactService().getArtifacts(Localization.language) ?? [];
      artifacts.sort(
        (a, b) {
          int rarity = b.rarity[b.rarity.length - 1]
              .compareTo(a.rarity[a.rarity.length - 1]);
          if (rarity != 0) {
            return rarity;
          }
          return Tools.removeDiacritics(a.name)
              .compareTo(Tools.removeDiacritics(b.name));
        },
      );

      // dung
      domains.value =
          await DomainService().getDomains(Localization.language) ?? [];

      // quái
      enemies.value =
          await EnemyService().getEnemies(Localization.language) ?? [];

      // achievement
      achievements.value =
          await AchievementService().getAchiements(Localization.language) ?? [];
      achievementGroups.value = await AchievementService()
              .getAchiementGroups(Localization.language) ??
          [];
      achievementGroups.sort(
        (a, b) {
          if (a.sortorder != null && b.sortorder != null) {
            return a.sortorder!.compareTo(b.sortorder!);
          }
          return a.name.compareTo(b.name);
        },
      );

      // namecard
      namecards.value =
          await NamecardService().getNamecards(Localization.language) ?? [];
      namecards.sort(
        (a, b) {
          return a.sortorder.compareTo(b.sortorder);
        },
      );

      // namecard
      animals.value =
          await AnimalService().getAnimals(Localization.language) ?? [];
      animals.sort(
        (a, b) {
          return a.sortorder.compareTo(b.sortorder);
        },
      );

      // đồ thủ công
      crafts.value =
          await CraftService().getCrafts(Localization.language) ?? [];
      crafts.sort(
        (a, b) {
          if (a.resource == null && b.resource == null) {
            return a.sortorder.compareTo(b.sortorder);
          } else if (a.resource == null) {
            return 1;
          } else if (b.resource == null) {
            return -1;
          }
          // if (a.resource != null || b.resource != null) {
          //   return a.sortorder.compareTo(b.sortorder);
          // }
          return a.sortorder.compareTo(b.sortorder);
        },
      );

      // trang phục
      outfits.value =
          await OutfitService().getOutfits(Localization.language) ?? [];

      // khu vực địa lý
      geographies.value =
          await GeographyService().getGeographies(Localization.language) ?? [];
      geographies.sort(
        (a, b) {
          return a.sortorder.compareTo(b.sortorder);
        },
      );

      return true;
    } catch (e) {
      log("$e", name: "AppController - getData");
    }
    return false;
  }

  void updateTheme(bool isDark) {
    themeData.value = isDark ? ThemeApp.dark() : ThemeApp.light();
    ThemeApp.changeTheme(isDark: isDark);
    update();
    notifyChildrens();
  }

  Future<void> updateLanguage(String languageCode, String? countryCode) async {
    // ngôn ngữ khác ngôn ngữ hiện tại mới đổi
    if (languageCode != Get.locale?.languageCode ||
        countryCode != Get.locale?.countryCode) {
      await Localization.changeLocale(languageCode, countryCode);
      Get.offAllNamed("/");
    } else {
      Get.back();
      Get.back();
    }
  }

  Future<void> login() async {
    UserCredential? userCredential = await AppService().signInWithGoogle();
    User? user = userCredential?.user;
    if (user != null) {
      this.user.value = user;
    }
  }

  Future<void> logout() async {
    await dialogConfirm("confirm".tr, "logout_question".tr, () async {
      await AppService().logout();
      user.value = null;
    });
  }

  @override
  void onInit() async {
    super.onInit();
    // init theme
    themeData.value = ThemeApp.theme;

    user.value = FirebaseAuth.instance.currentUser;
    userApp.value = await AppService().checkAndInitUser();

    // init internet stream
    _streamConnect = connectivity.onConnectivityChanged.listen((value) async {
      if (value == ConnectivityResult.none) {
        // không có kết nối
        hasInternet.value = false;
      } else {
        // có kết nối
        hasInternet.value = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamConnect?.cancel();
  }
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResourceController());
    Get.put(CharacterController());
    Get.put(WeaponController());
    Get.put(ArtifactController());
    Get.put(DomainController());
    Get.put(EnemyController());
    Get.put(AchievementController());
    Get.put(NamecardController());
    Get.put(AnimalController());
    Get.put(CraftController());
    Get.put(OutfitController());
    Get.put(GeographyController());
  }
}
