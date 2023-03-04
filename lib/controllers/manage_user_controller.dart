import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/objects/app/user.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:genshinfan/services/manage_service.dart';
import 'package:get/get.dart';

class ManageUserController extends GetxController {
  RxInt status = 0.obs;
  RxList<UserApp> users = <UserApp>[].obs;

  Future<void> changePermission(String uid, int role) async {
    bool result = await ManageService().changePermissionForUser(uid, role);
    if (result) {
      Fluttertoast.showToast(msg: "complete".tr);
    } else {
      Fluttertoast.showToast(msg: "permission_denied".tr);
    }
  }

  @override
  void onInit() async {
    status.value = 1;

    String roleCurrentUser = Get.find<AppController>().userApp.value?.uid ?? "";
    users.value = await ManageService().getUserAppForManager();
    users.removeWhere((element) {
      return element.uid == roleCurrentUser ||
          Config.roleAdminLV1.contains(element.role);
    });
    status.value = 2;
    super.onInit();
  }
}
