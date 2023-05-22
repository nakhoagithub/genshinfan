import 'package:flutter/widgets.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/objects/geography.dart';
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
    geographies.addAll(Get.find<AppController>().geographies);
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
