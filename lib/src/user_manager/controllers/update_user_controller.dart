import 'package:fluttertoast/fluttertoast.dart';
import 'package:genshinfan/models/app/role_app.dart';
import 'package:genshinfan/models/app/user.dart';
import 'package:genshinfan/services/user_service.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/src/user_manager/controllers/user_controller.dart';
import 'package:genshinfan/src/widgets/dialog.dart';
import 'package:get/get.dart';

class UpdateUserController extends GetxController {
  Rx<UserApp?> user = Get.find<UserController>().user;
  RxList<RoleApp> roles = <RoleApp>[].obs;

  Future<void> updateUser() async {
    List<int> rolesInt = roles.map((e) => e.role).toList();
    rolesInt.sort();

    dialogProgress("processing".tr, handle: () async {
      bool result =
          await UserService().changeRoleUser(user.value!.uid, rolesInt);
      if (result) {
        Fluttertoast.showToast(msg: "success".tr);
        await Get.find<UserController>().reload();
      } else {
        Fluttertoast.showToast(msg: "ERROR");
      }
    });
  }

  _init() {
    if (user.value != null) {
      List<RoleApp> roles = user.value!.roles
          .map(
            (e) => Config.menuRole.firstWhere((element) => element.role == e),
          )
          .toList();

      this.roles.value = roles;
    }
  }

  @override
  void onInit() {
    _init();
    super.onInit();
  }
}
