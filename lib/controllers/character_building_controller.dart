import 'package:genshinfan/controllers/character_controller.dart';
import 'package:genshinfan/objects/app/character_building.dart';
import 'package:genshinfan/services/character_service.dart';
import 'package:get/get.dart';

class CharacterBuildingController extends GetxController {
  RxInt status = 0.obs;
  RxList<CharacterBuilding> characters = <CharacterBuilding>[].obs;
  RxString key = "".obs;

  @override
  void onInit() async {
    status.value = 1;
    String key = Get.find<CharacterController>().character.value?.id ?? "";
    characters.value = await CharacterService().getCharacterBuilding(key);
    status.value = 2;
    super.onInit();
  }
}
