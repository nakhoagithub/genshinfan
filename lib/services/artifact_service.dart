import 'dart:convert';
import 'dart:io';

import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/objects/artifact.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ArtifactService {
  Future<List<Artifact>?> getArtifacts(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file = File("${directory.path}/$language/artifacts.json");
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
    List<dynamic> artifacts = [];
    dynamic data = json['data'];
    dynamic image = json['image'];

    dynamic jsonData = data[language]['artifacts'];
    dynamic img = image['artifacts'];
    for (var k in jsonData.keys) {
      Artifact obj = Artifact.fromJson(jsonData[k]);
      obj.id = k;
      // hình ảnh
      obj.setImage(img[k]);
      artifacts.add(obj.toJson());
    }
    File fileCharacter = File("${directory.path}/$language/artifacts.json");
    await fileCharacter.create(recursive: true);
    await fileCharacter.writeAsString(jsonEncode(artifacts).toString());
  }

  Artifact? getArtifactFromId(String? id) {
    if (id == null) {
      return null;
    }
    List<Artifact> artifacts = Get.find<AppController>().artifacts;
    return artifacts.firstWhereOrNull((element) {
      return element.id == id;
    });
  }
}
