import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/resources/utils/enum.dart';
import 'package:get/get.dart';
import '../objects/weapon.dart';

class WeaponController extends GetxController with GetTickerProviderStateMixin {
  List<Weapon> weapons = Get.find<AppController>().weapons;
  Rx<Status> status = Status.init.obs;
  Rx<Weapon?> weapon = Rx(null);
  RxString imageGacha = "".obs;
  ScrollController scrollController = ScrollController();


  void selectWeapon(Weapon value) async {
    weapon.value = value;
    imageGacha.value = weapon.value?.images?.namegacha ?? "";
    update();
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
