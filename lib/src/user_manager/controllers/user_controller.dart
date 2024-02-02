import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/models/app/user.dart';
import 'package:genshinfan/services/user_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  RxInt status = 0.obs;
  RxList<UserApp> users = <UserApp>[].obs;
  Rx<UserApp?> user = Rx(null);

  void selectUser(UserApp value) {
    user.value = value;
  }

  Future<void> changePermission(String uid, List<int> roles) async {
    bool result = await UserService().changeRoleUser(uid, roles);
    if (result) {
      Fluttertoast.showToast(msg: "complete".tr);
    } else {
      Fluttertoast.showToast(msg: "permission_denied".tr);
    }
  }

  Future<void> reload() async {
    users.value = await UserService().getUserAppForManager();
  }

  @override
  void onInit() async {
    status.value = 1;
    users.value = await UserService().getUserAppForManager();
    status.value = 2;
    super.onInit();
  }
}
