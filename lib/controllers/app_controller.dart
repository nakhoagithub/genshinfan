import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/controllers/domain_controller.dart';
import 'package:genshinfan/controllers/enemy_controller.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/controllers/weapon_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/objects/domain.dart';
import 'package:genshinfan/objects/enemy.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/objects/weapon.dart';
import 'package:genshinfan/resources/utils/localization.dart';
import 'package:genshinfan/services/artifact_service.dart';
import 'package:genshinfan/services/character_service.dart';
import 'package:genshinfan/services/domain_service.dart';
import 'package:genshinfan/services/enemy_service.dart';
import 'package:genshinfan/services/resource_service.dart';
import 'package:genshinfan/services/weapon_service.dart';
import 'package:get/get.dart';

import '../resources/utils/theme.dart';
import 'character_controller.dart';

class AppController extends GetxController {
  // theme app
  Rx<ThemeData> themeData = ThemeData().obs;

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

  @override
  void onInit() {
    super.onInit();
    // init theme
    themeData.value = ThemeApp.theme;

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

  Future<bool> getData() async {
    try {
      characters.value =
          await CharacterService().getCharacters(Localization.language) ?? [];

      weapons.value =
          await WeaponService().getWeapons(Localization.language) ?? [];
      resources.value =
          await ResourceService().getResources(Localization.language) ?? [];
      // sắp xếp resource
      resources.sort(
        (a, b) {
          return a.sortorder.compareTo(b.sortorder);
        },
      );

      artifacts.value =
          await ArtifactService().getArtifacts(Localization.language) ?? [];

      artifacts.sort(
        (a, b) {
          int rarity = b.rarity[b.rarity.length - 1]
              .compareTo(a.rarity[a.rarity.length - 1]);
          if (rarity != 0) {
            return rarity;
          }
          return a.name.compareTo(b.name);
        },
      );

      domains.value =
          await DomainService().getDomains(Localization.language) ?? [];

      enemies.value =
          await EnemyService().getEnemies(Localization.language) ?? [];

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

  void updateLanguage(String langCode) {
    // ngôn ngữ khác ngôn ngữ hiện tại mới đổi
    if (langCode != Get.locale?.languageCode) {
      Localization.changeLocale(langCode);
      Get.offAllNamed("/");
    } else {
      Get.back();
      Get.back();
    }
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
    Get.put(CharacterController());
    Get.put(ResourceController());
    Get.put(WeaponController());
    Get.put(ArtifactController());
    Get.put(DomainController());
    Get.put(EnemyController());
  }
}
