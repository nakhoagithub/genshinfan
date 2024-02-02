import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/namecard.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NamecardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Namecard> namecards = <Namecard>[].obs;
  Rx<Namecard?> namecard = Rx(null);

  void selectNamecard(Namecard namecard) {
    this.namecard.value = namecard;
  }

  @override
  void onInit() {
    namecards.addAll(Get.find<MainController>().namecards);
    super.onInit();
  }
}
