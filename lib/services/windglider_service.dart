import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshinfan/models/windglider.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:path_provider/path_provider.dart';

class WindgliderService {
  Future<List<Windglider>?> getWindgliders(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file =
          File("${directory.path}/$language/${Config.fileNameWindglider}.json");
      String json = await file.readAsString();
      List<Windglider> windgliders = List<Windglider>.from(
          jsonDecode(json).map((e) => Windglider.fromJson(e))).toList();
      return windgliders;
    }
    return null;
  }

  Future<void> getWindgliderFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      List<dynamic> windgliders = [];
      dynamic data = json['data'];
      dynamic image = json['image'];

      dynamic jsonData = data[language]['windgliders'];
      dynamic img = image['windgliders'];
      for (var k in jsonData.keys) {
        Windglider obj = Windglider.fromJson(jsonData[k]);
        // hình ảnh
        obj.key = k;
        obj.setImage(img[k]);
        windgliders.add(obj.toJson());
      }
      File file =
          File("${directory.path}/$language/${Config.fileNameWindglider}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(windgliders).toString());
    } catch (e) {
      log("$e", name: "getWindgliderFromGzip");
    }
  }
}
