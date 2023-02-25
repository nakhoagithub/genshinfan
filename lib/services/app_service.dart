import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:genshinfan/models/traffic.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AppService {
  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> openApplication() async {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    try {
      await db.set({
        "analytics": {
          "totalTraffic": ServerValue.increment(1),
          "trafficInDay": ServerValue.increment(1),
          "trafficInMonth": ServerValue.increment(1),
        }
      }).then((value) {
        return true;
      });
    } catch (e) {
      log("$e", name: "openApplication");
    }

    return false;
  }

  Future<Traffic> getTraffic() async {
    DatabaseReference db = FirebaseDatabase.instance.ref();
    Traffic traffic =
        Traffic(totalTraffic: 0, trafficInDay: 0, trafficInMonth: 0);
    await db.child("analytics").get().then((value) {
      DataSnapshot dataSnapshot = value;
      traffic = Traffic.fromJson(dataSnapshot.value as Map<dynamic, dynamic>);
    });
    return traffic;
  }

  /// trả về `true` nếu có dữ liệu mới.
  Future<bool> checkUpdateData() async {
    try {
      var response = await http.get(Uri.parse(Config.apiData));
      var json = jsonDecode(response.body);
      int? size = json['size'];

      GetStorage box = GetStorage();
      int length = box.read(Config.storageDataContentLength) ?? 0;
      print("$size $length");
      if (size == length) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      log("$e", name: "checkUpdateData");
    }
    return false;
  }
}
