import 'dart:async';

import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../resources/utils/enum.dart';

class ResourceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Resource> resources = <Resource>[].obs;
  Rx<Status> status = Status.init.obs;
  Rx<Resource?> resource = Rx(null);
  ScrollController scrollController = ScrollController();

  // filter
  RxList<String> substatResourceFilter = <String>[].obs;
  RxList<bool> substatResourceFilters = <bool>[].obs;
  RxBool substatAllFilter = true.obs;
  RxBool oneRarity = false.obs;
  RxList<bool> checkRarityFilters = List.generate(5, (index) => true).obs;
  RxInt sortName = 0.obs;

  void selectResource(Resource resource) {
    this.resource.value = resource;
  }

  void checkSubstatFilter(int index) {
    substatResourceFilters[index] = !substatResourceFilters[index];
    // tất cả true thì true
    substatAllFilter.value = substatResourceFilters.every((element) => element);
    unawaited(box.write(
        Config.storageListSubstatResourceFilter, substatResourceFilters));
  }

  void checkAllSubstat() {
    substatAllFilter.value = !substatAllFilter.value;
    if (substatAllFilter.value) {
      substatResourceFilters.value =
          List.generate(substatResourceFilters.length, (index) => true);
    } else {
      substatResourceFilters.value =
          List.generate(substatResourceFilters.length, (index) => false);
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
        List.generate(substatResourceFilters.length, (index) {
      if (substatResourceFilters[index]) {
        return substatResourceFilter[index];
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
    resources.clear();
    resources.addAll(Get.find<AppController>().resources);

    // reset substat
    substatResourceFilters.value =
        List.generate(substatResourceFilters.length, (index) => true);
    substatAllFilter.value = substatResourceFilters.every((element) => element);
    unawaited(box.write(
        Config.storageListSubstatResourceFilter, substatResourceFilters));

    // reset rarity
    checkRarityFilters.value = List.generate(5, (index) => true);
    unawaited(
        box.write(Config.storageListRarityResourceFilter, checkRarityFilters));

    sortName.value = 0;
    unawaited(box.write(Config.storageSortResourceFilter, 0));
  }

  @override
  void update([List<Object>? ids, bool condition = true]) async {
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
    super.update(ids, condition);
  }

  @override
  void onInit() {
    resources.addAll(Get.find<AppController>().resources);
    for (var e in resources) {
      if (!substatResourceFilter.contains(e.materialtype) &&
          e.materialtype != "") {
        substatResourceFilter.add(e.materialtype);
      }
    }
    substatResourceFilters =
        List.generate(substatResourceFilter.length, (index) => true).obs;

    // filter substat
    List<dynamic>? substats = box.read(Config.storageListSubstatResourceFilter);
    if (substats != null) {
      substatResourceFilters.value =
          RxList.from(substats.map((element) => element as bool));
      substatAllFilter.value =
          substatResourceFilters.every((element) => element);
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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
