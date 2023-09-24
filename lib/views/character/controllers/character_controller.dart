import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/utils/enum.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/game/character.dart';

class CharacterController extends GetxController
    with GetTickerProviderStateMixin {
  GetStorage box = GetStorage();
  RxList<Character> characters = <Character>[].obs;
  RxList<Character> charactersView = <Character>[].obs;
  Rx<Status> status = Status.init.obs;
  Rx<Character?> character = Rx(null);
  RxString element = "".obs;

  void selectCharacter(Character value) async {
    character.value = value;
    if (character.value?.association == "MAINACTOR") {
      if (character.value?.name != "" &&
          character.value?.talentTravelers != null) {
        element.value = character.value!.talentTravelers?[0].element ?? "";
      }
    } else {
      element.value = character.value?.element ?? "";
    }
  }

  void selectElement(String? element) async {
    this.element.value = element ?? "";
  }

  @override
  void onInit() {
    characters.addAll(Get.find<MainController>().characters);
    charactersView.addAll(Get.find<MainController>().characters);
    super.onInit();
  }
}
