import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:genshinfan/objects/app/character_building.dart';
import 'package:get_storage/get_storage.dart';

class ContributeCharacterService {
  Future<bool> contribute(CharacterBuilding characterBuilding) async {
    DatabaseReference db =
        FirebaseDatabase.instance.ref("contribution_management");
    try {
      await db.push().update(characterBuilding.toJson()).then((value) => value);
      return true;
    } catch (e) {
      log("$e", name: "contribute");
      return false;
    }
  }

  Future<List<CharacterBuilding>> getContributeCharacterForManager() async {
    DatabaseReference db =
        FirebaseDatabase.instance.ref("contribution_management");

    List<CharacterBuilding> contributions = [];
    try {
      await db.get().then((value) {
        dynamic data = value.value;
        if (data != null) {
          for (var key in data.keys) {
            CharacterBuilding characterBuilding =
                CharacterBuilding.fromJson(data[key]);
            characterBuilding.key = key;
            contributions.add(characterBuilding);
          }
        }
      });
    } catch (e) {
      log("$e", name: "getContributeCharacterForManager");
    }
    return contributions;
  }

  Future<bool> addContribute(CharacterBuilding characterBuilding) async {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    try {
      await db.update({
        "contributions/${characterBuilding.characterName}/${db.push().key}":
            characterBuilding.toJson(),
        "contribution_management/${characterBuilding.key}": null,
      });
      return true;
    } catch (e) {
      log("$e", name: "addContribute");
      return false;
    }
  }
}
