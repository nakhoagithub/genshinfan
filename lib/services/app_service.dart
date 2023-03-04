import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/objects/app/traffic.dart';
import 'package:genshinfan/objects/app/user.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AppService {
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
      Get.find<AppController>().userApp.value = await checkAndInitUser();
      return userCredential;
    } catch (e) {
      log("$e", name: "login");
    }
    return null;
  }

  Future<void> logout() async {
    Get.find<AppController>().userApp.value = null;
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
              role: 10);
          await db.child(user.uid).update(userApp.toJson());
        } else {
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

  /// trả về `true` nếu có dữ liệu mới.
  Future<List<Object?>> checkUpdateData() async {
    try {
      var response = await http.get(Uri.parse(Config.apiData));
      dynamic json = jsonDecode(response.body);
      int? size = json['size'];

      GetStorage box = GetStorage();
      int length = box.read(Config.storageDataContentLength) ?? 0;
      log("$size $length", name: "Update");
      if (size == length) {
        return [false, json];
      } else {
        return [true, json];
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
        await box.remove(Config.storageContentSHA512);
        await box.remove(Config.storageDataContentLength);
        return true;
      } catch (e) {
        log("$e", name: "deleteFileData");
        return false;
      }
    }
    return false;
  }
}
