import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/models/app/character_building.dart';
import 'package:genshinfan/services/contribute_service.dart';
import 'package:get/get.dart';

class ManagementContributeCharacterController extends GetxController {
  RxInt status = 0.obs;
  RxList<CharacterBuilding> contributeCharacters = <CharacterBuilding>[].obs;

  Future<void> addContribution(
      CharacterBuilding characterBuilding, int index) async {
    bool result =
        await ContributeCharacterService().addContribute(characterBuilding);
    if (result) {
      contributeCharacters.removeAt(index);
    } else {
      Fluttertoast.showToast(msg: "Error: Permission denied");
    }
  }

  Future<void> deleteContribution(
      CharacterBuilding characterBuilding, int index) async {
    bool result = await ContributeCharacterService()
        .deleteContributeManager(characterBuilding);
    if (result) {
      contributeCharacters.removeAt(index);
    } else {
      Fluttertoast.showToast(msg: "Error: Permission denied");
    }
  }

  @override
  void onInit() async {
    status.value = 1;
    contributeCharacters.value =
        await ContributeCharacterService().getContributeCharacterForManager();
    status.value = 2;
    super.onInit();
  }
}
