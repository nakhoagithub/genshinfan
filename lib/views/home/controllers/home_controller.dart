import 'dart:async';
import 'dart:developer';

import 'package:genshinfan/models/app/traffic.dart';
import 'package:genshinfan/models/domain.dart';
import 'package:genshinfan/utils/config.dart';
import 'package:genshinfan/services/app_service.dart';
import 'package:genshinfan/views/widgets/slide_layout.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  StreamController<ScreenPosition> homeStream = StreamController();
  RxBool haveNewVesion = false.obs;
  Rx<Traffic?> traffic = Rx(null);
  RxInt today = 0.obs;
  RxInt day = 0.obs;
  RxInt month = 0.obs;
  RxBool hasBirthday = false.obs;
  RxList<Domain> domainToday = <Domain>[].obs;

  void pageLeft() {
    homeStream.sink.add(ScreenPosition.left);
  }

  void pageCenter() {
    homeStream.sink.add(ScreenPosition.center);
  }

  void pageRight() {
    homeStream.sink.add(ScreenPosition.right);
  }

  void openGenshinMap() async {
    if (await canLaunchUrl(Uri.parse(Config.urlGenshinMap))) {
      await launchUrl(Uri.parse(Config.urlGenshinMap),
          mode: LaunchMode.externalApplication);
    } else {
      log("Không thể mở liên kết ${Config.urlGenshinMap}", name: "Open URL");
    }
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

  @override
  void onInit() async {
    super.onInit();
    DateTime dateTime = DateTime.now();
    today.value = dateTime.weekday;
    day.value = dateTime.day;
    month.value = dateTime.month;

    unawaited(getTraffic());
    unawaited(checkUpdateApp());
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
