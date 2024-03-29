import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/game/craft.dart';
import 'package:genshinfan/models/game/resource.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class CraftService {
  Future<List<Craft>?> getCrafts(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    try {
      if (directory != null) {
        File file =
            File("${directory.path}/$language/${Config.fileNameCraft}.json");
        String json = await file.readAsString();
        List<Craft> crafts =
            List<Craft>.from(jsonDecode(json).map((e) => Craft.fromJson(e)))
                .toList();

        List<Resource> resources = Get.find<MainController>().resources;

        for (Craft craft in crafts) {
          Resource? resource =
              resources.firstWhereOrNull((element) => element.key == craft.key);
          if (resource != null) {
            craft.resource = resource;
          }
        }

        return crafts;
      }
    } catch (e) {
      log("$e", name: "getCrafts");
    }
    return null;
  }

  Future<void> getCraftFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      List<dynamic> crafts = [];
      dynamic data = json['data'];

      dynamic jsonData = data[language]['crafts'];
      for (var k in jsonData.keys) {
        Craft obj = Craft.fromJson(jsonData[k]);
        // hình ảnh
        obj.key = k;
        crafts.add(obj.toJson());
      }
      File file =
          File("${directory.path}/$language/${Config.fileNameCraft}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(crafts).toString());
    } catch (e) {
      log("$e", name: "getCraftFromGzip");
    }
  }
}
