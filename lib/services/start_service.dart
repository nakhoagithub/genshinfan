import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:genshinfan/controllers/start_controller.dart';
import 'package:genshinfan/objects/app/api_github.dart';
import 'package:genshinfan/objects/app/package_app.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/resources/utils/enum.dart';
import 'package:genshinfan/services/achievement_service.dart';
import 'package:genshinfan/services/animal_service.dart';
import 'package:genshinfan/services/app_service.dart';
import 'package:genshinfan/services/artifact_service.dart';
import 'package:genshinfan/services/character_service.dart';
import 'package:genshinfan/services/craft_service.dart';
import 'package:genshinfan/services/domain_service.dart';
import 'package:genshinfan/services/enemy_service.dart';
import 'package:genshinfan/services/geography_service.dart';
import 'package:genshinfan/services/namecard_service.dart';
import 'package:genshinfan/services/outfit_service.dart';
import 'package:genshinfan/services/resource_service.dart';
import 'package:genshinfan/services/weapon_service.dart';
import 'package:genshinfan/services/windglider_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class StartService {
  const StartService();

  Future<PackageApp> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    return PackageApp(
      appName: appName,
      packageName: packageName,
      version: version,
      buildNumber: buildNumber,
    );
  }

  Future<bool> checkGzipData(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    try {
      File data = File("${directory!.path}/data.gzip");
      if (await data.exists()) {
        return true;
      }
    } catch (e) {
      log("$e", name: "StartService checkGzipData");
    }
    return false;
  }

  Future<bool> checkJsonData(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    try {
      File fCharacter =
          File("${directory!.path}/$language/${Config.fileNameCharacter}.json");
      File fResource =
          File("${directory.path}/$language/${Config.fileNameMaterial}.json");
      File fWeapon =
          File("${directory.path}/$language/${Config.fileNameWeapon}.json");
      File fArtifact =
          File("${directory.path}/$language/${Config.fileNameArtifact}.json");
      File fDomain =
          File("${directory.path}/$language/${Config.fileNameDomain}.json");
      File fEnemy =
          File("${directory.path}/$language/${Config.fileNameEnemie}.json");
      File fAchievementGroup = File(
          "${directory.path}/$language/${Config.fileNameAchievementGroup}.json");
      File fAchievement = File(
          "${directory.path}/$language/${Config.fileNameAchievement}.json");
      File fNamecard =
          File("${directory.path}/$language/${Config.fileNameNamecard}.json");
      File fAnimal =
          File("${directory.path}/$language/${Config.fileNameAnimal}.json");
      File fCraft =
          File("${directory.path}/$language/${Config.fileNameCraft}.json");
      File fOutfit =
          File("${directory.path}/$language/${Config.fileNameOutfit}.json");
      File fGeography =
          File("${directory.path}/$language/${Config.fileNameGeography}.json");
      File fWindglider =
          File("${directory.path}/$language/${Config.fileNameWindglider}.json");
      if (await fCharacter.exists() &&
          await fResource.exists() &&
          await fWeapon.exists() &&
          await fArtifact.exists() &&
          await fDomain.exists() &&
          await fEnemy.exists() &&
          await fAchievementGroup.exists() &&
          await fAchievement.exists() &&
          await fNamecard.exists() &&
          await fAnimal.exists() &&
          await fCraft.exists() &&
          await fOutfit.exists() &&
          await fGeography.exists() &&
          await fWindglider.exists()) {
        return true;
      }
    } catch (e) {
      log("$e", name: "StartService checkJsonData");
    }
    return false;
  }

  Future<bool> download() async {
    bool result = false;
    Directory? directory = await getExternalStorageDirectory();
    try {
      // nhận link download từ api
      ApiGithub? apiGithub = await AppService().getAPI();
      if (apiGithub != null) {
        // download
        Dio dio = Dio();
        await dio.download(
          apiGithub.downloadUrl,
          "${directory!.path}/data.gzip",
          onReceiveProgress: (count, total) async {
            Get.find<StartController>()
                .setProgress(total, count, DataAppStatus.downloading);
            if (count == total) {
              // viết xong đổi thành hash lưu vô bộ nhớ cache
              // lưu dataContentLength để kiểm data mới
              GetStorage box = GetStorage();
              await box.write(Config.storageContentSHA, apiGithub.sha);
              Get.find<StartController>()
                  .setProgress(total, total, DataAppStatus.downloaded);
              result = true;
            }
          },
        );
      }
    } catch (e) {
      log("$e", name: "StartService download");
      if (e is HttpException) {
        Get.find<StartController>()
            .setProgress(1, 0, DataAppStatus.notInternet);
      }
    }
    return result;
  }

  Future<bool> extractData(String language) async {
    Get.find<StartController>().setProgress(1, 1, DataAppStatus.extract);
    Directory? directory = await getExternalStorageDirectory();

    if (directory != null) {
      try {
        File file = File("${directory.path}/data.gzip");
        // chuyển bytes thành gzip
        final gzipBytes = GZipDecoder().decodeBytes(await file.readAsBytes());

        // chuyển gzip thành utf-8
        String data = utf8.decode(gzipBytes);
        dynamic json = jsonDecode(data);

        // giải nén dữ liệu
        await CharacterService()
            .getCharacterFromGzip(directory, language, json);
        await ResourceService().getResourceFromGzip(directory, language, json);
        await WeaponService().getWeaponFromGzip(directory, language, json);
        await ArtifactService().getArtifactFromGzip(directory, language, json);
        await DomainService().getDomainFromGzip(directory, language, json);
        await EnemyService().getEnemyFromGzip(directory, language, json);
        await AchievementService()
            .getAchievementGroupsFromGzip(directory, language, json);
        await AchievementService()
            .getAchievementsFromGzip(directory, language, json);
        await NamecardService().getNamecardFromGzip(directory, language, json);
        await AnimalService().getAnimalFromGzip(directory, language, json);
        await CraftService().getCraftFromGzip(directory, language, json);
        await OutfitService().getOutfitFromGzip(directory, language, json);
        await GeographyService()
            .getGeographyFromGzip(directory, language, json);
        await WindgliderService()
            .getWindgliderFromGzip(directory, language, json);
        return true;
      } catch (e) {
        log("$e", name: "StartService extractData");
        return false;
      }
    }
    return false;
  }
}
