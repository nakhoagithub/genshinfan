import 'dart:convert';
import 'dart:io';

import 'package:genshinfan/objects/enemy.dart';
import 'package:path_provider/path_provider.dart';

class EnemyService {

   Future<List<Enemy>?> getEnemies(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file = File("${directory.path}/$language/enemies.json");
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
    File fileEnemy = File("${directory.path}/$language/enemies.json");
    await fileEnemy.create(recursive: true);
    await fileEnemy.writeAsString(jsonEncode(enemies).toString());
  }
}
