import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../resources/utils/enum.dart';

class ResourceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  List<Resource> resources = <Resource>[].obs;
  Rx<Status> status = Status.init.obs;
  Rx<Resource?> resource = Rx(null);
  ScrollController scrollController = ScrollController();

  void selectResource(Resource resource) {
    this.resource.value = resource;
  }

  @override
  void update([List<Object>? ids, bool condition = true]) async {
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
    super.update(ids, condition);
  }

  @override
  void onInit() {
    resources.addAll(Get.find<AppController>().resources);
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
