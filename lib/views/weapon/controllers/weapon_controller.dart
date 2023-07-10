import 'package:flutter/material.dart';
import 'package:genshinfan/app_controller.dart';
import 'package:genshinfan/utils/enum.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/game/weapon.dart';

class WeaponController extends GetxController with GetTickerProviderStateMixin {
  GetStorage box = GetStorage();
  RxList<Weapon> weapons = <Weapon>[].obs;
  RxList<Weapon> weaponsView = <Weapon>[].obs;
  Rx<Status> status = Status.init.obs;
  Rx<Weapon?> weapon = Rx(null);
  RxString imageGacha = "".obs;
  ScrollController scrollController = ScrollController();

  void selectWeapon(Weapon value) {
    weapon.value = value;
    imageGacha.value = weapon.value?.images?.namegacha ?? "";
    update();
  }

  @override
  void onInit() {
    weapons.addAll(Get.find<AppController>().weapons);
    weaponsView.addAll(Get.find<AppController>().weapons);
    super.onInit();
  }

  @override
  void update([List<Object>? ids, bool condition = true]) async {
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
    super.update(ids, condition);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
