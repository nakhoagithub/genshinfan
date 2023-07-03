import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshinfan/app_controller.dart';
import 'package:genshinfan/models/game/artifact.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ArtifactService {
  Future<List<Artifact>?> getArtifacts(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file =
          File("${directory.path}/$language/${Config.fileNameArtifact}.json");
      String json = await file.readAsString();
      List<Artifact> artifacts =
          List<Artifact>.from(jsonDecode(json).map((e) => Artifact.fromJson(e)))
              .toList();
      return artifacts;
    }
    return null;
  }

  Future<void> getArtifactFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      List<dynamic> artifacts = [];
      dynamic data = json['data'];
      dynamic image = json['image'];

      dynamic jsonData = data[language]['artifacts'];
      dynamic img = image['artifacts'];
      for (var k in jsonData.keys) {
        Artifact obj = Artifact.fromJson(jsonData[k]);
        obj.key = k;
        // hình ảnh
        obj.setImage(img[k]);
        artifacts.add(obj.toJson());
      }
      File file =
          File("${directory.path}/$language/${Config.fileNameArtifact}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(artifacts).toString());
    } catch (e) {
      log("$e", name: "getArtifactFromGzip");
    }
  }

  Artifact? getArtifactFromKey(String? key) {
    if (key == null) {
      return null;
    }
    List<Artifact> artifacts = Get.find<AppController>().artifacts;
    return artifacts.firstWhereOrNull((element) {
      return element.key == key;
    });
  }
}
