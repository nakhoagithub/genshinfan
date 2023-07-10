import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshinfan/models/game/food.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:path_provider/path_provider.dart';

class FoodService {
  Future<List<Food>?> getFoods(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file =
          File("${directory.path}/$language/${Config.fileNameFood}.json");
      String json = await file.readAsString();
      List<Food> foods =
          List<Food>.from(jsonDecode(json).map((e) => Food.fromJson(e)))
              .toList();
      return foods;
    }
    return null;
  }

  Future<void> getFoodFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      List<dynamic> foods = [];
      dynamic data = json['data'];
      dynamic image = json['image'];

      dynamic jsonData = data[language]['foods'];
      dynamic img = image['foods'];
      for (var k in jsonData.keys) {
        Food obj = Food.fromJson(jsonData[k]);
        // hình ảnh
        obj.key = k;

        obj.setImage(img[k]);
        foods.add(obj.toJson());
      }
      File file =
          File("${directory.path}/$language/${Config.fileNameFood}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(foods).toString());
    } catch (e) {
      log("$e", name: "getFoodFromGzip");
    }
  }
}
