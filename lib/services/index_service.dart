import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshinfan/models/game/index_all.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:path_provider/path_provider.dart';

class IndexService {
  Future<void> getIndexFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      dynamic index = json['index'][language];
      IndexAll indexAll = IndexAll.fromJson(index);
      File file =
          File("${directory.path}/$language/${Config.fileNameIndex}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(indexAll.toJson()).toString());
    } catch (e) {
      log("$e", name: "getIndexFromGzip");
    }
  }

  Future<IndexAll?> getIndexAll(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    try {
      if (directory != null) {
        File file =
            File("${directory.path}/$language/${Config.fileNameIndex}.json");
        String json = await file.readAsString();
        Map<String, dynamic> dataDecode =
            jsonDecode(json) as Map<String, dynamic>;
        IndexAll indexAll = IndexAll.fromJson(dataDecode);
        return indexAll;
      }
    } catch (e) {
      log("$e", name: "getIndexAll");
    }

    return null;
  }
}
