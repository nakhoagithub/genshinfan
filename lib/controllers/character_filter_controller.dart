import 'dart:async';

import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/controllers/character_controller.dart';
import 'package:genshinfan/objects/character.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CharacterFilterController extends GetxController {
  GetStorage box = GetStorage();
  RxList<Character> characters = <Character>[].obs;
  RxList<bool> checkElementFilters =
      List.generate(Config.elements.length, (index) => true).obs;
  RxList<bool> checkWeaponFilters =
      List.generate(Config.weapons.length, (index) => true).obs;

  RxBool oneRarity = false.obs;
  RxList<bool> checkRarityFilters = List.generate(5, (index) => true).obs;

  RxInt sortName = 0.obs;

  Future<void> checkElementFilter(int index) async {
    checkElementFilters[index] = !checkElementFilters[index];
    unawaited(box.write(
        Config.storageListElementCharacterFilter, checkElementFilters));
  }

  Future<void> checkWeaponFilter(int index) async {
    checkWeaponFilters[index] = !checkWeaponFilters[index];
    unawaited(
        box.write(Config.storageListWeaponCharacterFilter, checkWeaponFilters));
  }

  Future<void> checkRarityFilter(int index) async {
    checkRarityFilters[index] = !checkRarityFilters[index];
    for (int i = 0; i < checkRarityFilters.length; i++) {
      if (i >= index + 1 && !checkRarityFilters[index]) {
        checkRarityFilters[i] = false;
      }
      if (i <= index && checkRarityFilters[index]) {
        checkRarityFilters[i] = true;
      }
    }
    // không có ít hơn 4 sao
    checkRarityFilters[0] = true;
    checkRarityFilters[1] = true;
    checkRarityFilters[2] = true;
    checkRarityFilters[3] = true;
    unawaited(
        box.write(Config.storageListRarityCharacterFilter, checkRarityFilters));
  }

  void checkOneRarity() {
    oneRarity.value = !oneRarity.value;
  }

  Future<void> checkSortFilter(int value) async {
    sortName.value = value;
    unawaited(box.write(Config.storageSortCharacterFilter, value));
  }

  void filter() {
    // lọc theo nguyên tố
    List<String> elements = List.generate(checkElementFilters.length, (index) {
      if (checkElementFilters[index]) {
        return Config.elements[index];
      }
      return "None";
    });
    characters.clear();
    characters.addAll(Get.find<AppController>().characters);
    characters.removeWhere((element) =>
        !elements.contains(Tools.getEnglishElementFromName(element.element)) &&
        element.element != "none".tr);

    // lọc theo vũ khí
    List<String> weapons = List.generate(checkWeaponFilters.length, (index) {
      if (checkWeaponFilters[index]) {
        return Config.weapons[index];
      }
      return "None";
    });
    characters.removeWhere((element) =>
        !weapons.contains(Tools.getEnglishWeaponType(element.weapontype)));

    // lọc theo rarity
    List<bool> rarities = List.generate(
        checkRarityFilters.length, (index) => checkRarityFilters[index]);
    rarities.removeWhere((element) => element == false);
    characters.removeWhere((element) {
      if (oneRarity.value) {
        return element.rarity != rarities.length.toString();
      } else {
        return int.parse(element.rarity) > rarities.length;
      }
    });

    // sắp xếp tên
    characters.sort(
      (a, b) {
        if (sortName.value == 0) {
          return Tools.removeDiacritics(a.name)
              .compareTo(Tools.removeDiacritics(b.name));
        } else {
          return Tools.removeDiacritics(b.name)
              .compareTo(Tools.removeDiacritics(a.name));
        }
      },
    );
  }

  void reset() {
    characters.clear();
    characters.addAll(Get.find<AppController>().characters);
    // reset element
    checkElementFilters.value =
        List.generate(Config.elements.length, (index) => true);
    unawaited(box.write(
        Config.storageListElementCharacterFilter, checkElementFilters));

    // reset weapon
    checkWeaponFilters.value =
        List.generate(Config.weapons.length, (index) => true);
    unawaited(
        box.write(Config.storageListWeaponCharacterFilter, checkWeaponFilters));

    // reset rarity
    checkRarityFilters.value = List.generate(5, (index) => true);
    unawaited(
        box.write(Config.storageListRarityCharacterFilter, checkRarityFilters));

    sortName.value = 0;
    unawaited(box.write(Config.storageSortCharacterFilter, 0));
  }

  @override
  void onInit() {
    characters = Get.find<CharacterController>().characters;

    // filter element
    List<dynamic>? elements =
        box.read(Config.storageListElementCharacterFilter);
    if (elements != null) {
      checkElementFilters.value =
          RxList.from(elements.map((element) => element as bool));
    }

    // filter weapon
    List<dynamic>? weapons = box.read(Config.storageListWeaponCharacterFilter);
    if (weapons != null) {
      checkWeaponFilters.value =
          RxList.from(weapons.map((element) => element as bool));
    }

    // filter weapon
    List<dynamic>? rarities = box.read(Config.storageListRarityCharacterFilter);
    if (rarities != null) {
      checkRarityFilters.value =
          RxList.from(rarities.map((element) => element as bool));
    }

    // filter sort name
    int? sort = box.read(Config.storageSortCharacterFilter);
    if (sort != null) {
      sortName.value = sort;
    }
    super.onInit();
  }
}
