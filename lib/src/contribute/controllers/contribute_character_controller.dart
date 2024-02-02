import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/app/character_building.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/services/contribute_service.dart';
import 'package:genshinfan/src/widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ContributeCharacterController extends GetxController {
  GetStorage box = GetStorage();
  TextEditingController textEditingControllerAuth = TextEditingController();
  RxList<Character> characters = Get.find<MainController>().characters;
  RxString author = "".obs;
  Rx<Character?> character = Rx(null);
  RxString elementOfTraveler = "".obs;
  RxList<Weapon> weapons = <Weapon>[].obs;
  Rx<Weapon?> weapon = Rx(null);
  RxList<Artifact> artifacts = <Artifact>[].obs;
  Rx<Artifact?> a1 = Rx(null);
  Rx<Artifact?> a2 = Rx(null);
  RxInt type = 0.obs;
  RxList<String> sandsEffect = <String>[].obs;
  RxList<String> gobletsEffect = <String>[].obs;
  RxList<String> circletsEffect = <String>[].obs;

  void changeAuthor(String value) {
    author.value = value;
    textEditingControllerAuth.text = value;
    unawaited(box.write(Config.keyAuthContribute, value));
  }

  void selectCharacter(Character value) {
    character.value = value;
    weapon.value = null;
    MainController appController = Get.find<MainController>();
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

  void selectSandsEffect(List<String> value) {
    sandsEffect.value = value;
  }

  void selectGobletEffect(List<String> value) {
    gobletsEffect.value = value;
  }

  void selectCircletEffect(List<String> value) {
    circletsEffect.value = value;
  }

  Future<void> contribute() async {
    String? characterName = character.value?.key;
    if (character.value?.association == "MAINACTOR") {
      characterName = "main";
    }

    String? weapon = this.weapon.value?.key;
    String? a1 = this.a1.value?.key;
    String? a2 = this.a2.value?.key;
    List<String> sands = sandsEffect;
    List<String> goblets = gobletsEffect;
    List<String> circlets = circletsEffect;

    String uid = Get.find<MainController>().user.value?.uid ?? "";
    String author = this.author.value;

    if ((author.length >= 3 && author.length <= 30) &&
        (characterName != null && weapon != null && a1 != null) &&
        (type.value == 1 || (type.value == 0 && a2 != null)) &&
        sands.isNotEmpty &&
        goblets.isNotEmpty &&
        circlets.isNotEmpty) {
      CharacterBuilding characterBuilding = CharacterBuilding(
        characterName: characterName,
        element: elementOfTraveler.value,
        weapon: weapon,
        typeSet: type.value,
        a1: a1,
        a2: a2,
        sands: sands,
        goblets: goblets,
        circlets: circlets,
        author: author,
        uidAuthor: uid,
      );

      bool result =
          await ContributeCharacterService().contribute(characterBuilding);
      if (result) {
        Fluttertoast.showToast(msg: "success".tr);
        Get.back();
      } else {
        Fluttertoast.showToast(msg: "error".tr);
      }
    } else {
      dialogInfo("select_full_info".tr);
    }
  }

  @override
  void onInit() {
    MainController appController = Get.find<MainController>();
    author.value = box.read(Config.keyAuthContribute) ??
        appController.userApp.value?.name ??
        "";
    textEditingControllerAuth.text = author.value;

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
    artifacts.addAll(Get.find<MainController>().artifacts);
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
