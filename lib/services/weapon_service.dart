import 'dart:convert';
import 'dart:io';

import 'package:genshinfan/objects/weapon.dart';
import 'package:path_provider/path_provider.dart';

class WeaponService {
  Future<void> getWeaponFromGzip(
      Directory directory, String language, dynamic json) async {
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
      // hình ảnh
      obj.setImage(img[k]);
      obj.setStat(statWeapon[k], curveWeapon);
      weapons.add(obj.toJson());
    }
    File fileWeapon = File("${directory.path}/$language/weapons.json");
    await fileWeapon.create(recursive: true);
    await fileWeapon.writeAsString(jsonEncode(weapons).toString());
  }

  Future<List<Weapon>?> getWeapons(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file = File("${directory.path}/$language/weapons.json");
      String json = await file.readAsString();
      List<Weapon> weapons = List<Weapon>.from(
          jsonDecode(json).map((e) => Weapon.fromJson(e))).toList();
      return weapons;
    }
    return null;
  }
}
