import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/windglider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WindgliderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Windglider> windgliders = <Windglider>[].obs;
  Rx<Windglider?> windglider = Rx(null);

  void selectWindglider(Windglider windglider) {
    this.windglider.value = windglider;
  }

  @override
  void onInit() {
    windgliders.addAll(Get.find<MainController>().windgliders);
    super.onInit();
  }
}
