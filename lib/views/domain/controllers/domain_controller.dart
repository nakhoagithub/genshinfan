import 'package:flutter/material.dart';
import 'package:genshinfan/views/app_controller.dart';
import 'package:genshinfan/models/game/domain.dart';
import 'package:get/get.dart';

class DomainController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<Domain> domains = Get.find<AppController>().domains;
  Rx<Domain?> domain = Rx(null);
  ScrollController scrollController = ScrollController();

  void selectDomain(Domain domain) {
    this.domain.value = domain;
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
