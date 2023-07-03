import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshinfan/models/achievement.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:path_provider/path_provider.dart';

class AchievementService {
  Future<List<AchievementGroup>?> getAchiementGroups(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file = File(
          "${directory.path}/$language/${Config.fileNameAchievementGroup}.json");
      String json = await file.readAsString();
      List<dynamic> dataDecode = jsonDecode(json);
      List<AchievementGroup> achievementGroups = List<AchievementGroup>.from(
          dataDecode.map((e) => AchievementGroup.fromJson(e))).toList();
      return achievementGroups;
    }
    return null;
  }

  Future<void> getAchievementGroupsFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      List<dynamic> achievementGroups = [];
      dynamic data = json['data'];
      dynamic image = json['image'];

      dynamic jsonData = data[language]['achievementgroups'];
      dynamic img = image['achievementgroups'];
      for (var k in jsonData.keys) {
        AchievementGroup obj = AchievementGroup.fromJson(jsonData[k]);
        obj.key = k;
        // hình ảnh
        obj.setImage(img[k]);
        achievementGroups.add(obj.toJson());
      }
      File file = File(
          "${directory.path}/$language/${Config.fileNameAchievementGroup}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(achievementGroups).toString());
    } catch (e) {
      log("$e", name: "getAchievementGroupsFromGzip");
    }
  }

  /// -------------------------------------- ACHIEVEMENT --------------------------------------

  Future<List<Achievement>?> getAchiements(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File file = File(
          "${directory.path}/$language/${Config.fileNameAchievement}.json");
      String json = await file.readAsString();
      List<dynamic> dataDecode = jsonDecode(json);

      List<Achievement> achievements =
          List<Achievement>.from(dataDecode.map((e) => Achievement.fromJson(e)))
              .toList();
      return achievements;
    }
    return null;
  }

  Future<void> getAchievementsFromGzip(
      Directory directory, String language, dynamic json) async {
    try {
      List<dynamic> achievements = [];
      dynamic data = json['data'];
      dynamic jsonData = data[language]['achievements'];
      for (var k in jsonData.keys) {
        Achievement obj = Achievement.fromJson(jsonData[k]);
        obj.key = k;
        // hình ảnh
        achievements.add(obj.toJson());
      }
      File file = File(
          "${directory.path}/$language/${Config.fileNameAchievement}.json");
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(achievements).toString());
    } catch (e) {
      log("$e", name: "getAchievementsFromGzip");
    }
  }
}
