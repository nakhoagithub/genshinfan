import 'package:flutter/material.dart';
import 'package:genshinfan/controllers/app_controller.dart';
import 'package:genshinfan/objects/resource.dart';
import 'package:get/get.dart';

import '../resources/utils/enum.dart';

class ResourceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<Resource> resources = Get.find<AppController>().resources;
  Rx<Status> status = Status.init.obs;
  Rx<Resource?> resource = Rx(null);
  ScrollController scrollController = ScrollController();

  void selectResource(Resource resource) {
    this.resource.value = resource;
    update();
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
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
