import 'dart:convert';
import 'dart:io';

import 'package:genshinfan/objects/resource.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:path_provider/path_provider.dart';

class ResourceService {
  Future<List<Resource>?> getResources(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file =
          File("${directory.path}/$language/${Config.fileNameMaterial}.json");
      String json = await file.readAsString();
      List<Resource> resources =
          List<Resource>.from(jsonDecode(json).map((e) => Resource.fromJson(e)))
              .toList();
      return resources;
    }
    return null;
  }

  Future<void> getResourceFromGzip(
      Directory directory, String language, dynamic json) async {
    List<dynamic> resources = [];
    dynamic data = json['data'];
    dynamic image = json['image'];

    dynamic jsonData = data[language]['materials'];
    dynamic img = image['materials'];
    for (var k in jsonData.keys) {
      Resource obj = Resource.fromJson(jsonData[k]);
      // hình ảnh
      obj.key = k;
      obj.setImage(img[k]);
      resources.add(obj.toJson());
    }
    File file =
        File("${directory.path}/$language/${Config.fileNameMaterial}.json");
    await file.create(recursive: true);
    await file.writeAsString(jsonEncode(resources).toString());
  }
}
