import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/app/user.dart';
import 'package:genshinfan/models/app/character_building.dart';
import 'package:genshinfan/models/game/domain.dart';
import 'package:genshinfan/models/game/items.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../models/game/character.dart';

class CharacterService {
  Future<void> getCharacterFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
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
        try {
          Character obj = Character.fromJson(jsonData[k]);
          obj.key = k;
          // hình ảnh
          // obj.setImage(img[k]);
          // obj.setTalent(k, talent, imgTalent, statTalent);
          // obj.setConstellation(k, constellations, imgConstellation);
          // obj.setStat(statCharacter[k], curveCharacter);
          characters.add(obj.toJson());
        } catch (e) {
          // log("${jsonData[k]}", name: "Data");
          log("Error: $e $k", name: "getCharacterFromGzip");
        }
      }
      File file =
          File("${directory.path}/$language/${Config.fileNameCharacter}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(characters).toString());
    } catch (e) {
      log("$e", name: "getCharacterFromGzip");
    }
  }

  Future<List<Character>?> getCharacters(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    try {
      if (directory != null) {
        File file = File(
            "${directory.path}/$language/${Config.fileNameCharacter}.json");
        String json = await file.readAsString();
        List<dynamic> dataDecode = jsonDecode(json) as List<dynamic>;

        List<Character> characters =
            List<Character>.from(dataDecode.map((e) => Character.fromJson(e)))
                .toList();

        return characters;
      }
    } catch (e) {
      log("$e", name: "getCharacters");
    }

    return null;
  }

  List<Character>? getCharacterBirthdayInMonth() {
    DateTime dateTime = DateTime.now();
    MainController appController = Get.find<MainController>();
    List<Character> characters = appController.characters;
    List<Character> characterBirthday = characters.where((element) {
      if (element.birthdaymmdd != "") {
        String mm = element.birthdaymmdd
            .substring(0, element.birthdaymmdd.indexOf("/"));
        if (int.parse(mm) == dateTime.month) {
          return true;
        }
      }
      return false;
    }).toList();

    characterBirthday.sort(
      (a, b) {
        String aDay = a.birthdaymmdd.substring(a.birthdaymmdd.indexOf("/") + 1);
        String bDay = b.birthdaymmdd.substring(b.birthdaymmdd.indexOf("/") + 1);

        if (Tool.isInterger(aDay) && Tool.isInterger(bDay)) {
          return int.parse(aDay).compareTo(int.parse(bDay));
        }

        return aDay.compareTo(bDay);
      },
    );
    return characterBirthday;
  }

  List<Character>? getCharacterBirthdayToday() {
    DateTime dateTime = DateTime.now();
    MainController appController = Get.find<MainController>();
    List<Character> characters = appController.characters;
    List<Character> characterBirthday = characters.where((element) {
      if (element.birthdaymmdd != "") {
        String mm = element.birthdaymmdd
            .substring(0, element.birthdaymmdd.indexOf("/"));
        String dd = element.birthdaymmdd
            .substring(element.birthdaymmdd.indexOf("/") + 1);
        if (int.parse(mm) == dateTime.month && int.parse(dd) == dateTime.day) {
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

  List<Character>? getCharacterUpToday(List<Domain> domainsToday) {
    MainController appController = Get.find<MainController>();
    List<Character> characters = appController.characters;
    List<String> nameResourceToday = [];
    for (var domain in domainsToday) {
      if (domain.domainLvs != null) {
        for (var lv in domain.domainLvs!) {
          for (var rw in lv.rewardpreview) {
            Resource? resource = Tool.getResourceFromName(rw.name);
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
            List<Items>? cost = element.talent!.costs[key];
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

  Character? getCharacterFromId(String key) {
    List<Character> characters = Get.find<MainController>().characters;
    if (key == "main") {
      return characters
          .firstWhereOrNull((element) => element.association == "MAINACTOR");
    }

    return characters.firstWhereOrNull((element) {
      return element.key == key;
    });
  }

  /// Version 1.5
  Future<List<CharacterBuilding>> getCharacterBuilding(String key) async {
    DatabaseReference db = FirebaseDatabase.instance.ref("characters_building");

    List<CharacterBuilding> characters = [];
    try {
      await db.child(key).get().then((value) async {
        dynamic data = value.value;
        if (data != null) {
          for (var key in data.keys) {
            CharacterBuilding characterBuilding =
                CharacterBuilding.fromJson(data[key]);
            UserApp? u = await CharacterService()
                .getAuthorCharacterBuilding(characterBuilding.uidAuthor);
            characterBuilding.key = key;
            characterBuilding.userAuthor = u;
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

  /// Version 1.5
  Future<UserApp?> getAuthorCharacterBuilding(String uid) async {
    DatabaseReference db = FirebaseDatabase.instance.ref("users");

    UserApp? user;
    try {
      await db.child(uid).get().then((value) {
        dynamic data = value.value;
        if (data != null) {
          user = UserApp.fromJson(data);
        }
      }).timeout(const Duration(seconds: Config.seccondTimeout));
    } catch (e) {
      if (e is TimeoutException) {
        Fluttertoast.showToast(msg: "timeout_exception".tr);
      }
      log("$e", name: "getCharacterBuilding");
    }
    return user;
  }
}
