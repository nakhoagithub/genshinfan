import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/models/app/character_building.dart';
import 'package:genshinfan/models/app/character_building_old.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:get/get.dart';

class ContributeCharacterService {
  /// Version 1.5
  Future<bool> contribute(CharacterBuilding characterBuilding) async {
    DatabaseReference db =
        FirebaseDatabase.instance.ref("contributions_management");
    try {
      await db
          .push()
          .update(characterBuilding.toJson())
          .then((value) => value)
          .timeout(const Duration(seconds: Config.seccondTimeout));
      return true;
    } catch (e) {
      if (e is TimeoutException) {
        Fluttertoast.showToast(msg: "timeout_exception".tr);
      }
      log("$e", name: "contribute");
      return false;
    }
  }

  /// Version 1.5
  Future<List<CharacterBuilding>> getContributeCharacterForManager() async {
    DatabaseReference db =
        FirebaseDatabase.instance.ref("contributions_management");

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
      }).timeout(const Duration(seconds: Config.seccondTimeout));
    } catch (e) {
      if (e is TimeoutException) {
        Fluttertoast.showToast(msg: "timeout_exception".tr);
      }
      log("$e", name: "getContributeCharacterForManager");
    }
    return contributions;
  }

  /// version 1.5
  Future<bool> addContribute(CharacterBuilding characterBuilding) async {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    try {
      await db.update({
        "characters_build/${characterBuilding.characterName}/${db.push().key}":
            characterBuilding.toJson(),
        "contributions_management/${characterBuilding.key}": null,
      }).timeout(const Duration(seconds: Config.seccondTimeout));
      return true;
    } catch (e) {
      if (e is TimeoutException) {
        Fluttertoast.showToast(msg: "timeout_exception".tr);
      }
      log("$e", name: "addContribute");
      return false;
    }
  }

  /// Version 1.5
  Future<bool> deleteContribute(CharacterBuilding characterBuilding) async {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    try {
      await db.update({
        "contributions_management/${characterBuilding.key}": null,
      }).timeout(const Duration(seconds: Config.seccondTimeout));
      return true;
    } catch (e) {
      if (e is TimeoutException) {
        Fluttertoast.showToast(msg: "timeout_exception".tr);
      }
      log("$e", name: "addContribute");
      return false;
    }
  }

  /// xóa bài đóng góp của người dùng từ màn hình xem đóng góp, chỉ dành cho admin
  Future<bool> deleteContributeForManager(
      CharacterBuildingOld characterBuilding) async {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    try {
      await db.update({
        "contributions/${characterBuilding.characterName}/${characterBuilding.key}":
            null
      }).timeout(const Duration(seconds: Config.seccondTimeout));
      return true;
    } catch (e) {
      if (e is TimeoutException) {
        Fluttertoast.showToast(msg: "timeout_exception".tr);
      }
      log("$e", name: "addContribute");
      return false;
    }
  }
}
