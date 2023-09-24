import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/outfit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OutfitController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Outfit> outfits = <Outfit>[].obs;
  Rx<Outfit?> outfit = Rx(null);

  void selectOutfit(Outfit outfit) {
    this.outfit.value = outfit;
  }

  @override
  void onInit() {
    outfits.addAll(Get.find<MainController>().outfits);
    super.onInit();
  }
}
