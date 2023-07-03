import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshinfan/app_controller.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/models/game/domain.dart';
import 'package:genshinfan/models/game/items.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/models/game/weapon.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/utils/tools.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class WeaponService {
  Future<void> getWeaponFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      List<dynamic> weapons = [];
      dynamic data = json['data'];
      dynamic image = json['image'];
      dynamic stat = json['stats'];
      dynamic curve = json['curve'];

      dynamic jsonData = data[language]['weapons'];
      dynamic img = image['weapons'];
      dynamic statWeapon = stat['weapons'];
      dynamic curveWeapon = curve['weapons'];
      for (var k in jsonData.keys) {
        Weapon obj = Weapon.fromJson(jsonData[k]);
        obj.key = k;
        // hình ảnh
        obj.setImage(img[k]);
        obj.setStat(statWeapon[k], curveWeapon);
        weapons.add(obj.toJson());
      }
      File file =
          File("${directory.path}/$language/${Config.fileNameWeapon}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(weapons).toString());
    } catch (e) {
      log("$e", name: "getWeaponFromGzip");
    }
  }

  Future<List<Weapon>?> getWeapons(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file =
          File("${directory.path}/$language/${Config.fileNameWeapon}.json");
      String json = await file.readAsString();

      List<dynamic> dataDecode = jsonDecode(json);
      List<Weapon> weapons =
          List<Weapon>.from(dataDecode.map((e) => Weapon.fromJson(e))).toList();
      return weapons;
    }
    return null;
  }

  List<Weapon>? getWeaponUpToday() {
    AppController appController = Get.find<AppController>();
    List<Weapon> weapons = appController.weapons;
    List<Domain> domains = Get.find<HomeController>().domainToday;
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
    List<Weapon> weaponUpToday = weapons.where((element) {
      if (element.costs != null) {
        List<Items> ascendAll = [];
        ascendAll.addAll(element.costs!.ascend1);
        ascendAll.addAll(element.costs!.ascend2);
        ascendAll.addAll(element.costs!.ascend3);
        ascendAll.addAll(element.costs!.ascend4);
        ascendAll.addAll(element.costs!.ascend5 ?? []);
        ascendAll.addAll(element.costs!.ascend6 ?? []);

        for (var ascend in ascendAll) {
          if (nameResourceToday.contains(ascend.name)) {
            return true;
          }
        }
      }
      return false;
    }).toList();
    weaponUpToday.sort(
      (a, b) {
        return b.rarity.compareTo(a.rarity);
      },
    );
    return weaponUpToday;
  }

  Weapon? getWeaponFromId(String key) {
    List<Weapon> weapons = Get.find<AppController>().weapons;
    return weapons.firstWhereOrNull((element) {
      return element.key == key;
    });
  }
}
