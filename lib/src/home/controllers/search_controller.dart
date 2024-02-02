import 'package:flutter/material.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/animal.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/models/game/enemy.dart';
import 'package:genshinfan/models/game/food.dart';
import 'package:genshinfan/models/game/index.dart';
import 'package:genshinfan/models/game/index_all.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:get/get.dart';

class SearchAppController extends GetxController {
  ScrollController scrollController = ScrollController();
  RxList<String> recomments = <String>[].obs;

  List<Character> searchCharacter(String query) {
    List<Character> datas = Get.find<MainController>().characters;
    List<Character> results = [];
    results = datas.where((element) {
      String name = Tool.removeDiacritics(element.name.toLowerCase());
      String title = Tool.removeDiacritics(element.title.toLowerCase());
      String description =
          Tool.removeDiacritics(element.description.toLowerCase());
      String rarity = "${Tool.removeDiacritics(element.rarity.toLowerCase())}*";
      String elementCharacter =
          Tool.removeDiacritics(element.element.toLowerCase());
      String weapontype =
          Tool.removeDiacritics(element.weapontype.toLowerCase());
      String substat = Tool.removeDiacritics(element.substat.toLowerCase());
      String gender = Tool.removeDiacritics(element.gender.toLowerCase());
      String region = Tool.removeDiacritics(element.region.toLowerCase());
      String affiliation =
          Tool.removeDiacritics(element.affiliation.toLowerCase());
      String birthdaymmdd =
          Tool.removeDiacritics(element.birthdaymmdd.toLowerCase());
      String birthday = Tool.removeDiacritics(element.birthday.toLowerCase());
      String constellation =
          Tool.removeDiacritics(element.constellation.toLowerCase());
      String specialized =
          Tool.removeDiacritics((element.specialized ?? "").toLowerCase());
      return name.contains(query) ||
          title.contains(query) ||
          description.contains(query) ||
          rarity.contains(query) ||
          elementCharacter.contains(query) ||
          weapontype.contains(query) ||
          substat.contains(query) ||
          gender.contains(query) ||
          region.contains(query) ||
          affiliation.contains(query) ||
          birthdaymmdd.contains(query) ||
          birthday.contains(query) ||
          constellation.contains(query) ||
          specialized.contains(query);
    }).toList();
    return results;
  }

  List<Weapon> searchWeapon(String query) {
    List<Weapon> datas = Get.find<MainController>().weapons;
    List<Weapon> results = [];
    results = datas.where((element) {
      String name = Tool.removeDiacritics(element.name.toLowerCase());
      String description =
          Tool.removeDiacritics(element.description.toLowerCase());
      String rarity = "${Tool.removeDiacritics(element.rarity.toLowerCase())}*";
      String story = Tool.removeDiacritics(element.story.toLowerCase());
      String weapontype =
          Tool.removeDiacritics(element.weapontype.toLowerCase());
      String substat = Tool.removeDiacritics(element.substat.toLowerCase());
      String effectname =
          Tool.removeDiacritics(element.effectname.toLowerCase());
      String effect = Tool.removeDiacritics(element.effect.toLowerCase());
      String specialized =
          Tool.removeDiacritics((element.specialized ?? "").toLowerCase());
      return name.contains(query) ||
          description.contains(query) ||
          rarity.contains(query) ||
          story.contains(query) ||
          effectname.contains(query) ||
          effect.contains(query) ||
          weapontype.contains(query) ||
          substat.contains(query) ||
          specialized.contains(query);
    }).toList();
    return results;
  }

  List<Artifact> searchArtifact(String query) {
    List<Artifact> datas = Get.find<MainController>().artifacts;
    List<Artifact> results = [];
    results = datas.where((element) {
      String name = Tool.removeDiacritics(element.name.toLowerCase());
      String set1 = Tool.removeDiacritics((element.set1 ?? "").toLowerCase());
      String set2 = Tool.removeDiacritics((element.set2 ?? "").toLowerCase());
      String set4 = Tool.removeDiacritics((element.set4 ?? "").toLowerCase());

      return name.contains(query) ||
          set1.contains(query) ||
          set2.contains(query) ||
          set4.contains(query);
    }).toList();
    return results;
  }

