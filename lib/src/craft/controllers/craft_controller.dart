import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/craft.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CraftController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Craft> crafts = <Craft>[].obs;
  Rx<Craft?> craft = Rx(null);

  void selectCraft(Craft craft) {
    this.craft.value = craft;
  }
  @override
  void onInit() {
    crafts.addAll(Get.find<MainController>().crafts);
    super.onInit();
  }
}
