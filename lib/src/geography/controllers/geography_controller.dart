import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/geography.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GeographyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Geography> geographies = <Geography>[].obs;
  Rx<Geography?> geography = Rx(null);

  void selectGeography(Geography geography) {
    this.geography.value = geography;
  }

  @override
  void onInit() {
    geographies.addAll(Get.find<MainController>().geographies);
    super.onInit();
  }
}
