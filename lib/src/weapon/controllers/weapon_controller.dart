import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/utils/enum.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/game/weapon.dart';

class WeaponController extends GetxController with GetTickerProviderStateMixin {
  GetStorage box = GetStorage();
  RxList<Weapon> weapons = <Weapon>[].obs;
  RxList<Weapon> weaponsView = <Weapon>[].obs;
  Rx<Status> status = Status.init.obs;
  Rx<Weapon?> weapon = Rx(null);
  RxString imageGacha = "".obs;

  void selectWeapon(Weapon value) {
    weapon.value = value;
    imageGacha.value = weapon.value?.images?.namegacha ?? "";
  }

  @override
  void onInit() {
    weapons.addAll(Get.find<MainController>().weapons);
    weaponsView.addAll(Get.find<MainController>().weapons);
    super.onInit();
  }
}
