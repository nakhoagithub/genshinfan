import 'package:flutter/material.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/craft.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CraftController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Craft> crafts = <Craft>[].obs;
  Rx<Craft?> craft = Rx(null);
  ScrollController scrollController = ScrollController();

  void selectCraft(Craft craft) {
    this.craft.value = craft;
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
  void onInit() {
    crafts.addAll(Get.find<MainController>().crafts);
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
