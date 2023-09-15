import 'package:flutter/widgets.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/windglider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WindgliderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Windglider> windgliders = <Windglider>[].obs;
  Rx<Windglider?> windglider = Rx(null);
  ScrollController scrollController = ScrollController();

  void selectWindglider(Windglider windglider) {
    this.windglider.value = windglider;
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
    windgliders.addAll(Get.find<MainController>().windgliders);
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
