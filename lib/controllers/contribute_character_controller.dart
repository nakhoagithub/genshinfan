import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/objects/app/character_building.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/objects/weapon.dart';
import 'package:genshinfan/services/contribute_service.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ContributeCharacterController extends GetxController {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  RxList<Character> characters = Get.find<AppController>().characters;
  RxString author = "".obs;
  Rx<Character?> character = Rx(null);
  RxString elementOfTraveler = "".obs;
  RxList<Weapon> weapons = <Weapon>[].obs;
  Rx<Weapon?> weapon = Rx(null);
  RxList<Artifact> artifacts = <Artifact>[].obs;
  Rx<Artifact?> a1 = Rx(null);
  Rx<Artifact?> a2 = Rx(null);
  RxInt type = 0.obs;
  Rx<String> sandsEffect = 'option'.obs;
  Rx<String> gobletEffect = 'option'.obs;
  Rx<String> circletEffect = 'option'.obs;

  void changeAuthor(String value) {
    author.value = value;
    buttonController.reset();
  }

  void selectCharacter(Character value) {
    character.value = value;
    weapon.value = null;
    AppController appController = Get.find<AppController>();
    weapons.value = appController.weapons.where((p0) {
      return p0.weapontype == value.weapontype;
    }).toList();
    weapons.sort(
      (a, b) {
        int rarity = b.rarity.compareTo(a.rarity);
        if (rarity != 0) {
          return rarity;
        }
        return a.name.compareTo(b.name);
      },
    );
    buttonController.reset();
  }

  void selectWeapon(Weapon value) {
    weapon.value = value;
    buttonController.reset();
  }

  void selectTypeSet(int value) {
    type.value = value;
    a1.value = null;
    a2.value = null;
    buttonController.reset();
  }

  void selectA1(Artifact value) {
    a1.value = value;
    if (a1.value == a2.value) {
      type.value = 1;
      a1.value = value;
      a2.value = null;
    }
    buttonController.reset();
  }

  void selectA2(Artifact value) {
    a2.value = value;
    if (a1.value == a2.value) {
      type.value = 1;
      a1.value = value;
      a2.value = null;
    }
    buttonController.reset();
  }

  void selectSandsEffect(String value) {
    sandsEffect.value = value;
    buttonController.reset();
  }

  void selectGobletEffect(String value) {
    gobletEffect.value = value;
    buttonController.reset();
  }

  void selectCircletEffect(String value) {
    circletEffect.value = value;
    buttonController.reset();
  }

  Future<void> contribute() async {
    String? character = this.character.value?.id;

    String? weapon = this.weapon.value?.id;
    String? a1 = this.a1.value?.id;
    String? a2 = this.a2.value?.id;
    String sand = sandsEffect.value;
    String goblet = gobletEffect.value;
    String circlet = circletEffect.value;

    String uid = Get.find<AppController>().userApp.value?.uid ?? "";
    String author = this.author.value;

    if ((author.length >= 3 && author.length <= 30) &&
        (character != null && weapon != null && a1 != null) &&
        (type.value == 1 || (type.value == 0 && a2 != null))) {
      CharacterBuilding characterBuilding = CharacterBuilding(
        characterName: character,
        element: elementOfTraveler.value,
        weapon: weapon,
        typeSet: type.value,
        a1: a1,
        a2: a2,
        sands: sand,
        goblet: goblet,
        circlet: circlet,
        author: author,
        uidAuthor: uid,
      );

      bool result =
          await ContributeCharacterService().contribute(characterBuilding);
      if (result) {
        buttonController.success();
        Fluttertoast.showToast(msg: "success".tr);
        Get.back();
      } else {
        buttonController.error();
      }
    } else {
      dialogInfo("choose_full_info".tr);
      buttonController.error();
    }
  }

  @override
  void onInit() {
    characters.sort(
      (a, b) {
        int rarity = b.rarity.compareTo(a.rarity);
        if (rarity != 0) {
          return rarity;
        }
        return a.name.compareTo(b.name);
      },
    );
    // xóa các artifact không có bộ 2 và 4
    artifacts.addAll(Get.find<AppController>().artifacts);
    artifacts.removeWhere((element) => element.set1 != null);
    // sắp xếp theo độ hiếm
    artifacts.sort(
      (a, b) {
        int rarity = b.rarity[b.rarity.length - 1]
            .compareTo(a.rarity[a.rarity.length - 1]);
        if (rarity != 0) {
          return rarity;
        }
        return a.name.compareTo(b.name);
      },
    );
    super.onInit();
  }
}
