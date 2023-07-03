import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshinfan/models/game/enemy.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:path_provider/path_provider.dart';

class EnemyService {
  Future<List<Enemy>?> getEnemies(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file =
          File("${directory.path}/$language/${Config.fileNameEnemie}.json");
      String json = await file.readAsString();
      List<Enemy> enemies =
          List<Enemy>.from(jsonDecode(json).map((e) => Enemy.fromJson(e)))
              .toList();
      return enemies;
    }
    return null;
  }

  Future<void> getEnemyFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      List<dynamic> enemies = [];
      dynamic data = json['data'];
      dynamic image = json['image'];
      dynamic stat = json['stats'];
      dynamic curve = json['curve'];

      dynamic jsonData = data[language]['enemies'];
      dynamic img = image['enemies'];
      dynamic statEnemy = stat['enemies'];
      dynamic curveEnemy = curve['enemies'];
      for (var k in jsonData.keys) {
        Enemy obj = Enemy.fromJson(jsonData[k]);
        // hình ảnh
        obj.setImage(img[k]);
        obj.setStat(statEnemy[k], curveEnemy);
        enemies.add(obj.toJson());
      }
      File file =
          File("${directory.path}/$language/${Config.fileNameEnemie}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(enemies).toString());
    } catch (e) {
      log("$e", name: "getEnemyFromGzip");
    }
  }
}
