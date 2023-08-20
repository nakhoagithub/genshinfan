import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshinfan/models/game/outfit.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:path_provider/path_provider.dart';

class OutfitService {
  Future<List<Outfit>?> getOutfits(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    try {
      if (directory != null) {
        File file =
            File("${directory.path}/$language/${Config.fileNameOutfit}.json");
        String json = await file.readAsString();
        List<Outfit> outfits =
            List<Outfit>.from(jsonDecode(json).map((e) => Outfit.fromJson(e)))
                .toList();
        return outfits;
      }
    } catch (e) {
      log("$e", name: "getOutfits");
    }
    return null;
  }

  Future<void> getOutfitFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      List<dynamic> outfits = [];
      dynamic data = json['data'];
      dynamic image = json['image'];

      dynamic jsonData = data[language]['outfits'];
      dynamic img = image['outfits'];
      for (var k in jsonData.keys) {
        Outfit obj = Outfit.fromJson(jsonData[k]);
        // hình ảnh
        obj.key = k;
        obj.setImage(img[k]);
        outfits.add(obj.toJson());
      }
      File file =
          File("${directory.path}/$language/${Config.fileNameOutfit}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(outfits).toString());
    } catch (e) {
      log("$e", name: "getOutfitFromGzip");
    }
  }
}
