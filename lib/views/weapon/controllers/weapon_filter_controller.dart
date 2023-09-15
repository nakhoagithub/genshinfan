import 'dart:async';

import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/views/weapon/controllers/weapon_controller.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WeaponFilterController extends GetxController {
  GetStorage box = GetStorage();
  RxList<Weapon> weapons = <Weapon>[].obs;
  // filter
  RxList<String> substatWeaponFilter = <String>[].obs;
  RxList<bool> substatWeaponFilters = <bool>[].obs;
  RxBool substatAllFilter = true.obs;
  RxList<bool> checkWeaponFilters =
      List.generate(Config.weapons.length, (index) => true).obs;
  RxBool oneRarity = false.obs;
  RxList<bool> checkRarityFilters = List.generate(5, (index) => true).obs;
  RxInt sortName = 0.obs;

  void checkWeaponFilter(int index) {
    checkWeaponFilters[index] = !checkWeaponFilters[index];
    unawaited(
        box.write(Config.storageListWeaponWeaponFilter, checkWeaponFilters));
  }

  void checkSubstatFilter(int index) {
    substatWeaponFilters[index] = !substatWeaponFilters[index];

    // tất cả true thì true
    substatAllFilter.value = substatWeaponFilters.every((element) => element);
    unawaited(
        box.write(Config.storageListSubstatWeaponFilter, substatWeaponFilters));
  }

  void checkAllSubstat() {
    substatAllFilter.value = !substatAllFilter.value;
    if (substatAllFilter.value) {
      substatWeaponFilters.value =
          List.generate(substatWeaponFilters.length, (index) => true);
    } else {
      substatWeaponFilters.value =
          List.generate(substatWeaponFilters.length, (index) => false);
    }
  }

  void checkRarityFilter(int index) {
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
    unawaited(
        box.write(Config.storageListRarityWeaponFilter, checkRarityFilters));
  }

  void checkOneRarity() {
    oneRarity.value = !oneRarity.value;
  }

  void checkSortFilter(int value) {
    sortName.value = value;
    unawaited(box.write(Config.storageSortWeaponFilter, value));
  }

  void filter() {
    weapons.clear();
    weapons.addAll(Get.find<MainController>().weapons);
    // lọc theo vũ khí
    List<String> weapontypes =
        List.generate(checkWeaponFilters.length, (index) {
      if (checkWeaponFilters[index]) {
        return Config.weapons[index];
      }
      return "None";
    });
    weapons.removeWhere((element) =>
        !weapontypes.contains(Tool.getEnglishWeaponType(element.weapontype)));

    // lọc theo substat
    List<String> substat = List.generate(substatWeaponFilters.length, (index) {
      if (substatWeaponFilters[index]) {
        return substatWeaponFilter[index];
      }
      return "None";
    });
    weapons.removeWhere((element) => !substat.contains(element.substat));

    // lọc theo rarity
    List<bool> rarities = List.generate(
        checkRarityFilters.length, (index) => checkRarityFilters[index]);
    rarities.removeWhere((element) => element == false);
    weapons.removeWhere((element) {
      if (oneRarity.value) {
        return element.rarity != rarities.length.toString();
      } else {
        return int.parse(element.rarity) > rarities.length;
      }
    });

    // sắp xếp tên
    weapons.sort(
      (a, b) {
        if (sortName.value == 0) {
          return Tool.removeDiacritics(a.name)
              .compareTo(Tool.removeDiacritics(b.name));
        } else {
          return Tool.removeDiacritics(b.name)
              .compareTo(Tool.removeDiacritics(a.name));
        }
      },
    );
  }

  void reset() {
    weapons.clear();
    weapons.addAll(Get.find<MainController>().weapons);
    // reset weapon
    checkWeaponFilters.value =
        List.generate(Config.weapons.length, (index) => true);
    unawaited(
        box.write(Config.storageListWeaponWeaponFilter, checkWeaponFilters));

    // reset substat
    substatWeaponFilters.value =
        List.generate(substatWeaponFilters.length, (index) => true);
    substatAllFilter.value = substatWeaponFilters.every((element) => element);
    unawaited(
        box.write(Config.storageListSubstatWeaponFilter, substatWeaponFilters));

    // reset rarity
    checkRarityFilters.value = List.generate(5, (index) => true);
    unawaited(
        box.write(Config.storageListRarityWeaponFilter, checkRarityFilters));

    sortName.value = 0;
    unawaited(box.write(Config.storageSortWeaponFilter, 0));
  }

  @override
  void onInit() {
    weapons = Get.find<WeaponController>().weaponsView;

    for (var e in weapons) {
      if (!substatWeaponFilter.contains(e.substat) && e.substat != "") {
        substatWeaponFilter.add(e.substat);
      }
    }
    substatWeaponFilters =
        List.generate(substatWeaponFilter.length, (index) => true).obs;

    // filter weapon
    List<dynamic>? weapontypes = box.read(Config.storageListWeaponWeaponFilter);
    if (weapontypes != null) {
      checkWeaponFilters.value =
          RxList.from(weapontypes.map((element) => element as bool));
    }

    // filter substat
    List<dynamic>? substats = box.read(Config.storageListSubstatWeaponFilter);
    if (substats != null) {
      substatWeaponFilters.value =
          RxList.from(substats.map((element) => element as bool));
      substatAllFilter.value = substatWeaponFilters.every((element) => element);
    }

    // filter rarity
    List<dynamic>? rarities = box.read(Config.storageListRarityWeaponFilter);
    if (rarities != null) {
      checkRarityFilters.value =
          RxList.from(rarities.map((element) => element as bool));
    }

    // filter sort name
    int? sort = box.read(Config.storageSortWeaponFilter);
    if (sort != null) {
      sortName.value = sort;
    }
    super.onInit();
  }
}
