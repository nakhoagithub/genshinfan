import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/controllers/home_controller.dart';
import 'package:genshinfan/objects/app/character_building.dart';
import 'package:genshinfan/objects/domain.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/objects/talent.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/tools.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../objects/character.dart';

class CharacterService {
  Future<void> getCharacterFromGzip(
      Directory directory, String language, dynamic json) async {
    List<dynamic> characters = [];
    dynamic data = json['data'];
    dynamic image = json['image'];
    dynamic stat = json['stats'];
    dynamic curve = json['curve'];

    dynamic jsonData = data[language]['characters'];
    dynamic img = image['characters'];
    dynamic talent = data[language]['talents'];
    dynamic imgTalent = image['talents'];
    dynamic statTalent = stat['talents'];
    dynamic constellations = data[language]['constellations'];
    dynamic imgConstellation = image['constellations'];
    dynamic statCharacter = stat['characters'];
    dynamic curveCharacter = curve['characters'];
    for (var k in jsonData.keys) {
      Character obj = Character.fromJson(jsonData[k]);
      obj.id = k;
      // hình ảnh
      obj.setImage(img[k]);
      obj.setTalent(k, talent, imgTalent, statTalent);
      obj.setConstellation(k, constellations, imgConstellation);
      obj.setStat(statCharacter[k], curveCharacter);
      characters.add(obj.toJson());
    }
    File fileCharacter = File("${directory.path}/$language/characters.json");
    await fileCharacter.create(recursive: true);
    await fileCharacter.writeAsString(jsonEncode(characters).toString());
  }

  Future<List<Character>?> getCharacters(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file = File("${directory.path}/$language/characters.json");
      String json = await file.readAsString();
      List<Character> characters = List<Character>.from(
          jsonDecode(json).map((e) => Character.fromJson(e))).toList();
      return characters;
    }
    return null;
  }

  List<Character>? getCharacterBirthdayInMonth() {
    AppController appController = Get.find<AppController>();
    List<Character> characters = appController.characters;
    List<Character> characterBirthday = characters.where((element) {
      if (element.birthdaymmdd != "") {
        String mm = element.birthdaymmdd
            .substring(0, element.birthdaymmdd.indexOf("/"));
        if (int.parse(mm) == Get.find<HomeController>().month.value) {
          return true;
        }
      }
      return false;
    }).toList();

    characterBirthday.sort(
      (a, b) {
        String aDay = a.birthdaymmdd.substring(a.birthdaymmdd.indexOf("/"));
        String bDay = b.birthdaymmdd.substring(b.birthdaymmdd.indexOf("/"));
        return aDay.compareTo(bDay);
      },
    );
    return characterBirthday;
  }

  List<Character>? getCharacterBirthdayToday() {
    AppController appController = Get.find<AppController>();
    List<Character> characters = appController.characters;
    List<Character> characterBirthday = characters.where((element) {
      if (element.birthdaymmdd != "") {
        String mm = element.birthdaymmdd
            .substring(0, element.birthdaymmdd.indexOf("/"));
        String dd = element.birthdaymmdd
            .substring(element.birthdaymmdd.indexOf("/") + 1);
        if (int.parse(mm) == Get.find<HomeController>().month.value &&
            int.parse(dd) == Get.find<HomeController>().day.value) {
          return true;
        }
      }
      return false;
    }).toList();

    characterBirthday.sort(
      (a, b) {
        String aDay = a.birthdaymmdd.substring(a.birthdaymmdd.indexOf("/"));
        String bDay = b.birthdaymmdd.substring(b.birthdaymmdd.indexOf("/"));
        return aDay.compareTo(bDay);
      },
    );
    return characterBirthday;
  }

  List<Character>? getCharacterUpToday() {
    AppController appController = Get.find<AppController>();
    HomeController homeController = Get.find<HomeController>();
    List<Character> characters = appController.characters;
    List<Domain> domains = homeController.domainToday;
    List<String> nameResourceToday = [];
    for (var domain in domains) {
      if (domain.domainLvs != null) {
        for (var lv in domain.domainLvs!) {
          for (var rw in lv.rewardpreview) {
            Resource? resource = Tools.getResourceFromName(rw.name);
            if (resource != null && resource.category == "AVATAR_MATERIAL") {
              nameResourceToday.add(rw.name);
            }
          }
        }
      }
    }

    List<Character> characterUpToday = characters.where((element) {
      if (element.association == "MAINACTOR") {
        // nhà lữ hành
      } else {
        if (element.talent != null) {
          for (var key in element.talent!.costs.keys) {
            List<Cost>? cost = element.talent!.costs[key];
            if (cost != null) {
              for (var e in cost) {
                if (nameResourceToday.contains(e.name)) {
                  return true;
                }
              }
            }
          }
        }
      }
      return false;
    }).toList();
    characterUpToday.sort(
      (a, b) {
        return b.rarity.compareTo(a.rarity);
      },
    );
    return characterUpToday;
  }

  Character? getCharacterFromId(String id) {
    List<Character> characters = Get.find<AppController>().characters;
    return characters.firstWhereOrNull((element) {
      return element.id == id;
    });
  }

  Future<List<CharacterBuilding>> getCharacterBuilding(String key) async {
    DatabaseReference db = FirebaseDatabase.instance.ref("contributions");

    List<CharacterBuilding> characters = [];
    try {
      await db.child(key).get().then((value) {
        dynamic data = value.value;
        if (data != null) {
          for (var key in data.keys) {
            CharacterBuilding characterBuilding =
                CharacterBuilding.fromJson(data[key]);
            characterBuilding.key = key;
            characters.add(characterBuilding);
          }
        }
      }).timeout(const Duration(seconds: Config.seccondTimeout));
    } catch (e) {
      if (e is TimeoutException) {
        Fluttertoast.showToast(msg: "timeout_exception".tr);
        return [];
      }
      log("$e", name: "getCharacterBuilding");
    }
    return characters;
  }
}
