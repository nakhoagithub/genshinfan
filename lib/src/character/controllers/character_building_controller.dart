import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/models/app/character_building.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/src/character/controllers/character_controller.dart';
import 'package:genshinfan/services/character_service.dart';
import 'package:genshinfan/services/contribute_service.dart';
import 'package:get/get.dart';

class CharacterBuildingController extends GetxController {
  RxInt status = 0.obs;
  RxList<CharacterBuilding> charactersBuilding = <CharacterBuilding>[].obs;
  RxString key = "".obs;

  Future<void> deleteContribution(
      CharacterBuilding characterBuilding, int index) async {
    bool result =
        await ContributeCharacterService().deleteContribute(characterBuilding);
    if (result) {
      charactersBuilding.removeAt(index);
    } else {
      Fluttertoast.showToast(msg: "Error: Permission denied");
    }
  }

  @override
  void onInit() async {
    super.onInit();
    status.value = 1;
    // Character? character = Get.find<CharacterController>().character.value;
    // int key = Get.find<CharacterController>().character.value?.key ?? 0;
    // if (character?.association == "MAINACTOR") {
    //   key = "main";
    // }
    // charactersBuilding.value =
    //     await CharacterService().getCharacterBuilding(key);
    // status.value = 2;
  }
}
