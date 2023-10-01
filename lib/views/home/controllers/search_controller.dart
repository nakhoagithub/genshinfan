import 'package:flutter/foundation.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/models/game/character.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:get/get.dart';

class SearchAppController extends GetxController {
  List<Character> searchCharacter(String query) {
    List<Character> characters = Get.find<MainController>().characters;
    List<Character> results = [];
    results = characters.where((element) {
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
    List<Weapon> weapons = Get.find<MainController>().weapons;
    List<Weapon> results = [];
    results = weapons.where((element) {
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
    List<Artifact> artifacts = Get.find<MainController>().artifacts;
    List<Artifact> results = [];
    results = artifacts.where((element) {
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
}
