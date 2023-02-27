import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/models/package_app.dart';
import 'package:genshinfan/models/traffic.dart';
import 'package:genshinfan/resources/utils/localization.dart';
import 'package:genshinfan/services/app_service.dart';
import 'package:genshinfan/services/start_service.dart';
import 'package:get/get.dart';
import '../resources/utils/enum.dart';

class StartController extends GetxController {
  StartController get startController => this;

  late StartService startService;

  Rx<String> version = "".obs;
  Rx<int> total = 1.obs;
  Rx<int> received = 0.obs;
  Rx<String> log = ("loading".tr).obs;
  Rx<Color> colorLog = (Colors.orange).obs;
  Rx<DataAppStatus> dataAppStatus = DataAppStatus.init.obs;

  AppController appController = Get.find<AppController>();

  void _setLog(DataAppStatus dataAppStatus) {
    switch (dataAppStatus) {
      case DataAppStatus.init:
        log.value = "loading".tr;
        colorLog.value = Colors.green;
        break;
      case DataAppStatus.loading:
        log.value = "loading".tr;
        colorLog.value = Colors.green;
        break;
      case DataAppStatus.checkVersion:
        log.value = "loading".tr;
        colorLog.value = Colors.green;
        break;
      case DataAppStatus.downloading:
        log.value = "downloading".trParams({
          "percent": ((received.value / total.value) * 100).toStringAsFixed(2),
        });
        colorLog.value = Colors.green;
        break;
      case DataAppStatus.downloaded:
        log.value = "complete".tr;
        colorLog.value = Colors.green;
        break;
      case DataAppStatus.success:
        log.value = "complete".tr;
        colorLog.value = Colors.green;
        break;
      case DataAppStatus.failure:
        log.value = "ERROR";
        colorLog.value = Colors.red;
        break;
      case DataAppStatus.notInternet:
        log.value = "data_failure".tr;
        colorLog.value = Colors.red;
        break;
      case DataAppStatus.extract:
        log.value = "decompressing".tr;
        colorLog.value = Colors.orange;
        break;
    }
  }

  void setProgress(int total, int received, DataAppStatus dataAppStatus) {
    this.total.value = total;
    this.received.value = received;
    this.dataAppStatus.value = dataAppStatus;
    _setLog(dataAppStatus);
  }

  Future<void> _download() async {
    // tải dữ liệu
    bool resultDownload = await startService.downloadData();
    if (resultDownload) {
      setProgress(1, 1, DataAppStatus.extract);
      bool resultExtract =
          await startService.extractDataLocal(Localization.language);
      if (resultExtract) {
        // lấy dữ liệu
        bool resultGetData = await Get.find<AppController>().getData();
        if (resultGetData) {
          setProgress(1, 1, DataAppStatus.success);
          await Future.delayed(const Duration(milliseconds: 1500));
          Get.offAllNamed("/home");
        }
      } else {
        setProgress(1, 0, DataAppStatus.failure);
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // khởi tạo thành công
    startService = StartService(startController: startController);

    // version app
    PackageApp packageApp = await startService.getVersion();
    version.value = packageApp.version;

    // tạo thông lượng truy cập
    await AppService().setTraffic();

    bool hasData = await startService.checkInitData(Localization.language);
    if (hasData) {
      // có data
      // get data từ file json
      // xử lý progress
      setProgress(1, 1, DataAppStatus.loading);
      await Get.find<AppController>().getData();
      setProgress(1, 1, DataAppStatus.success);

      // đợi 2 giây rồi chuyển màn hình
      await Future.delayed(const Duration(milliseconds: 1500));
      Get.offAllNamed("/home");
    } else {
      //không có data
      bool conn = appController.hasInternet.value;
      if (conn) {
        await _download();
      } else {
        setProgress(1, 0, DataAppStatus.notInternet);
      }

      // stream download
      appController.hasInternet.listen((p0) async {
        if (p0) {
          // có internet
          await _download();
        } else {
          // không có internet
          setProgress(1, 0, DataAppStatus.notInternet);
        }
      });
    }
  }
}
