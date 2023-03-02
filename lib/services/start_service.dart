import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:genshinfan/controllers/start_controller.dart';
import 'package:genshinfan/objects/app/package_app.dart';
import 'package:genshinfan/services/artifact_service.dart';
import 'package:genshinfan/services/domain_service.dart';
import 'package:genshinfan/services/enemy_service.dart';
import 'package:genshinfan/services/weapon_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../resources/utils/config.dart';
import '../resources/utils/enum.dart';
import 'character_service.dart';
import 'resource_service.dart';

class StartService {
  StartController startController;
  StartService({required this.startController});

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

  // void _saveFile({
  //   required List<int> bytes,
  //   required int totalLength,
  // }) async {
  //   Directory? directory = await getExternalStorageDirectory();
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   if (directory != null) {
  //     // tạo và lưu file
  //     File file = File("${directory.path}/data.gzip");
  //     // viết xong đổi thành hash lưu vô bộ nhớ cache
  //     final hash = sha512.convert(await file.readAsBytes());
  //     // lưu dataContentLength để kiểm data mới
  //     sharedPreferences.setInt("dataContentLength", totalLength);
  //     sharedPreferences.setString("contentSHA512", hash.toString());
  //   }
  // }

  // void _stream({
  //   required int total,
  //   required int recieved,
  //   required DataAppStatus dataAppStatus,
  //   String? log,
  // }) {
  //   streamStart?.sink.add(DataApp(
  //     total: total,
  //     received: recieved,
  //     dataAppStatus: dataAppStatus,
  //     log: log,
  //   ));
  // }

  Future<bool> _download() async {
    try {
      Directory? directory = await getExternalStorageDirectory();
      if (directory != null) {
        Dio dio = Dio();
        await dio.download(
          Config.urlData,
          "${directory.path}/data.gzip",
          onReceiveProgress: (count, total) async {
            startController.setProgress(
                total, count, DataAppStatus.downloading);
            if (count == total) {
              File file = File("${directory.path}/data.gzip");
              // viết xong đổi thành hash lưu vô bộ nhớ cache
              final hash = sha512.convert(await file.readAsBytes());
              // lưu dataContentLength để kiểm data mới
              GetStorage box = GetStorage();
              await box.write(Config.storageDataContentLength, total);
              await box.write(Config.storageContentSHA512, hash.toString());
              startController.setProgress(
                  total, total, DataAppStatus.downloaded);
            }
          },
        );
        return true;
      }
    } catch (error) {
      log("$error", name: "Lỗi download");
      if (error is HttpException) {
        startController.setProgress(1, 0, DataAppStatus.notInternet);
      }
    }
    return false;
  }

  /// Kiểm tra dữ liệu cũ và tải dữ liệu
  Future<bool> downloadData() async {
    Directory? directory = await getExternalStorageDirectory();
    // Directory? pathFile = await getExternalStorageDirectory();
    if (directory != null) {
      // file data
      File file = File("${directory.path}/data.gzip");
      // file.create(recursive: true);
      // kiểm tra data
      GetStorage box = GetStorage();
      String? contentSHA512 = box.read(Config.storageContentSHA512);
      // file data tồn tại
      if (await file.exists()) {
        // mã hash của dữ liệu
        String hash = sha512.convert(await file.readAsBytes()).toString();
        // dữ liệu hoàn chỉnh không lỗi
        if (contentSHA512 == hash) {
          startController.setProgress(1, 1, DataAppStatus.downloaded);
          return true;
        } else {
          // dữ liệu lỗi -> tải lại
          return await _download();
        }
      } else {
        // file không tồn tại -> tải lại
        return await _download();
      }
    }
    return false;
  }

  Future<bool> checkInitData(String language) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      File data = File("${directory.path}/data.gzip");
      File fCharacter = File("${directory.path}/$language/characters.json");
      File fResource = File("${directory.path}/$language/materials.json");
      File fWeapon = File("${directory.path}/$language/weapons.json");
      File fArtifact = File("${directory.path}/$language/artifacts.json");
      File fDomain = File("${directory.path}/$language/domains.json");
      File fEnemy = File("${directory.path}/$language/enemies.json");
      if (await data.exists() &&
          await fCharacter.exists() &&
          await fResource.exists() &&
          await fWeapon.exists() &&
          await fArtifact.exists() &&
          await fDomain.exists() &&
          await fEnemy.exists()) {
        return true;
      }
    }
    return false;
  }

  Future<void> _extractStream(
      Directory directory, String language, dynamic json) async {
    CharacterService characterService = CharacterService();
    ResourceService resourceService = ResourceService();
    WeaponService weaponService = WeaponService();
    ArtifactService artifactService = ArtifactService();
    DomainService domainService = DomainService();
    EnemyService enemyService = EnemyService();
    await characterService.getCharacterFromGzip(directory, language, json);
    await resourceService.getResourceFromGzip(directory, language, json);
    await weaponService.getWeaponFromGzip(directory, language, json);
    await artifactService.getArtifactFromGzip(directory, language, json);
    await domainService.getDomainFromGzip(directory, language, json);
    await enemyService.getEnemyFromGzip(directory, language, json);

    startController.setProgress(1, 1, DataAppStatus.success);
  }

  Future<bool> extractDataLocal(String language) async {
    Directory? directory = await getExternalStorageDirectory();

    if (directory != null) {
      try {
        File file = File("${directory.path}/data.gzip");
        // chuyển bytes thành gzip
        final gzipBytes = GZipDecoder().decodeBytes(await file.readAsBytes());

        // chuyển gzip thành utf-8
        String data = utf8.decode(gzipBytes);
        dynamic json = jsonDecode(data);
        await _extractStream(directory, language, json);
        return true;
      } catch (e) {
        log("$e", name: "extractDataLocal");
        return false;
      }
    }
    return false;
  }
}
