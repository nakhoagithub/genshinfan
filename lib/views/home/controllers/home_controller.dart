import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:genshinfan/main_controller.dart';
import 'package:genshinfan/models/app/traffic.dart';
import 'package:genshinfan/models/game/domain.dart';
import 'package:genshinfan/services/domain_service.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/services/app_service.dart';
import 'package:genshinfan/views/widgets/dialog.dart';
import 'package:genshinfan/views/widgets/slide_layout.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  RxBool loading = false.obs;

  StreamController<ScreenPosition> homeStream = StreamController();
  RxBool haveNewVesion = false.obs;
  Rx<Traffic?> traffic = Rx(null);
  RxInt today = 0.obs;
  RxString todaySelected = "".obs;
  RxInt day = 0.obs;
  RxInt month = 0.obs;
  RxBool hasBirthday = false.obs;
  RxList<Domain> domainToday = <Domain>[].obs;

  List<String> todays = [
    "day1".tr,
    "day2".tr,
    "day3".tr,
    "day4".tr,
    "day5".tr,
    "day6".tr,
    "day7".tr,
  ];

  void openGenshinMap() async {
    dialogConfirm(
      "genshin_map".tr,
      "notification_open_genshin_map".tr,
      () async {
        if (await canLaunchUrl(Uri.parse(Config.urlGenshinMap))) {
          await launchUrl(Uri.parse(Config.urlGenshinMap),
              mode: LaunchMode.externalApplication);
        } else {
          log("Không thể mở liên kết ${Config.urlGenshinMap}",
              name: "Open URL");
        }
      },
    );
  }

  Future<void> getTraffic() async {
    traffic.value = await AppService().getTraffic();
  }

  // Future<void> onConnect() async {
  //   await FirebaseDatabase.instance
  //       .ref('analytics')
  //       .update({'online': ServerValue.increment(1)});
  // }

  // Future<void> onDisconnect() async {
  //   await FirebaseDatabase.instance
  //       .ref('analytics')
  //       .onDisconnect()
  //       .update({'online': ServerValue.increment(-1)});
  // }

  Future<void> checkUpdateApp() async {
    await InAppUpdate.checkForUpdate();
    AppUpdateResult appUpdateResult = await InAppUpdate.startFlexibleUpdate();
    if (appUpdateResult == AppUpdateResult.success) {
      await InAppUpdate.completeFlexibleUpdate();
    }
  }

  void getDomainToday() {
    domainToday.clear();
    domainToday.value =
        DomainService().getDomainToday(todaySelected.value) ?? [];
  }

  @override
  void onInit() async {
    super.onInit();
    loading.value = true;
    MainController mainController = Get.find<MainController>();
    mainController.user.value = FirebaseAuth.instance.currentUser;
    unawaited(AppService().checkAndInitUser());

    DateTime dateTime = DateTime.now();
    today.value = dateTime.weekday;
    todaySelected.value = "day${today.value}".tr;
    day.value = dateTime.day;
    month.value = dateTime.month;

    getDomainToday();
    unawaited(getTraffic());
    unawaited(checkUpdateApp());
    loading.value = false;
  }

  @override
  void onReady() async {
    List<Object?> results = await AppService().checkUpdateData();
    if (results[0] == true) {
      haveNewVesion.value = true;
    }
    super.onReady();
  }

  @override
  void dispose() {
    homeStream.close();
    super.dispose();
  }
}
