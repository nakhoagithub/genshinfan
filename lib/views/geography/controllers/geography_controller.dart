import 'package:flutter/widgets.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/geography.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GeographyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Geography> geographies = <Geography>[].obs;
  Rx<Geography?> geography = Rx(null);
  ScrollController scrollController = ScrollController();

  void selectGeography(Geography geography) {
    this.geography.value = geography;
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
    geographies.addAll(Get.find<MainController>().geographies);
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
