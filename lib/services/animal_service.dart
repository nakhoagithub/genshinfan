import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshinfan/models/game/animal.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:path_provider/path_provider.dart';

class AnimalService {
  Future<List<Animal>?> getAnimals(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    try {
      if (directory != null) {
        File file =
            File("${directory.path}/$language/${Config.fileNameAnimal}.json");
        String json = await file.readAsString();
        List<Animal> animals =
            List<Animal>.from(jsonDecode(json).map((e) => Animal.fromJson(e)))
                .toList();
        return animals;
      }
    } catch (e) {
      log("$e", name: "getAnimals");
    }
    return null;
  }

  Future<void> getAnimalFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      List<dynamic> animals = [];
      dynamic data = json['data'];
      dynamic image = json['image'];

      dynamic jsonData = data[language]['animals'];
      dynamic img = image['animals'];
      for (var k in jsonData.keys) {
        Animal obj = Animal.fromJson(jsonData[k]);
        // hình ảnh
        obj.key = k;

        obj.setImage(img[k]);
        animals.add(obj.toJson());
      }
      File file =
          File("${directory.path}/$language/${Config.fileNameAnimal}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(animals).toString());
    } catch (e) {
      log("$e", name: "getAnimalFromGzip");
    }
  }
}
