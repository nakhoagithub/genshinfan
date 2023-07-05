import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:genshinfan/models/app/user.dart';

class UserService {
  Future<List<UserApp>> getUserAppForManager() async {
    DatabaseReference db = FirebaseDatabase.instance.ref("users");
    List<UserApp> users = [];
    try {
      await db.get().then((value) {
        dynamic data = value.value;
        if (data != null) {
          for (var key in data.keys) {
            UserApp user = UserApp.fromJson(data[key]);
            users.add(user);
          }
        }
      });
    } catch (e) {
      log("$e", name: "getUserAppForManager");
    }
    return users;
  }

  Future<bool> changeRoleUser(String uid, List<int> roles) async {
    DatabaseReference db = FirebaseDatabase.instance.ref("users");
    try {
      await db.child(uid).update({
        "roles": roles,
      });
      return true;
    } catch (e) {
      log("$e", name: "changePermissionForUser");
      return false;
    }
  }
}
