import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/models/app/character_building.dart';
import 'package:genshinfan/models/app/character_building_old.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/views/character/controllers/character_controller.dart';
import 'package:genshinfan/services/character_service.dart';
import 'package:genshinfan/services/contribute_service.dart';
import 'package:get/get.dart';

class CharacterBuildingController extends GetxController {
  RxInt status = 0.obs;
  RxList<CharacterBuildingOld> characters = <CharacterBuildingOld>[].obs;
  RxList<CharacterBuilding> charactersBuilding = <CharacterBuilding>[].obs;
  RxString key = "".obs;

  Future<void> deleteContributionForManagerOld(
      CharacterBuildingOld characterBuilding, int index) async {
    bool result = await ContributeCharacterService()
        .deleteContributeForManagerOld(characterBuilding);
    if (result) {
      characters.removeAt(index);
    } else {
      Fluttertoast.showToast(msg: "Error: Permission denied");
    }
  }

  Future<void> deleteContributionForManager(
      CharacterBuilding characterBuilding, int index) async {
    bool result = await ContributeCharacterService()
        .deleteContributeForManager(characterBuilding);
    if (result) {
      characters.removeAt(index);
    } else {
      Fluttertoast.showToast(msg: "Error: Permission denied");
    }
  }

  @override
  void onInit() async {
    status.value = 1;
    Character? character = Get.find<CharacterController>().character.value;
    String key = Get.find<CharacterController>().character.value?.key ?? "";
    characters.value = await CharacterService().getCharacterBuildingOld(key);
    if (character?.association == "MAINACTOR") {
      key = "main";
    }
    charactersBuilding.value =
        await CharacterService().getCharacterBuilding(key);
    status.value = 2;
    super.onInit();
  }
}
