import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/objects/weapon.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ContributeCharacterController extends GetxController {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  RxList<Character> characters = Get.find<AppController>().characters;
  Rx<Character?> character = Rx(null);
  RxList<Weapon> weapons = <Weapon>[].obs;
  Rx<Weapon?> weapon = Rx(null);
  RxList<Artifact> artifacts = <Artifact>[].obs;
  Rx<Artifact?> a1 = Rx(null);
  Rx<Artifact?> a2 = Rx(null);
  RxInt type = 0.obs;
  Rx<String?> sandsEffect = 'not'.obs;
  Rx<String?> gobletEffect = 'not'.obs;
  Rx<String?> circletEffect = 'not'.obs;

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
  }

  void selectWeapon(Weapon value) {
    weapon.value = value;
  }

  void selectTypeSet(int value) {
    type.value = value;
    a1.value = null;
    a2.value = null;
  }

  void selectA1(Artifact value) {
    a1.value = value;
    if (a1.value == a2.value) {
      type.value = 1;
      a1.value = value;
      a2.value = null;
    }
  }

  void selectA2(Artifact value) {
    a2.value = value;
    if (a1.value == a2.value) {
      type.value = 1;
      a1.value = value;
      a2.value = null;
    }
  }

  void selectSandsEffect(String value) {
    sandsEffect.value = value;
  }

  void selectGobletEffect(String value) {
    gobletEffect.value = value;
  }

  void selectCircletEffect(String value) {
    circletEffect.value = value;
  }

  Future<void> contribute() async {
    await Future.delayed(const Duration(seconds: 2));
    buttonController.success();
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
