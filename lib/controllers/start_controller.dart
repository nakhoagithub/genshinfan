import 'dart:async';
import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/objects/app/package_app.dart';
import 'package:genshinfan/resources/utils/localization.dart';
import 'package:genshinfan/services/app_service.dart';
import 'package:genshinfan/services/start_service.dart';
import 'package:get/get.dart';
import '../resources/utils/enum.dart';

class StartController extends GetxController {
  late StartService startService;

  Rx<String> version = "".obs;
  Rx<int> total = 1.obs;
  Rx<int> received = 0.obs;
  Rx<String> log = ("loading".tr).obs;
  Rx<Color> colorLog = (Colors.orange).obs;
  Rx<DataAppStatus> dataAppStatus = DataAppStatus.init.obs;

  Rx<int> redownload = 0.obs;

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
      case DataAppStatus.extractFailure:
        log.value = "extract_failure".tr;
        colorLog.value = Colors.red;
        break;
      case DataAppStatus.deleteFileDataAndRedownload:
        log.value = "delete_data_and_redownload".tr;
        colorLog.value = Colors.cyan;
        break;
      case DataAppStatus.waitForNewUpdate:
        log.value = "data_failure_wait_for_new_update".tr;
        colorLog.value = Colors.cyan;
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

  Future<void> _getDataToHome() async {
    await Get.find<AppController>().getData();
    setProgress(1, 1, DataAppStatus.success);
    // đợi chút xíu rồi chuyển màn hình
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.offAllNamed("/home");
  }

  Future<void> deleteFileDataAndRedownload() async {
    setProgress(1, 0, DataAppStatus.deleteFileDataAndRedownload);
    await AppService().deleteFileData();
    await _download();
  }

  Future<void> _download() async {
    setProgress(1, 0, DataAppStatus.loading);
    // kiểm tra dữ liệu có chưa
    bool hasGzip = await startService.checkGzipData(Localization.language);
    if (hasGzip) {
      // có gzip
      // kiểm tra json
      bool hasJson = await startService.checkJsonData(Localization.language);
      if (hasJson) {
        // có json
        await _getDataToHome();
      } else {
        // không có json
        // giải nén dữ liệu
        bool resultExtract =
            await startService.extractData(Localization.language);
        if (resultExtract) {
          await _getDataToHome();
        } else {
          setProgress(1, 0, DataAppStatus.extractFailure);
        }
      }
    } else {
      // không có gzip
      // kiểm tra kết nối
      bool connect = appController.hasInternet.value;
      if (connect) {
        // tải dữ liệu
        bool resultDownload = await startService.download();
        if (resultDownload) {
          // giải nén dữ liệu
          bool resultExtract =
              await startService.extractData(Localization.language);
          if (resultExtract) {
            await _getDataToHome();
          } else {
            setProgress(1, 0, DataAppStatus.extractFailure);
          }
        }
      } else {
        setProgress(1, 0, DataAppStatus.notInternet);
      }
    }

    if (dataAppStatus.value == DataAppStatus.extractFailure) {
      await Future.delayed(const Duration(seconds: 2));
      await AppService().deleteFileData();
      if (redownload.value < 1) {
        _download();
        redownload.value += 1;
      } else {
        setProgress(1, 0, DataAppStatus.waitForNewUpdate);
      }
    }
  }

  @override
  void onInit() async {
    startService = const StartService();
    PackageApp packageApp = await AppService().getVersion();
    version.value = packageApp.version;
    unawaited(AppService().setTraffic());
    super.onInit();
  }

  @override
  void onReady() async {
    await _download();

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
    super.onReady();
  }
}
