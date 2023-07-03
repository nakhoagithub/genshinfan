import 'package:flutter/widgets.dart';
import 'package:genshinfan/app_controller.dart';
import 'package:genshinfan/models/outfit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OutfitController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Outfit> outfits = <Outfit>[].obs;
  Rx<Outfit?> outfit = Rx(null);
  ScrollController scrollController = ScrollController();

  void selectOutfit(Outfit outfit) {
    this.outfit.value = outfit;
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
    outfits.addAll(Get.find<AppController>().outfits);
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
