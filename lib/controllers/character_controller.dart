import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/resources/utils/enum.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../objects/character.dart';

class CharacterController extends GetxController
    with GetTickerProviderStateMixin {
  GetStorage box = GetStorage();
  RxList<Character> characters = <Character>[].obs;
  Rx<Status> status = Status.init.obs;
  Rx<Character?> character = Rx(null);
  RxString element = "".obs;
  ScrollController scrollController = ScrollController();

  void selectCharacter(Character value) async {
    character.value = value;
    if (character.value?.association == "MAINACTOR") {
      if (character.value?.name != "" &&
          character.value?.talentTravelers != null) {
        element.value = character.value!.talentTravelers?[0].element ?? "";
      }
    } else {
      element.value = character.value?.element ?? "";
    }
    update();
  }

  void selectElement(String? element) async {
    this.element.value = element ?? "";
  }

  @override
  void onInit() {
    characters.addAll(Get.find<AppController>().characters);
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
