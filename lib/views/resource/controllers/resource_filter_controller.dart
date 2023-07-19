import 'dart:async';

import 'package:genshinfan/views/app_controller.dart';
import 'package:genshinfan/views/resource/controllers/resource_controller.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ResourceFilterController extends GetxController {
  GetStorage box = GetStorage();
  List<Resource> resources = <Resource>[].obs;
  RxList<String> substatResourceFilters = <String>[].obs;
  RxList<bool> selectSubstatResourceFilters = <bool>[].obs;
  RxBool substatAllFilter = true.obs;
  RxBool oneRarity = false.obs;
  RxList<bool> checkRarityFilters = List.generate(5, (index) => true).obs;
  RxInt sortName = 0.obs;

  void checkSubstatFilter(int index) {
    selectSubstatResourceFilters[index] = !selectSubstatResourceFilters[index];
    // tất cả true thì true
    substatAllFilter.value =
        selectSubstatResourceFilters.every((element) => element);
    unawaited(box.write(
        Config.storageListSubstatResourceFilter, selectSubstatResourceFilters));
  }

  void checkAllSubstat() {
    substatAllFilter.value = !substatAllFilter.value;
    if (substatAllFilter.value) {
      selectSubstatResourceFilters.value =
          List.generate(selectSubstatResourceFilters.length, (index) => true);
    } else {
      selectSubstatResourceFilters.value =
          List.generate(selectSubstatResourceFilters.length, (index) => false);
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
    // một số resource không có sao
    // checkRarityFilters[0] = true;
    unawaited(
        box.write(Config.storageListRarityResourceFilter, checkRarityFilters));
  }

  void checkOneRarity() {
    oneRarity.value = !oneRarity.value;
  }

  void checkSortFilter(int value) {
    sortName.value = value;
    unawaited(box.write(Config.storageSortResourceFilter, value));
  }

  void filter() {
    resources.clear();
    resources.addAll(Get.find<AppController>().resources);

    // lọc theo substat
    List<String> substat =
        List.generate(selectSubstatResourceFilters.length, (index) {
      if (selectSubstatResourceFilters[index]) {
        return substatResourceFilters[index];
      }
      return "None";
    });
    resources.removeWhere((element) => !substat.contains(element.materialtype));

    // lọc theo rarity
    List<bool> rarities = List.generate(
        checkRarityFilters.length, (index) => checkRarityFilters[index]);
    rarities.removeWhere((element) => element == false);
    resources.removeWhere((element) {
      if (oneRarity.value) {
        return (element.rarity ?? "0") != rarities.length.toString();
      } else {
        return int.parse(element.rarity ?? "0") > rarities.length;
      }
    });

    // sắp xếp tên
    resources.sort(
      (a, b) {
        return a.sortorder.compareTo(b.sortorder);
        // if (sortName.value == 0) {
        //   return Tools.removeDiacritics(a.name)
        //       .compareTo(Tools.removeDiacritics(b.name));
        // } else {
        //   return Tools.removeDiacritics(b.name)
        //       .compareTo(Tools.removeDiacritics(a.name));
        // }
      },
    );
  }

  void reset() {
    resources.clear();
    resources.addAll(Get.find<AppController>().resources);

    // reset substat
    selectSubstatResourceFilters.value =
        List.generate(selectSubstatResourceFilters.length, (index) => true);
    substatAllFilter.value =
        selectSubstatResourceFilters.every((element) => element);
    unawaited(box.write(
        Config.storageListSubstatResourceFilter, selectSubstatResourceFilters));

    // reset rarity
    checkRarityFilters.value = List.generate(5, (index) => true);
    unawaited(
        box.write(Config.storageListRarityResourceFilter, checkRarityFilters));

    sortName.value = 0;
    unawaited(box.write(Config.storageSortResourceFilter, 0));
  }

  @override
  void onInit() {
    resources = Get.find<ResourceController>().resourcesView;
    for (var e in resources) {
      if (!substatResourceFilters.contains(e.materialtype) &&
          e.materialtype != "") {
        substatResourceFilters.add(e.materialtype);
      }
    }
    selectSubstatResourceFilters =
        List.generate(substatResourceFilters.length, (index) => true).obs;

    // filter substat with storage
    List<dynamic>? substats = box.read(Config.storageListSubstatResourceFilter);
    if (substats != null &&
        substats.length == selectSubstatResourceFilters.length) {
      selectSubstatResourceFilters.value =
          RxList.from(substats.map((element) => element as bool));
      substatAllFilter.value =
          selectSubstatResourceFilters.every((element) => element);
    }

    // filter rarity
    List<dynamic>? rarities = box.read(Config.storageListRarityResourceFilter);
    if (rarities != null) {
      checkRarityFilters.value =
          RxList.from(rarities.map((element) => element as bool));
    }

    // filter sort name
    int? sort = box.read(Config.storageSortResourceFilter);
    if (sort != null) {
      sortName.value = sort;
    }
    super.onInit();
  }
}
