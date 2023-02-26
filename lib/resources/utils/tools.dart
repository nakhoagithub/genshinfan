import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/controllers/enemy_controller.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/enemy.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:get/get.dart';

class Tools {
  static String capitalize(String value) {
    return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }

  static String handlerSpecializedStat(String? specialized, double value) {
    if (specialized == "FIGHT_PROP_ELEMENT_MASTERY") {
      return value.toStringAsFixed(1);
    } else {
      return "${(value * 100).toStringAsFixed(1)}%";
    }
  }

  static Color colorDendro = const Color(0xffa6c938);
  static Color colorCryo = const Color(0xffa0d7e4);
  static Color colorAnemo = const Color(0xff75c3aa);
  static Color colorGeo = const Color(0xfffab72e);
  static Color colorElectro = const Color(0xffa872c5);
  static Color colorPyro = const Color(0xffef7a35);
  static Color colorHydro = const Color(0xff4bc3f1);

  static String handleTextElement(String text) {
    String result = text;
    // replace dấu *
    RegExp rx = RegExp(r'\*\*(.*?)\*\*');
    Iterable<Match> matches = rx.allMatches(text);
    for (Match e in matches) {
      String valueBold = e[0]!;
      String content = valueBold.substring(2, valueBold.length - 2);
      content = "<b>$content</b>";
      result = result.replaceAll(valueBold, content);
    }
    result = result.replaceAll("·", "✦ ");
    result = result.replaceAll("HP", "<hp><b>HP</b></hp>");
    result =
        result.replaceAll("e_cryo".tr, "<cryo><b>${"e_cryo".tr}</b></cryo>");
    result = result.replaceAll(
        "e_hydro".tr, "<hydro><b>${"e_hydro".tr}</b></hydro>");
    result =
        result.replaceAll("e_pyro".tr, "<pyro><b>${"e_pyro".tr}</b></pyro>");
    result = result.replaceAll(
        "e_electro".tr, "<electro><b>${"e_electro".tr}</b></electro>");
    result = result.replaceAll(
        "e_anemo".tr, "<anemo><b>${"e_anemo".tr}</b></anemo>");
    result = result.replaceAll("e_geo".tr, "<geo><b>${"e_geo".tr}</b></geo>");
    result = result.replaceAll(
        "e_dendro".tr, "<dendro><b>${"e_dendro".tr}</b></dendro>");

    return result;
  }

  static String handleTextRegion(String text) {
    String result = text;
    result = result.replaceAll("Mondstadt", "<anemo>Mondstadt</anemo>");
    result = result.replaceAll("Liyue", "<geo>Liyue</geo>");
    result = result.replaceAll("Inazuma", "<electro>Inazuma</electro>");
    result = result.replaceAll("Sumeru", "<dendro>Sumeru</dendro>");
    return result;
  }

  static String handleEffectWeapon(String effect, List<String> r1,
      List<String> r2, List<String> r3, List<String> r4, List<String> r5) {
    String result = effect;
    RegExp rx = RegExp(r'{(.*?)}');
    Iterable<Match> matches = rx.allMatches(effect);
    for (Match e in matches) {
      String valueRefinement = e[0]!;
      int indexR =
          int.parse(valueRefinement.substring(1, valueRefinement.length - 1));

      result = result.replaceAll(valueRefinement,
          "<up>${r1[indexR]}/${r2[indexR]}/${r3[indexR]}/${r4[indexR]}/${r5[indexR]}</up>");
    }
    return result;
  }

  static String getBackground(String? rarity) {
    switch (rarity) {
      case "1":
        return "assets/images/bg1s.png";
      case "2":
        return "assets/images/bg2s.png";
      case "3":
        return "assets/images/bg3s.png";
      case "4":
        return "assets/images/bg4s.png";
      case "5":
        return "assets/images/bg5s.png";
    }
    return "assets/images/bg1s.png";
  }

  static String? getAssetWeaponType(String? weapon) {
    if (weapon == "sword".tr) {
      return "assets/images/weapon_sword.png";
    }
    if (weapon == "bow".tr) {
      return "assets/images/weapon_bow.png";
    }
    if (weapon == "claymore".tr) {
      return "assets/images/weapon_claymore.png";
    }
    if (weapon == "catalyst".tr) {
      return "assets/images/weapon_catalyst.png";
    }
    if (weapon == "polearm".tr) {
      return "assets/images/weapon_pole.png";
    }
    return null;
  }

  static String? getKeyWeaponType(String? weapon) {
    if (weapon == "sword".tr) {
      return "sword";
    }
    if (weapon == "bow".tr) {
      return "bow";
    }
    if (weapon == "claymore".tr) {
      return "claymore";
    }
    if (weapon == "catalyst".tr) {
      return "catalyst";
    }
    if (weapon == "polearm".tr) {
      return "pole";
    }
    return null;
  }

  static String? getElementFromName(String? element) {
    if (element == "anemo".tr || element == "Anemo") {
      return "assets/images/element_anemo.png";
    }
    if (element == "geo".tr || element == "Geo") {
      return "assets/images/element_geo.png";
    }
    if (element == "electro".tr || element == "Electro") {
      return "assets/images/element_electro.png";
    }
    if (element == "dendro".tr || element == "Dendro") {
      return "assets/images/element_dendro.png";
    }
    if (element == "pyro".tr || element == "Pyro") {
      return "assets/images/element_pyro.png";
    }
    if (element == "hydro".tr || element == "Hydro") {
      return "assets/images/element_hydro.png";
    }
    if (element == "cryo".tr || element == "Cryo") {
      return "assets/images/element_cryo.png";
    }
    if (element == "none".tr || element == "None") {
      return null;
    }
    return null;
  }

  static Color getColorElementCharacter(String? element) {
    if (element == "anemo".tr || element == "Anemo") {
      return colorAnemo;
    }
    if (element == "geo".tr || element == "Geo") {
      return colorGeo;
    }
    if (element == "electro".tr || element == "Electro") {
      return colorElectro;
    }
    if (element == "dendro".tr || element == "Dendro") {
      return colorDendro;
    }
    if (element == "pyro".tr || element == "Pyro") {
      return colorPyro;
    }
    if (element == "hydro".tr || element == "Hydro") {
      return colorHydro;
    }
    if (element == "cryo".tr || element == "Cryo") {
      return colorCryo;
    }
    if (element == "none".tr || element == "None") {
      return const Color.fromARGB(255, 105, 48, 34);
    }
    return const Color.fromARGB(255, 105, 48, 34);
  }

  static String getRarityStar(String rarity) {
    switch (rarity) {
      case "1":
        return "assets/images/ic_1s.png";
      case "2":
        return "assets/images/ic_2s.png";
      case "3":
        return "assets/images/ic_3s.png";
      case "4":
        return "assets/images/ic_4s.png";
      case "5":
        return "assets/images/ic_5s.png";
    }
    return "assets/images/ic_1s.png";
  }

  static Resource? getResourceFromName(String name) {
    ResourceController resourceController = Get.find<ResourceController>();
    Resource? resource = resourceController.resources
        .firstWhereOrNull((element) => element.name == name);
    return resource;
  }

  static Artifact? getArtifactFromName(String name) {
    ArtifactController artifactController = Get.find<ArtifactController>();
    Artifact? artifact = artifactController.artifacts
        .firstWhereOrNull((element) => element.name == name);
    return artifact;
  }

  static Enemy? getEnemyFromName(String name) {
    EnemyController enemyController = Get.find<EnemyController>();
    Enemy? enemy = enemyController.enemies
        .firstWhereOrNull((element) => element.name == name);
    return enemy;
  }
}
