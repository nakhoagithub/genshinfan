import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshinfan/app_controller.dart';
import 'package:genshinfan/views/home/controllers/home_controller.dart';
import 'package:genshinfan/models/game/domain.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

List<String> levels = [
  'i',
  'ii',
  'iii',
  'iv',
  'v',
  'vi',
  'vii',
  'viii',
  'ix',
  'x'
];

class DomainService {
  Future<List<Domain>?> getDomains(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file =
          File("${directory.path}/$language/${Config.fileNameDomain}.json");
      String json = await file.readAsString();
      List<Domain> domains =
          List<Domain>.from(jsonDecode(json).map((e) => Domain.fromJson(e)))
              .toList();
      return domains;
    }
    return null;
  }

  List<String> _getKey(List<String> keys) {
    List<String> keyFormat = [];
    String name = "";
    for (int i = 0; i < keys.length; i++) {
      if (name == "") {
        name = keys[i].substring(0, keys[i].length - 1);
        keyFormat.add(name);
      }

      if (i < keys.length - 2 && keys[i + 1].contains(name)) {
        continue;
      } else {
        if (i < keys.length - 2) {
          name = keys[i + 1].substring(0, keys[i + 1].length - 1);
          keyFormat.add(name);
        }
      }
    }
    return keyFormat;
  }

  Future<void> getDomainFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      List<dynamic> domains = [];
      dynamic data = json['data'];
      dynamic image = json['image'];

      dynamic jsonData = data[language]['domains'];
      dynamic img = image['domains'];
      List<String> keys = _getKey(List.from(jsonData.keys));
      for (var k in keys) {
        dynamic dataObj = jsonData["${k}i"];
        Domain domain = Domain.fromJson(dataObj);
        domain.name = domain.name.substring(0, domain.name.length - 2);
        List<DomainLv> domainLvs = [];
        for (String lv in levels) {
          dynamic dataLevel = jsonData["$k$lv"];
          dynamic imgLevel = img["$k$lv"];
          if (dataLevel != null) {
            DomainLv domainLv = DomainLv.fromJson(dataLevel);
            domainLv.images = ImageDomain.fromJson(imgLevel);
            domainLvs.add(domainLv);
          }
        }
        domain.domainLvs = domainLvs;
        domains.add(domain.toJson());
      }
      File file =
          File("${directory.path}/$language/${Config.fileNameDomain}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(domains).toString());
    } catch (e) {
      log("$e", name: "getDomainFromGzip");
    }
  }

  List<Domain>? getDomainToday(String today) {
    AppController appController = Get.find<AppController>();
    List<Domain> domains = appController.domains;

    List<Domain> domainToday = domains.where((element) {
      List<String>? daysofweeks = element.daysofweek?.where((element) {
        return element == today;
      }).toList();
      return daysofweeks != null && daysofweeks.isNotEmpty;
    }).toList();
    Get.find<HomeController>().domainToday.value = domainToday;
    return domainToday;
  }
}
