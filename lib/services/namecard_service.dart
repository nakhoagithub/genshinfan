import 'dart:convert';
import 'dart:io';

import 'package:genshinfan/objects/namecard.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:path_provider/path_provider.dart';

class NamecardService {
  Future<List<Namecard>?> getNamecards(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file =
          File("${directory.path}/$language/${Config.fileNameNamecard}.json");
      String json = await file.readAsString();
      List<Namecard> namecards =
          List<Namecard>.from(jsonDecode(json).map((e) => Namecard.fromJson(e)))
              .toList();
      return namecards;
    }
    return null;
  }

  Future<void> getNamecardFromGzip(
      Directory directory, String language, dynamic json) async {
    List<dynamic> namecards = [];
    dynamic data = json['data'];
    dynamic image = json['image'];

    dynamic jsonData = data[language]['namecards'];
    dynamic img = image['namecards'];
    for (var k in jsonData.keys) {
      Namecard obj = Namecard.fromJson(jsonData[k]);
      // hình ảnh
      obj.key = k;

      obj.setImage(img[k]);
      namecards.add(obj.toJson());
    }
    File file =
        File("${directory.path}/$language/${Config.fileNameNamecard}.json");
    await file.create(recursive: true);
    await file.writeAsString(jsonEncode(namecards).toString());
  }
}
