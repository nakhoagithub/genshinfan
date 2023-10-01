import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/app/traffic.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/models/game/domain.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/services/character_service.dart';
import 'package:genshinfan/services/domain_service.dart';
import 'package:genshinfan/services/weapon_service.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/services/app_service.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  RxBool loading = false.obs;
  Rx<Traffic?> traffic = Rx(null);
  RxInt today = 0.obs;
  RxString todaySelected = "".obs;
  RxInt day = 0.obs;
  RxInt month = 0.obs;
  RxBool hasBirthday = false.obs;
  RxList<Domain> domainToday = <Domain>[].obs;
  RxList<Character> characterBirthdayInMonth = <Character>[].obs;
  RxList<Character> characterBirthdayToday = <Character>[].obs;
  RxList<Character> characterUpToday = <Character>[].obs;
  RxList<Weapon> weaponUpToday = <Weapon>[].obs;

  List<String> todays = [
    "day1".tr,
    "day2".tr,
    "day3".tr,
    "day4".tr,
    "day5".tr,
    "day6".tr,
    "day7".tr,
  ];

  void openGenshinMap() async {
    dialogConfirm(
      "genshin_map".tr,
      "notification_open_genshin_map".tr,
      () async {
        if (await canLaunchUrl(Uri.parse(Config.urlGenshinMap))) {
          await launchUrl(Uri.parse(Config.urlGenshinMap),
              mode: LaunchMode.externalApplication);
        } else {
          log("Không thể mở liên kết ${Config.urlGenshinMap}",
              name: "Open URL");
        }
      },
    );
  }

  Future<void> getTraffic() async {
    traffic.value = await AppService().getTraffic();
  }

  // Future<void> onConnect() async {
  //   await FirebaseDatabase.instance
  //       .ref('analytics')
  //       .update({'online': ServerValue.increment(1)});
  // }

  // Future<void> onDisconnect() async {
  //   await FirebaseDatabase.instance
  //       .ref('analytics')
  //       .onDisconnect()
  //       .update({'online': ServerValue.increment(-1)});
  // }

  Future<void> checkUpdateApp() async {
    await InAppUpdate.checkForUpdate();
    AppUpdateResult appUpdateResult = await InAppUpdate.startFlexibleUpdate();
    if (appUpdateResult == AppUpdateResult.success) {
      await InAppUpdate.completeFlexibleUpdate();
    }
  }

  void changeDate() {
    getDomainToday();
    getCharacterUpToday();
    getWeaponUpToday();
  }

  void getDomainToday() {
    domainToday.clear();
    domainToday.value =
        DomainService().getDomainToday(todaySelected.value) ?? [];
  }

  void getCharacterBirthday() {
    characterBirthdayInMonth.clear();
    characterBirthdayInMonth.value =
        CharacterService().getCharacterBirthdayInMonth() ?? [];
    characterBirthdayToday.clear();
    characterBirthdayToday.value =
        CharacterService().getCharacterBirthdayToday() ?? [];
  }

  void getCharacterUpToday() {
    characterUpToday.clear();
    characterUpToday.value =
        CharacterService().getCharacterUpToday(domainToday) ?? [];
  }

  void getWeaponUpToday() {
    weaponUpToday.clear();
    weaponUpToday.value = WeaponService().getWeaponUpToday(domainToday) ?? [];
  }

  Future<void> checkAndInitUser() async {
    Get.find<MainController>().userApp.value =
        await AppService().checkAndInitUser();
  }

  Future<void> checkDataVersion() async {
    List<Object?> results = await AppService().checkUpdateData();
    if (results[0] == true) {
      Get.find<MainController>().haveNewVesion.value = true;
    }
  }

  @override
  void onInit() async {
    loading.value = true;
    MainController mainController = Get.find<MainController>();
    mainController.user.value = FirebaseAuth.instance.currentUser;
    unawaited(checkAndInitUser());

    DateTime dateTime = DateTime.now();
    today.value = dateTime.weekday;
    todaySelected.value = "day${today.value}".tr;
    day.value = dateTime.day;
    month.value = dateTime.month;

    getDomainToday();
    getCharacterBirthday();
    getCharacterUpToday();
    getWeaponUpToday();
    unawaited(getTraffic());
    unawaited(checkUpdateApp());
    unawaited(checkDataVersion());
    loading.value = false;
    super.onInit();
  }
}
