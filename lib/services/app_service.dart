import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/app/api_github.dart';
import 'package:genshinfan/models/app/package_app.dart';
import 'package:genshinfan/models/app/traffic.dart';
import 'package:genshinfan/models/app/user.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class AppService {
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

  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      Get.find<MainController>().userApp.value = await checkAndInitUser();
      return userCredential;
    } catch (e) {
      log("$e", name: "login");
    }
    return null;
  }

  Future<void> logout() async {
    Get.find<MainController>().userApp.value = null;
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    try {
      await GoogleSignIn().disconnect();
    } catch (e) {
      log("$e", name: "logout");
    }
  }

  Future<UserApp?> checkAndInitUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null && await AppService.checkInternetConnection()) {
        DatabaseReference db = FirebaseDatabase.instance.ref("users");
        DataSnapshot dataSnapshot =
            await db.child(user.uid).get().then((value) {
          return value;
        });
        if (dataSnapshot.value == null) {
          UserApp userApp = UserApp(
            uid: user.uid,
            name: user.displayName,
            email: user.email,
            linkImage: user.photoURL,
            role: 10,
            roles: [10],
            active: true,
          );

          await db.child(user.uid).update(userApp.toJson());
          Get.find<MainController>().userApp.value = userApp;
          return userApp;
        } else {
          log("${dataSnapshot.value}", name: "UserApp - login");
          return UserApp.fromJson(dataSnapshot.value as Map<dynamic, dynamic>);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<bool> setTraffic() async {
    try {
      DatabaseReference db = FirebaseDatabase.instance.ref("analytics");
      await db.update({
        "totalTraffic": ServerValue.increment(1),
        "trafficInDay": ServerValue.increment(1),
        "trafficInMonth": ServerValue.increment(1),
      }).then((value) {
        return true;
      }).timeout(const Duration(seconds: Config.seccondTimeout));
    } catch (e) {
      if (e is TimeoutException) {
        Fluttertoast.showToast(msg: "timeout_exception".tr);
      }
      log("$e", name: "setTraffic");
    }

    return false;
  }

  Future<Traffic> getTraffic() async {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    Traffic traffic =
        Traffic(totalTraffic: 0, trafficInDay: 0, trafficInMonth: 0);
    try {
      await db.child("analytics").get().then((value) {
        DataSnapshot dataSnapshot = value;
        traffic = Traffic.fromJson(dataSnapshot.value as Map<dynamic, dynamic>);
      });
    } catch (e) {
      log("$e", name: "getTraffic");
    }

    return traffic;
  }

  /// cần kết nối mạng để ứng dụng kết nối đến firebase
  Future<bool> isDeleteDataFirstInstall() async {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    DataSnapshot data =
        await db.child('application').child("deleteDataFirstInstall").get();
    if (data.value != null && data.value is bool) {
      return data.value as bool;
    }
    return false;
  }

  Future<ApiGithub?> getAPI() async {
    Dio dio = Dio();
    try {
      DatabaseReference db = FirebaseDatabase.instance.ref();
      PackageApp packageApp = await getVersion();
      DataSnapshot? link = await db
          .child('application')
          .child("dataAPI")
          .child("buildNumber${packageApp.buildNumber}")
          .get();

      if (link.value != null && link.value is String) {
        log("${link.value}", name: "Link API");
        final res = await dio.get(link.value as String);
        return ApiGithub.fromJson(res.data);
      } else if (link.value == null) {
        DataSnapshot link = await db
            .child('application')
            .child("dataAPI")
            .child("buildNumber")
            .get();

        if (link.value != null && link.value is String) {
          final res = await dio.get(link.value as String);
          return ApiGithub.fromJson(res.data);
        }
      }
    } catch (e) {
      log("$e", name: "AppService getAPI");
    }
    return null;
  }

  /// trả về `true` nếu có dữ liệu mới.
  Future<List<Object?>> checkUpdateData() async {
    try {
      // get link from firebase remote
      ApiGithub? apiGithub = await getAPI();
      if (apiGithub != null) {
        GetStorage box = GetStorage();
        String sha = box.read(Config.storageContentSHA) ?? "";
        log("API sha: ${apiGithub.sha} - Storage sha: $sha",
            name: "checkUpdateData");
        if (sha != "" && apiGithub.sha == sha) {
          return [false, apiGithub];
        } else {
          return [true, apiGithub];
        }
      }
    } catch (e) {
      log("$e", name: "checkUpdateData");
    }
    return [false, null];
  }

  /// xóa file data.gzip
  ///
  /// xóa GetStorage
  Future<bool> deleteFileData() async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      try {
        File file = File("${directory.path}/data.gzip");
        await file.delete();
        GetStorage box = GetStorage();
        await box.remove(Config.storageContentSHA);
        return true;
      } catch (e) {
        log("$e", name: "deleteFileData");
        return false;
      }
    }
    return false;
  }
}
