import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshinfan/objects/geography.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:path_provider/path_provider.dart';

class GeographyService {
  Future<List<Geography>?> getGeographies(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file =
          File("${directory.path}/$language/${Config.fileNameGeography}.json");
      String json = await file.readAsString();
      List<Geography> geographies = List<Geography>.from(
          jsonDecode(json).map((e) => Geography.fromJson(e))).toList();
      return geographies;
    }
    return null;
  }

  Future<void> getGeographyFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      List<dynamic> geographies = [];
      dynamic data = json['data'];
      dynamic image = json['image'];

      dynamic jsonData = data[language]['geographies'];
      dynamic img = image['geographies'];
      for (var k in jsonData.keys) {
        Geography obj = Geography.fromJson(jsonData[k]);
        // hình ảnh
        obj.key = k;
        obj.setImage(img[k]);
        geographies.add(obj.toJson());
      }
      File file =
          File("${directory.path}/$language/${Config.fileNameGeography}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(geographies).toString());
    } catch (e) {
      log("$e", name: "getGeographyFromGzip");
    }
  }
}
