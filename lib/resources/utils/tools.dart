import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/artifact_controller.dart';
import 'package:genshinfan/controllers/enemy_controller.dart';
import 'package:genshinfan/controllers/resource_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:genshinfan/objects/enemy.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/objects/weapon.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:get/get.dart';

class Tools {
  static String removeDiacritics(String str) {
    const vietnamese = 'aAeEoOuUiIdDyY';
    final vietnameseRegex = <RegExp>[
      RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
      RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
      RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
      RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
      RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
      RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
      RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
      RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
      RegExp(r'ì|í|ị|ỉ|ĩ'),
      RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
      RegExp(r'đ'),
      RegExp(r'Đ'),
      RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
      RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
    ];

    for (var i = 0; i < vietnamese.length; ++i) {
      str = str.replaceAll(vietnameseRegex[i], vietnamese[i]);
    }
    return str;
  }

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

  static String getRole(int role) {
    switch (role) {
      case 1:
        return 'admin';
      case 5:
        return 'censor';
      case 10:
        return 'member';
    }
    return 'member';
  }

  static bool getRoleMenuAdmin(int role) {
    return Config.roleAdmins.contains(role);
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
    result = result.replaceAll("<color=#", "<color color=#");
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

  static String handleRefinementWeapon(String? effect, WeaponRefine? r1,
      WeaponRefine? r2, WeaponRefine? r3, WeaponRefine? r4, WeaponRefine? r5) {
    String result = effect ?? "";
    RegExp rx = RegExp(r'<color=#.*?>{(.*?)}</color>');

    Iterable<Match> matches = rx.allMatches(effect ?? "");

    for (Match e in matches) {
      String valueRefinement = e[0]!;
      // int indexR =
      //     int.parse(valueRefinement.substring(1, valueRefinement.length - 1));
      int indexR = int.parse(e[1] ?? "0");
      result = result.replaceAll(valueRefinement,
          "<up>${r1!.values[indexR]}/${r2!.values[indexR]}/${r3!.values[indexR]}/${r4!.values[indexR]}/${r5!.values[indexR]}</up>");
    }
    return result;
  }

  static String handleDescriptionAchievement(
      String description, String valueReplace) {
    String result = description;
    RegExp rx = RegExp(r'{(.*?)}');
    Iterable<Match> matches = rx.allMatches(description);
    for (Match e in matches) {
      String valueParam = e[0]!;
      result = result.replaceAll(valueParam, valueReplace);
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

  static String getBackgroundSquare(String? rarity) {
    switch (rarity) {
      case "1":
        return "assets/images/bg1s_square.png";
      case "2":
        return "assets/images/bg2s_square.png";
      case "3":
        return "assets/images/bg3s_square.png";
      case "4":
        return "assets/images/bg4s_square.png";
      case "5":
        return "assets/images/bg5s_square.png";
    }
    return "assets/images/bg1s_square.png";
  }

  static String? getAssetWeaponType(String? weapon) {
    if (weapon == 'WEAPON_SWORD_ONE_HAND') {
      return "assets/images/weapon_sword.png";
    }
    if (weapon == 'WEAPON_BOW') {
      return "assets/images/weapon_bow.png";
    }
    if (weapon == 'WEAPON_CLAYMORE') {
      return "assets/images/weapon_claymore.png";
    }
    if (weapon == 'WEAPON_CATALYST') {
      return "assets/images/weapon_catalyst.png";
    }
    if (weapon == 'WEAPON_POLE') {
      return "assets/images/weapon_pole.png";
    }
    return null;
  }

  static String getAssetElementFromName(String? element) {
    if (element == "ELEMENT_ANEMO" || element == "anemo".tr) {
      return "assets/images/element_anemo.png";
    }
    if (element == "ELEMENT_GEO" || element == "geo".tr) {
      return "assets/images/element_geo.png";
    }
    if (element == "ELEMENT_ELECTRO" || element == "electro".tr) {
      return "assets/images/element_electro.png";
    }
    if (element == "ELEMENT_DENDRO" || element == "dendro".tr) {
      return "assets/images/element_dendro.png";
    }
    if (element == "ELEMENT_PYRO" || element == "pyro".tr) {
      return "assets/images/element_pyro.png";
    }
    if (element == "ELEMENT_HYDRO" || element == "hydro".tr) {
      return "assets/images/element_hydro.png";
    }
    if (element == "ELEMENT_CRYO" || element == "cryo".tr) {
      return "assets/images/element_cryo.png";
    }
    if (element == "ELEMENT_NONE" || element == "none".tr) {
      return "";
    }
    return "";
  }

  static Color getColorElementCharacter(String? element) {
    if (element == "ELEMENT_ANEMO") {
      return colorAnemo;
    }
    if (element == "ELEMENT_GEO") {
      return colorGeo;
    }
    if (element == "ELEMENT_ELECTRO") {
      return colorElectro;
    }
    if (element == "ELEMENT_DENDRO") {
      return colorDendro;
    }
    if (element == "ELEMENT_PYRO") {
      return colorPyro;
    }
    if (element == "ELEMENT_HYDRO") {
      return colorHydro;
    }
    if (element == "ELEMENT_CRYO") {
      return colorCryo;
    }
    if (element == "ELEMENT_NONE") {
      return const Color.fromARGB(255, 105, 48, 34);
    }
    return const Color.fromARGB(255, 105, 48, 34);
  }

  static String getRarityStar(String? rarity) {
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

  static String? linkImageArtifact(Artifact value) {
    if (value.flower == null) {
      return value.images?.circlet;
    }
    return value.images?.flower;
  }

  static Resource? getResourceFromName(String name) {
    ResourceController resourceController = Get.find<ResourceController>();
    Resource? resource = resourceController.resources
        .firstWhereOrNull((element) => element.name == name);
    return resource;
  }

  static Resource? getResourceFromKey(String key) {
    ResourceController resourceController = Get.find<ResourceController>();
    Resource? resource = resourceController.resources
        .firstWhereOrNull((element) => element.key == key);
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