  List<Resource> searchResource(String query) {
    List<Resource> datas = Get.find<MainController>().resources;
    List<Resource> results = [];
    results = datas.where((element) {
      String name = Tool.removeDiacritics(element.name.toLowerCase());
      String category = Tool.removeDiacritics((element.category).toLowerCase());
      String materialtype =
          Tool.removeDiacritics((element.materialtype).toLowerCase());
      String description =
          Tool.removeDiacritics((element.description).toLowerCase());
      String dropdomain =
          Tool.removeDiacritics((element.dropdomain ?? "").toLowerCase());
      List<String> sources = element.source;
      bool searchSources = sources.firstWhereOrNull((element) =>
                  Tool.removeDiacritics((element).toLowerCase())
                      .contains(query)) !=
              null
          ? true
          : false;

      return name.contains(query) ||
          category.contains(query) ||
          materialtype.contains(query) ||
          description.contains(query) ||
          dropdomain.contains(query) ||
          searchSources;
    }).toList();
    return results;
  }

  List<Food> searchFood(String query) {
    List<Food> datas = Get.find<MainController>().foods;
    List<Food> results = [];
    results = datas.where((element) {
      String name = Tool.removeDiacritics(element.name.toLowerCase());
      String rarity = Tool.removeDiacritics((element.rarity).toLowerCase());
      String foodtype = Tool.removeDiacritics((element.foodtype).toLowerCase());
      String description =
          Tool.removeDiacritics((element.description).toLowerCase());

      String foodfilter =
          Tool.removeDiacritics((element.foodfilter).toLowerCase());
      String foodcategory =
          Tool.removeDiacritics((element.foodcategory).toLowerCase());
      String effect = Tool.removeDiacritics((element.effect).toLowerCase());
      String basedish = Tool.removeDiacritics((element.basedish).toLowerCase());
      String character =
          Tool.removeDiacritics((element.character).toLowerCase());

      return name.contains(query) ||
          rarity.contains(query) ||
          foodtype.contains(query) ||
          description.contains(query) ||
          foodfilter.contains(query) ||
          foodcategory.contains(query) ||
          effect.contains(query) ||
          basedish.contains(query) ||
          character.contains(query);
    }).toList();
    return results;
  }

  List<Enemy> searchEnemies(String query) {
    List<Enemy> datas = Get.find<MainController>().enemies;
    List<Enemy> results = [];
    results = datas.where((element) {
      String name = Tool.removeDiacritics(element.name.toLowerCase());
      String specialname =
          Tool.removeDiacritics((element.specialname).toLowerCase());
      String enemytype =
          Tool.removeDiacritics((element.enemytype).toLowerCase());
      String description =
          Tool.removeDiacritics((element.description).toLowerCase());

      String category = Tool.removeDiacritics((element.category).toLowerCase());

      return name.contains(query) ||
          specialname.contains(query) ||
          enemytype.contains(query) ||
          description.contains(query) ||
          category.contains(query);
    }).toList();
    return results;
  }

  List<Animal> searchAnimal(String query) {
    List<Animal> datas = Get.find<MainController>().animals;
    List<Animal> results = [];
    results = datas.where((element) {
      String name = Tool.removeDiacritics(element.name.toLowerCase());
      String counttype =
          Tool.removeDiacritics((element.counttype).toLowerCase());
      String description =
          Tool.removeDiacritics((element.description).toLowerCase());

      String category = Tool.removeDiacritics((element.category).toLowerCase());

      return name.contains(query) ||
          counttype.contains(query) ||
          description.contains(query) ||
          category.contains(query);
    }).toList();
    return results;
  }

  List<String> _getListStringIndex(Index value) {
    List<String> results = [];
    value.names.forEach((key, value) {
      if (!results.contains(key)) {
        results.add(key);
      }
    });
    value.aliases.forEach((key, value) {
      if (!results.contains(key)) {
        results.add(key);
      }
    });
    value.categories.forEach((key, value) {
      if (!results.contains(key)) {
        results.add(key);
      }
    });
    return results;
  }

  void initRecommentSearch() {
    IndexAll? index = Get.find<MainController>().index.value;
    if (index != null) {
      List<String> characters = _getListStringIndex(index.character);
      List<String> weapons = _getListStringIndex(index.weapon);
      List<String> resources = _getListStringIndex(index.resource);
      List<String> artifacts = _getListStringIndex(index.artifact);
      List<String> foods = _getListStringIndex(index.food);
      List<String> enemies = _getListStringIndex(index.enemy);
      List<String> animals = _getListStringIndex(index.animal);

      List<String> newList = [
        ...characters,
        ...weapons,
        ...resources,
        ...artifacts,
        ...foods,
        ...enemies,
        ...animals,
      ];
      newList = newList.toSet().toList();
      recomments.value = newList;
    }
  }

  @override
  void onInit() {
    initRecommentSearch();
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
